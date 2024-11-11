---
title: Как загрузить видео в {{ video-full-name }}
description: Следуя данной инструкции, вы сможете загрузить видео в сервис {{ video-full-name }}.
---

# Загрузить видео

## Загрузить одно видео {#single}

{% list tabs group=instructions %}

- Интерфейс {{ video-name }} {#console}

  1. Откройте [главную страницу]({{ link-video-main }}) {{ video-name }}.
  1. Выберите канал.
  1. На вкладке ![image](../../../_assets/console-icons/circle-play.svg) **{{ ui-key.yacloud_video.videos.title_videos }}** нажмите кнопку **{{ ui-key.yacloud_video.videos.action_create-video }}**.
  1. На странице загрузки нажмите кнопку **Выбрать файл** и выберите видео, которое вы хотите загрузить.

      {% include [video-characteristic](../../../_includes/video/video-characteristic.md) %}

      Дождитесь окончания загрузки файла.

  1. Введите **{{ ui-key.yacloud_video.videos.label_title }}** видео. Название будет отображаться на всех ресурсах, где будет размещено видео.
  1. В поле **{{ ui-key.yacloud_video.videos.label_accessRights }}** укажите, для кого должно быть доступно видео:

      * `{{ ui-key.yacloud_video.videos.label_access_rights-auth-system-access }}` — видео будет доступно пользователям, авторизованным в вашей [организации](../../../organization/quickstart.md).
      * `{{ ui-key.yacloud_video.videos.label_access_rights-public }}` — видео будет общедоступным.

  1. (Опционально) Чтобы добавить обложку для видео, в поле **{{ ui-key.yacloud_video.thumbnails.label_thumbnail }}** нажмите кнопку ![image](../../../_assets/console-icons/cloud-arrow-up-in.svg) **Выберите файл** и выберите изображение для обложки.

      {% include [image-characteristic](../../../_includes/video/image-characteristic.md) %}

  1. {% include [add-subtitles-optional](../../../_includes/video/add-subtitles-optional.md) %}
  1. Нажмите кнопку **{{ ui-key.yacloud_video.common.action_accept }}**.

  Откроется страница управления созданным видео. После завершения обработки видео станет доступно для просмотра.

  Чтобы проверить доступность видео:

  1. В блоке **{{ ui-key.yacloud_video.videos.title_past-code }}** выберите вкладку `link`.
  1. Нажмите кнопку ![copy](../../../_assets/console-icons/copy.svg) **{{ ui-key.yacloud_video.streams.action_copy-code }}**.
  1. Откройте новую страницу браузера и вставьте в адресной строке полученную ссылку.
  1. Нажмите кнопку воспроизведения.

- REST API {#api}

  Чтобы создать видео в {{ video-name }} с помощью API, зарегистрируйте видео на канале и затем загрузите в него видеофайл по протоколу [tus](https://tus.io/protocols/resumable-upload). В случае сбоя загрузки дозагрузите файл, продолжив загрузку с той позиции в файле, на которой произошел сбой.

  1. Зарегистрируйте видео на канале:

      {% include [register-video-rest-api-command](../../../_includes/video/register-video-rest-api-command.md) %}

      Где:
      * `<IAM-токен>` — [IAM-токен](../../../iam/concepts/authorization/iam-token.md), необходимый для [аутентификации](../../api-ref/authentication.md) в {{ video-name }} API.
      * `<идентификатор_канала>` — идентификатор канала, в котором вы хотите создать ваше видео.
      * `<имя_видео>` — имя, которое будет присвоено видео при загрузке в канал.
      * `<размер_видеофайла>` — полученный размер загружаемого видеофайла в байтах.
      * `<имя_видеофайла>` — имя видеофайла, который вы хотите загрузить.

      {% include [register-video-rest-api-output](../../../_includes/video/register-video-rest-api-output.md) %}

      Сохраните ссылку на загрузку видео (значение поля `url`) и идентификатор видео (значение поля `videoId`) — они понадобятся позднее.

  1. Загрузите видеофайл:

      {% include [create-video-upload-file-curl](../../../_includes/video/create-video-upload-file-curl.md) %}

  1. Убедитесь, что видеофайл загрузился полностью, указав сохраненный ранее идентификатор видео:

      {% include [verify-video-upload-rest](../../../_includes/video/verify-video-upload-rest.md) %}

      Если поле `status` имеет значение `PROCESSING` или `READY`, значит видеофайл загрузился полностью.

  1. Если поле `status` имеет значение `WAIT_UPLOADING`, значит загрузка видеофайла была прервана. В этом случае видео требуется дозагрузить. Для этого необходимо знать позицию `offset`, на которой была прервана предыдущая попытка загрузки:

      {% include [resume-video-upload-curl](../../../_includes/video/resume-video-upload-curl.md) %}

      Повторно убедитесь, что видеофайл загрузился полностью. Если загрузка вновь была прервана, повторите действия, описанные в текущем шаге.

- gRPC API {#grpc-api}

  Чтобы создать видео в {{ video-name }} с помощью API, зарегистрируйте видео на канале и затем загрузите в него видеофайл по протоколу [tus](https://tus.io/protocols/resumable-upload). В случае сбоя загрузки дозагрузите файл, продолжив загрузку с той позиции в файле, на которой произошел сбой.

  1. Зарегистрируйте видео на канале:

      {% include [register-video-grpc-api-command](../../../_includes/video/register-video-grpc-api-command.md) %}

      Где:
      * `<IAM-токен>` — [IAM-токен](../../../iam/concepts/authorization/iam-token.md), необходимый для [аутентификации](../../api-ref/authentication.md) в {{ video-name }} API.
      * `<идентификатор_канала>` — идентификатор канала, в котором вы хотите создать ваше видео.
      * `<имя_видео>` — имя, которое будет присвоено видео при загрузке в канал.
      * `<размер_видеофайла>` — полученный размер загружаемого видеофайла в байтах.
      * `<имя_видеофайла>` — имя видеофайла, который вы хотите загрузить.

      {% include [register-video-grpc-api-output](../../../_includes/video/register-video-grpc-api-output.md) %}

      Сохраните ссылку на загрузку видео (значение поля `url`) и идентификатор видео (значение поля `videoId`) — они понадобятся позднее.

  1. Загрузите видеофайл:

      {% include [create-video-upload-file-curl](../../../_includes/video/create-video-upload-file-curl.md) %}

  1. Убедитесь, что видеофайл загрузился полностью, указав сохраненный ранее идентификатор видео:

      {% include [verify-video-upload-grpc](../../../_includes/video/verify-video-upload-grpc.md) %}

      Если поле `status` имеет значение `PROCESSING` или `READY`, значит видеофайл загрузился полностью.

  1. Если поле `status` имеет значение `WAIT_UPLOADING`, значит загрузка видеофайла была прервана. В этом случае видео требуется дозагрузить. Для этого необходимо знать позицию `offset`, на которой была прервана предыдущая попытка загрузки:

      {% include [resume-video-upload-curl](../../../_includes/video/resume-video-upload-curl.md) %}

      Повторно убедитесь, что видеофайл загрузился полностью. Если загрузка вновь была прервана, повторите действия, описанные в текущем шаге.

{% endlist %}


## Загрузить несколько видео {#multiple}

{% list tabs group=instructions %}

- Интерфейс {{ video-name }} {#console}

  1. Откройте [главную страницу]({{ link-video-main }}) {{ video-name }}.
  1. Выберите канал.
  1. На вкладке ![image](../../../_assets/console-icons/circle-play.svg) **{{ ui-key.yacloud_video.videos.title_videos }}** нажмите кнопку **{{ ui-key.yacloud_video.videos.action_create-video }}**.
  1. На странице загрузки нажмите кнопку **Выбрать файл** и выберите несколько видео, которые вы хотите загрузить.

      {% include [video-characteristic](../../../_includes/video/video-characteristic.md) %}

      Дождитесь окончания загрузки всех файлов.

  После завершения обработки видео станут доступны для просмотра.

  При необходимости [добавьте](./update.md) субтитры и [измените](./update.md) название и обложку отдельно для каждого из загруженных видео.

{% endlist %}


#### См. также {#see-also}

[{#T}](./update.md)