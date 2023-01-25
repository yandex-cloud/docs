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

   1. In the upper-right corner, click **Enable**.

   1. Select **Bucket**.

   1. (optional) Specify a **Prefix** for log file names.

   1. Click **Enable**.

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

{% endlist %}

## Deactivating export {#disabling}

To disable export:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where your resource is located.

   1. Select **{{ cdn-name }}**.

   1. Click the name of the desired resource.

   1. Go to the **Export logs** tab.

   1. In the upper-right corner, click **Disable**.

{% endlist %}
