## Terraform Bastion Host for AWS
This repository contains the Terraform code to deploy infrastructure on AWS. It includes creating a VPC with two public and two private subnets, launching EC2 instances in the public and private subnets, and creating RDS and Elasticache instances.

## AWS Architecture
![terraform final task ITI](https://user-images.githubusercontent.com/47304558/232818541-96e104c3-3224-4319-9add-572d6beb42a9.png)

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

## Getting started
To use this Terraform project, you will need:

- An AWS account with appropriate permissions to create EC2 instances and security groups.

- Terraform installed on your local machine.

- An SSH key pair to use for accessing the Bastion host.

## To get started:

Clone this repository to your local machine.
```
git clone https://github.com/mahmoudmohamed22/Bastion-host-Terraform
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
## test 
### - when resources created using terraform

![Screenshot from 2023-04-18 16-18-24](https://user-images.githubusercontent.com/47304558/232814947-5af73013-1589-4dca-bbd8-1b00f8ae1e68.png)


### - when connected ssh from public ec2 instance to private ec2 instance 

![image](https://user-images.githubusercontent.com/47304558/232341832-d396336e-2fae-40c6-a8a6-6629d1813621.png)

### - when terraform destroy resources
![image](https://user-images.githubusercontent.com/47304558/232342499-6fdacd86-7129-460e-b1ef-5a7048db59ef.png)




## Security considerations
The Bastion host is a critical component of the security infrastructure, and should be configured and maintained carefully. Here are some guidelines to follow:

- Only authorized users should be allowed to log in to the Bastion host.

- Strong passwords should be used for all accounts on the Bastion host.

- Two-factor authentication (2FA) should be used for all accounts on the Bastion host, if possible.

- Access to the private network should be restricted to only those users who need it.

- All SSH connections to the Bastion host and private servers should be encrypted using SSH keys or other secure authentication mechanisms.

- Logs should be monitored regularly for signs of unauthorized access or other security breaches.

- The Bastion host and private servers should be kept up-to-date with the latest security patches and software updates.

## License
This Terraform project is licensed under the MIT License. See the LICENSE file for more information.
