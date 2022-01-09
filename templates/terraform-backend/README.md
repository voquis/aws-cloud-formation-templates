# Terraform backend
This template provisions the infrastructure needed for a [Terraform S3 backend](https://www.terraform.io/language/settings/backends/s3) to store state, supported by a dynamodb table for state locking.

It is assumed the bucket and table name will be of the form `<project>-terraform-<environment>`, e.g. `mycompanywebsite-terraform-dev`.

## Creating the stack

Set the `Project` and `Env` parameters accordingly:
```shell
aws cloudformation create-stack \
  --stack-name terraform-backend \
  --enable-termination-protection \
  --template-url s3://voquis/aws/cloudformation/templates/terraform-backend/template.yml \
  --parameters ParameterKey=Project,ParameterValue=myproj ParameterKey=Env,ParameterValue=myenv
```

## Migrating from Terraform Cloud to S3 backend

Ensure local terraform state  is up to date:
```shell
terraform apply -refresh-only
```

Replace the Terraform Cloud remote configuration:
```terraform
backend "remote" {
  organization = "my-org"

  workspaces {
    name = "my-proj"
  }
}
```
with S3 backend configuration:
```terraform
backend "s3" {
  bucket = "bucket-name"
  key    = "state-file-name"
  region = "region"
}
```
Migrate local up-to-date terraform state to new s3 backend and initialise new S3 remote state
```shell
terraform init -migrate-state
```
