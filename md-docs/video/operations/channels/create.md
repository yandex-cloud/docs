# Создать канал

{% list tabs group=instructions %}

- Интерфейс Cloud Video {#console}

  1. Откройте [главную страницу](https://video.yandex.cloud/) Cloud Video.
  1. Нажмите кнопку ![plus-sign](../../../_assets/console-icons/plus.svg) **Создать канал**.
  1. На странице создания канала введите:
      * **Имя**.
      * (Опционально) **Описание**.
  1. Нажмите кнопку **Создать**.
  
  После создания канала вы окажетесь внутри этого канала во вкладке ![image](../../../_assets/console-icons/circle-play.svg) **Видео**.
  
  * Подробнее о каналах см. в разделе [Каналы](../../concepts/index.md#channels).
  * Подробнее о том, как настроить показ рекламы, см. в разделе [Настроить показ рекламы](settings.md#ad-settings).

- REST API {#api}

  Выполните команду:

  ```bash
  curl \
    --request POST \
    --url 'https://video.api.cloud.yandex.net/video/v1/channels' \
    --header 'Authorization: Bearer <IAM-токен>' \
    --header 'Content-Type: application/json' \
    --data '{
      "organization_id": "<идентификатор_организации>",
      "title": "<имя_канала>"
    }'
  ```

  Где:
  * `<IAM-токен>` — [IAM-токен](../../../iam/concepts/authorization/iam-token.md), необходимый для [аутентификации](../../api-ref/authentication.md) в Cloud Video API.
  * `<идентификатор_организации>` — [идентификатор](../../../organization/operations/organization-get-id.md) организации, в которой создается канал Cloud Video.
  * `<имя_канала>` — имя создаваемого канала в Cloud Video.

  Результат:
  
  ```text
  {
   "done": true,
   "metadata": {
    "@type": "type.googleapis.com/yandex.cloud.video.v1.CreateChannelMetadata",
    "channelId": "vplcdyphvqik********"
   },
   "response": {
    "@type": "type.googleapis.com/yandex.cloud.video.v1.Channel",
    "id": "vplcdyphvqik********",
    "organizationId": "bpfaidqca8vd********",
    "title": "my-very-first-channel",
    "createdAt": "2024-09-16T19:01:10.591128Z",
    "updatedAt": "2024-09-16T19:01:10.591128Z"
   },
   "id": "vplp4vofhojp********",
   "description": "Channel create",
   "createdAt": "2024-09-16T19:01:10.596734Z",
   "createdBy": "ajeol2afu1js********",
   "modifiedAt": "2024-09-16T19:01:10.596734Z"
  }
  ```

- gRPC API {#grpc-api}

  Выполните команду:

  ```bash
  grpcurl \
    -rpc-header "Authorization: Bearer <IAM-токен>" \
    -d '{
      "organization_id": "<идентификатор_организации>",
      "title": "<имя_канала>"
    }' \
    video.api.cloud.yandex.net:443 yandex.cloud.video.v1.ChannelService/Create
  ```

  Где:
  * `<IAM-токен>` — [IAM-токен](../../../iam/concepts/authorization/iam-token.md), необходимый для [аутентификации](../../api-ref/authentication.md) в Cloud Video API.
  * `<идентификатор_организации>` — [идентификатор](../../../organization/operations/organization-get-id.md) организации, в которой создается канал Cloud Video.
  * `<имя_канала>` — имя создаваемого канала в Cloud Video.

  Результат:
  
  ```text
  {
    "id": "vplpvkqo2uyv********",
    "description": "Channel create",
    "createdAt": "2024-09-16T10:36:56.973051Z",
    "createdBy": "ajeol2afu1js********",
    "modifiedAt": "2024-09-16T10:36:56.973051Z",
    "done": true,
    "metadata": {
      "@type": "type.googleapis.com/yandex.cloud.video.v1.CreateChannelMetadata",
      "channelId": "vplcqy2qxkjy********"
    },
    "response": {
      "@type": "type.googleapis.com/yandex.cloud.video.v1.Channel",
      "createdAt": "2024-09-16T10:36:56.968240Z",
      "id": "vplcqy2qxkjy********",
      "organizationId": "bpfaidqca8vd********",
      "title": "my-very-first-channel",
      "updatedAt": "2024-09-16T10:36:56.968240Z"
    }
  }
  ```

{% endlist %}