#!/bin/bash

if [ -z "$1" ]
then
echo"version tag must exist, sorry!"
exit 1
fi

MY_TAG=$1

echo "=======PULL DOCKER IMAGE========"

docker pull 029718676955.dkr.ecr.us-east-2.amazonaws.com/docker_cowsay:$MY_TAG


#echo "=======DOCKER-COMPOSE DOWN======"
#docker-compose -f /home/ec2-user/files_to_aws/docker-compose.yml down

# echo "======DELETE ALL SOURCES========"
# rm -rf /home/ec2-user/files_to_aws/


echo"======docker rm -f my_cont====="
docker rm -f my_cont


export MY_TAG=$MY_TAG

#echo "======DOCKER-COMPOSE UP========="
#docker-compose -f /home/ec2-user/files_to_aws/docker-compose.yml up

echo"=======docker run my_cont========="
docker run  -d --network=cowsay_jenkins_cowsay_network --name my_cont -p 3001:3001 my_coww 3001

sleep 5

echo"====curl test======"
curl http://3.15.178.57:3001/

