---
title: Managing object lifecycles in a {{ objstorage-full-name }} bucket
description: Follow this guide to manage object lifecycles in an {{ objstorage-name }} bucket.
---

# Managing bucket object lifecycles

{{ objstorage-name }} allows managing [object lifecycles](../../concepts/lifecycles.md) in a bucket.

Once a day, lifecycles are updated with the latest changes as of 00:00 UTC. This operation takes a few hours to complete.

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

  1. Define the object lifecycle configuration in JSON format. For example:

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
      * `id`: Unique rule ID, which must consist of 255 characters or less. This is an optional parameter.
      * `enabled`: Rule state. This is a required parameter.
      * `filter`: Object filter. This is an optional parameter. It may only contain one element of each type:

          * `prefix`: Object [key](../../concepts/object.md#key) prefix that identifies one or more objects to which the rule applies. The rule applies to objects with the specified key prefix. This is an optional parameter.
          * `objectSizeGreaterThan`: Minimum object size in bytes. The rule applies to objects whose size is greater than or equal to the set one. This is an optional parameter.
          * `objectSizeLessThan`: Maximum object size in bytes. The rule applies to objects whose size is less than or equal to the set one. This is an optional parameter.
          * `tag`: Object [label](../../concepts/tags.md#object-tags). This is an optional parameter. The rule applies to objects to which the specified tag is assigned. It is delivered as a record that contains two pairs of values, for example:

              ```json
              "tag": [{"key": "some_key", "value": "some_value"}]
              ```

          * `andOperator`: `AND` logical operator for filters. This is an optional parameter. Use this filter to combine filtering by prefix, size, or object tag in a single rule. With `andOperator`, you can configure filtering by multiple labels at the same time. To do this, specify the labels in the `tag` key as an array of objects, each containing two pairs of values.
          
              Here is an example of a filter with the `AND` logical operator:

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

          If no object filter is set, the rule applies to all objects in the bucket.

      * `transitions`: Parameter of a rule for changing the storage class of any objects from regular (`STANDARD`) to cold (`COLD` or `STANDARD_IA`) or ice (`ICE`) or from cold to ice. This is an optional parameter. It may contain:
          * `date`: Date after which you want the rule to take effect, in the [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format, such as `YYYY-MM-DDT00:00:00Z`. Time: Always 00:00 UTC. You cannot use the `date` key along with `days`. This is an optional parameter.
          * `days`: Number of days following the object creation date after which the rule will take effect. The minimum value is `1`. You cannot use the `days` key along with `date`. This is an optional parameter.
          * `storage_class`: Storage class to move the object to. It can be `COLD`, `STANDARD_IA`, or `ICE`. This is a required parameter.

          It is transferred as an array, e.g.:

          ```json
          "transitions": [{ "days": "<number_of_days>", "storage_class": "<storage_class>" }]
          ```

      * `expiration`: Parameter of a rule for deleting any objects. This is an optional parameter. It may contain:
          * `date`: Date after which you want the rule to take effect, in the [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format, such as `YYYY-MM-DDT00:00:00Z`. Time: Always 00:00 UTC. You cannot use the `date` key along with `days`. This is an optional parameter.
          * `days`: Number of days following the object creation date after which the rule will take effect. The minimum value is `1`. You cannot use the `days` key along with `date`. This is an optional parameter.
          * `expired_object_delete_marker`: Deletes the delete marker for which expired object versions no longer exist. It can either be `true` or `false`. This is an optional parameter.
      * `noncurrent_transitions`: Parameter of a rule for changing the storage class of non-current object versions from regular (`STANDARD`) to cold (`COLD` or `STANDARD_IA`) or ice (`ICE`) or from cold to ice. This is an optional parameter. It may contain:
          * `noncurrent_days`: Number of days before transition. The minimum value is `1`. This is a required parameter.
          * `storage_class`: Storage class to move the object to. It can be `COLD`, `STANDARD_IA`, or `ICE`. This is a required parameter.
      * `noncurrent_expiration`: Parameter of a rule for deleting non-current object versions. This is an optional parameter. It may contain:
          * `noncurrent_days`: Number of days before expiration. The minimum value is `1`. This is a required parameter.
      * `abort_incomplete_multipart_upload_days`: Parameter of a rule for removing all parts of multipart uploads that were not completed within the specified number of days. This is an optional parameter.
      * `noncurrent_delete_markers`: Parameter of a rule for deleting non-current delete markers. This is an optional parameter. It may contain:
          * `noncurrent_days`: Rule starts to apply after the number of days from the classification of the delete marker version as non-current, which is specified in this parameter, expires. The minimum value is `0`. This is a required parameter.

      Make sure to specify at least one of the following parameters: `transitions`, `expiration`, `noncurrent_transitions`, `noncurrent_expiration`, or `abort_incomplete_multipart_upload_days`.

      Once complete, save the configuration to a file, e.g., `lifecycles.json`.

  1. See the description of the CLI command to update a bucket:

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
   
  1. Save the `NAME` value for the bucket to configure lifecycles in.
  1. Run the following command:

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
      * `ID`: Unique rule ID, which must consist of 255 characters or less. This is an optional parameter.
      * `Filter`: Object filter. This is an optional parameter. It may only contain one element of each type:

          * `Prefix`: Object [key](../../concepts/object.md#key) prefix. The rule applies to objects with the specified key prefix. This is an optional parameter.
          * `ObjectSizeGreaterThan`: Minimum object size in bytes. The rule applies to objects whose size is greater than or equal to the set one. This is an optional parameter.
          * `ObjectSizeLessThan`: Maximum object size in bytes. The rule applies to objects whose size is less than or equal to the set one. This is an optional parameter.
          * `Tag`: Object [label](../../concepts/tags.md#object-tags). This is an optional parameter. The rule applies to objects to which the specified tag is assigned. It is delivered as a record that contains two pairs of values, for example:

              ```json
              "Tag": [{"Key": "some_key", "Value": "some_value"}]
              ```

          * `And`: `AND` logical operator for filters. This is an optional parameter. Use this filter to combine filtering by prefix, size, or object tag in a single rule. With `And`, you can configure filtering by multiple labels at the same time. To do this, specify the labels in the `Tags` key as an array of objects, each containing two pairs of values.
          
              Here is an example of a filter with the `AND` logical operator:

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

          If no object filter is set, the rule applies to all objects in the bucket.

      * `Status`: Rule status. This is a required parameter. Values:
          * `Enabled`: Rule enabled.
          * `Disabled`: Rule disabled.
      * `Transitions`: Parameter of a rule for changing the storage class of any objects from regular (`STANDARD`) to cold (`COLD` or `STANDARD_IA`) or ice (`ICE`) or from cold to ice. This is an optional parameter. It may contain:
          * `Date`: Date after which the storage class will change, in the [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format, such as `YYYY-MM-DD`. Time: Always 00:00 UTC. You cannot use the `Date` key along with `Days`. This is an optional parameter.
          * `Days`: Number of days from the object creation date after which the storage class will be changed. The minimum value is `1`. You cannot use the `Days` key along with `Date`. This is an optional parameter.
          * `StorageClass`: Storage class to move the object to. It can be `COLD`, `STANDARD_IA`, or `ICE`. This is a required parameter.

          It is transferred as an array:

          ```json
          "Transitions": [{ "Days": "<number_of_days>", "StorageClass": "<storage_class>" }]
          ```

          To set the `Transitions` parameter, you must specify the `Prefix` parameter in the configuration file. The `Prefix` value may even be empty (`""`).
      * `Expiration`: Parameter of a rule for deleting any objects. This is an optional parameter. It may contain:
          * `Date`: Date after which the object will be deleted, in the [ISO 8601](https://en.wikipedia.org/wiki/ISO_8601) format, such as `YYYY-MM-DD`. Time: Always 00:00 UTC. You cannot use the `Date` key along with `Days`. This is an optional parameter.
          * `Days`: Number of days from the object creation date after which the object will be deleted. The minimum value is `1`. You cannot use the `Days` key along with `Date`. This is an optional parameter.
          * `ExpiredObjectDeleteMarker`: Deletes the delete marker for which expired object versions no longer exist. It can either be `true` or `false`. This is an optional parameter.
      * `NoncurrentVersionTransitions`: Parameter of a rule for changing the storage class of non-current object versions from regular (`STANDARD`) to cold (`COLD` or `STANDARD_IA`) or ice (`ICE`) or from cold to ice. This is an optional parameter. It may contain:
          * `NoncurrentDays`: Number of days before changing the storage class of a non-current object version. The minimum value is `1`. This is a required parameter.
          * `StorageClass`: Storage class to move the object to. It can be `COLD`, `STANDARD_IA`, or `ICE`. This is a required parameter.

          To set the `NoncurrentVersionTransitions` parameter, you must specify the `Prefix` parameter in the configuration file. The `Prefix` value may even be empty (`""`).
      * `NoncurrentVersionExpiration`: Parameter of a rule for deleting non-current object versions. This is an optional parameter. 

          The rule has the required `NoncurrentDays` parameter that indicates the number of days before non-current object versions are deleted. The minimum value is `1`.
      * `AbortIncompleteMultipartUpload`: Parameter of a rule for removing all parts of multipart uploads that were not completed within the specified number of days. This is an optional parameter.

          The rule has the required `DaysAfterInitiation` parameter that indicates the number of days since the upload started. The minimum value is `1`.

      Specify at least one of the following parameters: `Transitions`, `Expiration`, `NoncurrentVersionTransition`, `NoncurrentVersionExpiration`, or `AbortIncompleteMultipartUpload`.

      Once complete, save the configuration to a file, e.g., `lifecycles.json`.

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

  Retrieve [static access keys](../../../iam/operations/sa/create-access-key.md): a static key and a key ID used to authenticate in {{ objstorage-short-name }}.

  1. In the configuration file, describe the parameters of the resources you want to create:

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

     * `bucket`: Bucket name. This is a required parameter.
     * `access_key`: Static access key ID.
     * `secret_key`: Secret access key value.

     `lifecycle_rule` parameters:
     * `id`: Unique rule ID, which must consist of 255 characters or less. This is an optional parameter.
     * `filter`: Object filter. This is an optional parameter. It may only contain one element of each type:
         * `prefix`: Object [key](../../concepts/object.md#key) prefix that identifies one or more objects to which the rule applies. This is an optional parameter.
         * `object_size_greater_than`: Minimum object size in bytes. The rule applies to objects whose size is greater than or equal to the set one. This is an optional parameter.
         * `object_size_less_than`: Maximum object size in bytes. The rule applies to objects whose size is less than or equal to the set one. This is an optional parameter.
         * `tag`: Object [label](../../concepts/tags.md#object-tags). This is an optional parameter. The rule applies to objects to which the specified tag is assigned. It is delivered as a record that contains two pairs of values, for example:

             ```hcl
             tag {
               key   = "some_key"
               value = "some_value"
             }
             ```

         * `And`: `AND` logical operator for filters. This is an optional parameter. Use this filter to combine filtering by prefix, size, or object tag in a single rule. With `And`, you can configure filtering by multiple labels at the same time. To do this, specify the labels as `key = value` pairs in the `tags` section.

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

         If no object filter is set, the rule applies to all objects in the bucket.

     * `enabled`: Rule state. This is a required parameter.
     * `abort_incomplete_multipart_upload_days`: Parameter of a rule for removing all parts of multipart uploads that were not completed within the specified number of days. This is an optional parameter.
     * `expiration`: Parameter of a rule for deleting any objects. This is an optional parameter.
     * `transition`: Parameter of a rule for changing the storage class of any objects from regular (`STANDARD`) to cold (`COLD` or `STANDARD_IA`) or ice (`ICE`) or from cold to ice. This is an optional parameter.
     * `noncurrent_version_expiration`: Parameter of a rule for deleting non-current object versions. This is an optional parameter.
     * `noncurrent_version_transition`: Parameter of a rule for changing the storage class of non-current object versions from regular (`STANDARD`) to cold (`COLD` or `STANDARD_IA`) or ice (`ICE`) or from cold to ice. This is an optional parameter.

     Make sure to specify at least one of the following parameters: `abort_incomplete_multipart_upload_days`, `expiration`, `transition`, `noncurrent_version_expiration`, or `noncurrent_version_transition`.

     `expiration` parameters:
     * `date`: Date after which you want the rule to take effect, You cannot use the `date` parameter along with `days`. This is an optional parameter.
     * `days`: Number of days following the object creation date after which the rule will take effect. The minimum value is `1`. You cannot use the `days` parameter along with `date`. This is an optional parameter.
     * `expired_object_delete_marker`: Deletes the delete marker for which expired object versions no longer exist. It can either be `true` or `false`. This is an optional parameter.

     `transition` parameters:
     * `date`: Date after which you want the rule to take effect, You cannot use the `date` parameter along with `days`. This is an optional parameter.
     * `days`: Number of days following the object creation date after which the rule will take effect. The minimum value is 1. You cannot use the `days` parameter along with `date`. This is an optional parameter.
     * `storage_class`: Storage class to move the object to. It can be `COLD`, `STANDARD_IA`, or `ICE`. This is a required parameter.

     `noncurrent_version_expiration` parameters:
     * `days`: Number of days before expiration. The minimum value is 1. This is a required parameter.

     `noncurrent_version_transition` parameters:
     * `days`: Number of days before transition. The minimum value is 1. This is a required parameter.
     * `storage_class`: Storage class to move the object to. It can be `COLD`, `STANDARD_IA`, or `ICE`. This is a required parameter.

     For more information about the resources you can create with {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/).

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

     1. Confirm that you want to create the resources.

     All the resources you need will then be created in the specified folder. You can check the new resources and their settings using the [management console]({{ link-console-main }}).

- API {#api}

  To manage bucket object lifecycles, use the [update](../../api-ref/Bucket/update.md) REST API method for the [Bucket](../../api-ref/Bucket/index.md) resource, the [BucketService/Update](../../api-ref/grpc/Bucket/update.md) gRPC API call, or the [upload](../../s3/api-ref/lifecycles/upload.md) S3 API method.

  If you are using the S3 API, specify a lifecycle configuration in the [XML format](../../s3/api-ref/lifecycles/xml-config.md).

{% endlist %}
