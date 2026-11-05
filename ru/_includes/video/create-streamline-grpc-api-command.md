```bash
grpcurl \
  -rpc-header "Authorization: Bearer <IAM-токен>" \
  -d '{
    "channel_id": "<идентификатор_канала>",
    "title": "<имя_трансляции>",
    "rtmp_push": {},
    "auto_line": {}
  }' \
  video.{{ api-host }}:443 yandex.cloud.video.v1.StreamLineService/Create
```
