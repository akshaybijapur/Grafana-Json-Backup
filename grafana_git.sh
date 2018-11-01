#!/bin/bash

# This is the Directory where the script grafana_backup.sh runs and it further creates a directory with the name of the Grafana host name.
x="/home/admin/Documents/"

# This is the Directory created after the backup is done and all the dashboards are stored in the "General" directory 
y="/home/admin/Documents/10.125.0.155/General/"

# A host name of Grafana used to access the dashboards
a="http://10.125.0.155:3000"

# An api key generated in grafana 
b="eyJrIjoiUGpQbVk3ZEZ6ZUx3ZURNNXlRcEtwNnNQdVE2cTIyS0wiLCJuIjoiQmFja3VwIiwiaWQiOjF9"
  
# Check for the directory and run the "grafana_backup.sh" script
cd $x
if [ "$?" = "0" ]; then
        sh grafana_backup.sh $a $b
else
        echo "Directory does not exist" 1>&2
        exit 1
fi


echo "backup completed"

# Change directory and push all the files that were backed up previously into github
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
git push -u origin master 

echo "Pushed and committed to Github"
