#!/usr/bin/python

with open('/tmp/RUNNABLE_APP03') as f:
   app03_runnable = [x.strip('\n') for x in f.readlines()]

with open('/tmp/RUNNABLE_APP04') as f:
   app04_runnable = [x.strip('\n') for x in f.readlines()]

with open('/tmp/RUNNABLE_APP06') as f:
   app06_runnable = [x.strip('\n') for x in f.readlines()]

common_to_all_3 = set(app03_runnable) & set(app04_runnable) & set(app06_runnable)

print 'Configs on all three servers:'
print '\n'.join(common_to_all_3)
