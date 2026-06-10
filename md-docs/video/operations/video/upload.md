# Загрузить видео

Поддерживается загрузка видео в различных форматах, например: [MP4](https://ru.wikipedia.org/wiki/MPEG-4_Part_14), [AVI](https://ru.wikipedia.org/wiki/Audio_Video_Interleave), [MKV](https://ru.wikipedia.org/wiki/Matroska), [FLV](https://ru.wikipedia.org/wiki/Flash_Video), [MOV](https://en.wikipedia.org/wiki/QuickTime_File_Format), [WebM](https://ru.wikipedia.org/wiki/WebM) и других. Вы можете [загружать](upload.md) видео как по одному файлу, так и по несколько файлов сразу.

Вы можете загрузить видео с несколькими аудиодорожками или добавить их после загрузки с помощью [нейроперевода](../../concepts/videos.md#translation). Дорожки выбираются в меню [плеера](../../concepts/player.md), подробнее см. в разделе [Выбрать аудиодорожку](../player-control.md#audio).

В сервисе действуют [ограничения](../../concepts/limits.md) на разрешение публикуемых видео.

## Загрузить одно видео {#single}

{% list tabs group=instructions %}

- Интерфейс Cloud Video {#console}

  1. Откройте [главную страницу](https://video.yandex.cloud/) Cloud Video.
  1. Выберите канал.
  1. На вкладке ![image](../../../_assets/console-icons/circle-play.svg) **Видео** нажмите кнопку **Загрузить видео**.
  1. На странице загрузки нажмите кнопку **Выбрать файл** и выберите видео, которое вы хотите загрузить.

      Поддерживается загрузка видео в различных форматах, например: [MP4](https://ru.wikipedia.org/wiki/MPEG-4_Part_14), [AVI](https://ru.wikipedia.org/wiki/Audio_Video_Interleave), [MKV](https://ru.wikipedia.org/wiki/Matroska), [FLV](https://ru.wikipedia.org/wiki/Flash_Video), [MOV](https://en.wikipedia.org/wiki/QuickTime_File_Format), [WebM](https://ru.wikipedia.org/wiki/WebM) и других.
      
      В сервисе действуют [ограничения](../../concepts/limits.md) на разрешение публикуемых видео.

      Дождитесь окончания загрузки файла.

  1. Введите **Название** видео. Название будет отображаться на всех ресурсах, где будет размещено видео.
  1. (Опционально) В поле **Описание** укажите таймкоды к видео в формате:
   
     ```
     00:00:00 Название главы 1
     hh:mm:ss Название главы 2
      ...
     ```
     
     {% note info %}
     
     Таймкоды должны начинаться с `00:00` или `00:00:00`. Время от названия главы отделяется пробелом. Каждый таймкод начинается с новой строки.
     
     {% endnote %}

  1. В списке **Доступ** выберите тип доступа к видео:

      * **По временной ссылке** — видео будет доступно по специальной ссылке.

        Видео по временной ссылке доступно не более 12 часов.

      * **Для всех пользователей** — видео доступно неограниченное время и всем, у кого есть ссылка на видео.

  1. (Опционально) Чтобы добавить рекламу для видео, включите опцию **Включить рекламу**.
  1. (Опционально) Чтобы добавить обложку для видео, в поле **Обложка** нажмите кнопку ![image](../../../_assets/console-icons/cloud-arrow-up-in.svg) **Выберите файл** и выберите изображение для обложки.

      Поддерживаются обложки в следующих форматах: [JPG](https://ru.wikipedia.org/wiki/JPEG), [PNG](https://ru.wikipedia.org/wiki/PNG) и [GIF](https://ru.wikipedia.org/wiki/GIF).

  1. В списке **Шаблон плеера** выберите [шаблон](../../concepts/presets.md) оформления плеера из доступных в канале или создайте новый.

     Если шаблон не выбран, к видео будут применен [шаблон по умолчанию](../style-presets/set-default.md), назначенный на канал.

  1. (Опционально) Чтобы добавить [суммаризацию](../../concepts/videos.md#summarization), включите опцию **Суммаризация**.
  1. (Опционально) Включите опцию **Автоматически обрабатывать ошибки видеофайла**, если ваш файл поврежден или возникли [ошибки обработки](../../troubleshooting/index.md#processing-error).
  1. (Опционально) Чтобы добавить [субтитры](../../concepts/videos.md#subtitles) для видео, в поле **Субтитры** нажмите кнопку **Добавить**:
     
     1. В открывшемся окне выберите язык субтитров.
     1. Нажмите кнопку **Выбрать файл** и выберите файл субтитров.
     1. Нажмите кнопку **Создать**.
     
         Дождитесь загрузки файла.
  1. (Опционально) Чтобы добавить [нейроперевод](../../concepts/videos.md#translation) для видео, в блоке **Нейроперевод** нажмите кнопку **Добавить**:
     
     1. В открывшемся окне выберите язык видео.
     1. Выберите языки для перевода.
     1. Нажмите **Создать**.
  1. Нажмите кнопку **Сохранить**.

  Откроется страница управления созданным видео. После завершения обработки видео станет доступно для просмотра.

  Чтобы проверить доступность видео:

  1. В блоке **Код вставки** выберите вкладку `link`.
  1. Нажмите кнопку ![copy](../../../_assets/console-icons/copy.svg) **Скопировать**.
  1. Откройте новую страницу браузера и вставьте в адресной строке полученную ссылку.
  1. Нажмите кнопку воспроизведения.

- REST API {#api}

  Чтобы создать видео в Cloud Video с помощью API, зарегистрируйте видео на канале и затем загрузите в него видеофайл по протоколу [tus](https://tus.io/protocols/resumable-upload). В случае сбоя загрузки дозагрузите файл, продолжив загрузку с той позиции в файле, на которой произошел сбой.

  1. Зарегистрируйте видео на канале:

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
      * `<IAM-токен>` — [IAM-токен](../../../iam/concepts/authorization/iam-token.md), необходимый для [аутентификации](../../api-ref/authentication.md) в Cloud Video API.
      * `<идентификатор_канала>` — идентификатор канала, в котором вы хотите создать ваше видео.
      * `<имя_видео>` — имя, которое будет присвоено видео при загрузке в канал.
      * `<размер_видеофайла>` — полученный размер загружаемого видеофайла в байтах.
      * `<имя_видеофайла>` — имя видеофайла, который вы хотите загрузить.
      * Тип доступа к видео:
        * `public_access` — неограниченное время и всем, у кого есть ссылка на видео. 
        * `signUrlAccess` — по временной ссылке.
          
           Видео по временной ссылке доступно не более 12 часов.

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

      Сохраните ссылку на загрузку видео (значение поля `url`) и идентификатор видео (значение поля `videoId`) — они понадобятся позднее.

  1. Загрузите видеофайл:

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

  1. Убедитесь, что видеофайл загрузился полностью, указав сохраненный ранее идентификатор видео:

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

      Если поле `status` имеет значение `PROCESSING` или `READY`, значит видеофайл загрузился полностью.

  1. Если поле `status` имеет значение `WAIT_UPLOADING`, значит загрузка видеофайла была прервана. В этом случае видео требуется дозагрузить. Для этого необходимо знать позицию `offset`, на которой была прервана предыдущая попытка загрузки:

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

      Повторно убедитесь, что видеофайл загрузился полностью. Если загрузка вновь была прервана, повторите действия, описанные в текущем шаге.

- gRPC API {#grpc-api}

  Чтобы создать видео в Cloud Video с помощью API, зарегистрируйте видео на канале и затем загрузите в него видеофайл по протоколу [tus](https://tus.io/protocols/resumable-upload). В случае сбоя загрузки дозагрузите файл, продолжив загрузку с той позиции в файле, на которой произошел сбой.

  1. Зарегистрируйте видео на канале:

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
      * `<IAM-токен>` — [IAM-токен](../../../iam/concepts/authorization/iam-token.md), необходимый для [аутентификации](../../api-ref/authentication.md) в Cloud Video API.
      * `<идентификатор_канала>` — идентификатор канала, в котором вы хотите создать ваше видео.
      * `<имя_видео>` — имя, которое будет присвоено видео при загрузке в канал.
      * `<размер_видеофайла>` — полученный размер загружаемого видеофайла в байтах.
      * `<имя_видеофайла>` — имя видеофайла, который вы хотите загрузить.
      * Тип доступа к видео:
        * `public_access` — неограниченное время и всем, у кого есть ссылка на видео. 
        * `signUrlAccess` — по временной ссылке.
          
           Видео по временной ссылке доступно не более 12 часов.

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

      Сохраните ссылку на загрузку видео (значение поля `url`) и идентификатор видео (значение поля `videoId`) — они понадобятся позднее.

  1. Загрузите видеофайл:

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

  1. Убедитесь, что видеофайл загрузился полностью, указав сохраненный ранее идентификатор видео:

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

      Если поле `status` имеет значение `PROCESSING` или `READY`, значит видеофайл загрузился полностью.

  1. Если поле `status` имеет значение `WAIT_UPLOADING`, значит загрузка видеофайла была прервана. В этом случае видео требуется дозагрузить. Для этого необходимо знать позицию `offset`, на которой была прервана предыдущая попытка загрузки:

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

      Повторно убедитесь, что видеофайл загрузился полностью. Если загрузка вновь была прервана, повторите действия, описанные в текущем шаге.

{% endlist %}


## Загрузить несколько видео {#multiple}

{% list tabs group=instructions %}

- Интерфейс Cloud Video {#console}

  1. Откройте [главную страницу](https://video.yandex.cloud/) Cloud Video.
  1. Выберите канал.
  1. На вкладке ![image](../../../_assets/console-icons/circle-play.svg) **Видео** нажмите кнопку **Загрузить видео**.
  1. На странице загрузки нажмите кнопку **Выбрать файл** и выберите несколько видео, которые вы хотите загрузить.

      Поддерживается загрузка видео в различных форматах, например: [MP4](https://ru.wikipedia.org/wiki/MPEG-4_Part_14), [AVI](https://ru.wikipedia.org/wiki/Audio_Video_Interleave), [MKV](https://ru.wikipedia.org/wiki/Matroska), [FLV](https://ru.wikipedia.org/wiki/Flash_Video), [MOV](https://en.wikipedia.org/wiki/QuickTime_File_Format), [WebM](https://ru.wikipedia.org/wiki/WebM) и других.
      
      В сервисе действуют [ограничения](../../concepts/limits.md) на разрешение публикуемых видео.

      Дождитесь окончания загрузки всех файлов.

  После завершения обработки видео станут доступны для просмотра.

  При необходимости [добавьте](update.md) субтитры и [измените](update.md) название и обложку отдельно для каждого из загруженных видео.

{% endlist %}


#### См. также {#see-also}

[Изменить видео](update.md)