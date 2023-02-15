# Managing bucket object lifecycles

{{ objstorage-name }} lets you manage [lifecycles of objects](../../concepts/lifecycles.md) in a bucket.

Changes are applied to the lifecycles at 00:00 UTC every 24 hours.

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the bucket you want to configure object lifecycles for.
   1. Select **Lifecycle**.
   1. Click **Configure**.
   1. On the page that opens, you can add, remove, and edit configuration rules.

      {% include [storage-create-rule](../../_includes_service/storage-create-rule.md) %}

      For more information, see [{#T}](../../s3/api-ref/lifecycles/xml-config.md).

   {% note info %}

   In the management console, you can't use a single rule to set the criteria for deleting objects or changing the object storage class. Use a separate rule for each type of criteria.

   {% endnote %}

- {{ yandex-cloud }} CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. Define the object lifecycle configuration in JSON format. For example:

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

      Supported configuration parameters:
      * `id`: Unique rule ID. Must be no more than 255 characters. Optional.
      * `enabled`: Rule status. Required parameter.
      * `filter`: Object filter. Optional. It may contain:
         * `prefix`: Object key prefix that identifies one or more objects that the rule applies to. Optional.
      * `transition`: Object expiration date of changing storage class from `STANDARD` to `COLD`. Optional. It may contain:
         * `date`: Date after which you want the rule to take effect. Optional.
         * `days`: The number of days after creating an object when the rule takes effect. Minimum value: 1. Optional.
         * `storage_class`: Storage class to move the object to. Either `COLD` or `STANDARD_IA`. Required parameter.
      * `expiration`: Object expiration date for deleting non-current object versions. Optional. It may contain:
         * `date`: Date after which you want the rule to take effect. Optional.
         * `days`: The number of days after creating an object when the rule takes effect. Minimum value: 1. Optional.
      * `noncurrent_version_transition`: Rule of changing storage class from `STANDARD` to `COLD` for non-active object versions. Optional. It may contain:
         * `days`: The number of days before the transition. Minimum value: 1. Required parameter.
         * `storage_class`: Storage class to move the object to. Either `COLD` or `STANDARD_IA`. Required parameter.
      * `noncurrent_version_expiration`: Rule for deleting non-current object versions. Optional. It may contain:
         * `days`: The number of days before expiration. Minimum value: 1. Required parameter.
      * `abort_incomplete_multipart_upload_days`: The number of days after the start of a multipart upload when it should be completed. Optional.

      Make sure to specify at least one of the following parameters: `transition`, `expiration`, `noncurrent_version_transition`, `noncurrent_version_expiration`, or `abort_incomplete_multipart_upload_days`.

      Once completed, save the configuration to a file like `lifecycles.json`.

   1. View the description of the CLI command to update a bucket:

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
      | first-bucket     | b1gmit33ngp6cv2mhjmo | 53687091200 | STANDARD              | 2022-12-16 13:58:18 |
      +------------------+----------------------+-------------+-----------------------+---------------------+
      ```

   1. Save the name of the bucket (the `NAME` column) to set up the lifecycles in.
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

   To remove the lifecycle configuration, run the command:

   ```bash
   yc storage bucket update \
     --name <bucket_name> \
     --remove-lifecycle-rules
   ```

- AWS CLI

   To upload a configuration via the [AWS CLI](../../tools/aws-cli.md):

   1. Define the object lifecycle configuration in JSON format. For example:

      ```json
      {
        "Rules": [
          {
            "ID": "DeleteOldBackups",
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

      When you're done, you can save your configuration as a file, like `lifecycles.json`.

   1. Upload the configuration to a bucket, like `backup-bucket`:

      ```bash
      aws s3api put-bucket-lifecycle-configuration \
        --bucket backup-bucket \
        --endpoint-url=https://{{ s3-storage-host }} \
        --lifecycle-configuration file://lifecycles.json
      ```

- {{ TF }}

   {% include [terraform-install](../../../_includes/terraform-install.md) %}

   Retrieve [static access keys](../../../iam/operations/sa/create-access-key.md): a static key and a key ID used to authenticate in {{ objstorage-short-name }}.

   1. In the configuration file, describe the parameters of resources that you want to create:

      
      ```hcl
      provider "yandex" {
        cloud_id  = "<cloud ID>"
        folder_id = "<folder ID>"
        zone      = "<availability zone>"
        token     = "<OAuth token>"
        }

      resource "yandex_storage_bucket" "bucket" {
        bucket     = "<bucket name>"
        acl        = "private"
        access_key = "<key ID>"
        secret_key = "<secret key>"

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
        bucket     = "<bucket name>"
        acl        = "private"
        access_key = "<key ID>"
        secret_key = "<secret key>"

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

      * `bucket`: Bucket name. Required parameter.
      * `access_key`: The ID of the static access key.
      * `secret_key`: The value of the secret access key.

      `lifecycle_rule` parameters:
      * `id`: Unique rule ID. Must be no more than 255 characters. This is an optional parameter.
      * `prefix`: Object key prefix that identifies one or more objects that the rule applies to. This is an optional parameter.
      * `enabled`: Rule status. Required parameter.
      * `abort_incomplete_multipart_upload_days`: The number of days after the start of a multipart upload when it should be completed. This is an optional parameter.
      * `expiration`: Object expiration date for deleting non-current object versions. This is an optional parameter.
      * `transition`: Object expiration date of changing storage class from `STANDARD` to `COLD`. This is an optional parameter.
      * `noncurrent_version_expiration`: Rule for deleting non-current object versions. This is an optional parameter.
      * `noncurrent_version_transition`: Rule of changing storage class from `STANDARD` to `COLD` for non-active object versions. This is an optional parameter.

      Make sure to specify at least one of the following parameters: `abort_incomplete_multipart_upload_days`, `expiration`, `transition`, `noncurrent_version_expiration`, or `noncurrent_version_transition`.

      `expiration` parameters:
      * `date`: Date after which you want the rule to take effect. This is an optional parameter.
      * `days`: The number of days after creating an object when the rule takes effect. Minimum value: 1. This is an optional parameter.

      `transition` parameters:
      * `date`: Date after which you want the rule to take effect. This is an optional parameter.
      * `days`: The number of days after creating an object when the rule takes effect. Minimum value: 1. This is an optional parameter.
      * `storage_class`: Storage class to move the object to. Either `COLD` or `STANDARD_IA`. Required parameter.

      `noncurrent_version_expiration` parameters:
      * `days`: The number of days before expiration. Minimum value: 1. Required parameter.

      `noncurrent_version_transition` parameters:
      * `days`: The number of days before the transition. Minimum value: 1. Required parameter.
      * `storage_class`: Storage class to move the object to. Either `COLD` or `STANDARD_IA`. Required parameter.

      For more information on resources that you can create with {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/).

   1. Make sure that the configuration files are valid.
      1. In the command line, go to the directory where you created the configuration file.
      1. Run the check using the command:

         ```bash
         terraform plan
         ```

      If the configuration is described correctly, the terminal displays a list of created resources and their parameters. If the configuration contains errors, {{ TF }} will point them out.

   1. Deploy the cloud resources.
      1. If the configuration doesn't contain any errors, run the command:

         ```bash
         terraform apply
         ```

      1. Confirm that you want to create the resources.

      Afterwards, all the necessary resources are created in the specified folder. You can check that the resources are there with the correct settings using the [management console]({{ link-console-main }}).

{% endlist %}
