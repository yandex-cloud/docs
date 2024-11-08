```bash
grpcurl \
  -rpc-header "Authorization: Bearer <IAM-токен>" \
  -rpc-header "Content-Type: application/json" \
  -d '{
    "videoId": "<идентификатор_видео>",
    "fieldMask": {"paths": ["thumbnail_id"]},
    "thumbnailId": "<идентификатор_обложки>"
  }' \
  video.{{ api-host }}:443 yandex.cloud.video.v1.VideoService/Update
```

Где:
* `<IAM-токен>` — полученный перед началом работы IAM-токен.
* `<идентификатор_видео>` — сохраненный ранее идентификатор видео, для которого вы хотите добавить обложку.
* `<идентификатор_обложки>` — сохраненный ранее идентификатор обложки.

Результат:

```text
{
  "id": "vplp77twonao********",
  "description": "Video update",
  "createdAt": "2024-11-03T09:38:13.363079Z",
  "createdBy": "ajeol2afu1js********",
  "modifiedAt": "2024-11-03T09:38:13.363079Z",
  "done": true,
  "metadata": {
    "@type": "type.googleapis.com/yandex.cloud.video.v1.UpdateVideoMetadata",
    "videoId": "vplvh4wvqimx********"
  },
  "response": {
    "@type": "type.googleapis.com/yandex.cloud.video.v1.Video",
    "channelId": "vplcdyphvqik********",
    "createdAt": "2024-09-16T19:18:08.384540Z",
    "duration": "39.981s",
    "id": "vplvh4wvqimx********",
    "publicAccess": {},
    "status": "READY",
    "thumbnailId": "vpltqlukqfoc********",
    "title": "my-very-first-video",
    "tusd": {
      "url": "https://tusd.video.cloud.yandex.net/files/75925d89ddc05c0d5ca3282781f13c6f+00062241********"
    },
    "updatedAt": "2024-11-03T09:38:13.354454Z",
    "visibilityStatus": "PUBLISHED"
  }
}
```