---
title: Managing bucket versioning in {{ objstorage-full-name }}
description: Follow this guide to learn how to manage an {{ objstorage-name }} bucket versioning.
---

# Managing bucket versioning

Bucket [versioning](../../concepts/versioning.md) enables keeping a history of an object through its versions.

{% note info %}

You cannot disable versioning once you enable it; however, you can pause the creation of new versions. After you pause versioning, new objects will be saved as `null` versions.

{% endnote %}

To enable bucket versioning:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}** from the list of services.
  1. Click the name of the bucket in question.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/wrench.svg) **{{ ui-key.yacloud.storage.bucket.switch_settings }}**.
  1. Select the **{{ ui-key.yacloud.storage.bucket.switch_versioning }}** tab.
  1. To enable or pause versioning, use **{{ ui-key.yacloud.storage.bucket.versioning.field_status }}**.
  1. Click **{{ ui-key.yacloud.storage.bucket.settings.button_save }}**.

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for editing a bucket ACL:

     ```bash
     yc storage bucket update --help
     ```  

  1. Run this command:

     ```bash
     yc storage bucket update --name <bucket_name> --versioning versioning-enabled
     ```

     Result:

     ```text
     name: my-bucket
     folder_id: csgeoelk7fl15********
     default_storage_class: STANDARD
     versioning: VERSIONING_ENABLED
     max_size: "10737418240"
     acl: {}
     created_at: "2022-12-14T08:42:16.273717Z"
     ```

- AWS CLI {#aws-cli}

  If you do not have the AWS CLI yet, [install and configure it](../../tools/aws-cli.md).

  Run this command:

  ```bash
  aws --endpoint https://{{ s3-storage-host }} \
    s3api put-bucket-versioning \
    --bucket <bucket_name> \
    --versioning-configuration 'Status=Enabled'
  ```

- {{ TF }} {#tf}

  {% include [terraform-role](../../../_includes/storage/terraform-role.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  Retrieve [static access keys](../../../iam/operations/authentication/manage-access-keys.md#create-access-key): a secret key and key ID used for {{ objstorage-short-name }} authentication.

  {% include [terraform-iamtoken-note](../../../_includes/storage/terraform-iamtoken-note.md) %}

  In the configuration file, define the parameters of the resources you want to create:

  ```hcl
  resource "yandex_iam_service_account" "sa" {
    name = "<service_account_name>"
  }

  // Assigning a role to a service account
  resource "yandex_resourcemanager_folder_iam_member" "sa-admin" {
    folder_id = "<folder_ID>"
    role      = "storage.admin"
    member    = "serviceAccount:${yandex_iam_service_account.sa.id}"
  }

  // Creating a static access key
  resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
    service_account_id = yandex_iam_service_account.sa.id
    description        = "static access key for object storage"
  }

  resource "yandex_storage_bucket" "b" {
    bucket     = "<bucket_name>"
    access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
    secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
    acl        = "private"

    versioning {
      enabled = true
    }
  }
  ```

  Where:

  * `bucket`: Bucket name. This is a required parameter.
  * `access_key`: Static access key ID.
  * `secret_key`: Secret access key value.
  * `acl`: ACL policy to apply. The default value is `private`. This is an optional parameter.
  * `versioning`: Managing bucket versioning:
    * `enabled`: Enables bucket versioning. This is an optional parameter.

- API {#api}

  To manage bucket versioning, use the [update](../../api-ref/Bucket/update.md) REST API method for the [Bucket](../../api-ref/Bucket/index.md) resource, the [BucketService/Update](../../api-ref/grpc/Bucket/update.md) gRPC API call, or the [putBucketVersioning](../../s3/api-ref/bucket/putBucketVersioning.md) S3 API method.

{% endlist %}
