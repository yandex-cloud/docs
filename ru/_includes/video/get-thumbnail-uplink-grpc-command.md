```bash
grpcurl \
  -rpc-header "Authorization: Bearer <IAM-токен>" \
  -d '{
    "thumbnail_id": "<идентификатор_обложки>"
  }' \
  video.{{ api-host }}:443 yandex.cloud.video.v1.ThumbnailService/GenerateUploadURL | jq
```