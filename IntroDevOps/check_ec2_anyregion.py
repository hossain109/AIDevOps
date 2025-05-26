#!/bin/bash

import boto3

def main():
    session = boto3.Session()
    ec2_client = session.client('ec2', region_name='us-east-1')
    regions = [region['RegionName'] for region in ec2_client.describe_regions()['Regions']]

    for region in regions:
        print(f"\nChecking region: {region}")
        ec2 = session.client('ec2', region_name=region)

        # Check for VPCs
        vpcs = ec2.describe_vpcs()['Vpcs']
        vpc_count = len(vpcs)
        print(f"  VPCs found: {vpc_count}")

        # Check for EC2 instances
        reservations = ec2.describe_instances()['Reservations']
        instance_count = sum(len(res['Instances']) for res in reservations)
        print(f"  EC2 instances found: {instance_count}")

        if vpc_count > 0 or instance_count > 0:
            print(f"  --> Resources exist in {region}")

if __name__ == "__main__":
    main()