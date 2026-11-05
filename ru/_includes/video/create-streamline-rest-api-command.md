```bash
curl \
  --request POST \
  --url 'https://video.{{ api-host }}/video/v1/streamLines' \
  --header 'Authorization: Bearer <IAM-токен>' \
  --header 'Content-Type: application/json' \
  --data '{
    "channel_id": "<идентификатор_канала>",
    "title": "<имя_трансляции>",
    "rtmp_push": {},
    "auto_line": {}
  }'
```
