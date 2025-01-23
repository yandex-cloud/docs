---
title: Preparing the environment for {{ yds-full-name }}
description: Follow this guide to prepare the environment for {{ yds-name }}.
---

# Preparing the environment for {{ yds-name }}

1. Log in to the [management console]({{ link-console-main }}). If not signed up yet, navigate to the management console and follow the instructions.
1. On the [**{{ ui-key.yacloud.component.navigation-menu.label_billing }}**]({{ link-console-billing }}) page, make sure you have a [billing account](../../billing/concepts/billing-account.md) linked and it is in `ACTIVE` or `TRIAL_ACTIVE` status. If you do not have a billing account yet, [create one](../../billing/quickstart/index.md#create_billing_account).
1. If you do not have a folder yet, [create one](../../resource-manager/operations/folder/create.md).
1. [Create](../../iam/operations/sa/create.md) a service account and [assign](../../iam/operations/sa/assign-role-for-sa.md) it the `editor` role for your folder.
1. [Create](../../iam/operations/sa/create-access-key.md) a static access key.
1. Set up the AWS CLI:
    1. Install the [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-files.html) and run this command:

        ```bash
        aws configure
        ```

    1. Enter the following one by one:

        * `AWS Access Key ID [None]:`: Service account [key ID](../../iam/concepts/authorization/access-key.md).
        * `AWS Secret Access Key [None]:`: Service account [secret key](../../iam/concepts/authorization/access-key.md).
        * `Default region name [None]:`: `{{ region-id }}`.
