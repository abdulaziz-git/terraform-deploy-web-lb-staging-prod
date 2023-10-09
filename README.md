# Terraform deploy webserver LB to staging and production

This is sample of how to deploy a simple web server that is serving behind a load balancer using Terraform to staging or production environment in GCP.

## Authentication to GCP

- Install Google Cloud CLI `gcloud` on your computer by following this documentation (https://cloud.google.com/sdk/docs/install)
- Run the following command to authenticate terraform

```bash
gcloud auth application-default login
```

## Running terraform

- Install terraform (https://developer.hashicorp.com/terraform/downloads)
- Change `project_id` value inside `environments/staging/staging.tfvars` and `environments/production/production.tfvars` with your project ID.

- Initialize terraform

```bash
terraform init
```

- Create terraform workspace for `staging` and `production`

```bash
terraform workspace new staging
terraform workspace new production
```

- Deploy to `staging`
```bash
terraform workspace select staging
terraform plan -var-file=environments/staging/staging.tfvars
terraform apply -var-file=environments/staging/staging.tfvars
```

- Deploy to `production`
```bash
terraform workspace select production
terraform plan -var-file=environments/production/production.tfvars
terraform apply -var-file=environments/production/production.tfvars
```

## Reference
- https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/getting_started
- https://developer.hashicorp.com/terraform/cli
