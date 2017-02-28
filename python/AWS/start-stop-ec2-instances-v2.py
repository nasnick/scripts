#!/usr/bin/python3
import boto3
import sys

start_stop = sys.argv[1:]

client = boto3.client('ec2')
instances = ['i-07aedb1f3bf5dc51b','i-0d1b98b814e854ea5']

def stop_instances(instance):
   print("Stopping instance: ", instance)
   client.stop_instances(InstanceIds=[instance])

def start_instances(instance):
   print("Starting instance: ", instance)
   client.start_instances(InstanceIds=[instance])

def main(instruction):
   for instance in instances:
      response = client.describe_instances(InstanceIds=[
         instance,
         ],
         )
      status = response['Reservations'][0]['Instances'][0]['State']['Name']
      if status == 'stopped' and instruction == 'start':
         start_instances(instance)
      elif status == 'running' and instruction == 'stop':
         stop_instances(instance)
      elif status == 'running' or status == 'stopping' and instruction == 'start':
         print("Cannot complete: ", instance," ", status)
      elif status == 'stopped' or status == 'stopping' and instruction == 'stop':
         print(instance, " already: ", status)

main(start_stop[0])
