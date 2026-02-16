```bash
curl \
  --request GET \
  --url 'https://video.{{ api-host }}/video/v1/videos/<идентификатор_видео>' \
  --header 'Authorization: Bearer <IAM-токен>'
```

Результат:

```text
{
 "tusd": {
  "url": "https://tusd.video.cloud.yandex.net/files/75925d89ddc05c0d5ca3282781f13c6f+00062241********"
 },
 "publicAccess": {},
 "id": "vplvh4wvqimx********",
 "channelId": "vplcdyphvqik********",
 "title": "my-very-first-video",
 "status": "READY",
 "duration": "39.981s",
 "visibilityStatus": "PUBLISHED",
 "createdAt": "2024-09-16T19:18:08.384540Z",
 "updatedAt": "2024-09-16T19:31:31.471857Z"
}
```