---
title: Как создать сервисное подключение в {{ vpc-full-name }}
description: Следуя данной инструкции, вы сможете создать сервисное подключение (Private Endpoint) в {{ vpc-name }}.
---

# Создать сервисное подключение

{% include [vpc-pe-preview](../../_includes/vpc/pe-preview.md) %}


{% include [private-endpoint-create-roles](../../_includes/vpc/private-endpoint-create-roles.md) %}

Чтобы создать [сервисное подключение](../concepts/private-endpoint.md):

{% list tabs group=instructions %}

- Консоль управления {#console}

  {% include [private-endpoint-create-console](../../_includes/vpc/private-endpoint-create-console.md) %}

- CLI {#cli}

  {% include [private-endpoint-create-cli](../../_includes/vpc/private-endpoint-create-cli.md) %}

- {{ TF }} {#tf}

  {% include [private-endpoint-create-tf](../../_includes/vpc/private-endpoint-create-tf.md) %}

- API {#api}

  Чтобы создать [сервисное подключение](../concepts/private-endpoint.md), воспользуйтесь методом REST API [create](../privatelink/api-ref/PrivateEndpoint/create.md) для ресурса [PrivateEndpoint](../privatelink/api-ref/PrivateEndpoint/index.md) или вызовом gRPC API [PrivateEndpointService/Create](../privatelink/api-ref/grpc/PrivateEndpoint/create.md).

{% endlist %}

#### См. также {#see-also}

* [{#T}](private-endpoint-get-info.md)
* [{#T}](private-endpoint-delete.md)
