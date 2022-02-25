# Configuring log export

[Log export](../../concepts/logs.md) is a paid function. For the pricing policy, see [{#T}](../../pricing.md).

## Enabling export {#enabling}

To enable log export for a [resource](../../concepts/resource.md):

{% list tabs %}

- Management console

  1. In the [management console]({{ link-console-main }}), select the folder your resource is hosted in.

  1. Select **{{ cdn-name }}**.

  1. On the **CDN resources** tab, click on the name of the desired resource.

  1. Go to the **Export logs** tab.

  1. In the upper-right corner, click **Enable**.

  1. Select a **Bucket** and specify a **Prefix** for log file names (optional).

  1. Click **Enable**.

{% endlist %}

Once enabled, the export status will change from `NOT_ACTIVATED` to `OK`.

If the status is `FAIL`, the service does not export logs. Please contact [technical support]({{ link-console-support }}).

## Editing export {#editing}

To edit export parameters:

{% list tabs %}

- Management console

  1. In the [management console]({{ link-console-main }}), select the folder your resource is hosted in.

  1. Select **{{ cdn-name }}**.

  1. On the **CDN resources** tab, click on the name of the desired resource.

  1. Go to the **Export logs** tab.

  1. In the upper-right corner, click ![image](../../../_assets/horizontal-ellipsis.svg) → **Edit**.

{% endlist %}

## Disabling export {#disabling}

To disable export:

{% list tabs %}

- Management console

  1. In the [management console]({{ link-console-main }}), select the folder your resource is hosted in.

  1. Select **{{ cdn-name }}**.

  1. On the **CDN resources** tab, click on the name of the desired resource.

  1. Go to the **Export logs** tab.

  1. In the upper-right corner, click **Disable**.

{% endlist %}

