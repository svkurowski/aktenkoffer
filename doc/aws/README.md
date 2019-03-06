# Setting up file storage on AWS S3

To store document files on [AWS S3](https://aws.amazon.com/s3/), you need to set up the following:

- An S3 bucket
- An IAM user with the following permissions on all objects (`/*`) in that bucket:
  - 's3:PutObject'
  - 's3:GetObject'

To make this process as easy, replicable and secure as possible we are providing an [AWS CloudFormation](https://aws.amazon.com/cloudformation/getting-started/) template in [cloudformation-template.yaml](cloudformation-template.yaml) that will create the required resources and permission setup.

After creating a new stack in AWS CloudFormation using the given template, expand the Outputs section on the stack detail page to find the settings required for running Aktenkoffer.
The output variables map to environment variables as follows:

- `AwsAccessKeyId`: `AWS_ACCESS_KEY_ID`
- `AwsSecretAccessKey`: `AWS_SECRET_ACCESS_KEY`
- `AwsBucket`: `AWS_BUCKET`
- `AwsDefaultRegion`: `AWS_DEFAULT_REGION`
