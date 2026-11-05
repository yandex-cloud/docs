```bash
grpcurl \
  -rpc-header "Authorization: Bearer <IAM-токен>" \
  -d '{
    "stream_line_id": "<идентификатор_трансляции>"
  }' \
  video.{{ api-host }}:443 yandex.cloud.video.v1.StreamLineService/GetStreamKey
```
