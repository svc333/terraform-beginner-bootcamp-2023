# Terraform Beginner Bootcamp 2023 - Week 1

## Fixing Tags
I didnt mess up my tags
[How to delete and fix tags](https://devconnected.com/how-to-delete-local-and-remote-tags-on-git/)

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

## Terraform and input Variables
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

## Dealing with config drift

## lose state file? 
SOL, tear everything down manually.  Import doesnt work on all resources.

`terraform import aws_s3_bucket.example`

### Fix missing resources with tf import
[Terraform Import](https://developer.hashicorp.com/terraform/cli/import)
[AWS S3 Bucket Import](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket.html#import)
`% terraform import aws_s3_bucket.bucket bucket-name`

### Fix manual config

If someone clickOps in AWS

Terraform Plan will attempt to put the infra back into the expected state to fix drift

## Terraform Modules

### Terraform module structure
Recommended to place `modules` in a modules directory when locally developing modules

### Passing Input Variables
Pass input variables to the module

The module has to declare the tf variables it its own variable
```tf
module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.user_uuid
  bucket_name = var.bucket_name
}
```

### Module Sources
Using the source we can impirt the module from various places eg:
- locally
- Github
- Terraform Registry

```tf
module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
}
```

[Module Sources](https://developer.hashicorp.com/terraform/language/modules/sources)

### Problems that didnt match Create Terrahouse Module video
- resources werent allowed in main
- I had to create a resource.tf and move them

## Considerations when using ChatGPT

LLMs may notbe trained on the latest documentation or information about terraform, so it spits out old examples that are depricated.  Often affecting providers

## Working with files in terraform

### Fileexists function

built in tf function to check existance of file
```
variable "index_html_filepath" {
  description = "The file path for index.html"
  type = string


validation {
  condition = fileexists(var.index_html_filepath)
  error_message = "the provided path for index.html does not exist."
}
}

```

### File md5
used to show a file updates, so it can be reuploaded

### Path Variable
In terraform there is a special variable called `path` that allows us to reference local paths:
- path.module = get the path for the current module 
- path.root = get the path for the root of the modile

[Special Path Variable](https://developer.hashicorp.com/terraform/language/expressions/references#filesystem-and-workspace-info)
``````
resource "aws_s3_object" "index_html" {
  bucket = aws_s3_bucket.website_bucket.bucket
  key = "index.html"
  source = "var.index_html_filepath"

  etag = filemd5(var.index_html_filepath)
}
``````
## Terraform Locals

[Local Values](https://developer.hashicorp.com/terraform/language/values/locals)

### Terraform Data Sources

This allows us to source data from cloud resources without importing them
```
data "aws_caller_identity" "current" {}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}
```

[Data Sources](https://developer.hashicorp.com/terraform/language/data-sources)


## AWS error requiring support
```
module.terrahouse_aws.aws_cloudfront_distribution.s3_distribution: Creating...
╷
│ Error: creating CloudFront Distribution: AccessDenied: Your account must be verified before you can add new CloudFront resources. To verify your account, please contact AWS Support (https://console.aws.amazon.com/support/home#/) and include this error message.
│       status code: 403, request id: d01186a3-c2cb-4a78-a6c2-b4bfd8b71e74
│ 
│   with module.terrahouse_aws.aws_cloudfront_distribution.s3_distribution,
│   on modules/terrahouse_aws/resource-cdn.tf line 16, in resource "aws_cloudfront_distribution" "s3_distribution":
│   16: resource "aws_cloudfront_distribution" "s3_distribution" {
```


## Working with JSON

used to create json policy inline

[jsonencode function](https://developer.hashicorp.com/terraform/language/functions/jsonencode)

### Changing the Lifecycle of Resources

[Meta Arguments Lifcycle](https://developer.hashicorp.com/terraform/language/meta-arguments/lifecycle)

## Terraform Data

Plain data values such as Local Values and Input Variables don't have any side-effects to plan against and so they aren't valid in replace_triggered_by. Use terraform_data's behavior of planning an action each time input changes to indirectly use a plain value to trigger replacement.

https://developer.hashicorp.com/terraform/language/resources/terraform-data

## Provisioners

Allow you to executuing commands on compute eg. AWS CLI

Not recommended for use by Hashicorp.  Ansible is better.
[Provisioners](https://developer.hashicorp.com/terraform/language/resources/provisioners/syntax)

### Local-exec

executes commands running the terraform commands eg. plan, apply

### Remote-exec

executes on....   REMOTE targets!