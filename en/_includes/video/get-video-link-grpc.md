```bash
grpcurl \
  -rpc-header "Authorization: Bearer <IAM_token>" \
  -d '{
    "videoId": "<video_ID>"
  }' \
  video.{{ api-host }}:443 yandex.cloud.video.v1.VideoService/GetPlayerURL
```