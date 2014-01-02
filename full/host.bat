@echo off

echo.
echo.
echo =================
echo ==Server Seeker==
echo =================
echo.
echo.
echo Welcome to Server Seeker.
echo.
echo This tool is used to verify the Webpass servers for every post.
echo There are different modes of operation.
echo.
goto :Begin

:Begin

echo.
echo Please select your next task:
echo.
echo F for Fast nslookup against all servers
echo S for Checking any failed servers
echo A for !Feature not implemented
echo I for Setting up the ip lists
echo.

CHOICE /C FSAI /N /D F /T 900 /M "Please Select:"
SET TASKID=%ERRORLEVEL%
IF %TASKID% EQU 1 goto :Fast
IF %TASKID% EQU 2 goto :Slow
IF %TASKID% EQU 3 goto :Begin
IF %TASKID% EQU 4 goto :IP
IF %TASKID% GTR 4 goto :Begin


:Fast

echo Loading
IF EXIST "IIS_fast_failed.txt" (del IIS_fast_failed.txt)
IF EXIST "SQL_fast_failed.txt" (del SQL_fast_failed.txt)
IF EXIST "failed_hosts.txt" (del failed_hosts.txt)
call nslookup_fast.bat
echo Scan Complete
IF EXIST "IIS_fast_failed.txt" (echo Warning: some IIS servers did not respond)
IF EXIST "SQL_fast_failed.txt" (echo Warning: some SQL servers did not respond)
echo.
goto :Begin

:Slow

echo Loading
Call nslookup_slow.bat
IF EXIST "failed_hosts.txt" (
echo Warning: some servers did not respond.
echo They are likely down OR incorrect
findstr /R /N "^" failed_hosts.txt > error_count.txt
)
goto :Begin

:IP
start IIS_IP.txt
start SQL_IP.txt
pause
goto :Begin

