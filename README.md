Terraform AWS module for creating an AWS IAM user
=========================================================

Generic repository for a terraform module for AWS IAM user

![Image of Terraform](https://i.imgur.com/Jj2T26b.jpg)

# Table of content

- [Introduction](#intro)
- [Usage](#usage)
- [Release log](#release-log)
- [Module versioning & git](#module-versioning-&-git)
- [Local terraform setup](#local-terraform-setup)
- [Authors/Contributors](#authorscontributors)


# Intro

Module to create a AWS IAM user module with the following details:
- maximum one aws iam user per instantiation
- configures the user's password policy
- configures the user access key
- associates a policy allowing user to update for his own account his credentials


# Usage

Example usage:

```hcl
module "jdoe" {
  source                        = "github.com/diogoaurelio/terraform-module-aws-iam-user"
  version                       = "v0.0.1"
  name                          = "jdoe"
  create_user                   = true
  create_iam_access_key         = false
  create_iam_user_login_profile = true
  password_reset_required       = true
  password_length               = 24
  force_destroy                 = false
  pgp_key                       = "<your public gpg key to encrypt the output of the generated password>"
}
```


# Release log

Whenever you bump this module's version, please add a summary description of the changes performed, so that collaboration across developers becomes easier.

* version v0.0.1 - first module release

# Module versioning & git

To update this module please follow the following proceedure:

1) make your changes following the normal git workflow
2) after merging the your changes to master, comes the most important part, namely versioning using tags:

```bash
git tag v0.0.2
```

3) push the tag to the remote git repository:
```bash
git push origin master tag v0.0.2
```

# Local terraform setup

* [Install Terraform](https://www.terraform.io/)

```bash
brew install terraform
```

* In order to automatic format terraform code (and have it cleaner), we use pre-commit hook. To [install pre-commit](https://pre-commit.com/#install).
* Run [pre-commit install](https://pre-commit.com/#usage) to setup locally hook for terraform code cleanup.

```bash
pre-commit install
```


# Authors/Contributors

See the list of [contributors](https://github.com/diogoaurelio/terraform-module-aws-compute-lambda/graphs/contributors) who participated in this project.