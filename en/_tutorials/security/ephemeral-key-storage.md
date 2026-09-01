[Ephemeral access keys](../../iam/concepts/authorization/ephemeral-keys.md) are temporary keys with a limited lifespan that provide a secure way to access [{{ objstorage-full-name }}](../../storage/) resources without having to store [static keys](../../iam/concepts/authorization/access-key.md). In this tutorial, you will learn how to create ephemeral keys with the help of a script and use them to create [buckets](../../storage/concepts/bucket.md) and upload [objects](../../storage/concepts/object.md) via the [AWS CLI](https://aws.amazon.com/cli/).

To upload objects to an {{ objstorage-name }} bucket using an ephemeral access key:

1. [Get your cloud ready](#before-you-begin).
1. [Create a service account](#create-sa).
1. [Create an ephemeral access key](#prepare-script).
1. [Check your AWS CLI configuration](#setup-aws-cli).
1. [Create a bucket](#create-bucket).
1. [Upload an object to the bucket](#upload-files).

If you no longer need the resources you created, [delete them](#clear-out).


## Get your cloud ready {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}



### Required paid resources {#paid-resources}

The infrastructure support cost includes:

* Fee for storing data in a bucket (see [{{ objstorage-name }} pricing](../../storage/pricing.md#prices-storage)).
* Fee for data operations (see [{{ objstorage-name }} pricing](../../storage/pricing.md#prices-operations)).



### Set up your environment {#setup-environment}


* {% include [cli-install](../../_includes/cli-install.md) %}
* Install and configure the [AWS CLI](../../storage/tools/aws-cli.md).
* Download and install the [jq](https://stedolan.github.io/jq/download/) utility.


## Create a service account {#create-sa}

Create a [service account](../../iam/concepts/users/service-accounts.md) you will use to create a bucket and upload objects. Assign it the `storage.editor` [role](../../storage/security/index.md#storage-editor) for the folder.

{% list tabs group=instructions %}

- Management console {#console}

  1. Open the [management console]({{ link-console-main }}).
  1. [Navigate]({{ link-console-main }}/link/iam) to **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. Click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
  1. In the **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_field_name }}** field, specify `ephemeral-sa`.
  1. Click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** and select `storage.editor`.
  1. Click **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

- {{ yandex-cloud }} CLI {#cli}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Create a service account:

      ```bash
      yc iam service-account create \
        --name ephemeral-sa
      ```

      Result:

      ```text
      id: ajeab0cnib1p********
      folder_id: b0g12ga82bcv********
      created_at: "2025-10-03T09:44:35.989446Z"
      name: ephemeral-sa
      ```

  1. Assign the `storage.editor` role for the folder to the service account:

      ```bash
      yc resource-manager folder add-access-binding <folder_name> \
        --service-account-name ephemeral-sa \
        --role storage.editor
      ```

      Result:

      ```text
      effective_deltas:
        - action: ADD
          access_binding:
            role_id: storage.editor
            subject:
              id: ajeab0cnib1p********
              type: serviceAccount
      ```

- API {#api}

  1. Create a service account named `ephemeral-sa`. Do it by using the [create](../../iam/api-ref/ServiceAccount/create.md) REST API method for the [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) resource or the [ServiceAccountService/Create](../../iam/api-ref/grpc/ServiceAccount/create.md) gRPC API call.
  1. Assign the `storage.editor` role for the current folder to the the service account. Do it by using the [setAccessBindings](../../resource-manager/api-ref/Folder/setAccessBindings.md) REST API method for the [Folder](../../resource-manager/api-ref/Folder/index.md) resource or the [FolderService/SetAccessBindings](../../resource-manager/api-ref/grpc/Folder/setAccessBindings.md) gRPC API call.

{% endlist %}

To manage [access](../../storage/security/overview.md) to the bucket, your service account must have the `storage.admin` [role](../../storage/security/index.md#storage-admin).

{% include [encryption-roles](../../_includes/storage/encryption-roles.md) %}


## Create an ephemeral access key {#prepare-script}

You can write an ephemeral access key to the AWS CLI credentials file. Learn how to manage ephemeral keys manually [here](../../iam/operations/authentication/manage-ephemeral-keys.md).

To create an ephemeral access key, the user needs the `iam.serviceAccounts.ephemeralAccessKeyAdmin` [role](../../iam/security/index.md#iam-serviceAccounts-ephemeralAccessKeyAdmin) or higher for the folder.

{% list tabs group=instructions %}

- {{ yandex-cloud }} CLI {#cli}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Get the `ephemeral-sa` service account ID:

      ```bash
      yc iam service-account get --name ephemeral-sa --format json | jq -r .id
      ```

  1. Create an ephemeral access key and write it to the AWS CLI credentials file:

      ```bash
      yc iam access-key issue-ephemeral \
        --subject-id <service_account_ID> \
        --session-name ephemeral-sa-1 \
        --aws-profile ephemeral-profile \
        --aws-credentials-file ~/.aws/credentials
      ```

      Where:

      * `--subject-id`: `ephemeral-sa` service account ID.
      * `--session-name`: Session name, 1 to 64 characters long. It is required for identifying a session if the service account is [impersonated](../../iam/concepts/access-control/impersonation.md) for multiple users.
      * `--aws-profile`: Name of the AWS CLI profile that will store the ephemeral key. If a profile with this name already exists, its data will be overwritten.
      * `--aws-credentials-file`: Path to the AWS CLI credentials file. The default value is `~/.aws/credentials`.

      After you run the command, the `ephemeral-profile` profile with the ephemeral key data will appear in the `~/.aws/credentials` file. The key values are not displayed in the console.

{% endlist %}


## Check your AWS CLI configuration {#setup-aws-cli}

Make sure the AWS CLI uses the ephemeral key you created.

{% list tabs group=instructions %}

- AWS CLI {#aws-cli}

  1. Add the region and the {{ objstorage-name }} endpoint parameters to `ephemeral-profile` in the `~/.aws/credentials` file if required:

      ```text
      [ephemeral-profile]
      region = {{ region-id }}
      endpoint_url = https://{{ s3-storage-host }}
      ```

  1. Check your profile configuration:

      ```bash
      aws s3 ls --profile ephemeral-profile
      ```

      If the configuration is correct, the command will run without errors.

{% endlist %}


## Create a bucket {#create-bucket}

Create a bucket to store objects.

{% list tabs group=instructions %}

- AWS CLI {#aws-cli}

  Run this command with the bucket name specified:

  ```bash
  aws s3 mb s3://<bucket_name> \
    --profile ephemeral-profile
  ```

  Result:

  ```text
  make_bucket: my-bucket
  ```

  For more information, see [{#T}](../../storage/operations/buckets/create.md).

{% endlist %}


## Upload an object to the bucket {#upload-files}

Upload an object to the new bucket.

{% list tabs group=instructions %}

- AWS CLI {#aws-cli}

  1. Create a test file:

      ```bash
      echo "Hello, {{ yandex-cloud }}!" > test-file.txt
      ```

  1. Run the command below to upload the file, stating the path to the local file, bucket name, and [key](../../storage/concepts/object.md#key) for storing the object in the bucket:

      ```bash
      aws s3 cp test-file.txt \
        s3://<bucket_name>/test-file.txt \
        --profile ephemeral-profile
      ```

      Result:

      ```text
      upload: ./test-file.txt to s3://my-bucket/test-file.txt
      ```

  1. Make sure the object has been uploaded successfully:

      ```bash
      aws s3 ls s3://<bucket_name>/ \
        --profile ephemeral-profile
      ```

      Result:

      ```text
      2025-10-03 09:45:12         23 test-file.txt
      ```

  For more information, see [{#T}](../../storage/operations/objects/upload.md).

{% endlist %}


## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:

* [Delete the objects](../../storage/operations/objects/delete-all.md) from the bucket.
* [Delete the bucket](../../storage/operations/buckets/delete.md).
