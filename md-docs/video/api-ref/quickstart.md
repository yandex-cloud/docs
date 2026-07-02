[Документация Yandex Cloud](../../index.md) > [Yandex Cloud Video](../index.md) > Справочник API > Начало работы с API

# Как начать работать с API Yandex Cloud Video

В этом разделе вы научитесь создавать [каналы](../concepts/index.md#channels), загружать [видео](../concepts/videos.md) и получать для загруженных видео ссылки на [видеоплеер](../concepts/player.md) с помощью [REST API](index.md) и [gRPC API](grpc/index.md) Cloud Video.

Чтобы начать работать с API Cloud Video:

1. [Создайте канал](#create-channel).
1. [Создайте видео](#create-video).
1. [Добавьте обложку к видео](#add-thumbnail).
1. [Получите ссылку на видеоплеер](#get-link).

## Перед началом работы {#before-begin}

1. В [сервисе Yandex Cloud Billing](https://center.yandex.cloud/billing/accounts) убедитесь, что у вас подключен [платежный аккаунт](../../billing/concepts/billing-account.md), и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md#create_billing_account).
1. [Получите](../../organization/operations/organization-get-id.md) идентификатор [организации](../../organization/quickstart.md), в которой вы будете создавать канал.

Чтобы воспользоваться примерами, установите утилиты:
* [cURL](https://curl.haxx.se) при использовании [REST API](index.md).
* [cURL](https://curl.haxx.se), [gRPCurl](https://github.com/fullstorydev/grpcurl) и [jq](https://stedolan.github.io/jq) при использовании [gRPC API](grpc/index.md).

### Настройте сервисный аккаунт {#configure-account}

Для доступа к организации и работы с API Cloud Video потребуется [сервисный аккаунт](../../iam/concepts/users/service-accounts.md) с [ролью](../../iam/concepts/access-control/roles.md) `video.admin` или `video.editor` и [IAM-токен](../../iam/concepts/authorization/iam-token.md).

#### Создайте сервисный аккаунт {#create-account}

Создайте сервисный аккаунт, от имени которого вы будете аутентифицироваться в API Cloud Video.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) выберите каталог, в котором вы будете работать с API Cloud Video.
  1. В списке сервисов выберите **Identity and Access Management**.
  1. Нажмите кнопку **Создать сервисный аккаунт**.
  1. Введите имя сервисного аккаунта, например `sa-video-api`.

      Требования к имени:

      * длина — от 3 до 63 символов;
      * может содержать строчные буквы латинского алфавита, цифры и дефисы;
      * первый символ — буква, последний — не дефис.

  1. Нажмите кнопку **Создать**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки Yandex Cloud (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Выполните команду для создания сервисного аккаунта:

  ```bash
  yc iam service-account create --name sa-video-api
  ```

  Где `--name` — имя сервисного аккаунта в формате:

  * длина — от 3 до 63 символов;
  * может содержать строчные буквы латинского алфавита, цифры и дефисы;
  * первый символ — буква, последний — не дефис.

  Результат:

  ```text
  id: ajehr0to1g8b********
  folder_id: b1gv87ssvu49********
  created_at: "2024-03-04T09:03:11.665153755Z"
  name: sa-video-api
  ```

  Сохраните идентификатор сервисного аккаунта (`id`), он понадобится при [назначении роли](#assign-role).

- API {#api}

  Чтобы создать сервисный аккаунт, воспользуйтесь методом REST API [create](../../iam/api-ref/ServiceAccount/create.md) для ресурса [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) или вызовом gRPC [ServiceAccountService/Create](../../iam/api-ref/grpc/ServiceAccount/create.md).

{% endlist %}

#### Назначьте роль сервисному аккаунту {#assign-role}

Назначьте сервисному аккаунту роль `video.admin` или `video.editor` на организацию. Подробнее в разделе [Управление доступом в Yandex Cloud Video](../security/index.md).

Чтобы предоставить сервисному аккаунту права доступа к организации, необходима роль не ниже `organization-manager.admin`.

{% list tabs group=instructions %}

- Интерфейс Cloud Center {#cloud-center}

  1. Войдите в сервис [Yandex Identity Hub](https://center.yandex.cloud/organization) с учетной записью администратора или владельца организации.
  1. На панели слева выберите ![persons-lock](../../_assets/console-icons/persons-lock.svg) **Права доступа**.
  1. В фильтре **Тип аккаунта** выберите `Сервисные аккаунты`.
  1. В правом верхнем углу страницы нажмите кнопку **Назначить роли**.
  1. В открывшемся окне перейдите в раздел **Сервисные аккаунты** и выберите созданный ранее сервисный аккаунт из списка или воспользуйтесь поиском.
  1. Нажмите кнопку ![plus](../../_assets/console-icons/plus.svg) **Добавить роль** и выберите роль `video.admin` или `video.editor`.
  1. Нажмите кнопку **Сохранить**.

- CLI {#cli}

  Выполните команду:

  ```bash
  yc organization-manager organization add-access-binding \
    --id <идентификатор_организации> \
    --role <роль> \
    --service-account-id <идентификатор_сервисного_аккаунта>
  ```

  Где `--role` — `video.admin`или `video.editor`.

- API {#api}

  Чтобы назначить сервисному аккаунту роль на организацию, воспользуйтесь методом REST API [updateAccessBindings](../../organization/api-ref/Organization/updateAccessBindings.md) для ресурса [Organization](../../organization/api-ref/Organization/index.md) или вызовом gRPC API [OrganizationService/UpdateAccessBindings](../../organization/api-ref/grpc/Organization/updateAccessBindings.md).

{% endlist %}

#### Получите IAM-токен {#get-iam}

Чтобы получить IAM-токен для созданного ранее сервисного аккаунта, воспользуйтесь инструкцией [Получение IAM-токена для сервисного аккаунта](../../iam/operations/iam-token/create-for-sa.md).

## Создайте канал {#create-channel}

Чтобы создать канал, выполните команду:

{% list tabs group=instructions %}

- REST API {#api}

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
  * `<IAM-токен>` — полученный перед началом работы IAM-токен.
  * `<идентификатор_организации>` — полученный перед началом работы идентификатор организации.
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
  * `<IAM-токен>` — полученный перед началом работы IAM-токен.
  * `<идентификатор_организации>` — полученный перед началом работы идентификатор организации.
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

Сохраните идентификатор (значение `channelId`) созданного канала — он понадобится позднее.

## Создайте видео {#create-video}

Чтобы создать видео в Cloud Video с помощью API, [зарегистрируйте](#register-video) видео на канале и затем [загрузите](#upload-video) в него видеофайл по протоколу [tus](https://tus.io/protocols/resumable-upload). В случае сбоя загрузки [дозагрузите](#continue-if-interrupted) файл, продолжив загрузку с той позиции в файле, на которой произошел сбой.

### Зарегистрируйте видео на канале {#register-video}

Чтобы зарегистрировать видео на канале:

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

1. Выполните команду:

    {% list tabs group=instructions %}

    - REST API {#api}

      ```bash
      curl \
        --request POST \
        --url 'https://video.api.cloud.yandex.net/video/v1/videos' \
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
      
      ```text
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
        video.api.cloud.yandex.net:443 yandex.cloud.video.v1.VideoService/Create
      ```

      Где:
      * `<IAM-токен>` — полученный перед началом работы IAM-токен.
      * `<идентификатор_канала>` — сохраненный на предыдущем шаге идентификатор созданного канала.
      * `<имя_видео>` — имя, которое будет присвоено видео при загрузке в канал.
      * `<размер_видеофайла>` — полученный ранее размер видеофайла в байтах.
      * `<имя_видеофайла>` — имя видеофайла, который вы будете загружать.

      Результат:
      
      ```text
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

### Загрузите видеофайл {#upload-video}

Загрузка видеофайлов производится по протоколу `tus`, который в случае сбоя соединения позволяет возобновить загрузку с момента, на котором она была прервана. Загрузку вы можете реализовать самостоятельно на любом языке программирования или воспользоваться для этого [готовыми библиотеками](https://tus.io/implementations).

Чтобы загрузить видеофайл с помощью утилиты `curl`, выполните команду:

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

### Убедитесь, что видеофайл загрузился {#verify-upload}

Убедитесь, что видеофайл был загружен полностью. Для этого выполните команду, указав сохраненный ранее идентификатор видео (`videoId`):

{% list tabs group=instructions %}

- REST API {#api}

  ```bash
  curl \
    --request GET \
    --url 'https://video.api.cloud.yandex.net/video/v1/videos/<идентификатор_видео>' \
    --header 'Authorization: Bearer <IAM-токен>'
  ```
  
  Результат:
  
  ```text
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
    video.api.cloud.yandex.net:443 yandex.cloud.video.v1.VideoService/Get
  ```
  
  Результат:
  
  ```text
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

Если поле `status` имеет значение `PROCESSING` или `READY`, значит видеофайл загрузился полностью. Переходите к [добавлению обложки видео](#add-thumbnail).

Если поле `status` имеет значение `WAIT_UPLOADING`, значит загрузка видеофайла была прервана. В этом случае видео необходимо дозагрузить.

### Продолжите прерванную загрузку {#continue-if-interrupted}

Чтобы дозагрузить видеофайл, необходимо знать позицию `offset`, на которой была прервана предыдущая попытка загрузки.

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

## Добавьте обложку к видео {#add-thumbnail}

Чтобы добавить обложку к видео в Cloud Video с помощью API, [зарегистрируйте](#register-thumbnail) обложку на канале, [получите ссылку](#get-thumbnail-upload-link) на загрузку в нее вашего изображения, [загрузите](#upload-thumbnail-image) по этой ссылке файл с изображением и [добавьте](#assign-thumbnail) созданную обложку к вашему видео.

### Зарегистрируйте обложку {#register-thumbnail}

Чтобы зарегистрировать обложку, выполните команду:

{% list tabs group=instructions %}

- REST API {#api}

  ```bash
  curl \
    --request POST \
    --url 'https://video.api.cloud.yandex.net/video/v1/thumbnails' \
    --header 'Authorization: Bearer <IAM-токен>' \
    --header 'Content-Type: application/json' \
    --data '{
      "videoId": "<идентификатор_видео>"
    }'
  ```
  
  Где:
  * `<IAM-токен>` — полученный перед началом работы IAM-токен.
  * `videoId` — идентификатор видео, для которого вы хотите добавить обложку.
  
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
    "videoId": "vplvh4wvqimx********",
    "createdAt": "2024-11-02T16:56:19.296797Z"
   },
   "id": "vplpgbyqopdr********",
   "description": "Thumbnail create",
   "createdAt": "2024-11-02T16:56:19.301776Z",
   "createdBy": "ajeol2afu1js********",
   "modifiedAt": "2024-11-02T16:56:19.301776Z"
  }
  ```

- gRPC API {#grpc-api}

  ```bash
  grpcurl \
    -rpc-header "Authorization: Bearer <IAM-токен>" \
    -rpc-header 'Content-Type: application/json' \
    -d '{
      "video_id": "<идентификатор_видео>"
    }' \
    video.api.cloud.yandex.net:443 yandex.cloud.video.v1.ThumbnailService/Create
  ```
  
  Где:
  * `<IAM-токен>` — полученный перед началом работы IAM-токен.
  * `video_id` — идентификатор видео, для которого вы хотите добавить обложку.
  
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
      "id": "vpltleyrfnjh********",
      "videoId": "vplvh4wvqimx********"
    }
  }
  ```

{% endlist %}

Сохраните значение идентификатора обложки (`thumbnailId`), оно понадобится позднее.

### Получите ссылку на загрузку изображения в обложку {#get-thumbnail-upload-link}

Чтобы получить ссылку на загрузку изображения обложки, выполните команду:

{% list tabs group=instructions %}

- REST API {#api}

  ```bash
  curl \
    --request POST \
    --url 'https://video.api.cloud.yandex.net/video/v1/thumbnails/<идентификатор_обложки>:generateUploadURL' \
    --header 'Authorization: Bearer <IAM-токен>'
  ```

- gRPC API {#grpc-api}

  ```bash
  grpcurl \
    -rpc-header "Authorization: Bearer <IAM-токен>" \
    -d '{
      "thumbnailId": "<идентификатор_обложки>"
    }' \
    video.api.cloud.yandex.net:443 yandex.cloud.video.v1.ThumbnailService/GenerateUploadURL | jq
  ```

{% endlist %}

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

### Загрузите в обложку файл с изображением {#upload-thumbnail-image}

Чтобы загрузить ваше изображение в обложку, выполните команду:

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

### Добавьте обложку к видео {#assign-thumbnail}

Чтобы добавить созданную обложку к вашему видео, выполните команду:

{% list tabs group=instructions %}

- REST API {#api}

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

## Получите ссылку на видеоплеер {#get-link}

Чтобы получить ссылку на видеоплеер, выполните команду:

{% list tabs group=instructions %}

- REST API {#api}

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
      "videoId": "<идентификатор_видео>"
    }' \
    video.api.cloud.yandex.net:443 yandex.cloud.video.v1.VideoService/GetPlayerURL
  ```

{% endlist %}

Где:
* `<IAM-токен>` — полученный перед началом работы IAM-токен.
* `<идентификатор_видео>` — сохраненный ранее идентификатор видео, загруженного в канал.

Результат:

```text
{
  "playerUrl": "https://runtime.video.cloud.yandex.net/player/video/vplva3626rvh********?autoplay=0\u0026mute=0",
  "html": "\u003ciframe width=\"560\" height=\"315\" src=\"https://runtime.video.cloud.yandex.net/player/video/vplva3626rvh********?autoplay=0\u0026mute=0\" allow=\"autoplay; fullscreen; accelerometer; gyroscope; picture-in-picture; encrypted-media\" frameborder=\"0\" scrolling=\"no\"\u003e\u003c/iframe\u003e"
}
```

Где:
* `playerUrl` — прямая ссылка на видео.
* `html` — HTML-код для вставки видео в формате Iframe.