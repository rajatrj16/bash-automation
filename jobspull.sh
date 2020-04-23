#!bin/bash

host="server1 server2"
run="cd path/to/folder;git pull"
for hostname in ${host};
do
	echo "-----Deploying on ${hostname}-----"
	ssh ${hostname}	"${run}"
done
