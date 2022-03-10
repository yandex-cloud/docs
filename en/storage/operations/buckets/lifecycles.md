# Managing lifecycles of object in buckets

{{ objstorage-name }} lets you manage [lifecycles](../../concepts/lifecycles.md) for objects in buckets.

{% list tabs %}

- Management console
  1. In the management console, go to the bucket you want to configure object lifecycles for.
  1. Select **Lifecycle**.
  1. Click **Configure**.
  1. On the page that opens, you can add, remove, and edit configuration rules. For a detailed description of the configuration fields, see [{#T}](../../s3/api-ref/lifecycles/xml-config.md).

    {% note info %}

    In the management console, you can't use a single rule to set the criteria for deleting objects or changing the object storage class. Use a separate rule for each type of criteria.

    {% endnote %}

- AWS CLI

    To upload a configuration via the AWS CLI:

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

- Terraform

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  Get [static access keys](../../../iam/operations/sa/create-access-key.md): a private key and key ID used for authentication in {{ objstorage-short-name }}.

  1. In the configuration file, describe the parameters of resources that you want to create:
     * `access_key`: The ID of the static access key.
     * `secret_key`: The value of the private access key.
     * `bucket`: Bucket name. Required parameter.

     `lifecycle_rule` parameters:
     * `id`: Unique rule ID. Must be no more than 255 characters. Optional.
     * `prefix`: Object key prefix that identifies one or more objects that the rule applies to. Optional.
     * `enabled`: Rule status. Required parameter.
     * `abort_incomplete_multipart_upload_days`: The number of days after the start of a multipart upload when it should be completed. Optional.
     * `expiration`: Object expiration date for deleting non-current object versions. Optional.
     * `transition`: Object expiration date for changing the storage class. Optional.
     * `noncurrent_version_expiration`: Rule for deleting non-current object versions. Optional.
     * `noncurrent_version_transition`: Rule for changing the storage class of non-current object versions. Optional.

     Make sure to specify at least one of the following parameters: `abort_incomplete_multipart_upload_days`, `expiration`, `transition`, `noncurrent_version_expiration`, or `noncurrent_version_transition`.

     `expiration` parameters:
     * `date`: Date after which you want the rule to take effect. Optional.
     * `days`: The number of days after creating an object when the rule takes effect. Optional.

     `transition` parameters:
     * `date`: Date after which you want the rule to take effect. Optional.
     * `days`: The number of days after creating an object when the rule takes effect. Optional.
     * `storage_class`: Storage class to move the object to. Either `COLD` or `STANDARD_IA`. Required parameter.

     `noncurrent_version_expiration` parameters:
     * `days`: The number of days before expiration. Required parameter.

     `noncurrent_version_transition` parameters:
     * `days`: The number of days before the transition. Required parameter.
     * `storage_class`: Storage class to move the object to. Either `COLD` or `STANDARD_IA`. Required parameter.

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

     For more information about the resources you can create using Terraform, see the [provider documentation](https://www.terraform.io/docs/providers/yandex/index.html).

  1. Make sure that the configuration files are correct.

     1. In the command line, go to the directory where you created the configuration file.

     1. Run the check using the command:

        ```bash
        terraform plan
        ```

     If the configuration is described correctly, the terminal displays a list of created resources and their parameters. If there are errors in the configuration, Terraform points them out.

  1. Deploy the cloud resources.

     1. If the configuration doesn't contain any errors, run the command:

        ```bash
        terraform apply
        ```

     1. Confirm that you want to create the resources.

     Afterwards, all the necessary resources are created in the specified folder. You can check resource availability and their settings in the [management console]({{ link-console-main }}).

{% endlist %}

