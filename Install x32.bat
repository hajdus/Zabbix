@echo off

setlocal enableextensions disabledelayedexpansion




xcopy "\\fileserver\Zabbix\*.*"  C:\Zabbix /s /i /y


set "search=Windows_host"
   
	set "replace=%COMPUTERNAME%"

			
    set "textFile=c:\Zabbix\conf\zabbix_agentd.win.conf"

    for /f "delims=" %%i in ('type "%textFile%" ^& break ^> "%textFile%" ') do (
        set "line=%%i"
        setlocal enabledelayedexpansion
		
        >>"%textFile%" echo(!line:%search%=%replace%!
        endlocal
    )

C:\Zabbix\bin\win32\zabbix_agentd.exe  --config C:\Zabbix\conf\zabbix_agentd.win.conf --install
C:\Zabbix\bin\win32\zabbix_agentd.exe --start
netsh advfirewall firewall add rule name="Zabbix" dir=in action=allow program="C:\Zabbix\bin\win32\zabbix_agentd.exe" enable=yes

PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& '\\fileserver\zabbix_API_create_host.ps1'"

pause

