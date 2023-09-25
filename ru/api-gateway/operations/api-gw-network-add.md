---
title: "Как указать облачную сеть, в которой будет находиться API-шлюз"
description: "Следуя данной инструкции, вы сможете указать облачную сеть, в которой будет находиться API-шлюз."
---

# Указать облачную сеть, в которой будет находиться API-шлюз

{% include [note-preview](../../_includes/note-preview.md) %}

Вы можете указать [облачную сеть](../../vpc/concepts/network.md#network), в которой будет находиться API-шлюз.

{% include [network](../../_includes/functions/network.md) %}

{% list tabs %}

- Консоль управления

    1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором находится API-шлюз.
    1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_api-gateway }}**.
    1. Выберите API-шлюз.
    1. В правом верхнем углу нажмите кнопку **{{ ui-key.yacloud.serverless-functions.gateways.overview.button_action-edit }}**.
    1. В поле **{{ ui-key.yacloud.vpc.label_network }}** укажите облачную сеть, в которой будет находиться API-шлюз.
    1. Нажмите кнопку **{{ ui-key.yacloud.serverless-functions.gateways.form.button_update-gateway }}**.

- API

  Чтобы указать облачную сеть, в которой будет находиться API-шлюз, воспользуйтесь методом REST API [update](../apigateway/api-ref/ApiGateway/update.md) для ресурса [ApiGateway](../apigateway/api-ref/ApiGateway/index.md) или вызовом gRPC API [ApiGatewayService/Update](../apigateway/api-ref/grpc/apigateway_service.md#Update).

{% endlist %}

## См. также

* [Сетевое взаимодействие в {{ api-gw-name }}](../concepts/networking.md).
