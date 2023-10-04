# Terraform Beginner Bootcamp 2023

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

### Sha-bang considerations
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
