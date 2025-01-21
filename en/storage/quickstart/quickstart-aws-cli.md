---
title: Getting started with the AWS CLI
description: Follow this guide to create a bucket and upload an object to it using the AWS CLI.
---

# Getting started with the AWS CLI in {{ objstorage-full-name }}

The [AWS CLI](../tools/aws-cli.md) is one of the most popular {{ objstorage-name }} tools. In this section, you will learn how to use the service with the help of this tool. For guidelines on using the management console, see [{#T}](../quickstart.md).

To get started with the AWS CLI:

1. [Prepare your cloud environment](#before-you-begin).
1. [Set up a service account](#create-sa).
1. [Install and configure the AWS CLI](#cli-setup).
1. [Create a bucket](#the-first-bucket).
1. [Upload an object to the bucket](#upload-files).
1. [Get a download link for the file](#get-link).

## Prepare your cloud {#before-you-begin}

{% list tabs group=instructions %}

- Management console {#console}

  1. Go to the [management console]({{ link-console-main }}) and log in to {{ yandex-cloud }} or sign up if not signed up yet.
  1. On the [**{{ ui-key.yacloud_billing.billing.label_service }}**]({{ link-console-billing }}) page, make sure you have a [billing account](../../billing/concepts/billing-account.md) linked and it has the `ACTIVE` or `TRIAL_ACTIVE` status. If you do not have a billing account, [create one](../../billing/quickstart/index.md#create_billing_account).
  1. [Assign](../../iam/operations/roles/grant.md) these _minimum_ roles to your {{ yandex-cloud }} account:
      * To create a [service account](../../iam/concepts/users/service-accounts.md) and get access keys for it: [iam.serviceAccounts.admin](../../iam/roles-reference.md#iam-serviceAccounts-admin) for a [folder](../../resource-manager/concepts/resources-hierarchy.md#folder). If you want to use an existing service account, the `iam.serviceAccounts.admin` role for that service account will be enough.
      * To assign a role to a service account: [storage.admin](../../storage/security/index.md#storage-admin) for a bucket or folder.

      If you have a primitive [admin](../../iam/roles-reference.md#admin) role for a folder, you do not need to assign any additional roles.

      {% include [note-managing-roles](../../_includes/mdb/note-managing-roles.md) %}

{% endlist %}

## Set up a service account {#create-sa}

{% list tabs group=instructions %}

- Management console {#console}

  1. Create a service account:

      {% include [create-sa-via-console-without-role](../../_includes/iam/create-sa-via-console-without-role.md) %}

      You can also use an existing service account.

      For more information, see [{#T}](../../iam/operations/sa/create.md).

  1. Assign a [role](../security/index.md#roles-list), e.g., [storage.editor](../security/index.md#storage-editor), for a folder to a service account:

      1. In the [management console]({{ link-console-main }}), select the cloud or folder.
      1. Go to the **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** tab.
      1. Click **{{ ui-key.yacloud.common.resource-acl.button_configure-access }}**.
      1. In the window that opens, select **{{ ui-key.yacloud_components.acl.label.service-accounts}}**.
      1. Select the service account from the list or use the search to locate it.
      1. Click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** and select the role from the list or use the search bar to locate it.
      1. Click **{{ ui-key.yacloud_components.acl.action.apply }}**.

      For more information, see [{#T}](../../iam/operations/sa/assign-role-for-sa.md).

      {% include [access-bucket-sa](../../_includes/storage/access-bucket-sa.md) %}

  1. Create a static access key {#create-keys}

      1. In the [management console]({{ link-console-main }}), navigate to the folder the service account belongs to.
      1. In the services list, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
      1. In the left-hand panel, select ![FaceRobot](../../_assets/console-icons/face-robot.svg) **{{ ui-key.yacloud.iam.label_service-accounts }}**.
      1. In the list that opens, select the service account you need.
      1. Click **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create-key-popup }}** in the top panel.
      1. Select **{{ ui-key.yacloud.iam.folder.service-account.overview.button_create_service-account-key }}**.
      1. Specify the key description and click **{{ ui-key.yacloud.iam.folder.service-account.overview.popup-key_button_create }}**.
      1. Save the ID and secret key.

          {% note alert %}

          After you close the dialog box, the key value will not be shown again.

          {% endnote %}

      For more information, see [{#T}](../../iam/operations/sa/create-access-key.md).

{% endlist %}

## Install and configure the AWS CLI {#cli-setup}

1. Install the AWS CLI:

    {% list tabs group=operating_system %}

    - Linux {#linux}

      1. In the terminal, run this command:

          ```bash
          curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" --output "awscliv2.zip"
          unzip awscliv2.zip
          sudo ./aws/install
          ```

      1. After installation is complete, restart the terminal.

    - macOS {#macos}

      1. In the terminal, run this command:

          ```bash
          curl "https://awscli.amazonaws.com/AWSCLIV2.pkg" --output "AWSCLIV2.pkg"
          sudo installer -pkg AWSCLIV2.pkg -target /
          ```

      1. After installation is complete, restart the terminal.

    - Windows {#windows}

      1. Download the AWS CLI [installation file](https://awscli.amazonaws.com/AWSCLIV2.msi).
      1. Open the file and follow the installer's instructions.

    {% endlist %}

    For more information about installing the AWS CLI, see the [AWS documentation](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html).

1. Set up the AWS CLI:

    {% list tabs group=instructions %}

    - AWS CLI {#aws-cli}

      1. To configure the AWS CLI, enter this command in the terminal:

          ```bash
          aws configure
          ```

      1. Enter the values for these parameters:

          * `AWS Access Key ID`: Previously obtained static key ID.
          * `AWS Secret Access Key`: Previously obtained secret key.
          * `Default region name`: `{{ region-id }}`.

            To work with {{ objstorage-name }}, always specify `{{ region-id }}` as the region. A different region value may lead to an authorization error.


          Leave the other parameter values unchanged.


          {% include [store-aws-key-in-lockbox](../../_includes/storage/store-aws-key-in-lockbox.md) %}


      1. Set the {{ objstorage-name }} endpoint:

          ```bash
          aws configure set endpoint_url https://{{ s3-storage-host }}/
          ```

          {% cut "Examples of the resulting configuration files" %}

          * `~/.aws/config`:



          * `~/.aws/credentials`:

            ```text
            [default]
            aws_access_key_id = <static_key_ID>
            aws_secret_access_key = <secret_key>
            ```

          {% endcut %}

    {% endlist %}

For more information about setting up the AWS CLI, see the [AWS documentation](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html).

{% note info %}

Take note of the AWS CLI [features](../tools/aws-cli.md#specifics) when used with {{ objstorage-name }}.

{% endnote %}

## Create a bucket {#the-first-bucket}

{% list tabs group=instructions %}

- AWS CLI {#aws-cli}

  In the terminal, run the command below stating the [bucket](../concepts/bucket.md) name:

  ```bash
  aws s3 mb s3://<bucket_name>
  ```

  For more information, see [{#T}](../operations/buckets/create.md).

{% endlist %}

## Upload an object to the bucket {#upload-files}

{% list tabs group=instructions %}

- AWS CLI {#aws-cli}

  To upload an [object](../concepts/object.md), run the command below stating the path to the local file you need to upload, bucket name, and the [key](../concepts/object.md#key) you will use to store the object in the bucket:

  ```bash
  aws s3 cp <local_file_path>/ s3://<bucket_name>/<object_key>
  ```

  For more information, see [{#T}](../operations/objects/upload.md).

{% endlist %}

## Get a download link for the object {#get-link}

{% list tabs group=instructions %}

- AWS CLI {#aws-cli}

  In the terminal, run the command below stating the bucket name, object key, and link lifetime in seconds:

  ```bash
  aws s3 presign s3://<bucket_name>/<object_key> --expires-in <lifetime>
  ```

  You can share the received link or use it in your service to access the file.

  For more information, see [{#T}](../operations/objects/link-for-download.md).

{% endlist %}
