---
title: Managing object locks in a bucket
description: Follow this guide to manage object locks in {{ objstorage-name }}.
---

# Managing object locks in a bucket

You can set up _[object locks](../../concepts/object-lock.md)_ in [versioned](versioning.md) buckets. With object lock enabled, you can lock an object version so that it cannot be deleted or overwritten. You can also set default object locks for a bucket that will apply to all new object versions.

{% include [versioning-block-relations](../../../_includes/storage/versioning-block-relations.md) %}

## Enabling object locks {#enable}

Enabling object locks does not automatically lock previously uploaded object versions. You can lock them manually as needed.

The minimum required role is `storage.admin`.

To enable object locks:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}** from the list of services and go to the bucket you want to configure locks for.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/persons-lock.svg) **{{ ui-key.yacloud.storage.bucket.switch_security }}**.
  1. Select the **{{ ui-key.yacloud.storage.bucket.switch_object-lock }}** tab.
  1. To enable using locks, check **{{ ui-key.yacloud.storage.form.BucketObjectLockFormContent.field_temp-object-lock-enabled_v3heA }}**.
  1. Click **{{ ui-key.yacloud.common.save }}**.

- AWS CLI {#cli}

  If you do not have the AWS CLI yet, [install and configure it](../../tools/aws-cli.md).

  Run this command:

  ```bash
  aws s3api put-object-lock-configuration \
    --bucket <bucket_name> \
    --object-lock-configuration ObjectLockEnabled=Enabled \
    --endpoint-url=https://{{ s3-storage-host }}
  ```

  Where:

  * `--bucket`: Bucket name.
  * `--object-lock-configuration`: Bucket lock settings. The `ObjectLockEnabled=Enabled` value enables object locks.
  * `--endpoint-url`: {{ objstorage-name }} endpoint.

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Open the {{ TF }} configuration file and add the `object_lock_configuration` section to the bucket description:

      ```hcl
      resource "yandex_storage_bucket" "b" {
        ...
        object_lock_configuration {
          object_lock_enabled = "Enabled"
        }
      }
      ```

      Where:

      * `object_lock_configuration`: Object lock settings:
        * `object_lock_enabled`: Enables object locks. You must enable bucket versioning to set this property. This is an optional parameter.

      For more information about the bucket parameters you can specify using {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/storage_bucket).

  1. Create the resources:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  With that done, the specified folder will now contain object locks for your bucket. You can check that object locks are now enabled using this [CLI](../../../cli/quickstart.md) command:

    ```bash
    yc storage bucket get <bucket_name>
    ```

    Result:

    ```text
    name: my-bucket
    folder_id: b1geoelk2fld*********
    ...
    object_lock:
      status: OBJECT_LOCK_STATUS_ENABLED
    ```

- API {#api}

  Use the [putObjectLockConfiguration](../../s3/api-ref/bucket/putobjectlockconfiguration.md) S3 API method, [update](../../api-ref/Bucket/update.md) REST API method for the [Bucket](../../api-ref/Bucket/index.md) resource, or the [BucketService/Update](../../api-ref/grpc/Bucket/update.md) gRPC API call.

{% endlist %}

## Setting up default object locks {#default}

Default locks apply to all new object versions you upload to the bucket. These settings do not affect the previously uploaded versions.

The minimum required role is `storage.admin`.

To set up default object locks:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}** from the list of services and go to the bucket you want to configure default locks for.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/persons-lock.svg) **{{ ui-key.yacloud.storage.bucket.switch_security }}**.
  1. Select the **{{ ui-key.yacloud.storage.bucket.switch_object-lock }}** tab.
  1. To enable or disable using locks, use the **{{ ui-key.yacloud.storage.form.BucketObjectLockFormContent.field_temp-object-lock-enabled_v3heA }}** option.
  1. Enable **{{ ui-key.yacloud.storage.form.BucketObjectLockFormContent.field_default-rules-enabled_qtmC8 }}**.
  1. Select **{{ ui-key.yacloud.storage.form.BucketObjectLockFormContent.field_mode_61kxf }}**:
     * **{{ ui-key.yacloud.storage.bucket.object-lock.title-mode-governance }}**: User with the `storage.admin` role can bypass the lock, change its expiration date, or remove it.
     * **{{ ui-key.yacloud.storage.bucket.object-lock.title-mode-compliance }}**: User with the `storage.admin` role can only extend the retention period. You cannot override, shorten, or remove such locks until they expire.
  1. Specify **{{ ui-key.yacloud.storage.form.BucketObjectLockFormContent.field_retention-period_jJYhy }}** in days or years. It starts from the moment you upload the object version to the bucket.
  1. Click **{{ ui-key.yacloud.common.save }}**.

