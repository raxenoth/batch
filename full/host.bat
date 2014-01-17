@echo off
ipconfig /flushdns
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
echo F for Fast nslookup against all servers with ping verification
echo S for Checking any failed servers
echo A for Reports
echo I for Setting up the ip lists
echo.

CHOICE /C FSAI /N /D F /T 900 /M "Please Select:"
SET TASKID=%ERRORLEVEL%

IF %TASKID% EQU 1 goto :Fast
IF %TASKID% EQU 2 goto :Slow
IF %TASKID% EQU 3 goto :Report
IF %TASKID% EQU 4 goto :IP
IF %TASKID% GTR 4 goto :Begin


:Fast
echo Loading
IF EXIST "IIS_fast_failed.txt" (del IIS_fast_failed.txt)
IF EXIST "SQL_fast_failed.txt" (del SQL_fast_failed.txt)
IF EXIST "IIS_bad_dns.txt" (del IIS_bad_dns.txt)
IF EXIST "SQL_bad_dns.txt" (del SQL_bad_dns.txt)
IF EXIST "failed_hosts.txt" (del failed_hosts.txt)
echo. >>iis_ip.txt
echo. >>sql_ip.txt
echo 192.168.254.0>>iis_ip.txt
echo 192.168.254.0>>sql_ip.txt

call nslookup_fast.bat
call IIS_dns_test.bat
call SQL_dns_test.bat
echo Scan Complete
IF EXIST "IIS_fast_failed.txt" (echo Warning: some IIS servers did not respond)
IF EXIST "SQL_fast_failed.txt" (echo Warning: some SQL servers did not respond)
echo.
IF EXIST "IIS_bad_dns.txt" (echo Warning: some IIS servers show DNS resolutions issues)
IF EXIST "SQL_bad_dns.txt" (echo Warning: some SQL servers show DNS resolutions issues)
goto :Begin


:Slow
echo Loading
Call nslookup_slow.bat
IF EXIST "failed_hosts.txt" (
echo Warning: some servers did not respond.
echo They are likely down OR incorrect
findstr /R /N "^" failed_hosts.txt | find /C ":" > ./count.txt
)
findstr /R /N "^" failed_hosts.txt | find /C ":"
goto :Begin


:IP
start IIS_IP.txt
start SQL_IP.txt
pause
goto :Begin

:Report
echo.
echo Please select the desired report:
echo.
echo D for non-responding hosts
echo N for Servers missing PTR records or not responding
echo A for !Feature not implemented
echo.

CHOICE /C DNA /N /D A /T 900 /M "Please Select:"
SET TASKID=%ERRORLEVEL%

IF %TASKID% EQU 1 goto :dns_report
IF %TASKID% EQU 2 goto :ns_report
IF %TASKID% EQU 3 goto :Begin
goto :Begin

:dns_report
start SQL_bad_dns.txt
start IIS_bad_dns.txt
goto :Begin

:ns_report
start IIS_fast_failed.txt
start SQL_fast_failed.txt
goto :Begin
