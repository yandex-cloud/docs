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