@echo off
echo.
echo =======================
echo =NS Lookup For WebPass=
echo =======================
echo.
echo Parsing Ip List for IIS
PING 1.1.1.1 -n 10 -w 500 >NUL
echo Now scanning IIS servers
echo Please wait
for /f %%a in (IIS_IP.txt) do (nslookup %%a  2> nul|find /i "%%a">nul||(echo %%a)) >>.\IIS_fast_failed.txt
echo IIS Complete!
echo.
echo.
echo Parsing Ip List for SQL
PING 1.1.1.1 -n 10 -w 500 >NUL
echo Now scanning SQL servers
echo Please wait
@echo off
for /f %%a in (SQL_IP.txt) do (nslookup %%a  2> nul|find /i "%%a">nul||(echo %%a)) >>.\SQL_fast_failed.txt
echo SQL Complete!
echo.
echo.
