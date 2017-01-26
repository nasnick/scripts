#!/usr/bin/python3
import time
import boto3
import json
import subprocess
import os
import sys
#Debugging
#import logging, sys
#logging.basicConfig(stream=sys.stderr, level=logging.DEBUG)

#Usage
# python3 pgbadger_download_process_logs.py <config.json>

#Create a config.json file which will be the command line argument to the script config_file = str(sys.argv[1])

# {
#   "rds": {
#     "prod": [{
#       "database": "bt-test-adobe",
# 	  "region": "ap-southeast-2",
# 	  "download_file": "/var/www/pgbadger/logs/all-logs",
# 	  "output_folder": "/var/www/pgbadger/prod"
# 	}]
#   }
# }

config_file = str(sys.argv[1])

with open(config_file, 'r') as f:
    config = json.load(f)

database = config['rds']['prod'][0]['database']
region = config['rds']['prod'][0]['region']
download_file = config['rds']['prod'][0]['download_file']
output_folder = config['rds']['prod'][0]['output_folder']

client = boto3.client('rds',region_name=region)

now = time.time()
yesterday = int(round(now - 86400))

response = client.describe_db_log_files(
   DBInstanceIdentifier=database,
   FileLastWritten=yesterday
)

files = []

x = 0
while x < 25:
   files.append(response['DescribeDBLogFiles'][x]['LogFileName'])
   x += 1

#Not needed
#files_stripped = list(map(lambda x: str.replace(x, "error/", ""), files))

with open(download_file, "a") as all_logs:
   for log in files:
      response = client.download_db_log_file_portion(
      DBInstanceIdentifier=database,
      LogFileName=log
      )
      all_logs.write(str(response['LogFileData']))

all_logs.close()

bashCommand = "/usr/local/bin/pgbadger -p '%t:%r:%u@%d:[%p]:' -I -q " +  download_file + " -O " + output_folder

subprocess.call(bashCommand, shell=True)

os.remove(download_file)
