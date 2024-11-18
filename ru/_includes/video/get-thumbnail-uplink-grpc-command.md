```bash
grpcurl \
  -rpc-header "Authorization: Bearer <IAM-токен>" \
  -d '{
    "thumbnailId": "<идентификатор_обложки>"
  }' \
  video.{{ api-host }}:443 yandex.cloud.video.v1.ThumbnailService/GenerateUploadURL | jq
```