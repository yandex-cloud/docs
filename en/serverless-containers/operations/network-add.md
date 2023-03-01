# Specifying a cloud network where the container will be run

{% include [note-preview](../../_includes/note-preview.md) %}

You can specify a [cloud network](../../vpc/concepts/network.md#network) where the container will be executed.

{% include [network](../../_includes/functions/network.md) %}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder with your container.
   1. Select **{{ serverless-containers-name }}**.
   1. Select the container.
   1. Go to the **Editor** tab.
   1. Under **Parameters**, in the **Network** field, choose a cloud network for container execution.
   1. Click **Create revision**.

- API

   To specify the cloud network where the container will run, use the [deployRevision](../containers/api-ref/Container/deployRevision.md) API method.

{% endlist %}

## See also

* [Networking in {{ serverless-containers-name }}](../concepts/networking.md).
