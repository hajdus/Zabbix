#!/bin/bash

WYNIK="$(apt list --upgradable 2>/dev/null | grep \-security | wc -l)";

if [ "0" -eq "$WYNIK" ]
then
        echo "{\"data\":[]}";

else
        echo "{ \"data\":[ {\"{#UPNAME}\" : \"Security Updates\", \"{#UPNUMBER}\" : \"$WYNIK\"} ]}";

fi