- AWS CLI {#cli}

  If you do not have the AWS CLI yet, [install and configure it](../../tools/aws-cli.md).

  1. Specify the configuration for default object locks in JSON format:
 
     ```json
     {
       "ObjectLockEnabled": "Enabled",
       "Rule": {
         "DefaultRetention": {
           "Mode": "<lock_type>",
           "Days": <retention_period_in_days>,
           "Years": <retention_period_in_years>
         }
       }
     }
     ```

     Where:

     * `ObjectLockEnabled`: Object lock status. If this property is set to `Enabled`, you can use object locks.
 
       {% note alert %}

       This is a required field. If you do not set it to `Enabled`, you will get the `InvalidRequest` error message, and the object lock will be disabled. See also [Disabling object locks](#disable) for details.

       {% endnote %}

     * `Mode`: Lock [type](../../concepts/object-lock.md#types):

       * `GOVERNANCE`: Governance-mode retention.
       * `COMPLIANCE`: Compliance-mode retention.

     * `Days`: Retention period in days after uploading an object version. It must be a positive integer. You cannot use it together with `Years`.
     * `Years`: Retention period in years after uploading an object version. It must be a positive integer. You cannot use it together with `Days`.

     Once the configuration is complete, save it a file, e.g., `default-object-lock.json`.

  1. Upload the configuration to the bucket:

     ```bash
     aws s3api put-object-lock-configuration \
       --bucket <bucket_name> \
       --object-lock-configuration file://default-object-lock.json \
       --endpoint-url=https://{{ s3-storage-host }}
     ```

     Where:

     * `--bucket`: Bucket name.
     * `--object-lock-configuration`: Default lock settings. In our case, they are specified in the `default-object-lock.json` file.
     * `--endpoint-url`: {{ objstorage-name }} endpoint.

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Open the {{ TF }} configuration file and add the default lock settings to the `object_lock_configuration` section:

      ```
      ...
      rule {
        default_retention {
          mode = "GOVERNANCE"
          years = 1
        }
      }
      ...
      ```

      Where:

      * `rule`: Object lock rule. It contains the `default_retention` parameter with retention settings:
        * `mode`: Lock type. It can be either `GOVERNANCE` or `COMPLIANCE`. This is an optional parameter.
        * `years` or `days`: Object lock duration (retention period). Provide it as a number. This is an optional parameter.

  1. Apply the changes:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  You can check that object locks are now enabled using this [CLI](../../../cli/quickstart.md) command:

    ```bash
    yc storage bucket get <bucket_name>
    ```

    Result:

    ```text
    name: my-bucket
    folder_id: b1geoelk2fld********
    ...
    object_lock:
    status: OBJECT_LOCK_STATUS_ENABLED
    default_retention:
      mode: MODE_GOVERNANCE
      years: "1"
    ```

{% endlist %}

## Disabling object locks {#disable}

Disabling object locks only affects the lock feature itself and does not automatically remove existing locks. They will still be there, and you will not be able to remove or change them.

The minimum required role is `storage.admin`.

To disable object locks:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}** from the list of services and go to the bucket you want to configure locks for.
  1. In the left-hand panel, select ![image](../../../_assets/console-icons/persons-lock.svg) **{{ ui-key.yacloud.storage.bucket.switch_security }}**.
  1. Select the **{{ ui-key.yacloud.storage.bucket.switch_object-lock }}** tab.
  1. To disable using locks, uncheck **{{ ui-key.yacloud.storage.form.BucketObjectLockFormContent.field_temp-object-lock-enabled_v3heA }}**.
  1. Click **{{ ui-key.yacloud.common.save }}**.

- AWS CLI {#cli}

  If you do not have the AWS CLI yet, [install and configure it](../../tools/aws-cli.md).

  Run this command:

  ```bash
  aws s3api put-object-lock-configuration \
    --bucket <bucket_name> \
    --object-lock-configuration ObjectLockEnabled="" \
    --endpoint-url=https://{{ s3-storage-host }}
  ```

  Where:

  * `--bucket`: Bucket name.
  * `--object-lock-configuration`: Bucket lock settings. The `ObjectLockEnabled=""` value disables object locks.
  * `--endpoint-url`: {{ objstorage-name }} endpoint.

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. Open the {{ TF }} configuration file and delete the `object_lock_configuration` section:

      {% cut "Example of specifying object locks in {{ TF }} configuration" %}

        ```
        ...
        object_lock_configuration {
          object_lock_enabled = "Enabled"
          rule {
            default_retention {
              mode = "GOVERNANCE"
              years = 1
            }
          }
        }
        ...
        ```

      {% endcut %}

  1. Apply the changes:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

  You can check that object locks are now disabled using this [CLI](../../../cli/quickstart.md) command:

    ```bash
    yc storage bucket get <bucket_name>
    ```

    Result:

    ```text
    name: my-bucket
    folder_id: b1geoelk2fld********
    ...
    object_lock:
      status: OBJECT_LOCK_STATUS_DISABLED
    ```

- API {#api}

  To disable object locks for a bucket, use the[putObjectLockConfiguration](../../s3/api-ref/bucket/putobjectlockconfiguration.md) S3 API method, [update](../../api-ref/Bucket/update.md) REST API method for the [Bucket](../../api-ref/Bucket/index.md) resource, or the [BucketService/Update](../../api-ref/grpc/Bucket/update.md) gRPC API call.

  In the request body, provide the object lock parameter with an empty value:

  * `ObjectLockConfiguration`: For S3 API.
  * `objectLock`: For REST API.
  * `object_lock`: For gRPC API.

  Here is an example of an HTTP request body for S3 API:

  ```xml
  <ObjectLockConfiguration xmlns="http://s3.amazonaws.com/doc/2006-03-01/" />
  ```

{% endlist %}
