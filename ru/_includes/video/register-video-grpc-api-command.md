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