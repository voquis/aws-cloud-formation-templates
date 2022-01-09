# AWS Cloudformation Templates
A collection of cloudformation templates used to provision AWS infrastructure as code.

## Templates
### [Terraform backend](templates/terraform-backend/README.md)
This template creates an S3 bucket and a dynamodb table to implement state locking.

## Usage
### Creating stacks
In general, stacks are created with the following command, replacing `template-name` with directory names of templates in this repo, for example `terraform-backend`.
Add any required parameters, replacing key names and values, i.e. `Param1`, `Param2` and `Val1`, `Val2` in the example below:

```shell
aws cloudformation create-stack \
  --stack-name template-name \
  --enable-termination-protection \
  --template-url https://voquis.s3.eu-west-2.amazonaws.com/aws/cloudformation/templates/template-name/template.yml \
  --parameters ParameterKey=Param1,ParameterValue=Val1 ParameterKey=Param2,ParameterValue=Val2
```

### Updating stacks
To update stacks following template changes, run the following replacing `template-name` and key names and values appropriately:
```shell
aws cloudformation update-stack \
  --stack-name template-name \
  --enable-termination-protection \
  --template-url https://voquis.s3.eu-west-2.amazonaws.com/aws/cloudformation/templates/template-name/template.yml \
  --parameters ParameterKey=Param1,ParameterValue=Val1 ParameterKey=Param2,ParameterValue=Val2
```

### Deleting stacks
To delete a stack and the infrastructure provisioned by the stack, first deactivate termination protection:
```shell
aws cloudformation \
  update-termination-protection \
  --no-enable-termination-protection \
  --stack-name template-name
```
then delete the stack:
```shell
aws cloudformation delete-stack \
  --stack-name template-name
```
