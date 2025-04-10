---
title: Server-side encryption
description: Follow this guide to configure server-side encryption.
---

# Server-side encryption


In this scenario, you will enable bucket encryption. As a symmetric encryption key, you will use a [{{ kms-full-name }} key](../../kms/concepts/key.md). This key will encrypt all new bucket objects with [envelope encryption](../../kms/concepts/envelope.md).


{% include [encryption-roles](../../_includes/storage/encryption-roles.md) %}


To enable server-side bucket encryption:

1. [Get your cloud ready](#before-you-begin).
1. [Create a bucket](#create-bucket).
1. [Create a key](#create-key).
1. [Enable encryption](#enable-encryption).

If you no longer need to encrypt new bucket objects, [disable encryption](#disable-encryption).

## Get your cloud ready {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

The cost of maintaining a bucket with encryption includes:

* Fee for storing data in a bucket (see [{{ objstorage-name }} pricing](../pricing.md#prices-storage)).
* Fee for data operations (see [{{ objstorage-name }} pricing](../pricing.md#prices-operations)).
* Fee for using KMS keys (see [{{ kms-name }} pricing](../../kms/pricing.md#prices)).


## Create a bucket {#create-bucket}

You can create a new bucket or use an existing one. To create a bucket, run:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create a bucket.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. Click **{{ ui-key.yacloud.storage.buckets.button_create }}**.
  1. In the **{{ ui-key.yacloud.storage.bucket.settings.field_name }}** field, enter a name for the bucket.

     The name must meet the following requirements:

     {% include [bucket-name-reqs](../../_includes/bucket-name-reqs.md) %}

  1. Specify the maximum size of the bucket in GB.
  1. In the **{{ ui-key.yacloud.storage.bucket.settings.field_access-read }}**, **{{ ui-key.yacloud.storage.bucket.settings.field_access-list }}**, and **{{ ui-key.yacloud.storage.bucket.settings.field_access-config-read }}** fields, select **{{ ui-key.yacloud.storage.bucket.settings.access_value_private }}**.
  1. Click **{{ ui-key.yacloud.storage.buckets.create.button_create }}**.

- AWS CLI {#aws-cli}

  1. If you do not have the AWS CLI yet, [install and configure it](../tools/aws-cli.md).

  1. Run this command:

      ```bash
      aws s3 mb s3://<bucket_name> --endpoint-url=https://{{ s3-storage-host }}
      ```

      Result:

      ```text
      make_bucket: <bucket_name>
      ```

- {{ TF }} {#tf}

  {% include [terraform-role](../../_includes/storage/terraform-role.md) %}

  {% include [terraform-install](../../_includes/terraform-install.md) %}

  1. Describe the resources in the configuration file. In this scenario, specify the parameters under `locals`:

      ```
      locals {
        cloud_id    = "<cloud_ID>"
        folder_id   = "<folder_ID>"
        oauth       = "<OAuth>"
        zone        = "{{ region-id }}-a"

        sa_name     = "new-buckets-account"
        sa_desc     = "Account for managing {{ objstorage-name }} buckets"
        sa_key_desc = "Static key for ${local.sa_name}"

        bucket_name = "Bucket name" # Name of the bucket you are creating. If you do not specify a bucket name for the `yandex_storage_bucket` resource, the name will be generated automatically.
      }

      terraform {
        required_providers {
          yandex = {
            source = "yandex-cloud/yandex"
          }
        }
      }

      provider "yandex" {
        token     = local.oauth
        cloud_id  = local.cloud_id
        folder_id = local.folder_id
        zone      = local.zone
      }

      resource "yandex_iam_service_account" "buckets-account" {
        name        = local.sa_name
        description = local.sa_desc
      }

      resource "yandex_resourcemanager_folder_iam_member" "buckets-account-role" {
        folder_id = local.folder_id
        role      = "editor"
        member    = "serviceAccount:${yandex_iam_service_account.buckets-account.id}"
      }

      resource "yandex_iam_service_account_static_access_key" "buckets-account-key" {
        service_account_id = "${yandex_iam_service_account.buckets-account.id}"
        description        = local.sa_key_desc
      }

      resource "yandex_storage_bucket" "test" {
        bucket     = local.bucket_name
        access_key = "${yandex_iam_service_account_static_access_key.buckets-account-key.access_key}"
        secret_key = "${yandex_iam_service_account_static_access_key.buckets-account-key.secret_key}"
      }
      ```

      For more information about the resources you can create with [{{ TF }}](https://www.terraform.io/docs/language/index.html), see the [provider documentation]({{ tf-provider-link }}).

  1. Make sure the configuration files are correct.

      1. In the command line, go to the directory where you created the configuration file.

	    1. Run a check using this command:

        ```bash
        terraform plan
        ```

        If the configuration is correct, the terminal will display a list of the resources being created and their parameters. If the configuration contains any errors, {{ TF }} will point them out.

  1. Deploy the cloud resources.

      1. If the configuration does not contain any errors, run this command:

          ```bash
          terraform apply
          ```

      1. Confirm creating the resources.

          After the command is executed, {{ TF }} updates or creates the following resources in the specified folder:

          * `new-buckets-account` service account.
          * The `editor` role for the `new-buckets-account` service account.
          * Static key for the service account.
          * Bucket.

          You can check the new resources using the [management console]({{ link-console-main }}).

{% endlist %}

## Create a key {#create-key}

Create a new key or use an existing one. To create a key:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder you want to create a key in.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_kms }}**.
  1. Click **{{ ui-key.yacloud.kms.symmetric-keys.button_empty-create }}**.
  1. In the window that opens:

      * In the **{{ ui-key.yacloud.common.name }}** field, specify `bucket-key`.
      * In the **{{ ui-key.yacloud.kms.symmetric-key.form.field_algorithm }}** field, select `AES-256`.
      * In the **{{ ui-key.yacloud.kms.symmetric-key.form.field_rotation }}** field, set the [rotation](../../kms/concepts/version.md#rotate-key) period to `7 days`.
      * Click **{{ ui-key.yacloud.common.create }}**.

  The key is created together with its first version: click the key in the list to open a page with its attributes.

- {{ yandex-cloud }} CLI {#cli}

  Run this command:

  ```bash
  yc kms symmetric-key create \
    --name bucket-key \
    --default-algorithm aes-256 \
    --rotation-period 168h
  ```

  Where:

  * `--name`: Key name.
  * `--default-algorithm`: Encryption algorithm: `aes-128`, `aes-192`, or `aes-256`.
  * `--rotation-period`: Key rotation period. The value is set in hours, minutes, and seconds and cannot be less than 24 hours, e.g., `--rotation-period 27h14m27s`.

      To create a key without automatic rotation, do not specify the `--rotation-period` parameter.

  The key is created along with its first version. It is specified in the `primary_version` field.

- {{ TF }} {#tf}

  1. Describe the resources in the configuration file. In this scenario, specify the parameters under `locals`:

      ```
      locals {
        cloud_id    = "<cloud_ID>"
        folder_id   = "<folder_ID>"
        oauth       = "<OAuth>"
        zone        = "{{ region-id }}-a"

        sa_name     = "new-buckets-account"
        sa_desc     = "Account for managing {{ objstorage-name }} buckets"
        sa_key_desc = "Static key for ${local.sa_name}"

        key_name    = "bucket-key" # KMS key name
        key_desc    = "Bucket encryption key"

        bucket_name = "Bucket name"
      }

      terraform {
        required_providers {
          yandex = {
            source = "yandex-cloud/yandex"
          }
        }
      }

      provider "yandex" {
        token     = local.oauth
        cloud_id  = local.cloud_id
        folder_id = local.folder_id
        zone      = local.zone
      }

      resource "yandex_iam_service_account" "buckets-account" {
        name        = local.sa_name
        description = local.sa_desc
      }

      resource "yandex_resourcemanager_folder_iam_member" "buckets-account-role" {
        folder_id = local.folder_id
        role      = "editor"
        member    = "serviceAccount:${yandex_iam_service_account.buckets-account.id}"
      }

      resource "yandex_iam_service_account_static_access_key" "buckets-account-key" {
        service_account_id = "${yandex_iam_service_account.buckets-account.id}"
        description        = local.sa_key_desc
      }

      resource "yandex_kms_symmetric_key" "key-a" {
        name              = local.key_name
        description       = local.key_desc
        default_algorithm = "AES_256"
        rotation_period   = "168h"
      }

      resource "yandex_storage_bucket" "test" {
        bucket     = local.bucket_name
        access_key = "${yandex_iam_service_account_static_access_key.buckets-account-key.access_key}"
        secret_key = "${yandex_iam_service_account_static_access_key.buckets-account-key.secret_key}"
      }
      ```

  1. Make sure the configuration files are correct.

      1. In the command line, go to the directory where you created the configuration file.

      1. Run a check using this command:

          ```bash
          terraform plan
          ```

          If the configuration is correct, the terminal will display a list of the resources being created and their parameters. If the configuration contains any errors, {{ TF }} will point them out.

  1. Deploy the cloud resources.

      1. If the configuration does not contain any errors, run this command:

          ```bash
          terraform apply
          ```

      1. Confirm creating the resources.

          After the command is executed, {{ TF }} updates or creates the following resources in the specified folder:

          * `new-buckets-account` service account.
          * The `editor` role for the `new-buckets-account` service account.
          * Static key for the service account.
          * {{ kms-short-name }} key named `bucket-key`.
          * Bucket.

          You can check the new resources using the [management console]({{ link-console-main }}).

- API {#api}

  Use the [create](../../kms/api-ref/SymmetricKey/create.md) method for the `SymmetricKey` resource.

{% endlist %}

## Enable encryption {#enable-encryption}

To enable bucket encryption with a {{ kms-short-name }} key:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder the bucket is in.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. Select the previously created bucket.
  1. In the left-hand panel, select **{{ ui-key.yacloud.storage.bucket.switch_security }}**.
  1. Open the **{{ ui-key.yacloud.storage.bucket.switch_encryption }}** tab.
  1. In the **{{ ui-key.yacloud.storage.bucket.encryption.field_key }}** field, select `bucket-key`.
  1. Click **{{ ui-key.yacloud.storage.bucket.encryption.button_save }}**.

- AWS CLI {#aws-cli}

  Run this command:

  ```
  aws s3api put-bucket-encryption \
    --bucket <bucket_name> \
    --endpoint-url=https://{{ s3-storage-host }} \
    --server-side-encryption-configuration '{
	  "Rules": [
	    {
		  "ApplyServerSideEncryptionByDefault": {
		    "SSEAlgorithm": "aws:kms",
		    "KMSMasterKeyID": "<KMS_key_ID>"
		  },
		  "BucketKeyEnabled": true
		}
	  ]
	}'
  ```

- {{ TF }} {#tf}

  1. Describe the resources in the configuration file. In this scenario, specify the parameters under `locals`:

      ```
      locals {
        cloud_id    = "<cloud_ID>"
        folder_id   = "<folder_ID>"
        oauth       = "<OAuth>"
        zone        = "{{ region-id }}-a"

        sa_name     = "new-buckets-account"
        sa_desc     = "Account for managing {{ objstorage-name }} buckets"
        sa_key_desc = "Static key for ${local.sa_name}"

        key_name    = "bucket-key" # KMS key name
        key_desc    = "Bucket encryption key"

        bucket_name = "Bucket name" # Bucket name.
      }

      terraform {
        required_providers {
          yandex = {
            source = "yandex-cloud/yandex"
          }
        }
      }

      provider "yandex" {
        token     = local.oauth
        cloud_id  = local.cloud_id
        folder_id = local.folder_id
        zone      = local.zone
      }

      resource "yandex_iam_service_account" "buckets-account" {
        name        = local.sa_name
        description = local.sa_desc
      }

      resource "yandex_resourcemanager_folder_iam_member" "buckets-account-role" {
        folder_id = local.folder_id
        role      = "editor"
        member    = "serviceAccount:${yandex_iam_service_account.buckets-account.id}"
      }

      resource "yandex_iam_service_account_static_access_key" "buckets-account-key" {
        service_account_id = "${yandex_iam_service_account.buckets-account.id}"
        description        = local.sa_key_desc
      }

      resource "yandex_kms_symmetric_key" "key-a" {
        name              = local.key_name
        description       = local.key_desc
        default_algorithm = "AES_256"
        rotation_period   = "168h"
      }

      resource "yandex_storage_bucket" "test" {
        bucket     = local.bucket_name
        access_key = "${yandex_iam_service_account_static_access_key.buckets-account-key.access_key}"
        secret_key = "${yandex_iam_service_account_static_access_key.buckets-account-key.secret_key}"
        server_side_encryption_configuration {
          rule {
          apply_server_side_encryption_by_default {
            kms_master_key_id = yandex_kms_symmetric_key.key-a.id
            sse_algorithm     = "aws:kms"
          }
        }
        }
      }
      ```

  1. Make sure the configuration files are correct.

	    1. In the command line, go to the directory where you created the configuration file.

      1. Run a check using this command:

          ```bash
          terraform plan
          ```

          If the configuration is correct, the terminal will display a list of the resources being created and their parameters. If the configuration contains any errors, {{ TF }} will point them out.

  1. Deploy the cloud resources.

      1. If the configuration does not contain any errors, run this command:

          ```bash
          terraform apply
          ```

      1. Confirm creating the resources.

          After the command is executed, {{ TF }} updates or creates the following resources in the specified folder:

          * `new-buckets-account` service account.
          * The `editor` role for the `new-buckets-account` service account.
          * Static key for the service account.
          * {{ kms-short-name }} key named `bucket-key`.
          * Bucket with encryption.

          You can check the new resources using the [management console]({{ link-console-main }}).

{% endlist %}

Now all new objects in the bucket will be encrypted with `bucket-key`.

## Disable encryption {#disable-encryption}

If you no longer need to encrypt new bucket objects, disable encryption.

{% note alert %}

After you disable bucket encryption, previously uploaded objects will be stored in encrypted form. Data in {{ objstorage-name }} is encrypted using [envelope encryption](../../kms/concepts/envelope.md). Deleting a key is the same as deleting all data encrypted with that key.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder the bucket is in.
  1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. Select the previously created bucket.
  1. In the left-hand panel, select **{{ ui-key.yacloud.storage.bucket.switch_security }}**.
  1. Open the **{{ ui-key.yacloud.storage.bucket.switch_encryption }}** tab.
  1. In the **{{ ui-key.yacloud.storage.bucket.encryption.field_key }}** field, select `{{ ui-key.yacloud.component.symmetric-key-select.label_no-symmetric-key }}`.
  1. Click **{{ ui-key.yacloud.storage.bucket.encryption.button_save }}**.

- AWS CLI {#aws-cli}

  Run this command:

  ```bash
  aws s3api delete-bucket-encryption \
    --bucket <bucket_name> \
    --endpoint-url=https://{{ s3-storage-host }}
  ```

- {{ TF }} {#tf}

  1. Describe the resources in the configuration file. To disable encryption, delete or comment out the `server_side_encryption_configuration` section for the `yandex_storage_bucket` resource:

      ```
      locals {
        cloud_id    = "<cloud_ID>"
        folder_id   = "<folder_ID>"
        oauth       = "<OAuth>"
        zone        = "{{ region-id }}-a"

        sa_name     = "new-buckets-account"
        sa_desc     = "Account for managing {{ objstorage-name }} buckets"
        sa_key_desc = "Static key for ${local.sa_name}"

        key_name    = "bucket-key"
        key_desc    = "Bucket encryption key"

        bucket_name = "Bucket name"
      }

      terraform {
        required_providers {
          yandex = {
            source = "yandex-cloud/yandex"
          }
        }
      }

      provider "yandex" {
        token     = local.oauth
        cloud_id  = local.cloud_id
        folder_id = local.folder_id
        zone      = local.zone
      }

      resource "yandex_iam_service_account" "buckets-account" {
        name        = local.sa_name
        description = local.sa_desc
      }

      resource "yandex_resourcemanager_folder_iam_member" "buckets-account-role" {
        folder_id = local.folder_id
        role      = "editor"
        member    = "serviceAccount:${yandex_iam_service_account.buckets-account.id}"
      }

      resource "yandex_iam_service_account_static_access_key" "buckets-account-key" {
        service_account_id = "${yandex_iam_service_account.buckets-account.id}"
        description        = local.sa_key_desc
      }

      resource "yandex_kms_symmetric_key" "key-a" {
        name              = local.key_name
        description       = local.key_desc
        default_algorithm = "AES_256"
        rotation_period   = "168h"
      }

      resource "yandex_storage_bucket" "test" {
        bucket     = local.bucket_name
        access_key = "${yandex_iam_service_account_static_access_key.buckets-account-key.access_key}"
        secret_key = "${yandex_iam_service_account_static_access_key.buckets-account-key.secret_key}"
        /*
          server_side_encryption_configuration {
            rule {
            apply_server_side_encryption_by_default {
              kms_master_key_id = yandex_kms_symmetric_key.key-a.id
              sse_algorithm     = "aws:kms"
            }
          }
          }
        */
      }
      ```

  1. Make sure the configuration files are correct.

      1. In the command line, go to the directory where you created the configuration file.
      1. Run a check using this command:

          ```bash
          terraform plan
          ```

          If the configuration is correct, the terminal will display a list of the resources being created and their parameters. If the configuration contains any errors, {{ TF }} will point them out.

  1. Deploy the cloud resources.

      1. If the configuration does not contain any errors, run this command:

          ```bash
          terraform apply
          ```

      1. Confirm that you want to update the resources.

          After the command is executed, {{ TF }} updates the following resources in the specified folder:

          * `new-buckets-account` service account.
          * The `editor` role for the `new-buckets-account` service account.
          * Static key for the service account.
          * {{ kms-short-name }} key named `bucket-key`.
          * Bucket.

{% endlist %}

This will disable bucket encryption in the specified folder. You can check the resource update and configuration using the [management console]({{ link-console-main }}).