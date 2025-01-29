---
title: Using {{ postbox-full-name }} via the AWS CLI
description: In this article, you will learn how to install and set up the AWS CLI for working with {{ postbox-name }}.
---

# AWS CLI

The [AWS CLI](https://docs.aws.amazon.com/cli/) is a command line interface designed for AWS services. To learn [how to run commands](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/index.html), see the official Amazon documentation.

## Getting started {#before-you-begin}

1. [Create](../../iam/operations/sa/create.md) a service account.
1. [Assign](../../iam/operations/sa/assign-role-for-sa) the [roles](../security/index.md) required for your project to the service account. For more information about roles, see the [Identity and Access Management documentation](../../iam/concepts/access-control/roles).
1. [Create](../../iam/operations/sa/create-access-key.md) static access keys. Save the ID and secret key to a secure location. You will not be able to view the secret key parameters again after you close the window.

## Installation {#installation}

{% include [install-aws-cli](../../_includes/aws-tools/install-aws-cli.md) %}

## Setup {#setup}

To configure the AWS CLI, run the `aws configure` command in your terminal. The command will request values for the following parameters:
1. `AWS Access Key ID`: ID of the static key created when [getting started](#before-you-begin).
1. `AWS Secret Access Key`: Contents of the static access key.
1. `Default region name`: `{{ region-id }}`.

    To work with {{ postbox-name }}, always specify `{{ region-id }}` as the region. A different region value may lead to an authorization error.

1. Leave the other parameter values unchanged.

### Configuration files {#config-files}

The `aws configure` command saves the static key and the region.

* Static key format in `.aws/credentials`:

  ```ini
  [default]
    aws_access_key_id = <static_key_ID>
    aws_secret_access_key = <static_key_contents>
  ```

* Default region format in `.aws/config`:

  ```ini
  [default]
    region = {{ region-id }}
  ```

* You can create multiple profiles for different service accounts by specifying their details in the `.aws/credentials` file:

  ```ini
  [default]
    aws_access_key_id = <ID_of_static_key_1>
    aws_secret_access_key = <contents_of_static_key_1>
  [<name_of_profile_2>]
    aws_access_key_id = <ID_of_static_key_2>
    aws_secret_access_key = <contents_of_static_key_2>
  ...
  [<name_of_profile_n>]
    aws_access_key_id = <ID_of_static_key_n>
    aws_secret_access_key = <contents_of_static_key_n>
  ```

  Where `default` is the default profile.
