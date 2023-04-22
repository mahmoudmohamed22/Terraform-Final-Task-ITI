## Terraform Final Task ITI
This repository contains the Terraform code to deploy infrastructure on AWS. It includes creating a VPC with two public and two private subnets, launching EC2 instances in the public and private subnets, and creating RDS and Elasticache instances.

It includes creating network, Security, RDS, Elastic Cache modules , this is a way to organize, encapsulate, and reuse Terraform configurations, making it easier to manage complex infrastructure deployments

## AWS Architecture
![terraform final task ITI drawio](https://user-images.githubusercontent.com/47304558/233790912-c80943d8-6774-47d7-9f85-e578341f3cba.png)

## Overview
This project uses Terraform to create the following AWS resources:
- VPC
- Internet Gateway
- Public Route Table
- Private Route Table
- Public EC2 instances
- Private EC2 instances
- RDS instance
- Elasticache instance

The project also includes two workspaces for deploying the infrastructure in different regions, and a script for auto-installing MySQL and Redis on the EC2 instances and scripts to auto connect to them.

## Prerequisites
Before running the deployment script, you will need to have the following:

- AWS account
- Terraform installed on your local machine
- AWS CLI installed on your local machine
- AWS credentials configured on your local machine
- A Secret Manager in AWS with the RDS database credentials stored (username, password)
- A S3 bucket to store the Terraform state file, and DynamoDB to use for state locking. You can include them in backend.tf

## To get started:

Clone this repository to your local machine.
```
git clone https://github.com/mahmoudmohamed22/Terraform-final-task
```
Create the 2 workspaces
```
$ terraform workspace new dev
$ terraform workspace new prod
```
Run `terraform init` to download the necessary Terraform plugins.

Run `terraform apply` to create the Bastion host and security group.

Once the Bastion host has been created, you can connect to it using SSH. The Bastion host will be assigned a public IP address, which you can use to connect to it from the public internet. For example:


```
ssh -i /path/to/private/key ec2-user@<bastion-public-ip>
```

Replace /path/to/private/key with the path to your private SSH key, and <bastion-public-ip> with the public IP address of the Bastion host.

## To detect changes in aws infrastructure 
save tfstate for backend terraform in s3 buckect then create event event notification to connect to trigger for lambda function and write lambda function code to send email used SES in AWS and assign permissions to lambda function

![detect](https://user-images.githubusercontent.com/47304558/232821693-d26b5e35-1ed0-40a3-9e16-16f5b8169d30.png)

```
import boto3
from botocore.exceptions import ClientError

def send_email():
    SENDER = "mahmoudabdelwahab5555@gmail.com" # must be verified in AWS SES Email
    RECIPIENT = "mahmoudabdelwahab5555@gmail.com" # must be verified in AWS SES Email

    # If necessary, replace us-west-2 with the AWS Region you're using for Amazon SES.
    AWS_REGION = "eu-central-1"

    # The subject line for the email.
    SUBJECT = "This is test email for testing"

    # The email body for recipients with non-HTML email clients.
    BODY_TEXT = ("Hey Hi mahmoud m.abdelwahab...\r\n"
                "tfstate file has been changed\r\n"
                "infrastructure changed\r\n"
                )
    

    # The character encoding for the email.
    CHARSET = "UTF-8"

    # Create a new SES resource and specify a region.
    client = boto3.client('ses',region_name=AWS_REGION)

    # Try to send the email.
    try:
        #Provide the contents of the email.
        response = client.send_email(
            Destination={
                'ToAddresses': [
                    RECIPIENT,
                ],
            },
            Message={
                'Body': {
                    'Text': {
        
                        'Data': BODY_TEXT
                    },
                },
                'Subject': {

                    'Data': SUBJECT
                },
            },
            Source=SENDER
        )
    # Display an error if something goes wrong.  
    except ClientError as e:
        print(e.response['Error']['Message'])
    else:
        print("Email sent! Message ID:"),
        print(response['MessageId'])

def lambda_handler(event, context):
    # TODO implement
    send_email()

```
### when changed in AWS infrastructure
![image](https://user-images.githubusercontent.com/47304558/232820612-caee9ad3-abbe-4d7a-9276-3e733025266a.png)
## Test 
### - when resources created using terraform

![Screenshot from 2023-04-18 16-18-24](https://user-images.githubusercontent.com/47304558/232814947-5af73013-1589-4dca-bbd8-1b00f8ae1e68.png)


### - when connected ssh from public ec2 instance to private ec2 instance 

![image](https://user-images.githubusercontent.com/47304558/232341832-d396336e-2fae-40c6-a8a6-6629d1813621.png)

### - when connected RDS mysql from public ec2 instance 
![image](https://user-images.githubusercontent.com/47304558/232832593-aa2d71eb-6d6e-476b-9525-decd9f0df96f.png)


### - when terraform destroy resources
![image](https://user-images.githubusercontent.com/47304558/232836396-36381930-e1f6-4daa-bf45-ed20aa4512ca.png)




## Conclusion
With this Terraform code, you can create a VPC with public and private subnets in two different availability zones, launch EC2 instances with RDS and Elasticache instances, and set up a bastion host for accessing the private instances. By using modules and workspaces, you can easily manage the infrastructure for multiple environments.

Overall, this project provides a comprehensive infrastructure setup that includes networking, compute, database, and caching resources. It also implements best practices for Terraform, such as using modules, workspaces, and variable definition files. With this setup, you can easily deploy and manage your infrastructure in multiple environments and regions, while maintaining a high level of security and scalability.


## Author
- <a href="https://github.com/mahmoudmohamed22"> Mahmoud M.Abdelwahab</a>
