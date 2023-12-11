# Configuring log export

[Log export](../../concepts/logs.md) is a paid functionality. See [{#T}](../../pricing.md) for billing information.

## Enabling export {#enabling}

To enable log export for a [resource](../../concepts/resource.md):

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where your resource is located.

   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.

   1. Click the resource name.

   1. Go to the **{{ ui-key.yacloud.cdn.label_resource-raw-logs }}** tab.

   1. In the top-right corner, click **{{ ui-key.yacloud.cdn.button_resource-activate-raw-logs }}**.

   1. Select **{{ ui-key.yacloud.cdn.label_bucket }}**.

   1. (Optional) Specify a **{{ ui-key.yacloud.cdn.label_bucket-key-prefix }}** for log file names.

   1. Click **{{ ui-key.yacloud.cdn.button_resource-activate-raw-logs }}**.

- API

   Use the [activate](../../api-ref/RawLogs/activate.md) REST API method for the [RawLogs](../../api-ref/RawLogs/index.md) resource or the [RawLogsService/Activate](../../api-ref/grpc/raw_logs_service.md#Activate) gRPC API call.

{% endlist %}

Once enabled, the export status will change from `NOT_ACTIVATED` to `OK`.

If the status is `FAIL`, the service does not export logs. Please contact [technical support]({{ link-console-support }}).

## Editing export {#editing}

To edit export parameters:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where your resource is located.

   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.

   1. Click the resource name.

   1. Go to the **{{ ui-key.yacloud.cdn.label_resource-raw-logs }}** tab.

   1. In the top-right corner, click ![image](../../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.

   1. Enter the required parameters and click **{{ ui-key.yacloud.common.save }}**.

- API

   Use the [update](../../api-ref/RawLogs/update.md) REST API method for the [RawLogs](../../api-ref/RawLogs/index.md) resource or the [RawLogsService/Update](../../api-ref/grpc/raw_logs_service.md#Update) gRPC API call.

{% endlist %}

## Deactivating export {#disabling}

To disable export:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where your resource is located.

   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_cdn }}**.

   1. Click the resource name.

   1. Go to the **{{ ui-key.yacloud.cdn.label_resource-raw-logs }}** tab.

   1. In the top-right corner, click **{{ ui-key.yacloud.cdn.button_resource-deactivate-raw-logs }}**.

- API

   Use the [deactivate](../../api-ref/RawLogs/deactivate.md) REST API method for the [RawLogs](../../api-ref/RawLogs/index.md) resource or the [RawLogsService/Deactivate](../../api-ref/grpc/raw_logs_service.md#Deactivate) gRPC API call.

{% endlist %}
