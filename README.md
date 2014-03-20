Setup
======

Edit config.sh and set the environment variables for your application
Define the following tags for your image : 
````
env=
role=
````
these tags and environment variables are used to fetch the configuration in CONFIG_S3_BUCKET
````
$CONFIG_S3_BUCKET/$env/$role/VERSION # version of the package to be downloaded
$PACKAGES_S3_BASEURL/$APPLICATION_NAME/${APPLICATION_NAME}-${VERSION}/${VERSION}/zips/${APPLICATION_NAME}-${VERSION}_2_10.zip
$CONFIG_S3_BUCKET/$env/$role/env.conf
$CONFIG_S3_BUCKET/$env/$role/logger.xml
````

Connect to the vm and run bin/deploy.sh to ensure that everything is working as
expected

Edit the file /etc/cloud/cloud.cfg on the VM and add the following at the end of
the file
````
runcmd:
 - [sudo, -n, -u, ec2-user, /home/ec2-user/bin/deploy.sh]
````

You can now make an image of your vm, any vm started from this image must have
the tags env and role defined. based on that it will automatically retrieve
deploy and configure the corresponding application.

