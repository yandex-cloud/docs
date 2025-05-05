---
title: Managing object lifecycles in a {{ objstorage-full-name }} bucket
description: Follow this guide to manage object lifecycles in an {{ objstorage-name }} bucket.
---

# Managing bucket object lifecycles

{{ objstorage-name }} enables managing bucket [object lifecycles](../../concepts/lifecycles.md).

Object lifecycles are updated daily at 00:00 UTC. This operation takes a few hours to complete.

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}** from the list of services and go to the bucket you want to configure object lifecycles for.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/wrench.svg) **{{ ui-key.yacloud.storage.bucket.switch_settings }}**.
  1. Select the **{{ ui-key.yacloud.storage.bucket.switch_lifecycle }}** tab.
  1. Click **{{ ui-key.yacloud.storage.bucket.lifecycle.button_lifecycle_empty-create }}**.
  1. Fill out the form that opens. You can add, delete, and edit configuration rules.

     {% include [storage-create-rule](../../_includes_service/storage-create-rule.md) %}

     For more information, see [{#T}](../../s3/api-ref/lifecycles/xml-config.md).

- {{ yandex-cloud }} CLI {#cli}

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
              "prefix": "backup/"
            },
            "transitions": [
              {
                "date": "2025-01-01T00:00:00Z",
                "storage_class": "ICE"
              }
            ],
            "expiration": {
              "days": "180"
            }
          }
        ]
      }
      ```

      The possible configuration parameters include:
      * `id`: Unique rule ID which must consist of 255 characters or less. This is an optional parameter.
      * `enabled`: Rule state. This is a required parameter.
      * `filter`: Object filter. This is an optional parameter. It may only contain one element of each type:

          * `prefix`: Object [key](../../concepts/object.md#key) prefix that identifies one or more objects falling under the rule. The rule applies to objects with the specified key prefix. This is an optional parameter.
          * `objectSizeGreaterThan`: Minimum object size in bytes. The rule applies to objects with a size greater than or equal to the specified value. This is an optional parameter.
          * `objectSizeLessThan`: Maximum object size in bytes. The rule applies to objects with a size less than or equal to the specified value. This is an optional parameter.
          * `tag`: Object [label](../../concepts/tags.md#object-tags). This is an optional parameter. The rule applies to objects with the specified label assigned. It is provided as a record that contains two key-value pairs, such as the following:

              ```json
              "tag": [{"key": "some_key", "value": "some_value"}]
              ```

          * `andOperator`: `AND` logical operator for filters. This is an optional parameter. Use this filter to combine prefix, size, and label filtering in a single rule. With `andOperator`, you can configure filtering by multiple labels at the same time. To do this, specify the labels in the `tag` key as an array of objects, each containing two key-value pairs.
          
              Here is an example of a filter using `AND`:

              ```json
              "filter": {
                "andOperator": {
                  "prefix": "backup/",
                  "tag": [
                    {
                      "key": "key_1",
                      "value": "value_1"
                    },
                    {
                      "key": "key_2",
                      "value": "value_2"
                    }
                  ],
                  "objectSizeGreaterThan": "16",
                  "objectSizeLessThan": "1024"
                }
              }
              ```

          Without a specified object filter, the rule applies to all objects in the bucket.

      * `transitions`: Parameter of a rule for changing the storage class of any objects from regular (`STANDARD`) to cold (`COLD`, `STANDARD_IA`) or ice (`ICE`) or from cold to ice. This is an optional parameter. It may contain:
          * `date`: Date after which you want the rule to take effect, in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format, such as `YYYY-MM-DDT00:00:00Z`. The time is always 00:00 UTC. You cannot use `date` together with `days`. This is an optional parameter.
          * `days`: Number of days following the object creation date after which the rule will take effect. The minimum value is `1`. You cannot use `days` together with `date`. This is an optional parameter.
          * `storage_class`: Storage class to move the object to. It can be `COLD`, `STANDARD_IA`, or `ICE`. This is a required setting.

          It is provided as an array, such as follows:

          ```json
          "transitions": [{ "days": "<number_of_days>", "storage_class": "<storage_class>" }]
          ```

          For buckets with [versioning](versioning.md) enabled, the action will apply to current versions of objects. To work with non-current versions of objects, use the `noncurrent_transitions` parameter.

      * `expiration`: Parameter of a rule for deleting any objects. This is an optional parameter. It may contain:
          * `date`: Date after which you want the rule to take effect, in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format, such as `YYYY-MM-DDT00:00:00Z`. The time is always 00:00 UTC. You cannot use `date` together with `days`. This is an optional parameter.
          * `days`: Number of days following the object creation date after which the rule will take effect. The minimum value is `1`. You cannot use `days` together with `date`. This is an optional parameter.
          * `expired_object_delete_marker`: Removes the delete marker for which expired object versions no longer exist. It can either be `true` or `false`. This is an optional parameter.

          For buckets with versioning enabled, the action will apply to current versions of objects. To work with non-current versions of objects, use the `noncurrent_expiration` parameter.

      * `noncurrent_transitions`: Parameter of a rule for changing the storage class of non-current object versions from regular (`STANDARD`) to cold (`COLD`, `STANDARD_IA`) or ice (`ICE`) or from cold to ice. This is an optional parameter. It may contain:
          * `noncurrent_days`: Number of days before transition. The minimum value is `1`. This is a required setting.
          * `storage_class`: Storage class to move the object to. It can be `COLD`, `STANDARD_IA`, or `ICE`. This is a required setting.
      * `noncurrent_expiration`: Parameter of a rule for deleting non-current object versions. This is an optional parameter. It may contain:
          * `noncurrent_days`: Number of days before expiration. The minimum value is `1`. This is a required setting.
      * `abort_incomplete_multipart_upload_days`: Parameter of a rule for removing all parts of multipart uploads that were not complete within the specified number of days. This is an optional parameter.
      * `noncurrent_delete_markers`: Parameter of a rule for deleting non-current delete markers. This is an optional parameter. It may contain:
          * `noncurrent_days`: Number of days that must elapse after the delete marker version is classified as non-current before the rule takes effect. The minimum value is `0`. This is a required setting.

      Make sure to specify at least one of the following parameters: `transitions`, `expiration`, `noncurrent_transitions`, `noncurrent_expiration`, or `abort_incomplete_multipart_upload_days`.

      Once the configuration is complete, save it to a file, e.g., `lifecycles.json`.

  1. See the description of the CLI command for updating a bucket:

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
   
  1. Save the `NAME` value for the bucket to configure object lifecycles in.
  1. Run this command:

      ```bash
      yc storage bucket update \
        --name <bucket_name> \
        --lifecycle-rules-from-file <path_to_configuration_file>
      ```

      Where:

      * `--name`: Name of the bucket to configure lifecycles in.
      * `--lifecycle-rules-from-file`: Path to the lifecycle configuration file.

      The configuration specified in the command overrides the current bucket lifecycle settings. You can retrieve the current settings using the `yc storage bucket get <bucket_name> --full` command.

  To remove the lifecycle configuration, run this command:

  ```bash
  yc storage bucket update \
    --name <bucket_name> \
    --remove-lifecycle-rules
  ```

- AWS CLI {#aws-cli}

  To upload a configuration using the [AWS CLI](../../tools/aws-cli.md):

  1. Define the object lifecycle configuration in JSON format. Here is an example:

      ```json
      {
        "Rules": [
          {
            "ID": "DeleteOldBackups",
            "Filter": {
              "Prefix": "backup/"
            },
            "Status": "Enabled",
            "Transitions": [
              {
                "Date": "2025-01-01",
                "StorageClass": "ICE"
              }
            ],
            "Expiration": {
              "Days": 180
            }
          }
        ]
      }
      ```

      The possible configuration parameters include:
      * `ID`: Unique rule ID which must consist of 255 characters or less. This is an optional parameter.
      * `Filter`: Object filter. This is an optional parameter. It may only contain one element of each type:

          * `Prefix`: Object [key](../../concepts/object.md#key) prefix. The rule applies to objects with the specified key prefix. This is an optional parameter.
          * `ObjectSizeGreaterThan`: Minimum object size in bytes. The rule applies to objects with a size greater than or equal to the specified value. This is an optional parameter.
          * `ObjectSizeLessThan`: Maximum object size in bytes. The rule applies to objects with a size less than or equal to the specified value. This is an optional parameter.
          * `Tag`: Object [label](../../concepts/tags.md#object-tags). This is an optional parameter. The rule applies to objects with the specified label assigned. It is provided as a record that contains two key-value pairs, such as the following:

              ```json
              "Tag": [{"Key": "some_key", "Value": "some_value"}]
              ```

          * `And`: `AND` logical operator for filters. This is an optional parameter. Use this filter to combine prefix, size, and label filtering in a single rule. With `And`, you can configure filtering by multiple labels at the same time. To do this, specify the labels in the `Tags` key as an array of objects, each containing two key-value pairs.
          
              Here is an example of a filter using `AND`:

              ```json
              "Filter": {
                "And": {
                  "Prefix": "backup/",
                  "Tags": [
                    {
                      "Key": "key_1",
                      "Value": "value_1"
                    },
                    {
                      "Key": "key_2",
                      "Value": "value_2"
                    }
                  ],
                  "ObjectSizeGreaterThan": 1,
                  "ObjectSizeLessThan": 1024
                }
              }
              ```

          Without a specified object filter, the rule applies to all objects in the bucket.

      * `Status`: Rule status. This is a required setting. It can take one of the following values:
          * `Enabled`: Rule enabled.
          * `Disabled`: Rule disabled.
      * `Transitions`: Parameter of a rule for changing the storage class of any objects from regular (`STANDARD`) to cold (`COLD`, `STANDARD_IA`) or ice (`ICE`) or from cold to ice. This is an optional parameter. It may contain:
          * `Date`: Date after which the storage class will change, in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format, such as `YYYY-MM-DD`. The time is always 00:00 UTC. You cannot use `Date` together with `Days`. This is an optional parameter.
          * `Days`: Number of days from the object creation date after which the storage class will change. The minimum value is `1`. You cannot use `Days` together with `Date`. This is an optional parameter.
          * `StorageClass`: Storage class to move the object to. It can be `COLD`, `STANDARD_IA`, or `ICE`. This is a required setting.

          It is provided as an array, such as follows:

          ```json
          "Transitions": [{ "Days": "<number_of_days>", "StorageClass": "<storage_class>" }]
          ```

          To set the `Transitions` parameter, you must specify the `Prefix` parameter in the configuration file. The `Prefix` value may be empty (`""`).

          For buckets with [versioning](versioning.md) enabled, the action will apply to current versions of objects. To work with non-current versions of objects, use the `NoncurrentVersionTransition` parameter.

      * `Expiration`: Parameter of a rule for deleting any objects. This is an optional parameter. It may contain:
          * `Date`: Date after which the object will be deleted, in [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format, such as `YYYY-MM-DD`. The time is always 00:00 UTC. You cannot use `Date` together with `Days`. This is an optional parameter.
          * `Days`: Number of days from the object creation date after which the object will be deleted. The minimum value is `1`. You cannot use `Days` together with `Date`. This is an optional parameter.
          * `ExpiredObjectDeleteMarker`: Removes the delete marker for which expired object versions no longer exist. It can either be `true` or `false`. This is an optional parameter.

          For buckets with versioning enabled, the action will apply to current versions of objects. To work with non-current versions of objects, use the `NoncurrentVersionExpiration` parameter.

      * `NoncurrentVersionTransitions`: Parameter of a rule for changing the storage class of non-current object versions from regular (`STANDARD`) to cold (`COLD`, `STANDARD_IA`) or ice (`ICE`) or from cold to ice. This is an optional parameter. It may contain:
          * `NoncurrentDays`: Number of days before the storage class of a non-current object version is changed. The minimum value is `1`. This is a required setting.
          * `StorageClass`: Storage class to move the object to. It can be `COLD`, `STANDARD_IA`, or `ICE`. This is a required setting.

          To set the `NoncurrentVersionTransitions` parameter, you must specify the `Prefix` parameter in the configuration file. The `Prefix` value may even be empty (`""`).
      * `NoncurrentVersionExpiration`: Parameter of a rule for deleting non-current object versions. This is an optional parameter. 

          The rule has the required `NoncurrentDays` parameter for the number of days before non-current object version is deleted. The minimum value is `1`.
      * `AbortIncompleteMultipartUpload`: Parameter of a rule for removing all parts of multipart uploads that were not complete within the specified number of days. This is an optional parameter.

          The rule has the required `DaysAfterInitiation` parameter for the number of days since the upload started. The minimum value is `1`.

      Specify at least one of the following parameters: `Transitions`, `Expiration`, `NoncurrentVersionTransition`, `NoncurrentVersionExpiration`, or `AbortIncompleteMultipartUpload`.

      Once the configuration is complete, save it to a file, e.g., `lifecycles.json`.

  1. Upload the configuration to the bucket, e.g., `backup-bucket`:

      ```bash
      aws s3api put-bucket-lifecycle-configuration \
        --bucket backup-bucket \
        --endpoint-url=https://{{ s3-storage-host }} \
        --lifecycle-configuration file://lifecycles.json
      ```

- {{ TF }} {#tf}

  {% include [terraform-role](../../../_includes/storage/terraform-role.md) %}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  Retrieve [static access keys](../../../iam/operations/authentication/manage-access-keys.md#create-access-key): a secret key and key ID used for {{ objstorage-short-name }} authentication.

  {% include [terraform-iamtoken-note](../../../_includes/storage/terraform-iamtoken-note.md) %}

  1. In the configuration file, describe the resources you want to create:

     ```hcl
     provider "yandex" {
       cloud_id  = "<cloud_ID>"
       folder_id = "<folder_ID>"
       zone      = "<availability_zone>"
       token     = "<OAuth_token>"
       }

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

     resource "yandex_storage_bucket" "bucket" {
       bucket     = "<bucket_name>"
       acl        = "private"
       access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
       secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key

       lifecycle_rule {
         id      = "log"
         enabled = true

         filter {
           tag {
             key   = "some_key"
             value = "some_value"
           }
         }

         transition {
           days          = 30
           storage_class = "COLD"
         }

         expiration {
           days = 90
         }
       }

       lifecycle_rule {
         id      = "backup"
         enabled = true

         filter {
           and {
             prefix = "backup/"
             tags   = {
               key1 = "value1"
               key2 = "value2"
             }
           }
         }

         expiration {
           date = "2020-12-21"
         }
       }
     }

     resource "yandex_storage_bucket" "versioning_bucket" {
       bucket     = "<bucket_name>"
       acl        = "private"
       access_key = yandex_iam_service_account_static_access_key.sa-static-key.access_key
       secret_key = yandex_iam_service_account_static_access_key.sa-static-key.secret_key

       versioning {
         enabled = true
       }

       lifecycle_rule {
         enabled = true

         filter {
           prefix = "config/"
         }

         noncurrent_version_transition {
           days          = 30
           storage_class = "ICE"
         }

         noncurrent_version_expiration {
           days = 90
         }
       }
     }
     ```

     Where:

     * `bucket`: Bucket name. This is a required setting.
     * `access_key`: Static access key ID.
     * `secret_key`: Secret access key value.

     `lifecycle_rule` parameters:
     * `id`: Unique rule ID which must consist of 255 characters or less. This is an optional parameter.
     * `filter`: Object filter. This is an optional parameter. It may only contain one element of each type:
         * `prefix`: Object [key](../../concepts/object.md#key) prefix that identifies one or more objects falling under the rule. This is an optional parameter.
         * `object_size_greater_than`: Minimum object size in bytes. The rule applies to objects with a size greater than or equal to the specified value. This is an optional parameter.
         * `object_size_less_than`: Maximum object size in bytes. The rule applies to objects with a size less than or equal to the specified value. This is an optional parameter.
         * `tag`: Object [label](../../concepts/tags.md#object-tags). This is an optional parameter. The rule applies to objects with the specified label assigned. It is provided as a record that contains two key-value pairs, such as the following:

             ```hcl
             tag {
               key   = "some_key"
               value = "some_value"
             }
             ```

         * `And`: `AND` logical operator for filters. This is an optional parameter. Use this filter to combine prefix, size, and label filtering in a single rule. With `And`, you can configure filtering by multiple labels at the same time. To do this, specify the labels as `key = value` pairs in the `tags` section.

             ```hcl
             filter {
               and {
                 prefix = "backup/"
                 tags = {
                   key1 = "value1"
                   key2 = "value2"
                 }
                 object_size_greater_than = 1
                 object_size_less_than    = 1024
               }
             }
             ```

         Without a specified object filter, the rule applies to all objects in the bucket.

     * `enabled`: Rule state. This is a required setting.
     * `abort_incomplete_multipart_upload_days`: Parameter of a rule for removing all parts of multipart uploads that were not complete within the specified number of days. This is an optional parameter.
     * `expiration`: Parameter of a rule for deleting any objects. For buckets with [versioning](versioning.md) enabled, the action will apply to current versions of objects. To work with non-current versions of objects, use the `noncurrent_version_expiration` parameter. This is an optional parameter.
     * `transition`: Parameter of a rule for changing the storage class of any objects from regular (`STANDARD`) to cold (`COLD`, `STANDARD_IA`) or ice (`ICE`) or from cold to ice. For buckets with versioning enabled, the action will apply to current versions of objects. To work with non-current versions of objects, use the `noncurrent_version_transition` parameter. This is an optional parameter.
     * `noncurrent_version_expiration`: Parameter of a rule for deleting non-current object versions. This is an optional parameter.
     * `noncurrent_version_transition`: Parameter of a rule for changing the storage class of non-current object versions from regular (`STANDARD`) to cold (`COLD`, `STANDARD_IA`) or ice (`ICE`) or from cold to ice. This is an optional parameter.

     Make sure to specify at least one of the following parameters: `abort_incomplete_multipart_upload_days`, `expiration`, `transition`, `noncurrent_version_expiration`, or `noncurrent_version_transition`.

     `expiration` parameters:
     * `date`: Date after which you want the rule to take effect, You cannot use `date` together with `days`. This is an optional parameter.
     * `days`: Number of days following the object creation date after which the rule will take effect. The minimum value is `1`. You cannot use `days` together with `date`. This is an optional parameter.
     * `expired_object_delete_marker`: Removes the delete marker for which expired object versions no longer exist. It can either be `true` or `false`. This is an optional parameter.

     `transition` parameters:
     * `date`: Date after which you want the rule to take effect, You cannot use `date` together with `days`. This is an optional parameter.
     * `days`: Number of days following the object creation date after which the rule will take effect. The minimum value is `1`. You cannot use `days` together with `date`. This is an optional parameter.
     * `storage_class`: Storage class to move the object to. It can be `COLD`, `STANDARD_IA`, or `ICE`. This is a required setting.

     `noncurrent_version_expiration` parameters:
     * `days`: Number of days before expiration. The minimum value is `1`. This is a required setting.

     `noncurrent_version_transition` parameters:
     * `days`: Number of days before transition. The minimum value is `1`. This is a required setting.
     * `storage_class`: Storage class to move the object to. It can be `COLD`, `STANDARD_IA`, or `ICE`. This is a required setting.

     For more information about the resources you can create with {{ TF }}, see [this provider reference]({{ tf-provider-link }}/).

  1. Make sure the configuration files are correct.
     1. In the command line, navigate to the directory where you created the configuration file.
     1. Run a check using this command:

        ```bash
        terraform plan
        ```

     If you described the configuration correctly, the terminal will display a list of the resources being created and their settings. If the configuration contains any errors, {{ TF }} will point them out.

  1. Deploy the cloud resources.
     1. If the configuration does not contain any errors, run this command:

        ```bash
        terraform apply
        ```

     1. Confirm creating the resources.

     This will create all resources you need in the specified folder. You can check the new resources and their settings using the [management console]({{ link-console-main }}).

- API {#api}

  To manage bucket object lifecycles, use the [update](../../api-ref/Bucket/update.md) REST API method for the [Bucket](../../api-ref/Bucket/index.md) resource, the [BucketService/Update](../../api-ref/grpc/Bucket/update.md) gRPC API call, or the [upload](../../s3/api-ref/lifecycles/upload.md) S3 API method.

  If you are using the S3 API, specify the lifecycle configuration in [XML format](../../s3/api-ref/lifecycles/xml-config.md).

{% endlist %}
