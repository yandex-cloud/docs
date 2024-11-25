```bash
grpcurl \
  -rpc-header "Authorization: Bearer <IAM_token>" \
  -rpc-header "Content-Type: application/json" \
  -d '{
    "videoId": "<video_ID>",
    "fieldMask": {"paths": ["thumbnail_id"]},
    "thumbnailId": "<thumbnail_ID>"
  }' \
  video.{{ api-host }}:443 yandex.cloud.video.v1.VideoService/Update
```

Where:
* `<IAM_token>`: IAM token you got before you started.
* `<video_ID>`: Previously saved ID of the video you want to add a thumbnail for.
* `<thumbnail_ID>`: Previously saved thumbnail ID.

Result:

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