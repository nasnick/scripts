#!/usr/bin/python3
import boto3
import sys
import json

#Usage:
# Create a config.json file with tags:

# {
#   "tags": {
#     "Inspector": [{
#        "Key" : "PenTesting1632", 
#        "Value" : "InspectorEC2Instance"
# 	}]
#   }
# }

# Supply as command line argument e.g.

# tag-ec2-instances.py config.json


config_file = str(sys.argv[1])

with open(config_file, 'r') as f:
    config = json.load(f)

ec2 = boto3.resource('ec2')
reservations = ec2.instances.all()
mytags = config['tags']['Inspector']

instance_ids = []

def get_instance_ids():
	for reservation in reservations:
	   #print(reservation.id)
	   instance_ids.append(reservation.id)


def tag_instances():
	for instance in instance_ids:
	   ec2.create_tags(
	      Resources=[instance],
	      Tags= mytags
	      )

get_instance_ids()
tag_instances()
