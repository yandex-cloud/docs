---
title: Как добавить обложку для видео в {{ video-full-name }}
description: Следуя данной инструкции, вы сможете добавить обложку для видео в сервисе {{ video-name }}.
---

# Добавить обложку для видео

Чтобы добавить обложку для видео:

{% list tabs group=instructions %}

- Интерфейс {{ video-name }} {#console}

  1. Откройте [главную страницу]({{ link-video-main }}) {{ video-name }}.
  1. Выберите канал.
  1. На вкладке ![image](../../../_assets/console-icons/circle-play.svg) **{{ ui-key.yacloud_video.videos.title_videos }}** в строке с нужным видео нажмите значок ![image](../../../_assets/console-icons/ellipsis.svg) и выберите **{{ ui-key.yacloud_video.common.action_edit }}**.
  1. Если у видео уже есть обложка, удалите ее. Для этого наведите указатель на превью обложки и нажмите значок ![image](../../../_assets/console-icons/circle-xmark.svg).
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

  1. Зарегистрируйте обложку в {{ video-name }}:

      {% include [register-thumbnail-rest-api](../../../_includes/video/register-thumbnail-rest-api.md) %}

      Сохраните значение идентификатора обложки (`thumbnailId`), оно понадобится позднее.

  1. Получите ссылку на загрузку изображения в обложку:

      {% include [get-thumbnail-uplink-rest-command](../../../_includes/video/get-thumbnail-uplink-rest-command.md) %}

      {% include [get-thumbnail-uplink-api-output](../../../_includes/video/get-thumbnail-uplink-api-output.md) %}

  1. Загрузите в обложку файл с изображением:

      {% include [upload-thumbnail-curl](../../../_includes/video/upload-thumbnail-curl.md) %}

  1. Получите список видео на канале:

      ```bash
      curl \
        --request GET \
        --url 'https://video.{{ api-host }}/video/v1/videos?channelId=<идентификатор_канала>' \
        --header 'Authorization: Bearer <IAM-токен>'
      ```

      Где:
      * `<идентификатор_канала>` — идентификатор канала с видео, для которого вы хотите добавить обложку.
      * `<IAM-токен>` — полученный перед началом работы IAM-токен.

      Результат:

      ```text
      {
       "videos": [
        {
         "tusd": {
          "url": "https://tusd.video.cloud.yandex.net/files/75925d89ddc05c0d5ca3282781f13c6f+00062241********"
         },
         "publicAccess": {},
         "id": "vplvh4wvqimx********",
         "channelId": "vplcdyphvqik********",
         "title": "my-very-first-video",
         "status": "READY",
         "duration": "39.981s",
         "visibilityStatus": "PUBLISHED",
         "createdAt": "2024-09-16T19:18:08.384540Z",
         "updatedAt": "2024-11-03T12:53:07.769557Z"
        },
        {
         "tusd": {
          "url": "https://tusd.video.cloud.yandex.net/files/a95b9affc003bfb23708ca989e88f6b0+00062602********"
         },
         "id": "vplvm7wbmkon********",
         "channelId": "vplcdyphvqik********",
         "title": "my-second-video",
         "status": "PROCESSING",
         "visibilityStatus": "PUBLISHED",
         "createdAt": "2024-11-03T13:54:54.248715Z",
         "updatedAt": "2024-11-03T13:55:17.112515Z"
        }
       ]
      }
      ```

      Сохраните идентификатор видео (`id`), для которого вы хотите добавить обложку.

  1. Добавьте созданную обложку к выбранному видео:

      {% include [assign-thumbnail-to-video-rest](../../../_includes/video/assign-thumbnail-to-video-rest.md) %}

- gRPC API {#grpc-api}

  1. Перед началом работы:
  
      * [Получите](../../../organization/operations/organization-get-id.md) идентификатор организации, в которой находится ваш [канал](../../concepts/index.md#channels) {{ video-name }}.
      * [Получите](../../api-ref/authentication.md) IAM-токен, необходимый для аутентификации в API {{ video-name }}.
      * Чтобы воспользоваться примерами, установите утилиты [cURL](https://curl.haxx.se) и [gRPCurl](https://github.com/fullstorydev/grpcurl).
  1. Получите список каналов {{ video-name }} в вашей организации:

      {% include [list-channels-grpc-api](../../../_includes/video/list-channels-grpc-api.md) %}

  1. Зарегистрируйте обложку в {{ video-name }}:

      {% include [register-thumbnail-grpc-api](../../../_includes/video/register-thumbnail-grpc-api.md) %}

      Сохраните значение идентификатора обложки (`thumbnailId`), оно понадобится позднее.

  1. Получите ссылку на загрузку изображения в обложку:

      {% include [get-thumbnail-uplink-grpc-command](../../../_includes/video/get-thumbnail-uplink-grpc-command.md) %}

      {% include [get-thumbnail-uplink-api-output](../../../_includes/video/get-thumbnail-uplink-api-output.md) %}

  1. Загрузите в обложку файл с изображением:

      {% include [upload-thumbnail-curl](../../../_includes/video/upload-thumbnail-curl.md) %}

  1. Получите список видео на канале:

      ```bash
      grpcurl \
        -rpc-header "Authorization: Bearer <IAM-токен>" \
        -d '{
          "channelId": "<идентификатор_канала>"
        }' \
        video.{{ api-host }}:443 yandex.cloud.video.v1.VideoService/List
      ```

      Где:
      * `<IAM-токен>` — полученный перед началом работы IAM-токен.
      * `<идентификатор_канала>` — идентификатор канала с видео, для которого вы хотите добавить обложку.

      Результат:

      ```text
      {
        "videos": [
          {
            "id": "vplvh4wvqimx********",
            "channelId": "vplcdyphvqik********",
            "title": "my-very-first-video",
            "status": "READY",
            "duration": "39.981s",
            "visibilityStatus": "PUBLISHED",
            "createdAt": "2024-09-16T19:18:08.384540Z",
            "updatedAt": "2024-11-03T12:53:07.769557Z",
            "tusd": {
              "url": "https://tusd.video.cloud.yandex.net/files/75925d89ddc05c0d5ca3282781f13c6f+00062241********"
            },
            "publicAccess": {}
          },
          {
            "id": "vplvm7wbmkon********",
            "channelId": "vplcdyphvqik********",
            "title": "my-second-video",
            "status": "PROCESSING",
            "visibilityStatus": "PUBLISHED",
            "createdAt": "2024-11-03T13:54:54.248715Z",
            "updatedAt": "2024-11-03T14:05:52.004442Z",
            "tusd": {
              "url": "https://tusd.video.cloud.yandex.net/files/a95b9affc003bfb23708ca989e88f6b0+00062602********"
            }
          }
        ]
      }
      ```

      Сохраните идентификатор видео (`id`), для которого вы хотите добавить обложку.

  1. Добавьте созданную обложку к выбранному видео:

      {% include [assign-thumbnail-to-video-grpc](../../../_includes/video/assign-thumbnail-to-video-grpc.md) %}

{% endlist %}