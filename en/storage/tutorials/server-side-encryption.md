# Server-side encryption

In this scenario, you'll enable bucket encryption. As a symmetric encryption key, you'll use a [{{ kms-full-name }} key](../../kms/concepts/key.md) . This key will encrypt all new bucket objects with [envelope encryption](../../kms/concepts/envelope.md).


To decrypt objects, the user must have both the {{ objstorage-name }} role and the `kms.keys.decrypter` role that allows reading the encryption key (see the [role description](../../kms/security/index.md#service)).


To enable server-side bucket encryption:

1. [Prepare your cloud](#before-you-begin).
1. [Create a bucket](#create-bucket).
1. [Create a key](#create-key).
1. [Enable encryption](#enable-encryption).

If you no longer need to encrypt new bucket objects, [disable encryption](#disable-encryption).

## Prepare your cloud {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

The cost of maintaining a bucket with encryption includes:

* Fee for storing data in a bucket (see [{{ objstorage-name }} pricing](../pricing.md#prices-storage)).
* Fee for data operations (see [{{ objstorage-name }} pricing](../pricing.md#prices-operations)).
* A fee for using KMS keys (see [{{ kms-name }} pricing](../../kms/pricing.md#prices)).


## Create a bucket {#create-bucket}

You can create a new bucket or use an existing one. To create a bucket, run:

{% list tabs %}

- Management console

   1. Go to the [management console]({{ link-console-main }}) and select the folder to perform your steps in.
   1. On the folder page, click **Create resource** and select **Bucket**.
   1. In the **Name** field, name the bucket, such as `example-bucket`.

      The name must meet the following requirements:

      {% include [bucket-name-reqs](../../_includes/bucket-name-reqs.md) %}

   1. Specify the maximum size of the bucket in GB.
   1. Choose **Limited** access to the bucket.
   1. Click **Create bucket**.

- {{ TF }}

   If you do not have {{ TF }} yet, [install it and configure the {{ yandex-cloud }} provider](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   1. Describe the resources in the configuration file. In this scenario, the parameters are specified under `locals`:

      
      ```
      locals {
        cloud_id    = "<cloud ID>"
        folder_id   = "<folder ID>"
        oauth       = "<OAuth>"
        zone        = "{{ region-id }}-a"

        sa_name     = "new-buckets-account"
        sa_desc     = "Account for managing {{ objstorage-name }} buckets"
        sa_key_desc = "Static key for ${local.sa_name}"

        bucket_name = "example-bucket" # The name of the bucket being created. If you don't specify a bucket name for the `yandex_storage_bucket` resource, a name is generated automatically.
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

   2. Make sure the configuration files are valid.

      1. In the command line, go to the directory where you created the configuration file.

      1. Run the check using this command:

      ```bash
      terraform plan
      ```

      If the configuration is described correctly, the terminal will display a list of created resources and their parameters. If the configuration contains any errors, {{ TF }} will point them out.

   3. Deploy cloud resources.

      1. If the configuration does not contain any errors, run this command:

         ```bash
         terraform apply
         ```

      2. Confirm that you want to create the resources.

         After the command is executed, {{ TF }} updates or creates the following resources in the specified folder:

         * The `new-buckets-account` service account.
         * The `editor` role for `new-buckets-account`.
         * A static key for the service account.
         * A bucket named `example-bucket`.

         You can use the [management console]({{ link-console-main }}) to check that the resources have been created.

- AWS CLI

   1. If you do not have the AWS CLI yet, [install and configure it](../tools/aws-cli.md).

   1. Run the following command:

      ```bash
      aws s3 mb s3://example-bucket --endpoint-url=https://{{ s3-storage-host }}
      ```

      Result:

      ```bash
      make_bucket: example-bucket
      ```

{% endlist %}

## Create a key {#create-key}

Create a new key or use an existing one. To create a key:

{% list tabs %}

- Management console

   1. Log in to the [management console]({{ link-console-main }}).
   1. Select **{{ kms-name }}**.
   1. In the **Keys** tab, click **Create** and set the key attributes:

      * The key's name and optional description in any form, like `key-1` and `bucket-key`.
      * Encryption algorithm, such as `AES-256`.
      * [Rotation](../../kms/concepts/version.md#rotate-key)  period, for example, `7 days`.
      * Click **Create**.

   The key is created along with its first version: click the key in the list to open the page with its attributes.

- CLI

   Run the following command:

   ```bash
   yc kms symmetric-key create \
     --name key-1 \
     --default-algorithm aes-256 \
     --rotation-period 7d
   ```

   Where:

   * `name`: Key name.
   * `default-algorithm`: Encryption algorithm (`aes-128`, `aes-192`, or `aes-256`).
   * `rotation-period`: Key rotation period. To create a key without automatic rotation, don't specify the `rotation-period` parameter.

   The key is created along with its first version. It's specified in the `primary_version` field.

- {{ TF }}

   1. Describe the resources in the configuration file. In this scenario, the parameters are specified under `locals`:

      
      ```
      locals {
        cloud_id    = "<cloud ID>"
        folder_id   = "<folder ID>"
        oauth       = "<OAuth>"
        zone        = "{{ region-id }}-a"

        sa_name     = "new-buckets-account"
        sa_desc     = "Account for managing {{ objstorage-name }} buckets"
        sa_key_desc = "Static key for ${local.sa_name}"

        key_name    = "key-1" # KMS key name.
        key_desc    = "Bucket encryption key"

        bucket_name = "example-bucket"
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



   1. Make sure the configuration files are valid.

      1. In the command line, go to the directory where you created the configuration file.

      1. Run the check using this command:

         ```bash
         terraform plan
         ```

         If the configuration is described correctly, the terminal will display a list of created resources and their parameters. If the configuration contains any errors, {{ TF }} will point them out.

   1. Deploy cloud resources.

      1. If the configuration does not contain any errors, run this command:

         ```bash
         terraform apply
         ```

      1. Confirm that you want to create the resources.

         After the command is executed, {{ TF }} updates or creates the following resources in the specified folder:

         * The `new-buckets-account` service account.
         * The `editor` role for `new-buckets-account`.
         * A static key for the service account.
         * A {{ kms-short-name }} key named `key-1`.
         * A bucket named `example-bucket`.

         You can use the [management console]({{ link-console-main }}) to check that the resources have been created.

- API

   Use the [create](../../kms/api-ref/SymmetricKey/create.md) method for the `SymmetricKey` resource.

{% endlist %}

## Enable encryption {#enable-encryption}

To enable bucket encryption with a {{ kms-short-name }} key:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to `example-bucket`.
   1. In the left panel, select **Encryption**.
   1. In the **{{ kms-short-name }} key** field, select `key-1`.
   1. Click **Save**.

- {{ TF }}

   1. Describe the resources in the configuration file. In this scenario, the parameters are specified under `locals`:

      
      ```
      locals {
        cloud_id    = "<cloud ID>"
        folder_id   = "<folder ID>"
        oauth       = "<OAuth>"
        zone        = "{{ region-id }}-a"

        sa_name     = "new-buckets-account"
        sa_desc     = "Account for managing {{ objstorage-name }} buckets"
        sa_key_desc = "Static key for ${local.sa_name}"

        key_name    = "key-1" # KMS key name.
        key_desc    = "Bucket encryption key"

        bucket_name = "example-bucket" # Bucket name.
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



   1. Make sure the configuration files are valid.

      1. In the command line, go to the directory where you created the configuration file.

      1. Run the check using this command:

         ```bash
         terraform plan
         ```

         If the configuration is described correctly, the terminal will display a list of created resources and their parameters. If the configuration contains any errors, {{ TF }} will point them out.

   1. Deploy cloud resources.

      1. If the configuration does not contain any errors, run this command:

         ```bash
         terraform apply
         ```

      1. Confirm that you want to create the resources.

         After the command is executed, {{ TF }} updates or creates the following resources in the specified folder:

         * The `new-buckets-account` service account.
         * The `editor` role for `new-buckets-account`.
         * A static key for the service account.
         * A {{ kms-short-name }} key named `key-1`.
         * The `example-bucket` bucket with encryption.

         You can use the [management console]({{ link-console-main }}) to check that the resources have been deleted.

         As a result of successful command execution, all new objects in `example-bucket` will be encrypted with `key-1`.

- AWS CLI

  Run the following command:

  ```
  aws s3api put-bucket-encryption \
    --bucket example-bucket \
    --endpoint-url=https://{{ s3-storage-host }} \
    --server-side-encryption-configuration '{
   	"Rules": [
   	  {
   		"ApplyServerSideEncryptionByDefault": {
   		  "SSEAlgorithm": "aws:kms",
   		  "KMSMasterKeyID": "<KMS key ID>"
   		},
   		"BucketKeyEnabled": true
	  }
   	]
    }'
  ```

  As a result of successful command execution, all new objects in `example-bucket` will be encrypted with `key-1`.

{% endlist %}

## Disable encryption {#disable-encryption}

If you no longer need to encrypt new bucket objects, disable encryption.

{% note alert %}

After you disable bucket encryption, previously uploaded objects will be stored in encrypted form. Data in {{ objstorage-name }} is encrypted using [envelope encryption](../../kms/concepts/envelope.md). Deleting a key is the same as destroying all data encrypted with that key.

{% endnote %}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to `example-bucket`.
   1. In the left panel, select **Encryption**.
   1. In the **{{ kms-short-name }} key** field, set **Not selected**.
   1. Click **Save**.

- {{ TF }}

   1. Describe the resources in the configuration file. To disable encryption, delete or comment out the `server_side_encryption_configuration` section for the `yandex_storage_bucket` resource:

      
      ```
      locals {
        cloud_id    = "<cloud ID>"
        folder_id   = "<folder ID>"
        oauth       = "<OAuth>"
        zone        = "{{ region-id }}-a"

        sa_name     = "new-buckets-account"
        sa_desc     = "Account for managing {{ objstorage-name }} buckets"
        sa_key_desc = "Static key for ${local.sa_name}"

        key_name    = "key-1"
        key_desc    = "Bucket encryption key"

        bucket_name = "example-bucket"
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



   1. Make sure the configuration files are valid.

      1. In the command line, go to the directory where you created the configuration file.
      1. Run the check using this command:

         ```bash
         terraform plan
         ```

         If the configuration is described correctly, the terminal will display a list of created resources and their parameters. If the configuration contains any errors, {{ TF }} will point them out.

   1. Deploy cloud resources.

      1. If the configuration does not contain any errors, run this command:

         ```bash
         terraform apply
         ```

      1. Confirm that you want to update the resources.

         After the command is executed, {{ TF }} updates the following resources in the specified folder:

         * The `new-buckets-account` service account.
         * The `editor` role for `new-buckets-account`.
         * A static key for the service account.
         * A {{ kms-short-name }} key named `key-1`.
         * A bucket named `example-bucket`.

         The `example-bucket` encryption in the specified folder will be disabled. You can check whether the resources and their settings are updated in the [management console]({{ link-console-main }}).

- AWS CLI

   Run the following command:

   ```bash
   aws s3api delete-bucket-encryption \
     --bucket example-bucket \
     --endpoint-url=https://{{ s3-storage-host }}
   ```

   As a result of successful execution, the `example-bucket` encryption is disabled.

{% endlist %}
