```bash
curl \
  --request PATCH \
  --url 'https://video.{{ api-host }}/video/v1/videos/<video_ID>' \
  --header 'Authorization: Bearer <IAM_token>' \
  --header 'Content-Type: application/json' \
  --data '{
    "fieldMask": "thumbnailId",
    "thumbnailId": "<thumbnail_ID>"
  }'
```

Where:
* `<video_ID>`: Previously saved ID of the video you want to add a thumbnail for.
* `<IAM_token>`: IAM token you got before you started.
* `<thumbnail_ID>`: Previously saved thumbnail ID.

Result:

```text
{
 "done": true,
 "metadata": {
  "@type": "type.googleapis.com/yandex.cloud.video.v1.UpdateVideoMetadata",
  "videoId": "vplvh4wvqimx********"
 },
 "response": {
  "@type": "type.googleapis.com/yandex.cloud.video.v1.Video",
  "tusd": {
   "url": "https://tusd.video.cloud.yandex.net/files/75925d89ddc05c0d5ca3282781f13c6f+00062241********"
  },
  "publicAccess": {},
  "id": "vplvh4wvqimx********",
  "channelId": "vplcdyphvqik********",
  "title": "my-very-first-video",
  "thumbnailId": "vpltqm4nubzl********",
  "status": "READY",
  "duration": "39.981s",
  "visibilityStatus": "PUBLISHED",
  "createdAt": "2024-09-16T19:18:08.384540Z",
  "updatedAt": "2024-11-02T21:08:33.443368Z"
 },
 "id": "vplpriyo7eom********",
 "description": "Video update",
 "createdAt": "2024-11-02T21:08:33.461610Z",
 "createdBy": "ajeol2afu1js********",
 "modifiedAt": "2024-11-02T21:08:33.461610Z"
}
```