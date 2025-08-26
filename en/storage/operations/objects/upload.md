---
title: Uploading an object to a {{ objstorage-full-name }} bucket
description: Follow this guide to upload an object to an {{ objstorage-name }} bucket.
---

# Uploading an object

You can create folders within a bucket and upload objects to them. Keep in mind that in the SDK and HTTP API, an object key is the entire path to the object from the bucket root. For more information, see [{#T}](../../concepts/object.md).

{% note info %}

You can upload objects of up to 5 GB via the management console (see [{#T}](../../concepts/limits.md)). When uploading via the console, you cannot specify `content-type` or other headers. To upload larger objects or specify object headers, use other [tools](../../tools/index.md).

{% endnote %}

You can use [tools](../../tools/index.md) that support {{ objstorage-name }} and [signed URLs](../../concepts/pre-signed-urls.md) to upload objects into a bucket.

## Regular uploads {#simple}


{% include [encryption-roles](../../../_includes/storage/encryption-roles.md) %}


{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}** from the list of services and go to the bucket you want to upload your object to.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/folder-tree.svg) **{{ ui-key.yacloud.storage.bucket.switch_files }}**.
  1. If you want to upload an object to the bucket for the first time, click **{{ ui-key.yacloud.storage.bucket.button_empty-create }}**.
  1. If you want to upload the object to a specific folder, navigate to that folder by clicking its name. If you need to create a new folder, click **{{ ui-key.yacloud.storage.bucket.button_create }}**.
  1. Within the folder you need, click ![image](../../../_assets/console-icons/arrow-up-from-line.svg) **{{ ui-key.yacloud.storage.bucket.button_upload }}** on the top panel.
  1. In the window that opens, select the files and click **Open**.
  1. The management console will display all the objects you selected for uploading and prompt you to select a [storage class](../../concepts/storage-class.md). The [bucket configuration](../../concepts/bucket.md#bucket-settings) determines the default storage class.
  1. Click **{{ ui-key.yacloud.storage.button_upload }}**.
  1. Refresh the page.

  In the management console, the information about the number of objects and storage space used in the bucket is updated with a few minutes' delay.

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  {% include [upload-object-via-cli](../../../_includes/storage/upload-obect-via-cli.md) %}

- AWS CLI {#aws-cli}

  1. If you do not have the AWS CLI yet, [install and configure it](../../tools/aws-cli.md).
  1. To upload a single object, run this command:

     ```bash
     aws --endpoint-url=https://{{ s3-storage-host }}/ \
       s3 cp <local_file_path> s3://<bucket_name>/<object_key>
     ```

     Where:

     * `--endpoint-url`: {{ objstorage-name }} endpoint.
     * `s3 cp`: Command to upload an object. To upload an object, in the first part of the command, provide the path to the local file you want to upload, and in the second part, the name of your bucket and the object storage [key](../../concepts/object.md#key).

     To load all objects from the local directory, use the following command:
   
     ```bash
     aws --endpoint-url=https://{{ s3-storage-host }}/ \
       s3 cp --recursive <path_to_local_directory>/ s3://<bucket_name>/<prefix>/
     ```
   
     Where:
   
     * `--endpoint-url`: {{ objstorage-name }} endpoint.
     * `s3 cp --recursive`: Command to upload all objects stored in a local directory, including the nested ones. To upload objects, in the first part of the command, provide the path to the folder from which you want to copy the files to the bucket, and in the second part, the name of your bucket and storage [folder ID](../../concepts/object.md#folder).

  `aws s3 cp` is a high-level command providing limited features. For more information, see the [AWS CLI reference](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/s3/cp.html). All upload features {{ objstorage-name }} supports can be used when running the [aws s3api put-object](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/s3api/put-object.html) command (see examples of using [object locks](../../concepts/object-lock.md) [below](#w-object-lock)).

- {{ TF }} {#tf}

  {% include [terraform-role](../../../_includes/storage/terraform-role.md) %}

  {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  Before you start, retrieve the [static access keys](../../../iam/operations/authentication/manage-access-keys.md#create-access-key): a secret key and key ID used for {{ objstorage-short-name }} authentication.

  {% include [terraform-iamtoken-note](../../../_includes/storage/terraform-iamtoken-note.md) %}

  To create an object in an existing bucket:

  1. In the configuration file, define the parameters of the resources you want to create:

     ```hcl
     # Creating a service account

     resource "yandex_iam_service_account" "sa" {
       name = "<service_account_name>"
     }

     # Assigning roles to a service account

     resource "yandex_resourcemanager_folder_iam_member" "sa-admin" {
       folder_id = "<folder_ID>"
       role      = "storage.admin"
       member    = "serviceAccount:${yandex_iam_service_account.sa.id}"
     }

     # Creating a static access key
     
     resource "yandex_iam_service_account_static_access_key" "sa-static-key" {
       service_account_id = yandex_iam_service_account.sa.id
       description        = "static access key for object storage"
     }

     # Create object

     resource "yandex_storage_object" "test-object" {
       access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
       secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
       bucket     = "<bucket_name>"
       key        = "<object_name>"
       source     = "<path_to_file>"
     }
     ```

     Where:
     * `access_key`: Static access key ID.
     * `secret_key`: Secret access key value.
     * `bucket`: Name of the bucket to add the object to. This is a required parameter.
     * `key`: Name of the object in the bucket. This is a required parameter. Follow these naming requirements:

        {% include [name-format](../../../_includes/name-format.md) %}

     * `source`: Relative or absolute path to the file you need to upload to the bucket.

     To learn more about the resources you can create with {{ TF }}, see the [{{ TF }} documentation]({{ tf-provider-resources-link }}/storage_object).

1. Create the resources:

     {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

     This will create all the resources you need in the specified folder. You can check the new resources and their settings using the [management console]({{ link-console-main }}).

- API {#api}

  To upload an object, use the [upload](../../s3/api-ref/object/upload.md) S3 API method.

{% endlist %}

## Uploading an object version with an object lock {#w-object-lock}

For a bucket with enabled [versioning](../buckets/versioning.md) and [object lock](../buckets/configure-object-lock.md), you can define object lock settings (disable deleting or overwriting) when uploading an object version.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}** from the list of services and go to the bucket you want to upload your object to.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/folder-tree.svg) **{{ ui-key.yacloud.storage.bucket.switch_files }}**.
  1. If you want to upload an object to the bucket for the first time, click **{{ ui-key.yacloud.storage.bucket.button_empty-create }}**.
  1. If you want to upload the object to a specific folder, navigate to that folder by clicking its name. If you want to create a new folder, click **{{ ui-key.yacloud.storage.bucket.button_create }}** on the top panel.
  1. Within the folder you need, click ![image](../../../_assets/console-icons/arrow-up-from-line.svg) **{{ ui-key.yacloud.storage.bucket.button_upload }}** on the top panel.
  1. In the window that opens, select the files and click **Open**.
  1. The management console will display all the objects you selected for uploading and prompt you to select a [storage class](../../concepts/storage-class.md). The [bucket configuration](../../concepts/bucket.md#bucket-settings) determines the default storage class.
  1. To configure locks for the objects you are uploading, select the lock type from the **{{ ui-key.yacloud.storage.title_object-lock }}** drop-down list:
     * **{{ ui-key.yacloud.storage.field_perm-object-lock-enabled }}**: Indefinitely prohibits deleting or overwriting the object version, while you still can upload new versions of the object. A user with the `storage.uploader` role can set and remove legal hold. There is no way to bypass this type of lock. When combined with retention, legal hold takes priority.
     * **{{ ui-key.yacloud.storage.field_temp-object-lock-enabled }}**: Prohibits deleting or overwriting the object version for a specified period of time, while you still can upload new versions of the object. A user with the `storage.uploader` role can set a retention period. When combined with legal hold, retention takes no priority.
  1. If you selected **{{ ui-key.yacloud.storage.field_temp-object-lock-enabled }}**, specify **{{ ui-key.yacloud.storage.form.BucketObjectLockFormContent.field_mode_61kxf }}**:
     * **{{ ui-key.yacloud.storage.bucket.object-lock.title-mode-governance }}**: User with the `storage.admin` role can bypass the lock, change its expiration date, or remove it.
     * **{{ ui-key.yacloud.storage.bucket.object-lock.title-mode-compliance }}**: User with the `storage.admin` role can only extend the retention period. You cannot override, shorten, or remove such locks until they expire.
  1. Specify **{{ ui-key.yacloud.storage.form.BucketObjectLockFormContent.field_retention-period_jJYhy }}** in days or years. It starts from the moment you upload the object version to the bucket.
  1. Click **{{ ui-key.yacloud.storage.button_upload }}** and refresh the page.

  In the management console, the information about the number of objects and storage space used in the bucket is updated with a few minutes' delay.

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for uploading a file to a bucket:

      ```bash
      yc storage s3api put-object --help
      ```

  1. Get a list of buckets in the default folder:

      ```bash
      yc storage bucket list
      ```

      Result:

      ```text
      +------------------+----------------------+-------------+-----------------------+---------------------+
      |       NAME       |      FOLDER ID       |  MAX SIZE   | DEFAULT STORAGE CLASS |     CREATED AT      |
      +------------------+----------------------+-------------+-----------------------+---------------------+
      | first-bucket     | b1gmit33ngp6******** | 53687091200 | STANDARD              | 2022-12-16 13:58:18 |
      +------------------+----------------------+-------------+-----------------------+---------------------+
      ```

  1. Run this command:

      ```bash
      yc storage s3api put-object \
       --body <local_file_path> \
       --bucket <bucket_name> \
       --key <object_key> \
       --object-lock-mode <retention_type> \
       --object-lock-retain-until-date <retention_end_date_and_time> \
       --object-lock-legal-hold-status <legal_hold_status>
      ```

     Where:

     * `--body`: Path to the file you need to upload to the bucket.
     * `--bucket`: Name of your bucket.
     * `--key`: [Key](../../concepts/object.md#key) to use for storing the object in the bucket.
     * `--object-lock-mode`: [Type](../../concepts/object-lock.md#types) of retention:

       * `GOVERNANCE`: Governance-mode retention.
       * `COMPLIANCE`: Compliance-mode retention.
  
     * `--object-lock-retain-until-date`: Retention end date and time in any format described in the [HTTP standard](https://www.rfc-editor.org/rfc/rfc9110#name-date-time-formats), e.g., `2025-01-02T15:04:05Z`. You can only specify it together with the `--object-lock-mode` parameter.
  
     * `--object-lock-legal-hold-status`: [Legal hold](../../concepts/object-lock.md#types) status:
  
       * `ON`: Enabled.
       * `OFF`: Disabled.

     For an object version, you can use either retention (the `object-lock-mode` and `object-lock-retain-until-date` parameters), legal hold (`object-lock-legal-hold-status`), or both. For more information about their combined use, see [{#T}](../../concepts/object-lock.md#types).

     Result:

     ```bash
     etag: '"d41d8cd98f00b204e9800998********"'
     request_id: e19afe50********
     version_id: 0006241E********
     ```

- AWS CLI {#aws-cli}

  1. If you do not have the AWS CLI yet, [install and configure it](../../tools/aws-cli.md).
  1. Run this command:

     ```bash
     aws --endpoint-url=https://{{ s3-storage-host }}/ \
       s3api put-object \
       --body <local_file_path> \
       --bucket <bucket_name> \
       --key <object_key> \
       --object-lock-mode <retention_type> \
       --object-lock-retain-until-date <retention_end_date_and_time> \
       --object-lock-legal-hold-status <legal_hold_status>
     ```
     
     Where:
   
     * `--endpoint-url`: {{ objstorage-name }} endpoint.
     * `s3api put-object`: Command to upload an object version. To upload object versions with an object lock, specify the following parameters:
       * `--body`: Path to the file you need to upload to the bucket.
       * `--bucket`: Name of your bucket.
       * `--key`: [Key](../../concepts/object.md#key) to use for storing the object in the bucket.
       * `--object-lock-mode`: [Type](../../concepts/object-lock.md#types) of retention:
   
         * `GOVERNANCE`: Governance-mode retention.
         * `COMPLIANCE`: Compliance-mode retention.
    
       * `--object-lock-retain-until-date`: Retention end date and time in any format described in the [HTTP standard](https://www.rfc-editor.org/rfc/rfc9110#name-date-time-formats), e.g., `Mon, 12 Dec 2022 09:00:00 GMT`. You can only specify it together with the `--object-lock-mode` parameter.
    
       * `--object-lock-legal-hold-status`: [Legal hold](../../concepts/object-lock.md#types) status:
    
         * `ON`: Enabled.
         * `OFF`: Disabled.
    
     For an object version, you can use either retention (the `object-lock-mode` and `object-lock-retain-until-date` parameters), legal hold (`object-lock-legal-hold-status`), or both. For more information about their combined use, see [{#T}](../../concepts/object-lock.md#types).

- API {#api}

  To upload an object version with a lock, use the [upload](../../s3/api-ref/object/upload.md) S3 API method with the `X-Amz-Object-Lock-Mode` and `X-Amz-Object-Lock-Retain-Until-Date` headers to apply a retention period and `X-Amz-Object-Lock-Legal-Hold` to put a legal hold.

{% endlist %}

If your bucket already has [default retention periods](../../concepts/object-lock.md#default) configured, specify the relevant [MD5 hash](https://{{ lang }}.wikipedia.org/wiki/MD5) for any object you upload to the bucket:

{% list tabs group=instructions %}

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Determine the file’s MD5 hash and encode it with [Base64](https://{{ lang }}.wikipedia.org/wiki/Base64):

     ```bash
     md5=($(md5sum <local_file_path>))
     md5_base64=$(echo $md5 | base64)
     ```

  1. See the description of the CLI command for uploading a file to a bucket:

     ```bash
     yc storage s3api put-object --help
     ```

  1. Get a list of buckets in the default folder:

     ```bash
     yc storage bucket list
     ```

     Result:

     ```text
     +------------------+----------------------+-------------+-----------------------+---------------------+
     |       NAME       |      FOLDER ID       |  MAX SIZE   | DEFAULT STORAGE CLASS |     CREATED AT      |
     +------------------+----------------------+-------------+-----------------------+---------------------+
     | first-bucket     | b1gmit33ngp6******** | 53687091200 | STANDARD              | 2022-12-16 13:58:18 |
     +------------------+----------------------+-------------+-----------------------+---------------------+
     ```

  1. Upload an object to the bucket:

     ```bash
      yc storage s3api put-object \
       --body <local_file_path> \
       --bucket <bucket_name> \
       --key <object_key> \
       --content-md5 $md5_base64
     ```

     Where:

     * `--body`: Path to the file you need to upload to the bucket.
     * `--bucket`: Name of your bucket.
     * `--key`: [Key](../../concepts/object.md#key) to use for storing the object in the bucket.
     * `--content-md5`: Object's encoded MD5 hash.

     You can also add the following parameters to the command:

     * `--object-lock-mode` and `--object-lock-retain-until-date` to set a retention period for an object version that overrides the bucket's default retention settings.
     * `--object-lock-legal-hold-status` to set a legal hold on an object version.

     For more information about these parameters, see the steps above.

- AWS CLI {#aws-cli}

  1. Determine the file’s MD5 hash and encode it with [Base64](https://{{ lang }}.wikipedia.org/wiki/Base64):

     ```bash
     md5=($(md5sum <local_file_path>))
     md5_base64=$(echo $md5 | base64)
     ```

  1. If you do not have the AWS CLI yet, [install and configure it](../../tools/aws-cli.md).
  1. Upload an object to the bucket:

     ```bash
     aws --endpoint-url=https://{{ s3-storage-host }}/ \
       s3api put-object \
       --body <local_file_path> \
       --bucket <bucket_name> \
       --key <object_key> \
       --content-md5 $md5_base64
     ```
   
     Where:
   
     * `--endpoint-url`: {{ objstorage-name }} endpoint.
     * `s3api put-object`: Command to upload an object version. To upload object versions, specify the following parameters:
       * `--body`: Path to the file you need to upload to the bucket.
       * `--bucket`: Name of your bucket.
       * `--key`: [Key](../../concepts/object.md#key) to use for storing the object in the bucket.
       * `--content-md5`: Object's encoded MD5 hash.
     
     You can also add the following parameters to the command:
     
     * `--object-lock-mode` and `--object-lock-retain-until-date` to set a retention period for an object version that overrides the bucket's default retention settings.
     * `--object-lock-legal-hold-status` to set a legal hold on an object version.
 
     For more information about these parameters, see the steps above.

- API {#api}

  To upload an object version with a default retention period, use the [upload](../../s3/api-ref/object/upload.md) S3 API method with the `Content-MD5` header.

{% endlist %}


#### See also {#see-also}

* [{#T}](../../tutorials/storage-vpc-access.md)

