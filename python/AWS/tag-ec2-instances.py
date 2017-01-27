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
#  }]
#   }
# }

# Supply as command line argument e.g.

# tag-ec2-instances.py config.json


config_file = str(sys.argv[1])

with open(config_file, 'r') as f:
    config = json.load(f)

ec2 = boto3.resource('ec2')
mytags = config['tags']['Inspector']
instance_ids = []

def get_all_instance_ids():
   instance_ids = []

   reservations = ec2.instances.all()
   for reservation in reservations:
    #print(reservation.id)
      instance_ids.append(reservation.id)

def filter_instances(environment):
   instance_ids = []

   reservations = ec2.instances.filter(
      Filters=[{'Name': 'tag:opsworks:instance', 'Values': [environment]}])
   for reservation in reservations:
      print(reservation.id, reservation.instance_type)
      instance_ids.append(reservation.id)
   #print(instance_ids)
   tag_instances(instance_ids)

def tag_instances(instance_ids):

      for instance in instance_ids:
         ec2.create_tags(
         Resources=[instance],
         Tags= mytags
         )

filter_instances('*test*')