# Создать канал

{% list tabs group=instructions %}

- Интерфейс {{ video-name }} {#console}

  1. Откройте [главную страницу]({{ link-video-main }}) {{ video-name }}.
  1. Нажмите кнопку ![plus-sign](../../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_video.channels.action_create-channel }}**.
  1. На странице создания канала введите:
      * **{{ ui-key.yacloud_video.channels.label_title }}**.
      * (Опционально) **{{ ui-key.yacloud_video.channels.label_description }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud_video.common.action_create }}**.
  
  После создания канала вы окажетесь внутри этого канала во вкладке ![image](../../../_assets/console-icons/circle-play.svg) **{{ ui-key.yacloud_video.videos.title_videos }}**.
  
  * Подробнее о каналах см. в разделе [{#T}](../../concepts/index.md#channels).
  * Подробнее о том, как настроить показ рекламы, см. в разделе [{#T}](settings.md#ad-settings).

- REST API {#api}

  Выполните команду:

  ```bash
  curl \
    --request POST \
    --url 'https://video.{{ api-host }}/video/v1/channels' \
    --header 'Authorization: Bearer <IAM-токен>' \
    --header 'Content-Type: application/json' \
    --data '{
      "organization_id": "<идентификатор_организации>",
      "title": "<имя_канала>"
    }'
  ```

  Где:
  * `<IAM-токен>` — [IAM-токен](../../../iam/concepts/authorization/iam-token.md), необходимый для [аутентификации](../../api-ref/authentication.md) в {{ video-name }} API.
  * `<идентификатор_организации>` — [идентификатор](../../../organization/operations/organization-get-id.md) организации, в которой создается канал {{ video-name }}.
  * `<имя_канала>` — имя создаваемого канала в {{ video-name }}.

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
    video.{{ api-host }}:443 yandex.cloud.video.v1.ChannelService/Create
  ```

  Где:
  * `<IAM-токен>` — [IAM-токен](../../../iam/concepts/authorization/iam-token.md), необходимый для [аутентификации](../../api-ref/authentication.md) в {{ video-name }} API.
  * `<идентификатор_организации>` — [идентификатор](../../../organization/operations/organization-get-id.md) организации, в которой создается канал {{ video-name }}.
  * `<имя_канала>` — имя создаваемого канала в {{ video-name }}.

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