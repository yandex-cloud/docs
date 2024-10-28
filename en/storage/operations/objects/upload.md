# Uploading an object

You can create folders inside buckets and upload objects there. Keep in mind that in the SDK and HTTP API, an object key is the entire path to the object from the bucket root. For more information, see [{#T}](../../concepts/object.md).

{% note info %}

You can upload objects of up to 5 GB via the management console (see [{#T}](../../concepts/limits.md)). When uploading via the console, you cannot set `content-type` or other headers. To upload large objects or specify object headers, use other [tools](../../tools/index.md).

{% endnote %}

You can use [tools](../../tools/index.md) that support {{ objstorage-name }} and [signed URLs](../../concepts/pre-signed-urls.md) to upload objects into the bucket.

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
       s3 cp <local_file_path> s3://<bucket_name>/<object_key>
     ```

     Where:

     * `--endpoint-url`: {{ objstorage-name }} endpoint.
     * `s3 cp`: Command to upload an object. To upload an object, in the first part of the command, specify the path to the local file to upload. In the second part, provide the name of your bucket and [key](../../concepts/object.md#key) you will use to store the object in the bucket.

     To load all objects from the local directory, use the following command:

     ```bash
     aws --endpoint-url=https://{{ s3-storage-host }}/ \
       s3 cp --recursive <path_to_local_directory>/ s3://<bucket_name>/<prefix>/
     ```

     Where:

     * `--endpoint-url`: {{ objstorage-name }} endpoint.
     * `s3 cp --recursive`: Command to upload all objects stored in a local directory, including the nested ones. To upload objects, specify the path to the folder to copy the files from in the first part of the command and the name of the bucket to copy the files to and the [ID of the folder](../../concepts/object.md#folder) in storage in the second part.

  `aws s3 cp` is a high-level command with limited functionality. For more information, see the [AWS CLI reference](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/s3/cp.html). All upload features {{ objstorage-name }} supports can be used when running the [aws s3api put-object](https://awscli.amazonaws.com/v2/documentation/api/latest/reference/s3api/put-object.html) command  (see sample operations with [object locks](../../concepts/object-lock.md) [below](#w-object-lock)).

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
     * `access_key`: Static access key ID.
     * `secret_key`: Secret access key value.
     * `bucket`: Name of the bucket where to add the object. This is a required parameter.
     * `key`: Name of the object in the bucket. This is a required parameter. The name format is as follows:

        {% include [name-format](../../../_includes/name-format.md) %}

     * `source`: Relative or absolute path to the file you need to upload to the bucket.

     For more details about resources you can create using {{ TF }}, see [the provider documentation]({{ tf-provider-resources-link }}/storage_object).

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
       --body <local_file_path> \
       --bucket <bucket_name> \
       --key <object_key> \
       --object-lock-mode <retention_type> \
       --object-lock-retain-until-date <retention_period_end_date_and_time> \
       --object-lock-legal-hold-status <legal_hold_status>
     ```

     Where:

     * `--endpoint-url`: {{ objstorage-name }} endpoint.
     * `s3api put-object`: Command to upload an object version. To upload object versions with an object lock, specify the following parameters:
       * `--body`: Path to the file you need to upload to the bucket.
       * `--bucket`: Name of your bucket.
       * `--key`: [Key](../../concepts/object.md#key) to use for storing the object in the bucket.
       * `--object-lock-mode`: [Type](../../concepts/object-lock.md#types) of object lock with retention:

         * `GOVERNANCE`: Temporary managed lock.
         * `COMPLIANCE`: Temporary strict lock.

       * `--object-lock-retain-until-date`: Retention end date and time in any format described in the [HTTP standard](https://www.rfc-editor.org/rfc/rfc9110#name-date-time-formats), e.g., `Mon, 12 Dec 2022 09:00:00 GMT`. You can only specify it together with the `--object-lock-mode` parameter.

       * `--object-lock-legal-hold-status`: [Legal hold](../../concepts/object-lock.md#types) status:

         * `ON`: Enabled.
         * `OFF`: Disabled.

     For an object version, you can use only object lock with retention (`object-lock-mode` and `object-lock-retain-until-date` parameters), only legal hold (`object-lock-legal-hold-status`), or both at the same time. For more information about their combined use, see [{#T}](../../concepts/object-lock.md#types).

- API {#api}

  To upload an object version with a lock, use the [upload](../../s3/api-ref/object/upload.md) S3 API method with the `X-Amz-Object-Lock-Mode` and `X-Amz-Object-Lock-Retain-Until-Date` headers to apply a retention period and `X-Amz-Object-Lock-Legal-Hold` to put a legal hold.

{% endlist %}

If [object locks with retention](../../concepts/object-lock.md#default) are configured for a bucket by default, when uploading objects to that bucket, you should specify their [MD5 hashes](https://{{ lang }}.wikipedia.org/wiki/MD5):

{% list tabs group=instructions %}

- AWS CLI {#cli}

  1. Calculate a file’s MD5 hash and encode it with [Base64](https://{{ lang }}.wikipedia.org/wiki/Base64):

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

     * `--object-lock-mode` and `--object-lock-retain-until-date` to place an object version under an object lock with retention that is different from the bucket's default settings.
     * `--object-lock-legal-hold-status` to place a legal hold on an object version.
 
     For more information about these parameters, see the guide above.

- API {#api}

  To upload an object version with a default retention period, use the [upload](../../s3/api-ref/object/upload.md) S3 API method with the `Content-MD5` header.

{% endlist %}


#### See also {#see-also}

* [{#T}](../../tutorials/storage-vpc-access.md)
