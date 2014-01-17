@echo off
setlocal
echo ==========================
echo =IIS DNS Test For WebPass=
echo ==========================
echo.
echo.
echo Checking for DNS resolution issues for failed hosts
echo.
echo Please wait
echo.

for /f %%a in (IIS_fast_failed.txt) do (ping -n 4 %1 | findstr TTL
	if %errorlevel%==1 (@echo off) else (echo %%a failed > IIS_bad_dns.txt))

echo IIS DNS verification complete
echo.
endlocal
