<#
setup-db.ps1
PowerShell helper to initialize the MySQL database for the project and create a db.properties

Usage examples (run as Administrator in PowerShell):
  # interactive (prompts for MySQL root password)
  .\setup-db.ps1

  # non-interactive
  .\setup-db.ps1 -MySqlUser root -MySqlPassword 123456 -MySqlPort 3307 -DbName btljsp -TomcatConfPath 'C:\xampp\tomcat\conf' -SqlFilePath .\create_users.sql -RestartTomcat $false

What it does:
 - Locates mysql.exe (PATH or XAMPP default)
 - Creates database if not exists
 - Imports the provided SQL file (create_users.sql)
 - Writes db.properties to Tomcat conf folder
 - Optionally restarts a Tomcat service (looks for services named like Tomcat*)

Note: You must run this script on the machine hosting MySQL/Tomcat (can't run remotely from me).
#>
param(
    [string] $MySqlHost = '127.0.0.1',
    [int] $MySqlPort = 3307,
    [string] $MySqlUser = 'root',
    [string] $MySqlPassword = '',
    [string] $DbName = 'btljsp',
    [string] $TomcatConfPath = 'C:\xampp\tomcat\conf',
    [string] $SqlFilePath = "$(Split-Path -Parent $MyInvocation.MyCommand.Definition)\create_users.sql",
    [bool] $RestartTomcat = $true,
    [string] $TomcatServiceName = ''
)

function Find-MySqlExe {
    $candidates = @("mysql.exe")
    # add common XAMPP path
    $candidates += 'C:\xampp\mysql\bin\mysql.exe'
    foreach ($c in $candidates) {
        try {
            $full = (Get-Command $c -ErrorAction SilentlyContinue).Source
            if ($full) { return $full }
        } catch { }
    }
    return $null
}

Write-Host "--- Database setup helper for BtlJSP ---"

# Ask password if not provided
if (-not $MySqlPassword -or $MySqlPassword -eq '') {
    $MySqlPassword = Read-Host -AsSecureString "Enter MySQL password for user $MySqlUser (will be hidden)"
    $MySqlPasswordPlain = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($MySqlPassword))
} else {
    $MySqlPasswordPlain = $MySqlPassword
}

$mysqlExe = Find-MySqlExe
if (-not $mysqlExe) {
    Write-Error "mysql.exe not found in PATH or XAMPP default location. Please install MySQL client or adjust the script."
    return
}
Write-Host "Using mysql client at: $mysqlExe"

# Ensure SQL file exists
if (-not (Test-Path $SqlFilePath)) {
    Write-Error "SQL file not found: $SqlFilePath"
    return
}
Write-Host "SQL file: $SqlFilePath"

# Create database if not exists
$createDbCmd = "CREATE DATABASE IF NOT EXISTS `$DbName CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
$cmd = "`"$mysqlExe`" -h $MySqlHost -P $MySqlPort -u $MySqlUser -p$MySqlPasswordPlain -e \"$createDbCmd\""
Write-Host "Creating database (if not exists): $DbName"
$proc = Start-Process -FilePath $mysqlExe -ArgumentList "-h", $MySqlHost, "-P", $MySqlPort.ToString(), "-u", $MySqlUser, "-p$MySqlPasswordPlain", "-e", $createDbCmd -NoNewWindow -Wait -PassThru -ErrorAction Stop
if ($proc.ExitCode -ne 0) { Write-Error "Failed to create database (exit $($proc.ExitCode)). Ensure credentials and MySQL are correct."; return }

# Import SQL file
Write-Host "Importing SQL file into database $DbName..."
$importArgs = "-h", $MySqlHost, "-P", $MySqlPort.ToString(), "-u", $MySqlUser, "-p$MySqlPasswordPlain", $DbName
$procImp = Start-Process -FilePath $mysqlExe -ArgumentList $importArgs -RedirectStandardInput $SqlFilePath -NoNewWindow -Wait -PassThru -ErrorAction Stop
if ($procImp.ExitCode -ne 0) { Write-Error "Import failed (exit $($procImp.ExitCode))."; return }

Write-Host "SQL import finished."

# Write db.properties into Tomcat conf
if (-not (Test-Path $TomcatConfPath)) {
    Write-Warning "Tomcat conf path not found: $TomcatConfPath - skipping writing db.properties"
} else {
    $dbPropsPath = Join-Path $TomcatConfPath 'db.properties'
    $content = @"
# Externalized DB properties for BtlJSP
db.url=jdbc:mysql://$MySqlHost:$MySqlPort/$DbName?useSSL=false&serverTimezone=UTC
db.user=$MySqlUser
db.password=$MySqlPasswordPlain
db.poolSize=10
"@
    Write-Host "Writing db.properties to $dbPropsPath (will overwrite if exists)"
    try {
        $content | Out-File -FilePath $dbPropsPath -Encoding UTF8 -Force
        Write-Host "Wrote $dbPropsPath"
    } catch {
        Write-Warning "Failed to write db.properties: $_. Exception. Try running PowerShell as Administrator."
    }
}

# Optionally restart Tomcat service
if ($RestartTomcat) {
    # determine Tomcat service
    if (-not $TomcatServiceName -or $TomcatServiceName -eq '') {
        $svc = Get-Service | Where-Object { $_.Name -match 'Tomcat|tomcat' } | Select-Object -First 1
        if ($svc) { $TomcatServiceName = $svc.Name }
    }
    if ($TomcatServiceName) {
        Write-Host "Restarting Tomcat service: $TomcatServiceName"
        try {
            Stop-Service -Name $TomcatServiceName -Force -ErrorAction Stop
            Start-Sleep -Seconds 2
            Start-Service -Name $TomcatServiceName -ErrorAction Stop
            Write-Host "Tomcat service restarted."
        } catch {
            Write-Warning "Failed to restart Tomcat service '$TomcatServiceName': $_"
        }
    } else {
        Write-Warning "No Tomcat service found to restart. If you use XAMPP, please restart Tomcat via XAMPP Control Panel."
    }
}

Write-Host "Done. Try logging in with username 'admin' / password 'admin'"
