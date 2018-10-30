#!/bin/sh

 x="/home/admin/Documents/"
 y="/home/admin/Documents/10.125.0.155/General/"
  

cd $x
if [ "$?" = "0" ]; then
        sh grafana_backup.sh http://10.125.0.155:3000 eyJrIjoiUGpQbVk3ZEZ6ZUx3ZURNNXlRcEtwNnNQdVE2cTIyS0wiLCJuIjoiQmFja3VwIiwiaWQiOjF9
else
        echo "Directory does not exist" 1>&2
        exit 1
fi


echo "backup completed"

cd $y
if [ "$?" = "0" ]; then
        
	git add *
	if [ "$?" = "0" ]; then
		echo "All files in $y diroctory added"
	else
		echo "Error while adding files from $y directory" 1>&2
		exit 1
	fi

else
        echo "Directory does not exist" 1>&2
        exit 1
fi


git commit -m "Automatic Backup @ $(date)"
git push -u origin master --force

echo "Pushed and committed to Github"
