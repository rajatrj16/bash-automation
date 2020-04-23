#!/bin/bash
filecount='0'
for filename in $(ls ~/automation)
do 
   echo $filename; 
filecount=$((filecount+1)); 
done;
echo "Total files are: "
echo $filecount
newfilecount='0'
while true 
do
for newfilename in $(ls ~/automation)
do 
   echo $newfilename; 
newfilecount=$((newfilecount+1)); 
done;

sleep 5s
if [ $newfilecount -lt $filecount ]
then
   echo "File is deleted"
elif [ $newfilecount -gt $filecount ]
then
   echo "New file created"
else 
   echo "No Changes"
fi
done
