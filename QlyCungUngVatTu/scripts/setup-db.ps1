<#
PowerShell helper to set up database and Tomcat db.properties for the project.
Run as Administrator in PowerShell.
What it does:
 - Detects MySQL binary (prefers XAMPP install at C:\xampp\mysql\bin)
 - Creates database `btljsp` if missing
 - Imports deploy-samples/create_users.sql
 - Writes C:\xampp\tomcat\conf\db.properties with default credentials
 - Attempts to restart Tomcat service (if named 'Tomcat' or 'tomcat')

Usage: Open PowerShell as Admin and run:
    .\scripts\setup-db.ps1
#>

param(
    [string]$mysqlHost = '127.0.0.1',
    [int]$mysqlPort = 3307,
    [string]$mysqlUser = 'root',
    [string]$mysqlPass = '123456',
    [string]$dbName = 'btljsp'
)

function Find-MySqlExe {
    # Common XAMPP path
    $paths = @(
        'C:\xampp\mysql\bin\mysql.exe',
        'C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe',
        'C:\Program Files (x86)\MySQL\MySQL Server 5.7\bin\mysql.exe'
    )
    foreach ($p in $paths) { if (Test-Path $p) { return $p } }
    # fallback to PATH
    $which = (Get-Command mysql -ErrorAction SilentlyContinue)
    if ($which) { return $which.Source }
    return $null
}

$mysql = Find-MySqlExe
if (-not $mysql) {
    Write-Host "mysql client not found. Please ensure MySQL client is installed or mysql.exe is under PATH or XAMPP installed." -ForegroundColor Yellow
    exit 1
}
Write-Host "Using mysql client: $mysql"

# Ensure database exists
$createDbCmd = "CREATE DATABASE IF NOT EXISTS `$dbName CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
$cmd = "`"$mysql`" -h $mysqlHost -P $mysqlPort -u $mysqlUser -p$mysqlPass -e `"$createDbCmd`""
Write-Host "Creating database (if not exists)..."
& $mysql -h $mysqlHost -P $mysqlPort -u $mysqlUser -p$mysqlPass -e $createDbCmd
if ($LASTEXITCODE -ne 0) { Write-Host 'Failed to create database. Check credentials and that MySQL is running.' -ForegroundColor Red; exit 2 }

# Import SQL file
$sqlFile = Join-Path $PSScriptRoot '..\deploy-samples\create_users.sql'
$sqlFile = (Resolve-Path $sqlFile).Path
Write-Host "Importing sample SQL from $sqlFile"
& $mysql -h $mysqlHost -P $mysqlPort -u $mysqlUser -p$mysqlPass $dbName < $sqlFile
if ($LASTEXITCODE -ne 0) { Write-Host 'Failed to import SQL file.' -ForegroundColor Red; exit 3 }

# Write db.properties to Tomcat conf
$tomcatConf = 'C:\xampp\tomcat\conf\db.properties'
$content = @"
# DB properties for BtlJSP
db.url=jdbc:mysql://$mysqlHost:$mysqlPort/$dbName?useSSL=false&serverTimezone=UTC
db.user=$mysqlUser
db.password=$mysqlPass
db.poolSize=10
"@

Write-Host "Writing db.properties to $tomcatConf"
New-Item -ItemType Directory -Path (Split-Path $tomcatConf) -Force | Out-Null
Set-Content -Path $tomcatConf -Value $content -Encoding UTF8

# Restart Tomcat service if present
$svcNames = @('Tomcat', 'tomcat', 'Apache Tomcat')
$found = $null
foreach ($n in $svcNames) { if (Get-Service -Name $n -ErrorAction SilentlyContinue) { $found = $n; break } }
if ($found) {
    Write-Host "Restarting service $found"
    Restart-Service -Name $found -Force
} else {
    Write-Host "Tomcat service not found by common names. Please restart Tomcat using XAMPP Control Panel." -ForegroundColor Yellow
}

Write-Host "Setup complete. Try login with username 'admin' password 'admin'" -ForegroundColor Green
