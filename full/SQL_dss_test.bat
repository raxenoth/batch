@echo off
setlocal
echo ==========================
echo =SQL DNS Test For WebPass=
echo ==========================
echo.
echo.
echo Checking for DNS resolution issues for failed hosts
echo.
echo Please wait
echo.

for /f %%a in (sql_fast_failed.txt) do (ping -n 4 %1 | findstr TTL
	if %errorlevel%==1 (@echo off) else (echo %%a failed > SQL_bad_dns.txt))

echo SQL DNS verification complete
echo.
endlocal
