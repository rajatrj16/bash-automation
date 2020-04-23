import os
import boto3

def zip_files(file_list,zip_name='test.zip'):
	import zipfile

	with zipfile.ZipFile(zip_name,'w') as myzip:
		for f in file_list:
			myzip.write(f,f.split('/')[-1])
	print("Archived files to zip")

def download_dir(client, resource, path, local='/tmp', bucket_name='your_bucket'):
	bucket = resource.Bucket(bucket_name)

	files = [o for o in bucket.objects.all() if o.key.rsplit('/',1)[0]==path]
	if len(files)==0:
		print("No files found")
	for f in files:
		print("Downloading %s"%f.key)
		client.download_file(bucket_name,f.key,os.path.join(local,f.key.split('/')[-1]))
		print("Downloaded %s"%f.key.split('/')[-1])
	return [os.path.join(local,f.key.split('/')[-1]) for f in files]

def get_input_key_s3(module,data_month,country='',version=''):
	if module=="ic":
		path = os.path.join('inputs',data_month,country,version)
		return path.strip("/")
	elif module=="dm":
		path = os.path.join(module,country,version,data_month)
		return path.strip("/")

module=raw_input("Enter dm or ic:\n")
country=raw_input("Enter country:\n")
data_month=raw_input("Enter Data Month:\n")
version=raw_input("Enter Version:\n")

bucket_name="<bucketname>"

input_path=get_input_key_s3(module,data_month,country.upper() if country.lower()!="default" else "",version.upper() if version.lower()!="base" else "")
print(input_path)

client=boto3.client('s3')
resource=boto3.resource('s3')
downloaded_list = download_dir(client,resource,input_path,os.path.join(os.path.expanduser('~'),'Downloads'),bucket_name=bucket_name)

zip_files(downloaded_list,os.path.join(os.path.expanduser('~'),'Downloads',"%s_%s_%s.zip"%(module,country,data_month)))

