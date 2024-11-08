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