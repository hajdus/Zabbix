-dodac w zabbix do template

-dodac  skrypt.sh do /etc/zabbix
-chmod +x skrypt.sh

-dodac folder zabbix_agentd.d

-dodac plick userparameter_updates.conf
UserParameter=GetPendingUpdates[*],/etc/zabbix/skrypt.sh

-dodac Include=/etc/zabbix/zabbix_agentd.d/*.conf

-sudo service zabbix-agent restart

