[Ephemeral access keys](../../iam/concepts/authorization/ephemeral-keys.md) are temporary keys with a limited lifespan that provide a secure way to access [{{ objstorage-full-name }}](../../storage/) resources without having to store [static keys](../../iam/concepts/authorization/access-key.md). In this tutorial, you will learn how to create ephemeral keys and use them to create [buckets](../../storage/concepts/bucket.md) and upload [objects](../../storage/concepts/object.md) via the [AWS CLI](https://aws.amazon.com/cli/).

To upload objects to an {{ objstorage-name }} bucket using an ephemeral access key:

1. [Get your cloud ready](#before-you-begin).
1. [Create a service account](#create-sa).
1. [Create an ephemeral access key](#create-key).
1. [Configure the AWS CLI](#setup-aws-cli).
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

Install and configure the [AWS CLI](../../storage/tools/aws-cli.md).


## Create a service account {#create-sa}

Create a [service account](../../iam/concepts/users/service-accounts.md) you will use to create a bucket and upload objects. Assign it the `storage.editor` [role](../../storage/security/index.md#storage-editor) for the folder.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
  1. Click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
  1. In the **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_field_name }}** field, specify `ephemeral-sa`.
  1. Click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** and select `storage.editor`.
  1. Click **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

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


## Create an ephemeral access key {#create-key}

Create an ephemeral access key for the `ephemeral-sa` service account.

{% list tabs group=instructions %}

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Get the service account ID:

      ```bash
      yc iam service-account get --name ephemeral-sa --format json | jq -r .id
      ```

  1. Create an ephemeral access key:

      ```bash
      yc iam access-key issue-ephemeral \
        --subject-id <service_account_ID> \
        --session-name ephemeral-key-storage \
        --duration 2h
      ```

      Where:

      * `--subject-id`: ID of the `ephemeral-sa` service account you got in the previous step.
      * `--session-name`: Session name.
      * `--duration`: Key lifetime.

      Result:

      ```text
      access_key_id: ajelprpohp8t********
      secret: YCOs05v-KRXqhYpUINdWArH4MINhMyJ6CGU********
      session_token: s1.9muilY********
      expires_at: "2025-12-16T06:23:51.383485065Z"
      ```

  1. Save `access_key_id`, the `secret` key, and `session_token`.

      {% note alert %}

      You will not be able to get these values again.

      {% endnote %}

{% endlist %}


## Configure the AWS CLI {#setup-aws-cli}

Configure the AWS CLI to work with the ephemeral access key.

{% list tabs group=instructions %}

- AWS CLI {#aws-cli}

  1. Create a new profile in the `~/.aws/credentials` file:

      ```text
      [ephemeral-profile]
      aws_access_key_id     = <key_ID>
      aws_secret_access_key = <secret_key>
      aws_session_token     = <session_token>
      ```

      In this profile, specify the values you got when [creating](#create-key) the ephemeral key:

      * `aws_access_key_id`: `access_key_id` key ID.
      * `aws_secret_access_key`: `secret` key.
      * `aws_session_token`: `session_token`.

  1. Configure the {{ objstorage-name }} endpoint for the new profile:

      ```bash
      aws configure set endpoint_url https://{{ s3-storage-host }}/ --profile ephemeral-profile
      ```

      {% note info %}

      Instead of setting the endpoint, you can specify it when running commands using `--endpoint-url`.

      {% endnote %}

  1. Check your configuration:

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