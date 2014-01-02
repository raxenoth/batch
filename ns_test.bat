@echo off
echo Cleaning up old results:
del .\results\IIS_out.txt
echo .
echo ..
echo ...
del .\results\SQL_out.txt
echo Complete!
echo.
echo =======================
echo =NS Lookup For WebPass=
echo =======================
echo.
echo Parsing Ip List for IIS
echo Now scanning IIS servers
echo Please wait
for /f %%a in (IIS.txt) do (nslookup %%a  2> nul|find /i "%%a">nul||(echo %%a not found)) >>.\results\IIS_out.txt
echo IIS Complete!
echo.
echo.
echo Parsing Ip List for SQL
echo Now scanning SQL servers
echo Please wait
@echo off
for /f %%a in (SQL.txt) do (nslookup %%a  2> nul|find /i "%%a">nul||(echo %%a not found)) >>.\results\SQL_out.txt
)
echo SQL Complete!
echo.
echo.
echo Exiting!
echo.
echo.
pause
