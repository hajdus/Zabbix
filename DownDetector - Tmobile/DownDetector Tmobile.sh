curl "https://downdetector.pl/status/t-mobile/" -L --compressed -s | grep 'Nie ma problemów z T-Mobile' && [[ $? == 0 ]] && echo 0 || echo 1

curl "https://downdetector.pl/status/t-mobile/" -L --compressed -s | grep -q "title='Strona gl�wna'>
      Potencjalna awaria z T-Mobile" && [[ $? == 0 ]] && echo 1 || echo 0


curl "https://downdetector.pl/status/t-mobile/" -L --compressed -s | grep -q "title='Strona gl�wna'>
      Awaria w T-Mobile" && [[ $? == 0 ]] && echo 1 || echo 0




UserParameter=curl[*],curl -L --compressed -s $1  | grep -q "title='Strona gl�wna'>
      Potencjalna awaria z T-Mobile" && [[ $? == 0 ]] && echo 1 || echo 0


UserParameter=curl_awaria[*],curl -L --compressed -s $1  | grep -q "title='Strona gl�wna'>
      Awaria w T-Mobile" && [[ $? == 0 ]] && echo 1 || echo 0



zabbix_get -s 10.110.12.115 -k "curl[https://downdetector.pl/status/t-mobile/]"


