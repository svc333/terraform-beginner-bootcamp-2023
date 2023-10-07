# Terraform Beginner Bootcamp 2023

## Table of Contents


- [Terraform Beginner Bootcamp 2023](#terraform-beginner-bootcamp-2023)
  * [Table of Contents](#table-of-contents)
  * [Semantic Versioning :mage:](#semantic-versioning--mage-)
  * [Install the Terraform CLI](#install-the-terraform-cli)
    + [Considerations with the Terraform CLI changed](#considerations-with-the-terraform-cli-changed)
    + [While fixing the Terraform deprecation issues created new CLI bash script](#while-fixing-the-terraform-deprecation-issues-created-new-cli-bash-script)
  * [Sha-bang considerations](#sha-bang-considerations)
  * [Execution Considerations](#execution-considerations)
    + [Chmod changes file permissions](#chmod-changes-file-permissions)
    + [Gitpod documentation (init doesnt run on restart)](#gitpod-documentation--init-doesnt-run-on-restart-)
    + [Working with Env Vars](#working-with-env-vars)
      - [Setting and Unsetting env vars](#setting-and-unsetting-env-vars)
      - [Scoping env vars](#scoping-env-vars)
      - [Persisting env vars in gitpod](#persisting-env-vars-in-gitpod)
    + [AWS CLI installation](#aws-cli-installation)
  * [Terraform Basics](#terraform-basics)
    + [Terraform Registry](#terraform-registry)
  * [Terraform Console](#terraform-console)
      - [Terraform Init](#terraform-init)
      - [Terraform Plan](#terraform-plan)
      - [Terraform Apply](#terraform-apply)
    + [Terraform Lock files](#terraform-lock-files)
    + [Terraform State Files](#terraform-state-files)
    + [Terraform Directory](#terraform-directory)
  * [issues with terraform cloud and gitpod](#issues-with-terraform-cloud-and-gitpod)


## Semantic Versioning :mage:

[semver.org](https://semver.org/)

Given a version number **MAJOR.MINOR.PATCH**: eg. `1.0.1`

- MAJOR version when you make incompatible API changes
- MINOR version when you add functionality in a backward compatible manner
- PATCH version when you make backward compatible bug fixes

## Install the Terraform CLI

### Considerations with the Terraform CLI changed

The terraform CLI install instructions didnt work since the keyring was deprecated in gitpod.yml. Used terraform docs to update.

[Install Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

### While fixing the Terraform deprecation issues created new CLI bash script

- This will keep the ([gitpod.yml](.gitpod.yml)) tidy
- more portable

[Find linux distro; This one is Ubuntu](https://www.cyberciti.biz/faq/find-linux-distribution-name-version-number/)

example of checking os ver
```
cat /etc/*-release
DISTRIB_ID=Ubuntu
DISTRIB_RELEASE=22.04
DISTRIB_CODENAME=jammy
DISTRIB_DESCRIPTION="Ubuntu 22.04.3 LTS"
PRETTY_NAME="Ubuntu 22.04.3 LTS"
NAME="Ubuntu"
VERSION_ID="22.04"
VERSION="22.04.3 LTS (Jammy Jellyfish)"
VERSION_CODENAME=jammy
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=jammy
```

## Sha-bang considerations
- tells bash script what program is being used
- will search user path for portability

https://en.wikipedia.org/wiki/Shebang_(Unix)

## Execution Considerations
make it executable for user mode
chmod u+x `./bin/install_terraform_cli`

### Chmod changes file permissions
https://en.wikipedia.org/wiki/Chmod

### Gitpod documentation (init doesnt run on restart)
https://www.gitpod.io/docs/configure/workspaces/tasks

### Working with Env Vars

We can list out all Environment Variables using `env` command

Also filter specific Env Vars using grep eg. `env | grep AWS_`

#### Setting and Unsetting env vars

in terminal `export Hello='world` then `unset Hello`

Temp Vars

```
Hello=`world ./bin/print_message`
```

Within bash without export

```
HELLO='world'

echo $HELLO
```

####printing Vars

print env var using `echo $HELLO`

#### Scoping env vars

when opening new bash terminals, it per window.  If you want peristent env vars across all terminal windows.   Set env vars in bash profile.


#### Persisting env vars in gitpod

by storing them in gitpod secret storage


### AWS CLI installation
[AWS CLI installed for new project via the bash script](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)

`./bin/install_aws_cli`


```
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
```

Check for AWS creds using ``` aws sts get-caller-identity```

[AWS CLI Env Vars](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)

```
gitpod /workspace/terraform-beginner-bootcamp-2023 (8-refactor-aws-cli-script) $ aws sts get-caller-identity
{
    "UserId": "AFAKENUMBERHERE",
    "Account": "123456789012",
    "Arn": "arn:aws:iam::123456789012:user/terraform-beginner-bootcamp"
}
```
Refactor to use IAM Role instead of IAM user.

## Terraform Basics

### Terraform Registry
Terraform sources their providers and modules from the terraform registry which is located at [registry.terraform.io](https://registry.terraform.io/)

- **Providers** is an interface to APIs
- **Modules** are a way to make large amounts of code modular, portable and sharable

## Terraform Console

List of all terraform commands by typing `terraform`

#### Terraform Init
at the start of a new project, run `terraform init` to download the binaies for the terraform providers that will be used

#### Terraform Plan 

Generates changeset.  Output changeset ie. "plan" to be passed to apply, but often you can just ignore outputting

#### Terraform Apply

`terraform apply`

This runs the changeset to execute

to auto approve use `terraform apply --auto-approve`


### Terraform Lock files

`.terraform.lock.hcl` contains the locked versioning for the providers or modules that should be used with this project.

The lock files shoul be commited to Github

### Terraform State Files

`.terraform.tfstate` contains info about the current state.  This files should not be commited to Github.  If you lose this files, you lose knowing the state of your infrastructure

`.terraform.tfstate.backup` is the previous state

### Terraform Directory

`.terraform` directory contains binaries of terraform providers

## issues with terraform cloud and gitpod

When attempting to run`terraform login` it will launch a cli that doesnt work.  Had to copy the url that shows up

create the token:

```
https://app.terraform.io/app/settings/tokens
```

then create the file manually:

```
 touch /home/gitpod/.terraform.d/credentials.tfrc.json
 open /home/gitpod/.terraform.d/credentials.tfrc.json
```

```
{
    "credentials": {
      "app.terraform.io": {
        "token": "REPLACE_ME"
      }
    }
  }
  
```


Automated process using workaround with following bash script [bin/generate_tfrc_credentials](bin/generate_tfrc_credentials)

