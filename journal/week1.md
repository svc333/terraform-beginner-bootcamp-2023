# Terraform Beginner Bootcamp 2023 - Week 1

## Root Module Structure

```
Root module structure is as follows:
- PROJECT_ROOT
  - main.tf - all other things
  - variables.tf - stores the structure of input variables
  - providers.tf - defines required providers and their config
  - outputs.tf - stores outputs
  - terraform.tfvars  - the data of variables to load into terraform project
  - README.md - required for root modules
```
[Standard Module Structure](https://developer.hashicorp.com/terraform/language/modules/develop/structure)

## Terraform and input Vanriables
## Terraform Cloud Variables

in terraform you can set 2 variables
- Environment variables - set in bash
- Terraform Variables - normally set in tfvars file

We can set variables to sensitive or not

## Loading Terraform Input Variables

[Input Variables](https://developer.hashicorp.com/terraform/language/values/variables)

use the `-var` flag to set input variable or override a variable in the tfvars files eg. `terraform -var user_uuid=my-user-id`

### var-file flag

 - TODO: Document this functionality

 ### terraform.tfvars

 Default file to load in terraform variables in bulk

 ### auto.tfvars

 - TODO: Document this functionality

 ### order of tf variables

 - Document this functionality and the precidence