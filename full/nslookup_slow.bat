@echo off
ipconfig /flushdns
echo.
echo ================
echo == Slow-Probe ==
echo ================
echo.
echo.
echo NOTICE
echo.
echo This tool is slow, and bandwith intensive.
echo Use CTRL + C to return to the main menu, or any other key to continue.
pause
IF EXIST "IIS_bad_dns.txt" (
echo.
echo IIS non-responsive server list found!
echo IIS list loaded.
echo.
echo Probing IIS Servers.
for /f %%a in (IIS_bad_dns.txt) do (nbtstat -A %%a > nul|find /i "%%a">nul||(echo %%a)) >>.\failed_hosts.txt
echo.
echo IIS list complete.
)
IF EXIST "SQL_bad_dns.txt" (
echo.
echo SQL non-responsive server list found!
echo SQL list loaded.
echo.
echo Probing SQL Servers.
for /f %%a in (SQL_bad_dns.txt) do (nbtstat -A %%a > nul|find /i "%%a">nul||(echo %%a)) >>.\failed_hosts.txt
)

echo Complete
