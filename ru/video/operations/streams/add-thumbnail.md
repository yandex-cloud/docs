---
title: Как добавить обложку для трансляции в {{ video-full-name }}
description: Следуя данной инструкции, вы сможете добавить обложку для трансляции в сервисе {{ video-name }}.
---

# Добавить обложку для трансляции

Чтобы добавить обложку для трансляции:

{% list tabs group=instructions %}

- Интерфейс {{ video-name }} {#console}

  1. Откройте [главную страницу]({{ link-video-main }}) {{ video-name }}.
  1. Выберите канал.
  1. На вкладке ![image](../../../_assets/console-icons/antenna-signal.svg) **{{ ui-key.yacloud_video.streams.title_streams }}** выберите нужную трансляцию.
  2. В блоке **{{ ui-key.yacloud_video.streams.title_stream-episodes }}** в строке необходимого эпизода нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud_video.common.action_edit }}**.
  1. Если у эпизода трансляции уже есть обложка, удалите ее. Для этого наведите указатель на превью обложки и нажмите значок ![image](../../../_assets/console-icons/circle-xmark.svg).
  1. Нажмите кнопку ![image](../../../_assets/console-icons/cloud-arrow-up-in.svg) **Выберите файл** и выберите новое изображение для обложки.

      {% include [image-characteristic](../../../_includes/video/image-characteristic.md) %}

  1. Нажмите кнопку **{{ ui-key.yacloud_video.common.action_accept }}**.

