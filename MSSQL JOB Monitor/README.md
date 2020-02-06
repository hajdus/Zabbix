## Installation
 
### Zabbix Configuration

- Copy `userparameter_mssql.conf` to your Zabbix Agent folder, e.g. `C:\Zabbix\conf.d`.

- Copy PowerShell scripts (`mssqljobmonitor.ps1`) to the scripts folder, e.g. `C:\Zabbix\scripts` folder.
IMPORTANT: if you use another folder for agent scripts, then update userparameter file in the previous step!

- Import XML template file (`zbx_template_mssql.xml`) into Zabbix via Web GUI (Configuration -> Templates -> Import).

- Assign the imported template to a host.

- in mssqljobmonitor.ps1 change value of $server, $username, $password for your MS SQL credencials

- in zabbix_agentd.win.conf add Include=C:\zabbix\conf.d\*.conf
                                
- Restart Zabbix Agent
                             