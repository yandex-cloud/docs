---
title: "Начало работы с API {{ video-full-name }}"
description: "В данном разделе вы научитесь работать с API {{ video-name }}: создавать канал, загружать видео и получать ссылку на видеоплеер."
---

# Как начать работать с API {{ video-full-name }}

В этом разделе вы научитесь создавать [каналы](../concepts/index.md#channels), загружать [видео](../concepts/videos.md) и получать для загруженных видео ссылки на [видеоплеер](../concepts/player.md) с помощью [REST API](../api-ref/) и [gPRC API](../api-ref/grpc/) {{ video-name }}.

## Перед началом работы {#before-begin}

Чтобы начать работать c API {{ video-name }}:

1. В [сервисе {{ billing-name }}]({{ link-console-billing }}) убедитесь, что у вас подключен [платежный аккаунт](../../billing/concepts/billing-account.md), и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md#create_billing_account).
1. Получите идентификатор организации, в которой вы будете создавать канал. Идентификатор организации указан на странице **{{ ui-key.yacloud_org.pages.settings }}** в интерфейсе [{{org-full-name}}]({{link-org-main}}).
1. [Назначьте](../../organization/operations/add-role.md) пользователю или [сервисному аккаунту](../../iam/concepts/users/service-accounts.md), от имени которого вы будете аутентифицироваться в API {{ video-name }}, [роль](../../iam/concepts/access-control/roles.md) `video.admin` или `video.editor`. Подробнее см. в разделе [{#T}](../security/index.md).
1. [Получите](./authentication.md) IAM-токен для пользователя или сервисного аккаунта, от имени которого вы будете аутентифицироваться в API {{ video-name }}.

Чтобы воспользоваться примерами, установите [cURL](https://curl.haxx.se) и [gRPCurl](https://github.com/fullstorydev/grpcurl) (при использовании [gRPC API](../api-ref/grpc/)).

## Создайте канал {#create-channel}

Чтобы создать канал, выполните команду:

{% list tabs group=api_type %}

- REST API {#rest-api}

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
  * `<IAM-токен>` — полученный перед началом работы IAM-токен.
  * `<идентификатор_организации>` — полученный перед началом работы идентификатор организации.
  * `<имя_канала>` — имя создаваемого канала в {{ video-name }}.

  Результат:

  ```json
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
  * `<IAM-токен>` — полученный перед началом работы IAM-токен.
  * `<идентификатор_организации>` — полученный перед началом работы идентификатор организации.
  * `<имя_канала>` — имя создаваемого канала в {{ video-name }}.

  Результат:

  ```json
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

Сохраните идентификатор (значение `channelId`) созданного канала — он понадобится позднее.

## Создайте видео {#create-video}

1. Узнайте точный размер видеофайла в байтах:

    {% list tabs group=operating_system %}

    - Linux/macOS {#linux-macos}

      В терминале выполните команду, указав путь к видеофайлу:

      ```bash
      ls -l /Users/myuser/Downloads/sample-video.MOV
      ```

      Результат:

      ```text
      ...  100100627 ... /Users/myuser/Downloads/sample-video.MOV
      ```

    - Windows {#windows}

      В powershell выполните команду, указав путь к видеофайлу:

      ```powershell
      (Get-Item "C:\Users\myuser\Downloads\sample-video.MOV").Length
      ```

      Результат:

      ```text
      100100627
      ```

    {% endlist %}

1. Чтобы создать видео, выполните команду:

    {% list tabs group=api_type %}

    - REST API {#rest-api}

      ```bash
      curl \
        --request POST \
        --url 'https://video.{{ api-host }}/video/v1/videos' \
        --header 'Authorization: Bearer <IAM-токен>' \
        --header 'Content-Type: application/json' \
        --data '{
          "channel_id": "<идентификатор_канала>",
          "title": "<имя_видео>",
          "tusd": {
            "file_size": <размер_видеофайла>,
            "file_name": "<имя_видеофайла>"
          },
          "public_access": {}
        }'
      ```

      Где:
      * `<IAM-токен>` — полученный перед началом работы IAM-токен.
      * `<идентификатор_канала>` — сохраненный на предыдущем шаге идентификатор созданного канала.
      * `<имя_видео>` — имя, которое будет присвоено видео при загрузке в канал.
      * `<размер_видеофайла>` — полученный ранее размер видеофайла в байтах.
      * `<имя_видеофайла>` — имя видеофайла, который вы будете загружать.

      Результат:

      ```json
      {
       "done": true,
       "metadata": {
        "@type": "type.googleapis.com/yandex.cloud.video.v1.CreateVideoMetadata",
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
        "status": "WAIT_UPLOADING",
        "visibilityStatus": "PUBLISHED",
        "createdAt": "2024-09-16T19:18:08.384540Z",
        "updatedAt": "2024-09-16T19:18:08.384540Z"
       },
       "id": "vplpjlgda3c2********",
       "description": "Video create",
       "createdAt": "2024-09-16T19:18:08.393546Z",
       "createdBy": "ajeol2afu1js********",
       "modifiedAt": "2024-09-16T19:18:08.393546Z"
      }
      ```

    - gRPC API {#grpc-api}

      ```bash
      grpcurl \
        -rpc-header "Authorization: Bearer <IAM-токен>" \
        -d '{
          "channel_id": "<идентификатор_канала>",
          "title": "<имя_видео>",
          "tusd": {
            "file_size": <размер_видеофайла>,
            "file_name": "<имя_видеофайла>"
          },
          "public_access": {}
        }' \
        video.{{ api-host }}:443 yandex.cloud.video.v1.VideoService/Create
      ```

      Где:
      * `<IAM-токен>` — полученный перед началом работы IAM-токен.
      * `<идентификатор_канала>` — сохраненный на предыдущем шаге идентификатор созданного канала.
      * `<имя_видео>` — имя, которое будет присвоено видео при загрузке в канал.
      * `<размер_видеофайла>` — полученный ранее размер видеофайла в байтах.
      * `<имя_видеофайла>` — имя видеофайла, который вы будете загружать.

      Результат:

      ```json
      {
        "id": "vplpskiedayr********",
        "description": "Video create",
        "createdAt": "2024-09-16T12:16:03.921095Z",
        "createdBy": "ajeol2afu1js********",
        "modifiedAt": "2024-09-16T12:16:03.921095Z",
        "done": true,
        "metadata": {
          "@type": "type.googleapis.com/yandex.cloud.video.v1.CreateVideoMetadata",
          "videoId": "vplvio5377ux********"
        },
        "response": {
          "@type": "type.googleapis.com/yandex.cloud.video.v1.Video",
          "channelId": "vplcqy2qxkjy********",
          "createdAt": "2024-09-16T12:16:03.905662Z",
          "id": "vplvio5377ux********",
          "publicAccess": {},
          "status": "WAIT_UPLOADING",
          "title": "my-very-first-video",
          "tusd": {
            "url": "https://tusd.video.cloud.yandex.net/files/5e7d6b3b68f9dc0d279ce719144c9caa+0006223B********"
          },
          "updatedAt": "2024-09-16T12:16:03.905662Z",
          "visibilityStatus": "PUBLISHED"
        }
      }
      ```

    {% endlist %}

    Сохраните ссылку на загрузку видео (значение поля `url`) и идентификатор видео (значение поля `videoId`) — они понадобятся позднее.

## Загрузите видео {#upload-video}

Загрузка видеофайлов производится по протоколу [tus](https://tus.io/protocols/resumable-upload), который в случае сбоя соединения позволяет возобновить загрузку с момента, на котором она была прервана. Загрузку вы можете реализовать самостоятельно на любом языке программирования или воспользоваться для этого [готовыми библиотеками](https://tus.io/implementations).

Чтобы загрузить видеофайл с помощью `curl`, выполните команду:

```bash
curl \
  --location \
  --request PATCH '<ссылка_на_загрузку_видео>' \
  --header 'Content-Type: application/offset+octet-stream' \
  --header 'Upload-Offset: 0' \
  --header 'Tus-Resumable: 1.0.0' \
  --data-binary '@<путь_к_видеофайлу>'
```

Где:
* `<ссылка_на_загрузку_видео>` — сохраненная ранее ссылка на загрузку, полученная при создании видео.
* `<путь_к_видеофайлу>` — полный путь к файлу с видео, предваряемый символом `@`.

    Например: `@/Users/myuser/Downloads/sample-video.MOV`.

    Не используйте в пути к файлу сокращения, в т.ч. тильду `~`.

## Убедитесь, что видео загрузилось {#verify-upload}

Убедитесь, что видео было загружено полностью. Для этого выполните команду, указав сохраненный ранее идентификатор видео (`videoId`):

{% list tabs group=api_type %}

- REST API {#rest-api}

  ```bash
  curl \
    --request GET \
    --url 'https://video.{{ api-host }}/video/v1/videos/<идентификатор_видео>' \
    --header 'Authorization: Bearer <IAM-токен>'
  ```

  Результат:
  
  ```json
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
   "updatedAt": "2024-09-16T19:31:31.471857Z"
  }
  ```

- gRPC API {#grpc-api}

  ```bash
  grpcurl \
    -rpc-header "Authorization: Bearer <IAM-токен>" \
    -d '{"video_id": "<идентификатор_видео>"}' \
    video.{{ api-host }}:443 yandex.cloud.video.v1.VideoService/Get
  ```

  Результат:
  
  ```json
  {
    "id": "vplva3626rvh********",
    "channelId": "vplcqy2qxkjy********",
    "title": "my-very-first-video",
    "status": "READY",
    "duration": "39.981s",
    "visibilityStatus": "PUBLISHED",
    "createdAt": "2024-09-16T14:11:04.803285Z",
    "updatedAt": "2024-09-16T14:14:36.467614Z",
    "tusd": {
      "url": "https://tusd.video.cloud.yandex.net/files/55994a57bd30b2161399ccab7eb5f2de+0006223D********"
    },
    "publicAccess": {}
  }
  ```

{% endlist %}

Если поле `status` нужного видео имеет значение `PROCESSING` или `READY`, значит видеофайл загрузился полностью. Переходите к [получению ссылки на видеоплеер](#get-link).

Если поле `status` нужного видео имеет значение `WAIT_UPLOADING`, значит загрузка видеофайла была прервана. В этом случае видео необходимо дозагрузить.

## Продолжите прерванную загрузку {#continue-if-interrupted}

Чтобы дозагрузить видео, необходимо знать позицию `offset`, на которой была прервана предыдущая попытка загрузки. 

1. Узнайте позицию `offset` прерванной загрузки, указав сохраненную ранее ссылку на загрузку видео:

    ```bash
    curl \
      --head '<ссылка_на_загрузку_видео>' \
      --header 'Host: tusd.video.cloud.yandex.net' \
      --header 'Tus-Resumable: 1.0.0'
    ```

    Результат:

    ```text
    HTTP/1.1 200 OK
    Server: nginx/1.18.0
    Date: Mon, 16 Sep 2024 15:21:52 GMT
    Connection: keep-alive
    Cache-Control: no-cache
    Tus-Resumable: 1.0.0
    Upload-Length: 100100627
    Upload-Metadata: filename c2FtcGxlLXZpZGVv********,video_id dnBsdjVpeWh2M2F6ZnYz********
    Upload-Offset: 28231123
    X-Content-Type-Options: nosniff
    X-Request-Id: 3b775c2a********
    X-Trace-Id: 95ab2f994557ce1b1ee9dd09********
    X_h: edge-5b647c8d67-*****
    Access-Control-Allow-Origin: *
    Access-Control-Allow-Headers: *
    Access-Control-Expose-Headers: *
    Expires: Thu, 01 Jan 1970 00:00:01 GMT
    ```

    Сохраните значение поля `Upload-Offset` — оно потребуется при дозагрузке видеофайла.

1. Дозагрузите видеофайл, выполнив команду:

    ```bash
    curl \
      --location \
      --request PATCH '<ссылка_на_загрузку_видео>' \
      --header 'Content-Type: application/offset+octet-stream' \
      --header 'Upload-Offset: <значение_offset>' \
      --header 'Tus-Resumable: 1.0.0' \
      --data-binary '@<путь_к_видеофайлу>'
    ```

    Где:
    * `<ссылка_на_загрузку_видео>` — сохраненная ранее ссылка на загрузку, полученная при создании видео.
    * `<значение_offset>` — сохраненное ранее значение `offset` — позиции в файле, на которой прервалась предыдущая попытка загрузки.
    * `<путь_к_видеофайлу>` — полный путь к файлу с видео, предваряемый символом `@`.
    
        Например: `@/Users/myuser/Downloads/sample-video.MOV`.

        Не используйте в пути к файлу сокращения, в т.ч. тильду `~`.

    Повторно [убедитесь](#verify-upload), что видеофайл загрузился полностью. Если загрузка вновь была прервана, повторите действия, описанные в текущем подразделе.

## Получите ссылку на видеоплеер {#get-link}

Чтобы получить ссылку на видеоплеер, выполните команду:

{% list tabs group=api_type %}

- REST API {#rest-api}

  ```bash
  curl \ 
    --request GET \
    --header 'Authorization: Bearer <IAM-токен>' \
    --url 'https://video.api.cloud.yandex.net/video/v1/videos/<идентификатор_видео>:getPlayerURL'
  ```

- gRPC API {#grpc-api}

  ```bash
  grpcurl \
    -rpc-header "Authorization: Bearer <IAM-токен>" \ 
    -d '{
      "video_id": "<идентификатор_видео>"
    }' \
    video.{{ api-host }}:443 yandex.cloud.video.v1.VideoService/GetPlayerURL
  ```
{% endlist %}

Где:
* `<IAM-токен>` — полученный перед началом работы IAM-токен.
* `<идентификатор_видео>` — сохраненный ранее идентификатор видео, загруженного в канал.

Результат:

```json
{
  "playerUrl": "https://runtime.video.cloud.yandex.net/player/video/vplva3626rvh********?autoplay=0\u0026mute=0",
  "html": "\u003ciframe width=\"560\" height=\"315\" src=\"https://runtime.video.cloud.yandex.net/player/video/vplva3626rvh********?autoplay=0\u0026mute=0\" allow=\"autoplay; fullscreen; accelerometer; gyroscope; picture-in-picture; encrypted-media\" frameborder=\"0\" scrolling=\"no\"\u003e\u003c/iframe\u003e"
}
```

Где:
* `playerUrl` — прямая ссылка на видео.
* `html` — HTML-код для вставки видео в формате Iframe.