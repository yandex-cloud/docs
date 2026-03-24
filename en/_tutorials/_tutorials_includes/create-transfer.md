## Create a transfer {#create-transfer}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create a [transfer](../../data-transfer/concepts/index.md#transfer).
  1. [Go](../../console/operations/select-service.md#select-service) to {{ ui-key.yacloud.iam.folder.dashboard.label_data-transfer }}.
  1. Create a source [endpoint](../../data-transfer/concepts/index.md#endpoint):
     1. In the ![endpoint](../../_assets/console-icons/aperture.svg) **{{ ui-key.yacloud.data-transfer.label_endpoints }}** tab, click **{{ ui-key.yacloud.data-transfer.button_create-endpoint }}**.
     1. In the **{{ ui-key.yacloud.data-transfer.forms.label-is_source }}** field, select `{{ ui-key.yacloud.data-transfer.forms.label_source-type }}`.
     1. Enter the endpoint name, e.g., `logs-source`.
     1. From the **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}** list, select `Yandex Data Streams`.
     1. Select the database you specified in the settings of the [stream](../../data-streams/concepts/glossary.md#stream-concepts) you created earlier.
     1. Name the data stream: `logs-stream`.
     1. Select the `logs-sa` [service account](../../iam/concepts/users/service-accounts.md) you created earlier.
     1. Under **{{ ui-key.yacloud.alb.label_detailed-settings }}**, specify the conversion rules for the `{{ ui-key.yc-data-transfer.data-transfer.console.form.logbroker.console.form.logbroker.ParserConfigCommon.parser_config_common_cloud_logging.title }}` data.
     1. Click **{{ ui-key.yacloud.common.create }}**.
  1. Create a target endpoint:
     1. In the ![endpoint](../../_assets/console-icons/aperture.svg) **{{ ui-key.yacloud.data-transfer.label_endpoints }}** tab, click **{{ ui-key.yacloud.data-transfer.button_create-endpoint }}**.
     1. In the **{{ ui-key.yacloud.data-transfer.forms.label-is_source }}** field, select `{{ ui-key.yacloud.data-transfer.forms.label_target-type }}`.
     1. Enter the endpoint name, e.g., `logs-receiver`.
     1. From the **{{ ui-key.yacloud.data-transfer.forms.label-database_type }}** list, select `Object Storage`.
     1. Enter the name of the previously created [bucket](../../storage/concepts/bucket.md).
     1. Select the `logs-sa` service account you created earlier.
     1. In the **{{ ui-key.yc-data-transfer.data-transfer.console.form.object_storage.console.form.object_storage.ObjectStorageTarget.output_format.title }}** field, select `JSON`.
     1. Click **{{ ui-key.yacloud.common.create }}**.
  1. Create a transfer:
     1. In the ![image](../../_assets/console-icons/arrow-right-arrow-left.svg) **{{ ui-key.yacloud.data-transfer.label_connectors }}** tab, click **{{ ui-key.yacloud.data-transfer.button_create-transfer }}**.
     1. Enter the transfer name, e.g., `logs-transfer`.
     1. Select the `logs-source` source endpoint you created earlier.
     1. Select the `logs-receiver` target endpoint you created earlier.
     1. Click **{{ ui-key.yacloud.common.create }}**.
  1. Click ![ellipsis](../../_assets/console-icons/ellipsis.svg) next to the new transfer and select **{{ ui-key.yacloud.data-transfer.label_connector-operation-ACTIVATE }}**.

  Wait until the transfer gets activated. Once the transfer is ready for use, its [status](../../data-transfer/concepts/transfer-lifecycle.md#statuses) will change from `{{ ui-key.yacloud.data-transfer.label_connector-status-CREATING }}` to `{{ ui-key.yacloud.data-transfer.label_connector-status-RUNNING }}`.

{% endlist %}