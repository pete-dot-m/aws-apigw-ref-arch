## AWS API Gateway Reference Infrastructure ##
### IaC/terraform/opentofu ###
This repository contains a reference implementation of an AWS API Gateway using Infrastructure as Code (IaC) with Terraform and OpenTofu.

### Overview ###
This project demonstrates how to set up an API Gateway and related infrastructure in AWS using Terraform/OpenTofu. It includes the necessary configurations for deploying a simple API, along with best practices for security and scalability.
### Prerequisites ###
- AWS Account: You need an active AWS account to deploy the API Gateway.
- AWS CLI: Ensure you have the AWS Command Line Interface (CLI) installed and configured with your AWS credentials. You can download it from the [AWS CLI website](https://aws.amazon.com/cli/).
- Terraform: Ensure you have Terraform installed on your local machine. You can download it from the [Terraform website](https://www.terraform.io/downloads.html).

 *Or*

- OpenTofu (preferred): Ensure you have OpenTofu installed on your local machine. You can download it from the [OpenTofu website](https://opentofu.org/download.html).

### Getting Started ###

*Backend*

The project uses a shared S3/DynamoDB backend to manage the Terraform state and locks. The [remote-state](./remote-state/README.md) directory contains the necessary configurations for setting up this backend. This sub project should be initialized and applied first to create the backend resources.
