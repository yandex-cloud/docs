# Uploading an object

You can create folders inside buckets and upload objects there. Keep in mind that in the SDK and HTTP API, an object key is the entire path to the object from the bucket root. For more information, see [{#T}](../../concepts/object.md).

{% note info %}

You cannot upload objects larger than 5 GB via the management console (see [{#T}](../../concepts/limits.md)). When uploading via the console, you also cannot set `content-type` or other headers. To upload large objects or specify object headers, use other [tools](../../tools/index.md).

{% endnote %}


## Regular uploads {#simple}


{% include [encryption-roles](../../../_includes/storage/encryption-roles.md) %}


{% list tabs group=instructions %}

- Management console {#console}

   In the management console, you can work with {{ objstorage-name }} buckets like a hierarchical file system.

   To upload an object:
   1. In the [management console]({{ link-console-main }}), select the folder to upload an object to.
   1. Select **{{ objstorage-name }}**.
   1. Click the name of the bucket you need.
   1. If you want to upload the object to a particular folder, go to that folder by clicking on its name. If you want to create a new folder, click **{{ ui-key.yacloud.storage.bucket.button_create }}**.
   1. Once you navigate to the appropriate folder, click **{{ ui-key.yacloud.storage.bucket.button_upload }}**.
   1. In the window that opens, select the required files and click **Open**.
   1. The management console displays all the objects selected for uploading and prompts you to select a [storage class](../../concepts/storage-class.md). The default storage class is defined in the [bucket settings](../../concepts/bucket.md#bucket-settings).
   1. Click **{{ ui-key.yacloud.storage.button_upload }}**.
   1. Refresh the page.

   In the management console, information about the number of objects in a bucket and the used space is updated with a few minutes' delay.

- AWS CLI {#cli}

   1. If you do not have the AWS CLI yet, [install and configure it](../../tools/aws-cli.md).
   1. To upload a single object, run the command:

      ```bash
      aws --endpoint-url=https://{{ s3-storage-host }}/ \
        s3 cp <path_to_local_file>/ s3://<bucket_name>/<object_key>
      ```

      Where:

      * `--endpoint-url`: {{ objstorage-name }} endpoint.
      * `s3 cp`: Command to upload an object. To upload an object, specify the path to the local file to upload in the first part of the command and the name of the bucket and the [key](../../concepts/object.md#key) to associate with the object in the bucket in the second part.

      To load all objects from the local directory, use the following command:

      ```bash
      aws --endpoint-url=https://{{ s3-storage-host }}/ \
        s3 cp --recursive <path_to_local_directory>/ s3://<bucket_name>/<prefix>/
      ```

      Where:

      * `--endpoint-url`: {{ objstorage-name }} endpoint.
      * `s3 cp --recursive`: Command to upload all objects contained in a local directory, including nested ones. To upload objects, specify the path to the folder to copy the files from in the first part of the command and the name of the bucket to copy the files to and the [ID of the folder](../../concepts/object.md#folder) in storage in the second part.

   The `aws s3 cp` command is high-level, its functionality is limited. For more information, see the [AWS CLI reference](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/s3/cp.html). All upload features {{ objstorage-name }} supports can be used when running the [aws s3api put-object](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/s3api/put-object.html) command (see sample operations with [object locks](../../concepts/object-lock.md) [below](#w-object-lock)).

- {{ TF }} {#tf}

   {% include [terraform-role](../../../_includes/storage/terraform-role.md) %}

   {% include [terraform-definition](../../../_tutorials/_tutorials_includes/terraform-definition.md) %}

   {% include [terraform-install](../../../_includes/terraform-install.md) %}

   Before you start, retrieve the [static access keys](../../../iam/operations/sa/create-access-key.md): a secret key and a key ID used for authentication in {{ objstorage-short-name }}.

   To create an object in an existing bucket:

   1. In the configuration file, describe the parameters of resources that you want to create:

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

      resource "yandex_storage_object" "test-object" {
        access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
        secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key
        bucket     = "<bucket_name>"
        key        = "<object_name>"
        source     = "<path_to_file>"
      }
      ```

      Where:
      * `access_key`: ID of the static access key.
      * `secret_key`: Value of the secret access key.
      * `bucket`: Name of the bucket to add the object to. This is a required parameter.
      * `key`: Name of the object in the bucket. This is a required parameter. The name format is as follows:

         {% include [name-format](../../../_includes/name-format.md) %}

      * `source`: Relative or absolute path to the files you need to upload to the bucket.

      For more information about resources you can create with {{ TF }}, see the [provider documentation]({{ tf-provider-resources-link }}/storage_object).

   1. Make sure the configuration files are correct.

      1. In the command line, go to the folder where you created the configuration file.
      1. Run a check using this command:

         ```bash
         terraform plan
         ```

      If the configuration is described correctly, the terminal will display a list of created resources and their parameters. If the configuration contains any errors, {{ TF }} will point them out.

   1. Deploy cloud resources.

      1. If the configuration does not contain any errors, run this command:

         ```bash
         terraform apply
         ```

      1. Confirm creating the resources: type `yes` in the terminal and press **Enter**.

         All the resources you need will then be created in the specified folder. You can check the new resources and their configuration using the [management console]({{ link-console-main }}).

- API {#api}

   To upload an object, use the [upload](../../s3/api-ref/object/upload.md) S3 API method.

{% endlist %}


## Uploading an object version with an object lock {#w-object-lock}

If a bucket has [versioning](../buckets/versioning.md) and [object lock](../buckets/configure-object-lock.md) enabled, you can specify object lock settings (disable deleting or overwriting) when uploading an object version.

{% list tabs group=instructions %}

- AWS CLI {#cli}

   1. If you do not have the AWS CLI yet, [install and configure it](../../tools/aws-cli.md).
   1. Run this command:

      ```bash
      aws --endpoint-url=https://{{ s3-storage-host }}/ \
        s3api put-object \
        --body <path_to_local_file> \
        --bucket <bucket_name> \
        --key <object_key> \
        --object-lock-mode <type_of_object_lock_with_retention_period> \
        --object-lock-retain-until-date <object_lock_retain_until_date_and_time> \
        --object-lock-legal-hold-status <status_of_legal_hold>
      ```

      Where:

      * `--endpoint-url`: {{ objstorage-name }} endpoint.
      * `s3api put-object`: Command to upload an object version. To upload object versions with an object lock, specify the following parameters:
         * `--body`: Path to the file to be uploaded to the bucket.
         * `--bucket`: Name of your bucket.
         * `--key`: [Key](../../concepts/object.md#key) to store the object in the bucket with.
         * `--object-lock-mode`: [Type](../../concepts/object-lock.md#types) of object lock set for a certain period:

            * `GOVERNANCE`: Object lock with a predefined retention period that can be managed.
            * `COMPLIANCE`: Object lock with a predefined retention period with strict compliance.

         * `--object-lock-retain-until-date` Date and time until which an object is to be locked, specified in any format described in the [HTTP standard](https://www.rfc-editor.org/rfc/rfc9110#name-date-time-formats), e.g., `Mon, 12 Dec 2022 09:00:00 GMT`. Can only be set together with the `--object-lock-mode` parameter.

         * `--object-lock-legal-hold-status`: [Legal hold](../../concepts/object-lock.md#types) status:

            * `ON`: Enabled.
            * `OFF`: Disabled.

      You can place an object version only under an object lock with a retention period (the `object-lock-mode` and `object-lock-retain-until-date` parameters), only under a legal hold (`object-lock-legal-hold-status`), or under both. For more information about their combined use, see [{#T}](../../concepts/object-lock.md#types).

- API {#api}

   To upload an object version with a lock, use the [upload](../../s3/api-ref/object/upload.md) S3 API method with the `X-Amz-Object-Lock-Mode` and `X-Amz-Object-Lock-Retain-Until-Date` headers to apply a retention period and `X-Amz-Object-Lock-Legal-Hold` to put a legal hold.

{% endlist %}

If a bucket already has the [default object locks set for a certain period](../../concepts/object-lock.md#default) configured, you should upload any objects to it with their [MD5 hash](https://{{ lang }}.wikipedia.org/wiki/MD5) specified:

{% list tabs group=instructions %}

- AWS CLI {#cli}

   1. Calculate a file's MD5 hash and encode it with [Base64](https://{{ lang }}.wikipedia.org/wiki/Base64):

      ```bash
      md5=($(md5sum <path_to_local_file>))
      md5_base64=$(echo $md5 | base64)
      ```

   1. If you do not have the AWS CLI yet, [install and configure it](../../tools/aws-cli.md).
   1. Upload an object to the bucket:

      ```bash
      aws --endpoint-url=https://{{ s3-storage-host }}/ \
        s3api put-object \
        --body <path_to_local_file> \
        --bucket <bucket_name> \
        --key <object_key> \
        --content-md5 $md5_base64
      ```

      Where:

      * `--endpoint-url`: {{ objstorage-name }} endpoint.
      * `s3api put-object`: Command to upload an object version. To upload object versions, specify the following parameters:
         * `--body`: Path to the file to be uploaded to the bucket.
         * `--bucket`: Name of your bucket.
         * `--key`: [Key](../../concepts/object.md#key) to store the object in the bucket with.
         * `--content-md5`: Object's encoded MD5 hash.

      You can also add the following parameters to the command:

      * `--object-lock-mode` and `--object-lock-mode` to place an object version under an object lock for a certain period with a configuration different from the bucket's object lock default settings.
      * `--object-lock-legal-hold-status` to place an object version under a legal hold.

      For more information about these parameters, see the guide above.

- API {#api}

   To upload an object version with a default retention period, use the [upload](../../s3/api-ref/object/upload.md) S3 API method with the `Content-MD5` header.


{% endlist %}
