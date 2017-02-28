#!/usr/bin/python3
import boto3

client = boto3.client('ec2')
instances = ['i-6818a655','i-5206846f']

def describe_instances():
   for instance in instances:
      response = client.describe_instances(InstanceIds=[
         instance,
         ],
         )
      
      status = response['Reservations'][0]['Instances'][0]['State']['Name']
      if status == 'running':
         print("The instance is ", status)
         client.stop_instances(InstanceIds=[instance])
      else:
         print("Nope it's ", status)

      #print(response)
#      x = 0
#      y = len(instances)
#
#      while x < y:
#         print(response['Reservations'][x]['OwnerId'])
#         x += 1

def stop_instances():
   for instance in instances:
      client.stop_instances(InstanceIds=[
           instance,
       ],
       Force=True
       )

#stop_instances()
describe_instances()
