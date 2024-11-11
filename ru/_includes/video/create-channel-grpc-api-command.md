```bash
grpcurl \
  -rpc-header "Authorization: Bearer <IAM-токен>" \
  -d '{
    "organization_id": "<идентификатор_организации>",
    "title": "<имя_канала>"
  }' \
  video.{{ api-host }}:443 yandex.cloud.video.v1.ChannelService/Create
```