```bash
grpcurl \
  -rpc-header "Authorization: Bearer <IAM_token>" \
  -d '{
    "thumbnailId": "<thumbnail_ID>"
  }' \
  video.{{ api-host }}:443 yandex.cloud.video.v1.ThumbnailService/GenerateUploadURL
```