echo "Download file from S3"

echo "Choose path/to/file"

bucket="s3://bucketname"

s3cmd ls $bucket

echo "Enter type: [XX or XX]"

read dm_or_input
if [ $dm_or_input = "XX" -o $dm_or_input = "XX" ]:
then
s3cmd ls $bucket/$dm_or_input/
else
echo "\e[01;31m ERROR: you have entred wrong path \e[0m"
exit
fi

echo "Enter Country like: [XX]"

read country
if [ $country = "XX" -o $country = "XX" -o $country = "XXXX" -o $country = "XX" ]:
then
s3cmd ls $bucket/$dm_or_input/$country/
else
echo "\e[01;31m ERROR: you have entred wrong path \e[0m"
exit
fi

echo "Enter Month like: 201911 To Download all files"

read month

s3cmd get $bucket/$dm_or_input/$country/$month ~/ --recursive

if [$? -eq 0]:
then
echo "downloading file for "/$dm_or_input/$country/$month 
else 
echo "\e[31;43m ERROR: Something wrong with the path \e[0m"
fi












