# Managing lifecycles of object in buckets

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

   Retrieve {% if audience != "internal" %}[static access keys](../../../iam/operations/sa/create-access-key.md){% else %}static access keys{% endif %}: a static key and a key ID used to authenticate in {{ objstorage-short-name }}.

   1. In the configuration file, describe the parameters of resources that you want to create:

      {% if product == "yandex-cloud" %}

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

      {% endif %}

      {% if product == "cloud-il" %}

      ```hcl
      provider "yandex" {
        cloud_id         = "<cloud ID>"
        folder_id        = "<folder ID>"
        zone             = "<availability zone>"
        endpoint         = "{{ api-host }}:443"
        token            = "<static key of service account>"
        storage_endpoint = "{{ s3-storage-host }}"
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

      {% endif %}

      Where:

      * `bucket`: Bucket name. Required parameter.
      * `access_key`: The ID of the static access key.
      * `secret_key`: The value of the secret access key.

      `lifecycle_rule` parameters:
      * `id`: Unique rule ID. Must be no more than 255 characters. Optional.
      * `prefix`: Object key prefix that identifies one or more objects that the rule applies to. Optional.
      * `enabled`: Rule status. Required parameter.
      * `abort_incomplete_multipart_upload_days`: The number of days after the start of a multipart upload when it should be completed. Optional.
      * `expiration`: Object expiration date for deleting non-current object versions. Optional.
      * `transition`: Object expiration date of changing storage class from `STANDARD` to `COLD`. Optional.
      * `noncurrent_version_expiration`: Rule for deleting non-current object versions. Optional.
      * `noncurrent_version_transition`: Rule of changing storage class from `STANDARD` to `COLD` for non-active object versions. Optional.

      Make sure to specify at least one of the following parameters: `abort_incomplete_multipart_upload_days`, `expiration`, `transition`, `noncurrent_version_expiration`, or `noncurrent_version_transition`.

      `expiration` parameters:
      * `date`: Date after which you want the rule to take effect. Optional.
      * `days`: The number of days after creating an object when the rule takes effect. Minimum value: 1. Optional.

      `transition` parameters:
      * `date`: Date after which you want the rule to take effect. Optional.
      * `days`: The number of days after creating an object when the rule takes effect. Minimum value: 1. Optional.
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
