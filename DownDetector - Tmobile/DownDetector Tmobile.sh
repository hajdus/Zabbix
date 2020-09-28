UserParameter=curl[*],/bin/bash -c "curl -L --compressed -s $1 |tr '\n' ' '  |tr  $'\'' ' ' |  grep -q   'title= Strona główna >       Potencjalna awaria z T-Mobile' && [[ $? == 0 ]] && echo 1 || echo 0"

UserParameter=curl_awaria[*],/bin/bash -c "curl -L --compressed -s $1 |tr '\n' ' '  |tr  $'\'' ' ' |  grep -q   'title= Strona główna >                </a>            <div class= color-danger h2 entry-title >            Awaria w T-Mobile' && [[ $? == 0 ]] && echo 1 || echo 0"


zabbix_get -s 10.110.12.115 -k "curl[https://downdetector.pl/status/t-mobile/]"