- REST API {#api}

  1. Перед началом работы:
  
      * [Получите](../../../organization/operations/organization-get-id.md) идентификатор организации, в которой находится ваш [канал](../../concepts/index.md#channels) {{ video-name }}.
      * [Получите](../../api-ref/authentication.md) IAM-токен, необходимый для аутентификации в API {{ video-name }}.
      * Чтобы воспользоваться примерами, установите утилиту [cURL](https://curl.haxx.se).
  1. Получите список каналов {{ video-name }} в вашей организации:

      {% include [list-channels-rest-api](../../../_includes/video/list-channels-rest-api.md) %}

  1. Получите список трансляций на канале:

      ```bash
      curl \
        --request GET \
        --url 'https://video.{{ api-host }}/video/v1/streams?channelId=<идентификатор_канала>' \
        --header 'Authorization: Bearer <IAM-токен>'
      ```

      Где:
      * `<идентификатор_канала>` — идентификатор канала с трансляцией, для которой вы хотите добавить обложку.
      * `<IAM-токен>` — полученный перед началом работы IAM-токен.

      Результат:

      ```text
      {
       "streams": [
        {
         "onDemand": {},
         "id": "vplsfj23t7tf********",
         "channelId": "vplcdyphvqik********",
         "lineId": "vplldrpqy42y********",
         "title": "my-first-stream",
         "status": "OFFLINE",
         "createdAt": "2024-11-03T16:55:32.976950Z",
         "updatedAt": "2024-11-03T16:55:33.091744Z"
        },
        {
         "onDemand": {},
         "id": "vplsgchsr5gi********",
         "channelId": "vplcdyphvqik********",
         "lineId": "vpllxc2mfleb********",
         "title": "my-new-stream",
         "thumbnailId": "vpltznjxpnyj********",
         "status": "OFFLINE",
         "createdAt": "2024-11-03T16:34:10.617101Z",
         "updatedAt": "2024-11-03T16:35:06.601920Z"
        }
       ]
      }
      ```

      Сохраните идентификатор трансляции (`id`), для которой вы хотите добавить обложку.

  1. Получите список эпизодов трансляции:

      ```bash
      curl \
        --request GET \
        --url 'https://video.{{ api-host }}/video/v1/episodes?streamId=<идентификатор_трансляции>' \
        --header 'Authorization: Bearer <IAM-токен>'
      ```

      Где:
      * `<идентификатор_трансляции>` — сохраненный ранее идентификатор трансляции.
      * `<IAM-токен>` — полученный перед началом работы IAM-токен.

      Результат:

      ```text
      {
       "episodes": [
        {
         "id": "vpleof6lm40k********",
         "streamId": "vplsfj23t7tf********",
         "lineId": "vplldrpqy42y********",
         "title": "my-first-episode",
         "visibilityStatus": "PUBLISHED",
         "createdAt": "2024-11-03T16:55:32.976950Z",
         "updatedAt": "2024-11-03T16:55:33.091744Z"
        }
       ]
      }
      ```

      Сохраните идентификатор эпизода (`id`), для которого вы хотите добавить обложку.

  1. Зарегистрируйте обложку в {{ video-name }}:

      ```bash
      curl \
        --request POST \
        --url 'https://video.{{ api-host }}/video/v1/thumbnails' \
        --header 'Authorization: Bearer <IAM-токен>' \
        --header 'Content-Type: application/json' \
        --data '{
          "episodeId": "<идентификатор_эпизода>"
        }'
      ```

      Где:
      * `<IAM-токен>` — полученный перед началом работы IAM-токен.
      * `episodeId` — сохраненный ранее идентификатор эпизода.

      Результат:

      ```text
      {
       "done": true,
       "metadata": {
        "@type": "type.googleapis.com/yandex.cloud.video.v1.CreateThumbnailMetadata",
        "thumbnailId": "vpltaurfr4pr********"
       },
       "response": {
        "@type": "type.googleapis.com/yandex.cloud.video.v1.Thumbnail",
        "id": "vpltaurfr4pr********",
        "channelId": "vplcdyphvqik********",
        "episodeId": "vpleof6lm40k********",
        "createdAt": "2024-11-02T16:56:19.296797Z"
       },
       "id": "vplpgbyqopdr********",
       "description": "Thumbnail create",
       "createdAt": "2024-11-02T16:56:19.301776Z",
       "createdBy": "ajeol2afu1js********",
       "modifiedAt": "2024-11-02T16:56:19.301776Z"
      }
      ```

      Сохраните значение идентификатора обложки (`thumbnailId`), оно понадобится позднее.

  1. Получите ссылку на загрузку изображения в обложку:

      {% include [get-thumbnail-uplink-rest-command](../../../_includes/video/get-thumbnail-uplink-rest-command.md) %}

      {% include [get-thumbnail-uplink-api-output](../../../_includes/video/get-thumbnail-uplink-api-output.md) %}

  1. Загрузите в обложку файл с изображением:

      {% include [upload-thumbnail-curl](../../../_includes/video/upload-thumbnail-curl.md) %}

  1. Добавьте созданную обложку к выбранному эпизоду:

      ```bash
      curl \
        --request PATCH \
        --url 'https://video.{{ api-host }}/video/v1/episodes/<идентификатор_эпизода>' \
        --header 'Authorization: Bearer <IAM-токен>' \
        --header 'Content-Type: application/json' \
        --data '{
          "fieldMask": "thumbnailId",
          "thumbnailId": "<идентификатор_обложки>"
        }'
      ```

      Где:
      * `<идентификатор_эпизода>` — сохраненный ранее идентификатор эпизода, для которого вы хотите добавить обложку.
      * `<IAM-токен>` — полученный перед началом работы IAM-токен.
      * `<идентификатор_обложки>` — сохраненный ранее идентификатор обложки.

      Результат:

      ```text
      {
       "done": true,
       "metadata": {
        "@type": "type.googleapis.com/yandex.cloud.video.v1.UpdateEpisodeMetadata",
        "episodeId": "vpleof6lm40k********"
       },
       "response": {
        "@type": "type.googleapis.com/yandex.cloud.video.v1.Episode",
        "id": "vpleof6lm40k********",
        "streamId": "vplsfj23t7tf********",
        "lineId": "vplldrpqy42y********",
        "title": "my-first-episode",
        "thumbnailId": "vpltxnjvjyzy********",
        "visibilityStatus": "PUBLISHED",
        "createdAt": "2024-11-03T16:55:32.976950Z",
        "updatedAt": "2024-11-03T17:21:31.672357Z"
       },
       "id": "vplpgadtyvhm********",
       "description": "Episode update",
       "createdAt": "2024-11-03T17:21:31.680037Z",
       "createdBy": "ajeol2afu1js********",
       "modifiedAt": "2024-11-03T17:21:31.680037Z"
      }
      ```

- gRPC API {#grpc-api}

  1. Перед началом работы:
  
      * [Получите](../../../organization/operations/organization-get-id.md) идентификатор организации, в которой находится ваш [канал](../../concepts/index.md#channels) {{ video-name }}.
      * [Получите](../../api-ref/authentication.md) IAM-токен, необходимый для аутентификации в API {{ video-name }}.
      * Чтобы воспользоваться примерами, установите утилиты [cURL](https://curl.haxx.se), [gRPCurl](https://github.com/fullstorydev/grpcurl) и [jq](https://stedolan.github.io/jq).
  1. Получите список каналов {{ video-name }} в вашей организации:

      {% include [list-channels-grpc-api](../../../_includes/video/list-channels-grpc-api.md) %}

  1. Получите список трансляций на канале:

      ```bash
      grpcurl \
        -rpc-header "Authorization: Bearer <IAM-токен>" \
        -d '{
          "channelId": "<идентификатор_канала>"
        }' \
        video.{{ api-host }}:443 yandex.cloud.video.v1.StreamService/List
      ```

      Где:
      * `<IAM-токен>` — полученный перед началом работы IAM-токен.
      * `<идентификатор_канала>` — идентификатор канала с трансляцией, для которой вы хотите добавить обложку.

      Результат:

      ```text
      {
        "streams": [
          {
            "id": "vplsfj23t7tf********",
            "channelId": "vplcdyphvqik********",
            "lineId": "vplldrpqy42y********",
            "title": "my-first-stream",
            "status": "OFFLINE",
            "createdAt": "2024-11-03T16:55:32.976950Z",
            "updatedAt": "2024-11-03T16:55:33.091744Z",
            "onDemand": {}
          },
          {
            "id": "vplsgchsr5gi********",
            "channelId": "vplcdyphvqik********",
            "lineId": "vpllxc2mfleb********",
            "title": "my-new-stream",
            "thumbnailId": "vpltznjxpnyj********",
            "status": "OFFLINE",
            "createdAt": "2024-11-03T16:34:10.617101Z",
            "updatedAt": "2024-11-03T16:35:06.601920Z",
            "onDemand": {}
          }
        ]
      }
      ```

      Сохраните идентификатор трансляции (`id`), для которой вы хотите добавить обложку.

  1. Получите список эпизодов трансляции:

      ```bash
      grpcurl \
        -rpc-header "Authorization: Bearer <IAM-токен>" \
        -d '{
          "stream_id": "<идентификатор_трансляции>"
        }' \
        video.{{ api-host }}:443 yandex.cloud.video.v1.EpisodeService/List
      ```

      Где:
      * `<IAM-токен>` — полученный перед началом работы IAM-токен.
      * `<идентификатор_трансляции>` — сохраненный ранее идентификатор трансляции.

      Результат:

      ```text
      {
        "episodes": [
          {
            "id": "vpleof6lm40k********",
            "streamId": "vplsfj23t7tf********",
            "lineId": "vplldrpqy42y********",
            "title": "my-first-episode",
            "visibilityStatus": "PUBLISHED",
            "createdAt": "2024-11-03T16:55:32.976950Z",
            "updatedAt": "2024-11-03T16:55:33.091744Z"
          }
        ]
      }
      ```

      Сохраните идентификатор эпизода (`id`), для которого вы хотите добавить обложку.

  1. Зарегистрируйте обложку в {{ video-name }}:

      ```bash
      grpcurl \
        -rpc-header "Authorization: Bearer <IAM-токен>" \
        -rpc-header 'Content-Type: application/json' \
        -d '{
          "episode_id": "<идентификатор_эпизода>"
        }' \
        video.{{ api-host }}:443 yandex.cloud.video.v1.ThumbnailService/Create
      ```

      Где:
      * `<IAM-токен>` — полученный перед началом работы IAM-токен.
      * `episode_id` — сохраненный ранее идентификатор эпизода.

      Результат:

      ```text
      {
        "id": "vplpoqhxep6q********",
        "description": "Thumbnail create",
        "createdAt": "2024-11-02T19:04:28.412672Z",
        "createdBy": "ajeol2afu1js********",
        "modifiedAt": "2024-11-02T19:04:28.412672Z",
        "done": true,
        "metadata": {
          "@type": "type.googleapis.com/yandex.cloud.video.v1.CreateThumbnailMetadata",
          "thumbnailId": "vpltleyrfnjh********"
        },
        "response": {
          "@type": "type.googleapis.com/yandex.cloud.video.v1.Thumbnail",
          "channelId": "vplcdyphvqik********",
          "createdAt": "2024-11-02T19:04:28.402787Z",
          "episodeId": "vpleof6lm40k********",
          "id": "vpltleyrfnjh********"
        }
      }
      ```

      Сохраните значение идентификатора обложки (`thumbnailId`), оно понадобится позднее.

  1. Получите ссылку на загрузку изображения в обложку:

      {% include [get-thumbnail-uplink-grpc-command](../../../_includes/video/get-thumbnail-uplink-grpc-command.md) %}

      {% include [get-thumbnail-uplink-api-output](../../../_includes/video/get-thumbnail-uplink-api-output.md) %}

  1. Загрузите в обложку файл с изображением:

      {% include [upload-thumbnail-curl](../../../_includes/video/upload-thumbnail-curl.md) %}

  1. Добавьте созданную обложку к выбранному эпизоду:

      ```bash
      grpcurl \
        -rpc-header "Authorization: Bearer <IAM-токен>" \
        -rpc-header "Content-Type: application/json" \
        -d '{
          "episode_id": "<идентификатор_эпизода>",
          "field_mask": {"paths": ["thumbnail_id"]},
          "thumbnail_id": "<идентификатор_обложки>"
        }' \
        video.{{ api-host }}:443 yandex.cloud.video.v1.EpisodeService/Update
      ```

      Где:
      * `<IAM-токен>` — полученный перед началом работы IAM-токен.
      * `<идентификатор_эпизода>` — сохраненный ранее идентификатор эпизода, для которого вы хотите добавить обложку.
      * `<идентификатор_обложки>` — сохраненный ранее идентификатор обложки.

      Результат:

      ```text
      {
        "id": "vplpl2wqhe62********",
        "description": "Episode update",
        "createdAt": "2024-11-03T17:29:26.987297Z",
        "createdBy": "ajeol2afu1js********",
        "modifiedAt": "2024-11-03T17:29:26.987297Z",
        "done": true,
        "metadata": {
          "@type": "type.googleapis.com/yandex.cloud.video.v1.UpdateEpisodeMetadata",
          "episodeId": "vpleof6lm40k********"
        },
        "response": {
          "@type": "type.googleapis.com/yandex.cloud.video.v1.Episode",
          "createdAt": "2024-11-03T16:55:32.976950Z",
          "id": "vpleof6lm40k********",
          "lineId": "vplldrpqy42y********",
          "streamId": "vplsfj23t7tf********",
          "thumbnailId": "vpltxnjvjyzy********",
          "title": "my-first-episode",
          "updatedAt": "2024-11-03T17:29:26.986096Z",
          "visibilityStatus": "PUBLISHED"
        }
      }
      ```

{% endlist %}