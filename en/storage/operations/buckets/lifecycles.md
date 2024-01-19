# Managing bucket object lifecycles

{{ objstorage-name }} allows you to manage [object lifecycles](../../concepts/lifecycles.md) in a bucket.

Once a day, lifecycles are updated with the latest changes as of 00:00 UTC. This operation takes a few hours to complete.

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the bucket you want to configure object lifecycles for.
   1. Select **{{ ui-key.yacloud.storage.bucket.switch_lifecycle }}**.
   1. Click **{{ ui-key.yacloud.storage.bucket.lifecycle.button_lifecycle_empty-create }}**.
   1. On the page that opens, you can add, remove, and edit configuration rules.

      {% include [storage-create-rule](../../_includes_service/storage-create-rule.md) %}

      For more information, see [{#T}](../../s3/api-ref/lifecycles/xml-config.md).

- {{ yandex-cloud }} CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. Define the object lifecycle configuration in JSON format. Here is an example:

      ```json
      {
        "lifecycleRules": [
          {
            "id": "DeleteOldBackups",
            "enabled": true,
            "filter": {
              "prefix": "test/"
            },
            "expiration": {
              "days": 180
            }
          }
        ]
      }
      ```

      The possible configuration parameters include:
      * `id`: Unique rule ID, which must be 255 characters or less. This is an optional parameter.
      * `enabled`: Rule status. This is a required parameter.
      * `filter`: Object filter. This is an optional parameter. It may contain:
         * `prefix`: Object key prefix that identifies one or more objects the rule applies to. This is an optional parameter.
      * `transition`: Parameter of a rule for changing the storage class of any objects from `STANDARD` to `COLD` or `STANDARD_IA`. This is an optional parameter. It may contain:
         * `date`: Date after which you want the rule to take effect. This is an optional parameter.
         * `days`: Number of days after creating an object when the rule takes effect. The minimum value is 1. This is an optional parameter.
         * `storage_class`: Storage class to move the object to. Can be either `COLD` or `STANDARD_IA`. This is a required parameter.
      * `expiration`: Parameter of a rule for deleting any objects. This is an optional parameter. It may contain:
         * `date`: Date after which you want the rule to take effect. This is an optional parameter.
         * `days`: Number of days after creating an object when the rule takes effect. The minimum value is 1. This is an optional parameter.
      * `noncurrent_version_transition`: Parameter of a rule for changing the storage class of non-current object versions from `STANDARD` to `COLD` or `STANDARD_IA`. This is an optional parameter. It may contain:
         * `days`: Number of days before the transition. The minimum value is 1. This is a required parameter.
         * `storage_class`: Storage class to move the object to. Can be either `COLD` or `STANDARD_IA`. This is a required parameter.
      * `noncurrent_version_expiration`: Parameter of a rule for deleting non-current object versions. This is an optional parameter. It may contain:
         * `days`: Number of days before expiration. The minimum value is 1. This is a required parameter.
      * `abort_incomplete_multipart_upload_days`: Parameter of a rule for removing all parts of multipart uploads that were not completed within the specified number of days. This is an optional parameter.

      Make sure to specify at least one of the following parameters: `transition`, `expiration`, `noncurrent_version_transition`, `noncurrent_version_expiration`, or `abort_incomplete_multipart_upload_days`.

      Once completed, save the configuration to a file, e.g., `lifecycles.json`.

   1. View a description of the CLI command to update a bucket:

      ```bash
      yc storage bucket update --help
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

   1. Using the `NAME` column, save the name of the bucket to set up the lifecycles in.
   1. Run the following command:

      ```bash
      yc storage bucket update \
        --name <bucket_name> \
        --lifecycle-rules-from-file <configuration_file_path>
      ```

      Where:

      * `--name`: Name of the bucket to set up the lifecycles in.
      * `--lifecycle-rules-from-file`: Path to the lifecycle configuration file.

      The configuration specified in the command overrides the current bucket lifecycle settings. You can retrieve the current settings using the `yc storage bucket get <bucket_name> --full` command.

   To remove the lifecycle configuration, run this command:

   ```bash
   yc storage bucket update \
     --name <bucket_name> \
     --remove-lifecycle-rules
   ```

- AWS CLI

   To upload a configuration via the [AWS CLI](../../tools/aws-cli.md):

   1. Define the object lifecycle configuration in JSON format. Here is an example:

      ```json
      {
        "Rules": [
          {
            "ID": "DeleteOldTaggedBackups",
            "Filter": {
              "Prefix": "backup/"
            },
            "Status": "Enabled",
            "Expiration": {
              "Days": 180
            }
          }
        ]
      }
      ```

      The possible configuration parameters include:
      * `ID`: Unique rule ID, which must be 255 characters or less. This is an optional parameter.
      * `Filter`: Object filter. This is an optional parameter. It may only contain one element of each type:
         * `Prefix`: Key prefix. The rule applies to objects with the specified key prefix. This is an optional parameter. It cannot be used with the `Tag` filter.

         * `ObjectSizeGreaterThan`: Minimum object size in bytes. The rule applies to objects whose size is greater than or equal to the set one. This is an optional parameter.
         * `ObjectSizeLessThan`: Maximum object size in bytes. The rule applies to objects whose size is less than or equal to the set one. This is an optional parameter.
         * `Tag`: Object's [tag](../../concepts/tags.md#object-tags). This is an optional parameter. The rule applies to objects to which the specified tag is assigned. It cannot be used with the `Prefix` filter. It is delivered as a record that contains two pairs of values, for example:

            ```json
            "Tag": {"Key":"sample-key", "Value":"sample-value"}
            ```

         If no object filter is set, the rule applies to all objects in the bucket.
      * `Status`: Rule status. This is a required parameter. The possible values include:
         * `Enabled`: Rule enabled.
         * `Disabled`: Rule disabled.
      * `Transition`: Parameter of a rule for changing the storage class of any objects from `STANDARD` to `COLD` or `STANDARD_IA`. This is an optional parameter. It may contain:
         * `Date`: Date after which the storage class will change, in the [ISO 8601](https://ru.wikipedia.org/wiki/ISO_8601) format, e.g., `YYYY-MM-DD`. Time is always 00:00 UTC. This is an optional parameter.
         * `Days`: Number of days since the creation of the object, after which the storage class will be changed. The minimum value is `1`. This is an optional parameter.
         * `StorageClass`: Storage class to move the object to. Can be either `COLD` or `STANDARD_IA`. This is a required parameter.
      * `Expiration`: Parameter of a rule for deleting any objects. This is an optional parameter. It may contain:
         * `Date`: Date after which the object will be deleted, in the ISO 8601 format, e.g., `YYYY-MM-DD`. Time is always 00:00 UTC. This is an optional parameter.
         * `Days`: Number of days since the creation of the object, after which the object will be deleted. The minimum value is `1`. This is an optional parameter.
      * `NoncurrentVersionTransitions`: Parameter of a rule for changing the storage class of non-current object versions from `STANDARD` to `COLD` or `STANDARD_IA`. This is an optional parameter. It may contain:
         * `NoncurrentDays`: Number of days before changing the storage class of non-current object versions. The minimum value is `1`. This is a required parameter.
         * `StorageClass`: Storage class to move the object to. Can be either `COLD` or `STANDARD_IA`. This is a required parameter.
      * `NoncurrentVersionExpiration`: Parameter of a rule for deleting non-current object versions. This is an optional parameter.

         The rule has the required `NoncurrentDays` parameter that indicates the number of days before deleting non-current object versions. The minimum value is `1`.
      * `AbortIncompleteMultipartUpload`: Parameter of a rule for removing all parts of multipart uploads that were not completed within the specified number of days. This is an optional parameter.

         The rule has the required `DaysAfterInitiation` parameter that indicates the number of days since the upload start. The minimum value is `1`.

      Make sure to specify at least one of the following parameters: `Transition`, `Expiration`, `NoncurrentVersionTransition`, `NoncurrentVersionExpiration`, or `AbortIncompleteMultipartUpload`.

      Once completed, save the configuration to a file, e.g., `lifecycles.json`.

   1. Upload the configuration to a bucket, e.g., `backup-bucket`:

      ```bash
      aws s3api put-bucket-lifecycle-configuration \
        --bucket backup-bucket \
        --endpoint-url=https://{{ s3-storage-host }} \
        --lifecycle-configuration file://lifecycles.json
      ```

- {{ TF }}

   {% include [terraform-install](../../../_includes/terraform-install.md) %}

   Retrieve [static access keys](../../../iam/operations/sa/create-access-key.md): a static key and a key ID used to authenticate in {{ objstorage-short-name }}.

   1. In the configuration file, describe the parameters of the resources you want to create:

      
      ```hcl
      provider "yandex" {
        cloud_id  = "<cloud_ID>"
        folder_id = "<folder_ID>"
        zone      = "<availability_zone>"
        token     = "<OAuth_token>"
        }

      resource "yandex_storage_bucket" "bucket" {
        bucket     = "<bucket_name>"
        acl        = "private"
        access_key = "<key_ID>"
        secret_key = "<secret_key>"

        lifecycle_rule {
          id      = "log"
          enabled = true
          prefix = "log/"

          transition {
            days          = 30
            storage_class = "COLD"
          }

          expiration {
            days = 90
          }
        }

        lifecycle_rule {
          id      = "tmp"
          prefix  = "tmp/"
          enabled = true

          expiration {
            date = "2020-12-21"
          }
        }
      }

      resource "yandex_storage_bucket" "versioning_bucket" {
        bucket     = "<bucket_name>"
        acl        = "private"
        access_key = "<key_ID>"
        secret_key = "<secret_key>"

        versioning {
          enabled = true
        }

        lifecycle_rule {
          prefix  = "config/"
          enabled = true

          noncurrent_version_transition {
            days          = 30
            storage_class = "COLD"
          }

          noncurrent_version_expiration {
            days = 90
          }
        }
      }
      ```



      Where:

      * `bucket`: Bucket name. This is a required parameter.
      * `access_key`: ID of the static access key.
      * `secret_key`: Value of the secret access key.

      `lifecycle_rule` parameters:
      * `id`: Unique rule ID, which must be 255 characters or less. This is an optional parameter.
      * `prefix`: Object key prefix that identifies one or more objects that the rule applies to. This is an optional parameter.
      * `enabled`: Rule status. This is a required parameter.
      * `abort_incomplete_multipart_upload_days`: Parameter of a rule for removing all parts of multipart uploads that were not completed within the specified number of days. This is an optional parameter.
      * `expiration`: Parameter of a rule for deleting any objects. This is an optional parameter.
      * `transition`: Parameter of a rule for changing the storage class of any objects from `STANDARD` to `COLD` or `STANDARD_IA`. This is an optional parameter.
      * `noncurrent_version_expiration`: Parameter of a rule for deleting non-current object versions. This is an optional parameter.
      * `noncurrent_version_transition`: Parameter of a rule for changing the storage class of non-current object versions from `STANDARD` to `COLD` or `STANDARD_IA`. This is an optional parameter.

      Make sure to specify at least one of the following parameters: `abort_incomplete_multipart_upload_days`, `expiration`, `transition`, `noncurrent_version_expiration`, or `noncurrent_version_transition`.

      `expiration` parameters:
      * `date`: Date after which you want the rule to take effect. This is an optional parameter.
      * `days`: Number of days after creating an object when the rule takes effect. The minimum value is 1. This is an optional parameter.

      `transition` parameters:
      * `date`: Date after which you want the rule to take effect. This is an optional parameter.
      * `days`: Number of days after creating an object when the rule takes effect. The minimum value is 1. This is an optional parameter.
      * `storage_class`: Storage class to move the object to. Can be either `COLD` or `STANDARD_IA`. This is a required parameter.

      `noncurrent_version_expiration` parameters:
      * `days`: Number of days before expiration. The minimum value is 1. This is a required parameter.

      `noncurrent_version_transition` parameters:
      * `days`: Number of days before the transition. The minimum value is 1. This is a required parameter.
      * `storage_class`: Storage class to move the object to. Can be either `COLD` or `STANDARD_IA`. This is a required parameter.

      For more information about resources you can create with {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/).

   1. Make sure the configuration files are valid.
      1. In the command line, go to the directory where you created the configuration file.
      1. Run a check using this command:

         ```bash
         terraform plan
         ```

      If the configuration is specified correctly, the terminal will display a list of created resources and their parameters. If the configuration contains any errors, {{ TF }} will point them out.

   1. Deploy cloud resources.
      1. If the configuration does not contain any errors, run this command:

         ```bash
         terraform apply
         ```

      1. Confirm that you want to create the resources.

      All the resources you need will then be created in the specified folder. You can check the new resources and their configuration using the [management console]({{ link-console-main }}).

- API

   To manage bucket object lifecycles, use the [update](../../api-ref/Bucket/update.md) REST API method for the [Bucket](../../api-ref/Bucket/index.md) resource, the [BucketService/Update](../../api-ref/grpc/bucket_service.md#Update) gRPC API call, or the [upload](../../s3/api-ref/lifecycles/upload.md) S3 API method.

   If you are using the S3 API, specify a lifecycle configuration in [XML format](../../s3/api-ref/lifecycles/xml-config.md).

{% endlist %}
