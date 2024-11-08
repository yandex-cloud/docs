---
title: Как создать канал в {{ video-full-name }}
description: Следуя данной инструкции, вы сможете создать канал {{ video-full-name }}.
---

# Создать канал

{% list tabs group=instructions %}

- Интерфейс {{ video-name }} {#console}

  {% include [create-channel](../../../_includes/video/create-channel.md) %}

- REST API {#api}

  Выполните команду:

  {% include [create-channel-rest-api-command](../../../_includes/video/create-channel-rest-api-command.md) %}

  Где:
  * `<IAM-токен>` — [IAM-токен](../../../iam/concepts/authorization/iam-token.md), необходимый для [аутентификации](../../api-ref/authentication.md) в {{ video-name }} API.
  * `<идентификатор_организации>` — [идентификатор](../../../organization/operations/organization-get-id.md) организации, в которой создается канал {{ video-name }}.
  * `<имя_канала>` — имя создаваемого канала в {{ video-name }}.

  {% include [create-channel-rest-api-output](../../../_includes/video/create-channel-rest-api-output.md) %}

- gRPC API {#grpc-api}

  Выполните команду:

  {% include [create-channel-grpc-api-command](../../../_includes/video/create-channel-grpc-api-command.md) %}

  Где:
  * `<IAM-токен>` — [IAM-токен](../../../iam/concepts/authorization/iam-token.md), необходимый для [аутентификации](../../api-ref/authentication.md) в {{ video-name }} API.
  * `<идентификатор_организации>` — [идентификатор](../../../organization/operations/organization-get-id.md) организации, в которой создается канал {{ video-name }}.
  * `<имя_канала>` — имя создаваемого канала в {{ video-name }}.

  {% include [create-channel-grpc-api-output](../../../_includes/video/create-channel-grpc-api-output.md) %}

{% endlist %}