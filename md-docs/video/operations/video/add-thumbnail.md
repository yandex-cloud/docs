# Добавить обложку для видео

{% list tabs group=instructions %}

- Интерфейс Cloud Video {#console}

  1. Откройте [главную страницу](https://video.yandex.cloud/) Cloud Video.
  1. Выберите канал.
  1. На вкладке ![image](../../../_assets/console-icons/circle-play.svg) **Видео** выберите видео.
  1. Если у видео уже есть обложка, удалите ее. Для этого наведите указатель на превью обложки и нажмите значок ![image](../../../_assets/console-icons/circle-xmark.svg).
  1. Нажмите кнопку ![image](../../../_assets/console-icons/cloud-arrow-up-in.svg) **Выберите файл** и выберите новое изображение для обложки.

      Поддерживаются обложки в следующих форматах: [JPG](https://ru.wikipedia.org/wiki/JPEG), [PNG](https://ru.wikipedia.org/wiki/PNG) и [GIF](https://ru.wikipedia.org/wiki/GIF).

  1. Нажмите кнопку **Сохранить**.

- REST API {#api}

  1. Перед началом работы:
  
      * [Получите](../../../organization/operations/organization-get-id.md) идентификатор организации, в которой находится ваш [канал](../../concepts/index.md#channels) Cloud Video.
      * [Получите](../../api-ref/authentication.md) IAM-токен, необходимый для аутентификации в API Cloud Video.
      * Чтобы воспользоваться примерами, установите утилиту [cURL](https://curl.haxx.se).
  1. Получите список каналов Cloud Video в вашей организации:

      ```bash
      curl \
        --request GET \
        --url 'https://video.api.cloud.yandex.net/video/v1/channels?organizationId=<идентификатор_организации>' \
        --header 'Authorization: Bearer <IAM-токен>'
      ```
      
      Где:
      * `<идентификатор_организации>` — полученный перед началом работы идентификатор организации.
      * `<IAM-токен>` — полученный перед началом работы IAM-токен.
      
      Результат:
      
      ```text
      {
       "channels": [
        {
         "id": "vplc3neipzso********",
         "organizationId": "bpfaidqca8vd********",
         "title": "my-first-channel",
         "description": "My very first Cloud Video channel",
         "createdAt": "2023-07-07T10:51:48.658737Z",
         "updatedAt": "2023-07-07T10:51:48.658737Z"
        },
        {
         "id": "vplc3vssjcxh********",
         "organizationId": "bpfaidqca8vd********",
         "title": "my-work-channel",
         "createdAt": "2023-08-09T23:32:55.372456Z",
         "updatedAt": "2023-08-09T23:32:55.372456Z"
        },
        {
         "id": "vplc4cfwamlx********",
         "organizationId": "bpfaidqca8vd********",
         "title": "my-personal-channel",
         "createdAt": "2024-03-14T13:48:34.535821Z",
         "updatedAt": "2024-03-14T13:48:34.535821Z"
        },
       ]
      }
      ```
      
      Сохраните идентификатор канала (`id`), в хранилище которого вы хотите загрузить обложку.

  1. Зарегистрируйте обложку в Cloud Video:

      ```bash
      curl \
        --request POST \
        --url 'https://video.api.cloud.yandex.net/video/v1/thumbnails' \
        --header 'Authorization: Bearer <IAM-токен>' \
        --header 'Content-Type: application/json' \
        --data '{
          "channelId": "<идентификатор_канала>"
        }'
      ```
      
      Где:
      * `<IAM-токен>` — полученный перед началом работы IAM-токен.
      * `<идентификатор_канала>` — сохраненный ранее идентификатор канала.
      
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

      ```bash
      curl \
        --request POST \
        --url 'https://video.api.cloud.yandex.net/video/v1/thumbnails/<идентификатор_обложки>:generateUploadURL' \
        --header 'Authorization: Bearer <IAM-токен>'
      ```

      Где:
      * `<IAM-токен>` — полученный перед началом работы IAM-токен.
      * `<идентификатор_обложки>` — сохраненное ранее значение идентификатора обложки.
      
      Результат:
      
      ```text
      {
        "uploadUrl": "https://storage.yandexcloud.net/videoplatform-thumbnail/vpltleyrfnjh********?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=********3aBOmv27nzbJZaEHZ%2F20241102%2Fru-central1%2Fs3%2Faws4_request&X-Amz-Date=20241102T190000Z&X-Amz-Expires=43200&X-Amz-Signature=057fe4c0da26c7758474f5eaa85ff41d7212632572fb636ed6d8f65d039c309b&X-Amz-SignedHeaders=host"
      }
      ```
      
      Поле `uploadUrl` содержит подписанную ссылку, с помощью которой вы сможете загрузить файл обложки.

  1. Загрузите в обложку файл с изображением:

      ```
      curl \
        --request PUT \
        --url '<подписанная_ссылка>' \
        --header 'Content-Type: image/<формат_изображения>' \
        --upload-file '<путь_к_файлу_с_обложкой>'
      ```
      
      Где:
      * `<подписанная_ссылка>` — полученная на предыдущем шаге подписанная ссылка на загрузку файла обложки.
      * `<формат_изображения>` — в зависимости от формата загружаемого изображения, укажите `png`, `jpeg` или `gif`. 
      * `<путь_к_файлу_с_обложкой>` — абсолютный путь к файлу с загружаемым изображением. Не используйте сокращения, в т.ч. тильду `~`.

  1. Получите список видео на канале:

      ```bash
      curl \
        --request GET \
        --url 'https://video.api.cloud.yandex.net/video/v1/videos?channelId=<идентификатор_канала>' \
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

      ```bash
      curl \
        --request PATCH \
        --url 'https://video.api.cloud.yandex.net/video/v1/videos/<идентификатор_видео>' \
        --header 'Authorization: Bearer <IAM-токен>' \
        --header 'Content-Type: application/json' \
        --data '{
          "fieldMask": "thumbnailId",
          "thumbnailId": "<идентификатор_обложки>"
        }'
      ```
      
      Где:
      * `<идентификатор_видео>` — сохраненный ранее идентификатор видео, для которого вы хотите добавить обложку.
      * `<IAM-токен>` — полученный перед началом работы IAM-токен.
      * `<идентификатор_обложки>` — сохраненный ранее идентификатор обложки.
      
      Результат:
      
      ```text
      {
       "done": true,
       "metadata": {
        "@type": "type.googleapis.com/yandex.cloud.video.v1.UpdateVideoMetadata",
        "videoId": "vplvh4wvqimx********"
       },
       "response": {
        "@type": "type.googleapis.com/yandex.cloud.video.v1.Video",
        "tusd": {
         "url": "https://tusd.video.cloud.yandex.net/files/75925d89ddc05c0d5ca3282781f13c6f+00062241********"
        },
        "publicAccess": {},
        "id": "vplvh4wvqimx********",
        "channelId": "vplcdyphvqik********",
        "title": "my-very-first-video",
        "thumbnailId": "vpltqm4nubzl********",
        "status": "READY",
        "duration": "39.981s",
        "visibilityStatus": "PUBLISHED",
        "createdAt": "2024-09-16T19:18:08.384540Z",
        "updatedAt": "2024-11-02T21:08:33.443368Z"
       },
       "id": "vplpriyo7eom********",
       "description": "Video update",
       "createdAt": "2024-11-02T21:08:33.461610Z",
       "createdBy": "ajeol2afu1js********",
       "modifiedAt": "2024-11-02T21:08:33.461610Z"
      }
      ```

- gRPC API {#grpc-api}

  1. Перед началом работы:
  
      * [Получите](../../../organization/operations/organization-get-id.md) идентификатор организации, в которой находится ваш [канал](../../concepts/index.md#channels) Cloud Video.
      * [Получите](../../api-ref/authentication.md) IAM-токен, необходимый для аутентификации в API Cloud Video.
      * Чтобы воспользоваться примерами, установите утилиты [cURL](https://curl.haxx.se), [gRPCurl](https://github.com/fullstorydev/grpcurl) и [jq](https://stedolan.github.io/jq).
  1. Получите список каналов Cloud Video в вашей организации:

      ```bash
      grpcurl \
        -rpc-header "Authorization: Bearer <IAM-токен>" \
        -d '{
          "organizationId": "<идентификатор_организации>"
        }' \
        video.api.cloud.yandex.net:443 yandex.cloud.video.v1.ChannelService/List
      ```
      
      Где:
      * `<IAM-токен>` — полученный перед началом работы IAM-токен.
      * `<идентификатор_организации>` — полученный перед началом работы идентификатор организации.
      
      Результат:
      
      ```text
      {
        "channels": [
          {
            "id": "vplc3neipzso********",
            "organizationId": "bpfaidqca8vd********",
            "title": "my-first-channel",
            "description": "My very first Cloud Video channel",
            "createdAt": "2023-07-07T10:51:48.658737Z",
            "updatedAt": "2023-07-07T10:51:48.658737Z"
          },
          {
            "id": "vplc3vssjcxh********",
            "organizationId": "bpfaidqca8vd********",
            "title": "my-work-channel",
            "createdAt": "2023-08-09T23:32:55.372456Z",
            "updatedAt": "2023-08-09T23:32:55.372456Z"
          },
          {
            "id": "vplc4cfwamlx********",
            "organizationId": "bpfaidqca8vd********",
            "title": "my-personal-channel",
            "createdAt": "2024-03-14T13:48:34.535821Z",
            "updatedAt": "2024-03-14T13:48:34.535821Z"
          },
        ]
      }
      ```
      
      Сохраните идентификатор канала (`id`), в хранилище которого вы хотите загрузить обложку.

  1. Зарегистрируйте обложку в Cloud Video:

      ```bash
      grpcurl \
        -rpc-header "Authorization: Bearer <IAM-токен>" \
        -rpc-header 'Content-Type: application/json' \
        -d '{
          "channel_id": "<идентификатор_канала>"
        }' \
        video.api.cloud.yandex.net:443 yandex.cloud.video.v1.ThumbnailService/Create
      ```
      
      Где:
      * `<IAM-токен>` — полученный перед началом работы IAM-токен.
      * `<идентификатор_канала>` — сохраненный ранее идентификатор канала.
      
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
          "id": "vpltleyrfnjh********"
        }
      }
      ```

      Сохраните значение идентификатора обложки (`thumbnailId`), оно понадобится позднее.

  1. Получите ссылку на загрузку изображения в обложку:

      ```bash
      grpcurl \
        -rpc-header "Authorization: Bearer <IAM-токен>" \
        -d '{
          "thumbnailId": "<идентификатор_обложки>"
        }' \
        video.api.cloud.yandex.net:443 yandex.cloud.video.v1.ThumbnailService/GenerateUploadURL | jq
      ```

      Где:
      * `<IAM-токен>` — полученный перед началом работы IAM-токен.
      * `<идентификатор_обложки>` — сохраненное ранее значение идентификатора обложки.
      
      Результат:
      
      ```text
      {
        "uploadUrl": "https://storage.yandexcloud.net/videoplatform-thumbnail/vpltleyrfnjh********?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=********3aBOmv27nzbJZaEHZ%2F20241102%2Fru-central1%2Fs3%2Faws4_request&X-Amz-Date=20241102T190000Z&X-Amz-Expires=43200&X-Amz-Signature=057fe4c0da26c7758474f5eaa85ff41d7212632572fb636ed6d8f65d039c309b&X-Amz-SignedHeaders=host"
      }
      ```
      
      Поле `uploadUrl` содержит подписанную ссылку, с помощью которой вы сможете загрузить файл обложки.

  1. Загрузите в обложку файл с изображением:

      ```
      curl \
        --request PUT \
        --url '<подписанная_ссылка>' \
        --header 'Content-Type: image/<формат_изображения>' \
        --upload-file '<путь_к_файлу_с_обложкой>'
      ```
      
      Где:
      * `<подписанная_ссылка>` — полученная на предыдущем шаге подписанная ссылка на загрузку файла обложки.
      * `<формат_изображения>` — в зависимости от формата загружаемого изображения, укажите `png`, `jpeg` или `gif`. 
      * `<путь_к_файлу_с_обложкой>` — абсолютный путь к файлу с загружаемым изображением. Не используйте сокращения, в т.ч. тильду `~`.

  1. Получите список видео на канале:

      ```bash
      grpcurl \
        -rpc-header "Authorization: Bearer <IAM-токен>" \
        -d '{
          "channelId": "<идентификатор_канала>"
        }' \
        video.api.cloud.yandex.net:443 yandex.cloud.video.v1.VideoService/List
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

      ```bash
      grpcurl \
        -rpc-header "Authorization: Bearer <IAM-токен>" \
        -rpc-header "Content-Type: application/json" \
        -d '{
          "videoId": "<идентификатор_видео>",
          "fieldMask": {"paths": ["thumbnail_id"]},
          "thumbnailId": "<идентификатор_обложки>"
        }' \
        video.api.cloud.yandex.net:443 yandex.cloud.video.v1.VideoService/Update
      ```
      
      Где:
      * `<IAM-токен>` — полученный перед началом работы IAM-токен.
      * `<идентификатор_видео>` — сохраненный ранее идентификатор видео, для которого вы хотите добавить обложку.
      * `<идентификатор_обложки>` — сохраненный ранее идентификатор обложки.
      
      Результат:
      
      ```text
      {
        "id": "vplp77twonao********",
        "description": "Video update",
        "createdAt": "2024-11-03T09:38:13.363079Z",
        "createdBy": "ajeol2afu1js********",
        "modifiedAt": "2024-11-03T09:38:13.363079Z",
        "done": true,
        "metadata": {
          "@type": "type.googleapis.com/yandex.cloud.video.v1.UpdateVideoMetadata",
          "videoId": "vplvh4wvqimx********"
        },
        "response": {
          "@type": "type.googleapis.com/yandex.cloud.video.v1.Video",
          "channelId": "vplcdyphvqik********",
          "createdAt": "2024-09-16T19:18:08.384540Z",
          "duration": "39.981s",
          "id": "vplvh4wvqimx********",
          "publicAccess": {},
          "status": "READY",
          "thumbnailId": "vpltqlukqfoc********",
          "title": "my-very-first-video",
          "tusd": {
            "url": "https://tusd.video.cloud.yandex.net/files/75925d89ddc05c0d5ca3282781f13c6f+00062241********"
          },
          "updatedAt": "2024-11-03T09:38:13.354454Z",
          "visibilityStatus": "PUBLISHED"
        }
      }
      ```

{% endlist %}