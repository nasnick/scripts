lsSDFSDFS
#exit=$?

   if [ $exit == 127 ]
        then
        echo "File have vanished"
        #exit 0
    elif [ $exit != 0 ]
        then
        echo "Rsync failed"
        #exit 1
    fi

ls
#exit=$?

   if [ $exit == 127 ]
        then
        echo "File have vanished"
        exit 0
    elif [ $exit == 0 ]
        then
        echo "all good"
        exit 1
    fi
