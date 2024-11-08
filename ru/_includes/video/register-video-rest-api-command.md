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