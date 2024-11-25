```bash
grpcurl \
  -rpc-header "Authorization: Bearer <IAM_token>" \
  -d '{
    "organization_id": "<organization_ID>",
    "title": "<channel_name>"
  }' \
  video.{{ api-host }}:443 yandex.cloud.video.v1.ChannelService/Create
```