```bash
grpcurl \
  -rpc-header "Authorization: Bearer <IAM-токен>" \
  -d '{
    "videoId": "<идентификатор_видео>"
  }' \
  video.{{ api-host }}:443 yandex.cloud.video.v1.VideoService/GetPlayerURL
```