```bash
grpcurl \
  -rpc-header "Authorization: Bearer <IAM_token>" \
  -d '{
    "channel_id": "<channel_ID>",
    "title": "<video_name>",
    "tusd": {
      "file_size": <video_file_size>,
      "file_name": "<video_file_name>"
    },
    "public_access": {}
  }' \
  video.{{ api-host }}:443 yandex.cloud.video.v1.VideoService/Create
```