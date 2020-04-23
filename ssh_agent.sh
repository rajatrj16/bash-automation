ssh git@gitlab.com
temp=$(eval $(ssh-agent -s) | awk '{print $3}') && echo $temp && kill -9 $temp
ssh git@gitlab.com
