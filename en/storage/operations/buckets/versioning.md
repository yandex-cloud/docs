---
title: "Managing bucket versioning in {{ objstorage-full-name }}"
description: "Bucket versioning makes it possible to store object history through versions. In this article, you will learn how to manage versioning in {{ objstorage-name }}."
---

# Managing bucket versioning

Bucket [versioning](../../concepts/versioning.md) enables storing object history through versions.

{% note info %}

You cannot disable versioning once you enable it; however, you can pause new version creation. After you pause versioning, new objects will be saved as `null` versions.

{% endnote %}

Enable bucket versioning:

{% list tabs group=instructions %}

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. View a description of the CLI command to edit a bucket ACL:

     ```bash
     yc storage bucket update --help
     ```

  1. Run the following command:

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

  Run the following command:

  ```bash
  aws --endpoint https://{{ s3-storage-host }} \
    s3api put-bucket-versioning \
    --bucket <bucket_name> \
    --versioning-configuration 'Status=Enabled'
  ```

- {{ TF }} {#tf}

  {% include [terraform-role](../../../_includes/storage/terraform-role.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  Retrieve [static access keys](../../../iam/operations/sa/create-access-key.md): a static key and a key ID used to authenticate in {{ objstorage-short-name }}.

  In the configuration file, describe the parameters of the resources you want to create:

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
  * `versioning`: Managing bucket versioning.
    * `enabled`: Enables bucket versioning. This is an optional parameter.

- API {#api}

  To manage bucket versioning, use the [update](../../api-ref/Bucket/update.md) REST API method for the [Bucket](../../api-ref/Bucket/index.md) resource, the [BucketService/Update](../../api-ref/grpc/bucket_service.md#Update) gRPC API call, or the [putBucketVersioning](../../s3/api-ref/bucket/putBucketVersioning.md) S3 API method.

{% endlist %}
