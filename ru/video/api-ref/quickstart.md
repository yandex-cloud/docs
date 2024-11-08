---
title: Начало работы с API {{ video-full-name }}
description: 'В данном разделе вы научитесь работать с API {{ video-name }}: создавать канал, загружать видео и получать ссылку на видеоплеер.'
---

# Как начать работать с API {{ video-full-name }}

В этом разделе вы научитесь создавать [каналы](../concepts/index.md#channels), загружать [видео](../concepts/videos.md) и получать для загруженных видео ссылки на [видеоплеер](../concepts/player.md) с помощью [REST API](../api-ref/) и [gPRC API](../api-ref/grpc/) {{ video-name }}.

## Перед началом работы {#before-begin}

Чтобы начать работать c API {{ video-name }}:

1. В [сервисе {{ billing-name }}]({{ link-console-billing }}) убедитесь, что у вас подключен [платежный аккаунт](../../billing/concepts/billing-account.md), и он находится в [статусе](../../billing/concepts/billing-account-statuses.md) `ACTIVE` или `TRIAL_ACTIVE`. Если платежного аккаунта нет, [создайте его](../../billing/quickstart/index.md#create_billing_account).
1. [Получите](../../organization/operations/organization-get-id.md) идентификатор организации, в которой вы будете создавать канал.
1. [Назначьте](../../organization/operations/add-role.md) пользователю или [сервисному аккаунту](../../iam/concepts/users/service-accounts.md), от имени которого вы будете аутентифицироваться в API {{ video-name }}, [роль](../../iam/concepts/access-control/roles.md) `video.admin` или `video.editor`. Подробнее см. в разделе [{#T}](../security/index.md).
1. [Получите](./authentication.md) IAM-токен для пользователя или сервисного аккаунта, от имени которого вы будете аутентифицироваться в API {{ video-name }}.

Чтобы воспользоваться примерами, установите утилиты [cURL](https://curl.haxx.se) и [gRPCurl](https://github.com/fullstorydev/grpcurl) (при использовании [gRPC API](../api-ref/grpc/)).

## Создайте канал {#create-channel}

Чтобы создать канал, выполните команду:

{% list tabs group=api_type %}

- REST API {#rest-api}

  {% include [create-channel-rest-api-command](../../_includes/video/create-channel-rest-api-command.md) %}

  Где:
  * `<IAM-токен>` — полученный перед началом работы IAM-токен.
  * `<идентификатор_организации>` — полученный перед началом работы идентификатор организации.
  * `<имя_канала>` — имя создаваемого канала в {{ video-name }}.

  {% include [create-channel-rest-api-output](../../_includes/video/create-channel-rest-api-output.md) %}

- gRPC API {#grpc-api}

  {% include [create-channel-grpc-api-command](../../_includes/video/create-channel-grpc-api-command.md) %}

  Где:
  * `<IAM-токен>` — полученный перед началом работы IAM-токен.
  * `<идентификатор_организации>` — полученный перед началом работы идентификатор организации.
  * `<имя_канала>` — имя создаваемого канала в {{ video-name }}.

  {% include [create-channel-grpc-api-output](../../_includes/video/create-channel-grpc-api-output.md) %}

{% endlist %}

Сохраните идентификатор (значение `channelId`) созданного канала — он понадобится позднее.

## Создайте видео {#create-video}

Чтобы создать видео в {{ video-name }} с помощью API, [зарегистрируйте](#register-video) видео на канале и затем [загрузите](#upload-video) в него видеофайл по протоколу [tus](https://tus.io/protocols/resumable-upload). В случае сбоя загрузки [дозагрузите](#continue-if-interrupted) файл, продолжив загрузку с той позиции в файле, на которой произошел сбой.

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

    {% list tabs group=api_type %}

    - REST API {#rest-api}

      {% include [register-video-rest-api-command](../../_includes/video/register-video-rest-api-command.md) %}

      Где:
      * `<IAM-токен>` — полученный перед началом работы IAM-токен.
      * `<идентификатор_канала>` — сохраненный на предыдущем шаге идентификатор созданного канала.
      * `<имя_видео>` — имя, которое будет присвоено видео при загрузке в канал.
      * `<размер_видеофайла>` — полученный ранее размер видеофайла в байтах.
      * `<имя_видеофайла>` — имя видеофайла, который вы будете загружать.

      {% include [register-video-rest-api-output](../../_includes/video/register-video-rest-api-output.md) %}

    - gRPC API {#grpc-api}

      {% include [register-video-grpc-api-command](../../_includes/video/register-video-grpc-api-command.md) %}

      Где:
      * `<IAM-токен>` — полученный перед началом работы IAM-токен.
      * `<идентификатор_канала>` — сохраненный на предыдущем шаге идентификатор созданного канала.
      * `<имя_видео>` — имя, которое будет присвоено видео при загрузке в канал.
      * `<размер_видеофайла>` — полученный ранее размер видеофайла в байтах.
      * `<имя_видеофайла>` — имя видеофайла, который вы будете загружать.

      {% include [register-video-grpc-api-output](../../_includes/video/register-video-grpc-api-output.md) %}

    {% endlist %}

    Сохраните ссылку на загрузку видео (значение поля `url`) и идентификатор видео (значение поля `videoId`) — они понадобятся позднее.

### Загрузите видеофайл {#upload-video}

Загрузка видеофайлов производится по протоколу `tus`, который в случае сбоя соединения позволяет возобновить загрузку с момента, на котором она была прервана. Загрузку вы можете реализовать самостоятельно на любом языке программирования или воспользоваться для этого [готовыми библиотеками](https://tus.io/implementations).

Чтобы загрузить видеофайл с помощью утилиты `curl`, выполните команду:

{% include [create-video-upload-file-curl](../../_includes/video/create-video-upload-file-curl.md) %}

### Убедитесь, что видеофайл загрузился {#verify-upload}

Убедитесь, что видеофайл был загружен полностью. Для этого выполните команду, указав сохраненный ранее идентификатор видео (`videoId`):

{% list tabs group=api_type %}

- REST API {#rest-api}

  {% include [verify-video-upload-rest](../../_includes/video/verify-video-upload-rest.md) %}

- gRPC API {#grpc-api}

  {% include [verify-video-upload-grpc](../../_includes/video/verify-video-upload-grpc.md) %}

{% endlist %}

Если поле `status` имеет значение `PROCESSING` или `READY`, значит видеофайл загрузился полностью. Переходите к [добавлению обложки видео](#add-thumbnail).

Если поле `status` имеет значение `WAIT_UPLOADING`, значит загрузка видеофайла была прервана. В этом случае видео необходимо дозагрузить.

### Продолжите прерванную загрузку {#continue-if-interrupted}

Чтобы дозагрузить видеофайл, необходимо знать позицию `offset`, на которой была прервана предыдущая попытка загрузки.

{% include [resume-video-upload-curl](../../_includes/video/resume-video-upload-curl.md) %}

Повторно [убедитесь](#verify-upload), что видеофайл загрузился полностью. Если загрузка вновь была прервана, повторите действия, описанные в текущем подразделе.

## Добавьте обложку к видео {#add-thumbnail}

Чтобы добавить обложку к видео в {{ video-name }} с помощью API, [зарегистрируйте](#register-thumbnail) обложку на канале, [получите ссылку](#get-thumbnail-upload-link) на загрузку в нее вашего изображения, [загрузите](#upload-thumbnail-image) по этой ссылке файл с изображением и [добавьте](#assign-thumbnail) созданную обложку к вашему видео.

### Зарегистрируйте обложку {#register-thumbnail}

Чтобы зарегистрировать обложку, выполните команду:

{% list tabs group=api_type %}

- REST API {#rest-api}

  {% include [register-thumbnail-rest-api](../../_includes/video/register-thumbnail-rest-api.md) %}

- gRPC API {#grpc-api}

  {% include [register-thumbnail-grpc-api](../../_includes/video/register-thumbnail-grpc-api.md) %}

{% endlist %}

Сохраните значение идентификатора обложки (`thumbnailId`), оно понадобится позднее.

### Получите ссылку на загрузку изображения в обложку {#get-thumbnail-upload-link}

Чтобы получить ссылку на загрузку изображения обложки, выполните команду:

{% list tabs group=api_type %}

- REST API {#rest-api}

  {% include [get-thumbnail-uplink-rest-command](../../_includes/video/get-thumbnail-uplink-rest-command.md) %}

- gRPC API {#grpc-api}

  {% include [get-thumbnail-uplink-grpc-command](../../_includes/video/get-thumbnail-uplink-grpc-command.md) %}

{% endlist %}

{% include [get-thumbnail-uplink-api-output](../../_includes/video/get-thumbnail-uplink-api-output.md) %}

### Загрузите в обложку файл с изображением {#upload-thumbnail-image}

Чтобы загрузить ваше изображение в обложку, выполните команду:

{% include [upload-thumbnail-curl](../../_includes/video/upload-thumbnail-curl.md) %}

### Добавьте обложку к видео {#assign-thumbnail}

Чтобы добавить созданную обложку к вашему видео, выполните команду:

{% list tabs group=api_type %}

- REST API {#rest-api}

  {% include [assign-thumbnail-to-video-rest](../../_includes/video/assign-thumbnail-to-video-rest.md) %}

- gRPC API {#grpc-api}

  {% include [assign-thumbnail-to-video-grpc](../../_includes/video/assign-thumbnail-to-video-grpc.md) %}

{% endlist %}

## Получите ссылку на видеоплеер {#get-link}

Чтобы получить ссылку на видеоплеер, выполните команду:

{% list tabs group=api_type %}

- REST API {#rest-api}

  {% include [get-video-link-rest](../../_includes/video/get-video-link-rest.md) %}

- gRPC API {#grpc-api}

  {% include [get-video-link-grpc](../../_includes/video/get-video-link-grpc.md) %}

{% endlist %}

Где:
* `<IAM-токен>` — полученный перед началом работы IAM-токен.
* `<идентификатор_видео>` — сохраненный ранее идентификатор видео, загруженного в канал.

{% include [get-video-link-output](../../_includes/video/get-video-link-output.md) %}