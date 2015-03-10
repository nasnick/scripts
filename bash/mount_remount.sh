esxcli storage nfs add -H 10.0.10.2 -s /mnt/sdb1 -v nfs_backups2

MOUNT_POINT='nfs_backups2'
MOUNT_POINT_FIND='nfs_backups2$'
MOUNT_POINT_FOLDER='/mnt/sdb1'
SERVER='10.0.10.2'

CHECK_MOUNT=$(esxcli storage nfs list | awk '{print $1}' | grep $MOUNT_POINT_FIND | wc -l)

if [ $CHECK_MOUNT -eq 1 ]; then
  echo "Mounted.. will mount then unmount"
  esxcli storage nfs remove -v $MOUNT_POINT
  sleep 1
  esxcli storage nfs add -H $SERVER -s $MOUNT_POINT_FOLDER -v $MOUNT_POINT                 
  sleep 1
  CHECK_MOUNT=$(esxcli storage nfs list | awk '{print $1}' | grep $MOUNT_POINT_FIND | wc -l)

elif [ $CHECK_MOUNT -eq 0 ]; then 
  echo "Not mounted... mounting"
  esxcli storage nfs add -H $SERVER -s $MOUNT_POINT_FOLDER -v $MOUNT_POINT
  sleep 1
  CHECK_MOUNT=$(esxcli storage nfs list | awk '{print $1}' | grep $MOUNT_POINT_FIND | wc -l)
fi

if [ $CHECK_MOUNT -ne 1 ]; then
  echo "Problem mounting drive"
  exit 1
else
  echo "Drive successfully mounted"
  exit 0
fi