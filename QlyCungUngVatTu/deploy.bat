@echo off
REM === Cau hinh duong dan ===
set MAVEN_HOME=C:\apache-maven-3.9.11
set PROJECT_PATH=C:\xampp\tomcat\BTLJSP\QlyCungUngVatTu
set TOMCAT_WEBAPPS=C:\xampp\tomcat\webapps
set WAR_NAME=BTLJSP.war
set TOMCAT_BIN=C:\xampp\tomcat\bin

echo =======================================
echo  BAT DAU DEPLOY UNG DUNG JSP LEN TOMCAT
echo =======================================

REM === Kiem tra Maven ===
if not exist "%MAVEN_HOME%\bin\mvn.cmd" (
    echo  Maven khong ton tai tai: %MAVEN_HOME%
    pause
    exit /b
)

REM === Buoc 1: Build bang Maven ===
cd %PROJECT_PATH%
echo  Dang build voi Maven...
call %MAVEN_HOME%\bin\mvn clean package > build.log 2>&1

if not exist "%PROJECT_PATH%\target\%WAR_NAME%" (
    echo  Build that bai, xem chi tiet trong build.log
    notepad build.log
    pause
    exit /b
)

REM === Buoc 2: Xoa ban cu trong webapps ===
echo  Xoa ban deploy cu...
del /F /Q "%TOMCAT_WEBAPPS%\%WAR_NAME%"
rmdir /S /Q "%TOMCAT_WEBAPPS%\BTLJSP"

REM === Bước 3: Copy WAR moi sang Tomcat ===
echo  Copy WAR moi...
copy "%PROJECT_PATH%\target\%WAR_NAME%" "%TOMCAT_WEBAPPS%\" >nul

REM === Bước 4: Restart Tomcat ===
echo  Restart Tomcat...
call %TOMCAT_BIN%\shutdown.bat
timeout /t 5 >nul
call %TOMCAT_BIN%\startup.bat

echo =======================================
echo  DEPLOY HOAN TAT! Vao: http://localhost:8080/BTLJSP/
echo =======================================
pause
