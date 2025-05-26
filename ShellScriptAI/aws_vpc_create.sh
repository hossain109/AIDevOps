
#!/bin/bash


######################
# Description: Create a VPC in AWS
# Create vpc
# create a public subnet

# verify if user is installed in aws, user must be use windows, mac or linux
# verify if aws cli is configured
########################

# variables
VPC_CIDR="10.0.0.0/16"
SUBNET_CIDR="10.0.3.0/24"
VPC_NAME="demo-vpc"
REGION="us-east-1"
SUBNET_NAME="demo-subnet"
SUBNET_AZ="us-east-1a"

# Check if AWS CLI is installed
if ! command -v aws &> /dev/null
then
    echo "AWS CLI could not be found. Please install it and configure it."
    exit 1
fi

# create vpc
VPC_ID=$(aws ec2 create-vpc --cidr-block $VPC_CIDR --region $REGION --query 'Vpc.VpcId' --output text)
# tag vpc
aws ec2 create-tags --resources $VPC_ID --tags Key=Name,Value=$VPC_NAME --region $REGION


# create subnet
SUBNET_ID=$(aws ec2 create-subnet --vpc-id $VPC_ID --cidr-block $SUBNET_CIDR --availability-zone $SUBNET_AZ --region $REGION --query 'Subnet.SubnetId' --output text)
# tag subnet
aws ec2 create-tags --resources $SUBNET_ID --tags Key=Name,Value=$SUBNET_NAME --region $REGION

# echo the vpc id
echo "VPC ID: $VPC_ID"
echo "Subnet ID: $SUBNET_ID"
echo "VPC Name: $VPC_NAME"
echo "Subnet Name: $SUBNET_NAME"

# End of script




