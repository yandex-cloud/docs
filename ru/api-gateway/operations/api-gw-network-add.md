# Указать облачную сеть, в которой будет находиться API-шлюз

{% include [note-preview](../../_includes/note-preview.md) %}

Вы можете указать [облачную сеть](../../vpc/concepts/network.md#network), в которой будет находиться API-шлюз.

{% include [network](../../_includes/functions/network.md) %}

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится API-шлюз.
    1. Выберите сервис **{{ api-gw-name }}**.
    1. Выберите API-шлюз.
    1. В правом верхнем углу нажмите кнопку **Редактировать**.
    1. В поле **Сеть** укажите облачную сеть, в которой будет находиться API-шлюз.
    1. Нажмите кнопку **Сохранить**.

- API

  Чтобы указать облачную сеть, в которой будет находиться API-шлюз, воспользуйтесь методом REST API [update](../apigateway/api-ref/ApiGateway/update.md) для ресурса [ApiGateway](../apigateway/api-ref/ApiGateway/index.md) или вызовом gRPC API [ApiGatewayService/Update](../apigateway/api-ref/grpc/apigateway_service.md#Update).

{% endlist %}

## См. также

* [Сетевое взаимодействие в {{ api-gw-name }}](../concepts/networking.md).
