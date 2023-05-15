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

   To specify a cloud network to run a container in, use the [deployRevision](../containers/api-ref/Container/deployRevision.md) REST API method for the [Container](../containers/api-ref/Container/index.md) resource or the [ContainerService/DeployRevision](../containers/api-ref/grpc/container_service.md#DeployRevision) gRPC API call.

{% endlist %}

## See also

* [Networking in {{ serverless-containers-name }}](../concepts/networking.md).
