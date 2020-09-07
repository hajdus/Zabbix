UserParameter=curl[*],/bin/bash -c "curl -L --compressed -s $1   | grep 'GMT' | tr -s [:space:] | cut -c 2-11 | grep -q   '$(date +%Y/%m/%d -d yesterday)' && [[ $? == 0 ]] && echo 1 || echo 0"
