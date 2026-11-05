```bash
grpcurl \
  -rpc-header "Authorization: Bearer <IAM-токен>" \
  -d '{
    "line_id": "<идентификатор_трансляции>",
    "title": "<имя_эпизода>",
    "public_access": {},
    "start_time": "<время_начала_эпизода>",
    "finish_time": "<время_окончания_эпизода>"
  }' \
  video.{{ api-host }}:443 yandex.cloud.video.v1.EpisodeService/Create
```
