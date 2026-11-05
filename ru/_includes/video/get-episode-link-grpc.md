```bash
grpcurl \
  -rpc-header "Authorization: Bearer <IAM-токен>" \
  -d '{
    "episode_id": "<идентификатор_эпизода>"
  }' \
  video.{{ api-host }}:443 yandex.cloud.video.v1.EpisodeService/GetPlayerURL
```
