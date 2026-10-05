Create the {{ objstorage-name }} bucket you will connect to Nextcloud:

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you are deploying your infrastructure.
  1. [Navigate]({{ link-console-main }}/link/storage) to **{{ ui-key.yacloud.iam.folder.dashboard.label_storage }}**.
  1. In the top panel, click **{{ ui-key.yacloud.storage.buckets.button_create }}**.
  1. In the **{{ ui-key.yacloud.storage.bucket.settings.field_name }}** field, enter a name for the bucket. Here is an example: `my-nextcloud-bucket`. The bucket name must be [unique](../../../storage/concepts/bucket.md#naming) within {{ objstorage-full-name }}.
  1. To set a bucket size limit, enable **{{ ui-key.yacloud.storage.form-components.SizeLimitField.field_size-limit-enabled_hPy7f }}** and specify the desired size in the fields that appear.

      {% include [storage-no-max-limit](../../../storage/_includes_service/storage-no-max-limit.md) %}

  1. Leave all the other parameters unchanged and click **{{ ui-key.yacloud.storage.buckets.create.button_create }}**.

{% endlist %}