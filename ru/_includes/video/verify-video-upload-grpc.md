```bash
grpcurl \
  -rpc-header "Authorization: Bearer <IAM-токен>" \
  -d '{"video_id": "<идентификатор_видео>"}' \
  video.{{ api-host }}:443 yandex.cloud.video.v1.VideoService/Get
```

Результат:

```text
{
  "id": "vplva3626rvh********",
  "channelId": "vplcqy2qxkjy********",
  "title": "my-very-first-video",
  "status": "READY",
  "duration": "39.981s",
  "visibilityStatus": "PUBLISHED",
  "createdAt": "2024-09-16T14:11:04.803285Z",
  "updatedAt": "2024-09-16T14:14:36.467614Z",
  "tusd": {
    "url": "https://tusd.video.cloud.yandex.net/files/55994a57bd30b2161399ccab7eb5f2de+0006223D********"
  },
  "publicAccess": {}
}
```