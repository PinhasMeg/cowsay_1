#!/bin/bash
version_tag=$1

echo " =================================="
echo " = > BUILD > Building image locally"
echo " =================================="


docker rm -f my_cont
docker build -t my_coww:version_tag .


echo " =================================="
echo " = > PACKAGE > Packing startup.sh > startup.tar"
echo " =================================="

#tar -czvf my_init.tar ./init.sh



echo " =================================="
echo " = > PUBLISH > Pushing to ECR"
echo " =================================="

echo "=========configuraton aws============"

read -e -p "aws access key id: " ACCESS
read -e -p "aws secret access key: " SECRET
read -e -p "region: " REGION
read -e -p "accout aws: " OUTPUT

aws configure set aws_access_key_id $ACCESS
aws configure set aws_secret_access_key $SECRET
aws configure set region $REGION
aws configure set output $OUTPUT



aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin 029718676955.dkr.ecr.us-east-2.amazonaws.com

docker tag my_coww:version_tag 029718676955.dkr.ecr.us-east-2.amazonaws.com/docker_cowsay:$version_tag
docker push 029718676955.dkr.ecr.us-east-2.amazonaws.com/docker_cowsay:$version_tag


echo " =================================="
echo " = > DEPLOY > scp startup && ./startup"
echo " =================================="

scp -i "~/pinhas_key_aws.pem" init.sh ec2-user@ec2-3-22-217-233.us-east-2.compute.amazonaws.com:
ssh -i "~/pinhas_key_aws.pem" ec2-user@ec2-3-22-217-233.us-east-2.compute.amazonaws.com sudo systemctl start docker.service
#ssh -i "~/pinhas_key_aws.pem" ec2-user@ec2-3-22-217-233.us-east-2.compute.amazonaws.com tar -xzvf startup.tar.gz
ssh -i "~/pinhas_key_aws.pem" ec2-user@ec2-3-22-217-233.us-east-2.compute.amazonaws.com /home/ec2-user/init.sh $version_tag

