Create the {{ objstorage-name }} bucket you will connect to Nextcloud:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you are deploying your infrastructure.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. At the top right, click **{{ ui-key.yacloud.storage.buckets.button_create }}**.
  1. In the **{{ ui-key.yacloud.storage.bucket.settings.field_name }}** field, enter a name for the bucket, e.g., `my-nextcloud-bucket`. The bucket name must be [unique](../../../storage/concepts/bucket.md#naming) within {{ objstorage-full-name }}.
  1. In the **{{ ui-key.yacloud.storage.bucket.settings.field_size-limit }}** field, specify the bucket size you need or enable **{{ ui-key.yacloud.storage.bucket.settings.label_size-limit-disabled }}**.
  1. Leave all the other parameters unchanged and click **{{ ui-key.yacloud.storage.buckets.create.button_create }}**.

{% endlist %}