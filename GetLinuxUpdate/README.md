dodac w zabbix do template

dodac  skrypt.sh do /etc/zabbix
chmod +x skrypt.sh
#!/bin/bash

WYNIK="$(apt list --upgradable 2>/dev/null | grep \-security | wc -l)";

if [ "0" -eq "$WYNIK" ]
then
        echo "{\"data\":[]}";

else
        echo "{ \"data\":[ {\"{#UPNAME}\" : \"Security Updates\", \"{#UPNUMBER}\" : \"$WYNIK\"} ]}";

fi




dodac folder zabbix_agentd.d

dodac plick userparameter_updates.conf
UserParameter=GetPendingUpdates[*],/etc/zabbix/skrypt.sh

dodac Include=/etc/zabbix/zabbix_agentd.d/*.conf

sudo service zabbix-agent restart

