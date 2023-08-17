# Configuring log export

[Log export](../../concepts/logs.md) is a paid functionality. See [{#T}](../../pricing.md) for billing information.

## Enabling export {#enabling}

To enable log export for a [resource](../../concepts/resource.md):

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where your resource is located.

   1. Select **{{ cdn-name }}**.

   1. Click the name of the desired resource.

   1. Go to the **Export logs** tab.

   1. In the top-right corner, click **Enable**.

   1. Select **Bucket**.

   1. (Optional) Specify a **Prefix** for log file names.

   1. Click **Enable**.

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

   1. Select **{{ cdn-name }}**.

   1. Click the name of the desired resource.

   1. Go to the **Export logs** tab.

   1. In the top right-hand corner, click ![image](../../../_assets/pencil.svg) **Edit**.

   1. Enter the required parameters and click **Save**.

- API

   Use the [update](../../api-ref/RawLogs/update.md) REST API method for the [RawLogs](../../api-ref/RawLogs/index.md) resource or the [RawLogsService/Update](../../api-ref/grpc/raw_logs_service.md#Update) gRPC API call.

{% endlist %}

## Deactivating export {#disabling}

To disable export:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where your resource is located.

   1. Select **{{ cdn-name }}**.

   1. Click the name of the desired resource.

   1. Go to the **Export logs** tab.

   1. In the top-right corner, click **Disable**.

- API

   Use the [deactivate](../../api-ref/RawLogs/deactivate.md) REST API method for the [RawLogs](../../api-ref/RawLogs/index.md) resource or the [RawLogsService/Deactivate](../../api-ref/grpc/raw_logs_service.md#Deactivate) gRPC API call.

{% endlist %}
