# Specifying a cloud network to host an API gateway

{% include [note-preview](../../_includes/note-preview.md) %}

You can specify a [cloud network](../../vpc/concepts/network.md#network) to host an API gateway.

{% include [network](../../_includes/functions/network.md) %}

{% list tabs %}

- Management console

    1. In the [management console]({{ link-console-main }}), select the folder containing the API gateway.
    1. Select **{{ api-gw-name }}**.
    1. Select the API gateway.
    1. In the top-right corner, click **Edit**.
    1. In the **Network** field, specify a cloud network to host your API gateway.
    1. Click **Save**.

- API

  To specify a cloud network to host an API gateway, use the [update](../apigateway/api-ref/ApiGateway/update.md) REST API method for the [ApiGateway](../apigateway/api-ref/ApiGateway/index.md) resource or the [ApiGatewayService/Update](../apigateway/api-ref/grpc/apigateway_service.md#Update) gRPC API call.

{% endlist %}

## See also

* [Networking in {{ api-gw-name }}](../concepts/networking.md).
