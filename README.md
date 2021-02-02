# Sample terraform localstack

Sample project to use Terraform, Localstack (AWS Local) and Docker compose.

## Getting started

Open two terminal windows

terminal 1

```bash
docker-compose up
```

terminal 2

```bash
terraform init
terraform apply
```

## Issues

Currently there is an issue creating the IAM roles

- https://github.com/localstack/localstack/issues/2286

 - https://github.com/hashicorp/terraform/issues/19938

 - https://github.com/hashicorp/terraform-provider-aws/issues/5218

It looks like its probably related to the last issue which we might be able to overcome by creating our own roles for Localstack possibly?

