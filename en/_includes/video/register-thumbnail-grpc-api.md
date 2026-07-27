```bash
grpcurl \
  -rpc-header "Authorization: Bearer <IAM_token>" \
  -rpc-header 'Content-Type: application/json' \
  -d '{
    "video_id": "<video_ID>"
  }' \
  video.{{ api-host }}:443 yandex.cloud.video.v1.ThumbnailService/Create
```

Where:
* `<IAM_token>`: IAM token you got before you started.
* `video_id`: ID of the video you want to add a thumbnail for.

Result:

```text
{
  "id": "vplpoqhxep6q********",
  "description": "Thumbnail create",
  "createdAt": "2024-11-02T19:04:28.412672Z",
  "createdBy": "ajeol2afu1js********",
  "modifiedAt": "2024-11-02T19:04:28.412672Z",
  "done": true,
  "metadata": {
    "@type": "type.googleapis.com/yandex.cloud.video.v1.CreateThumbnailMetadata",
    "thumbnailId": "vpltleyrfnjh********"
  },
  "response": {
    "@type": "type.googleapis.com/yandex.cloud.video.v1.Thumbnail",
    "channelId": "vplcdyphvqik********",
    "createdAt": "2024-11-02T19:04:28.402787Z",
    "id": "vpltleyrfnjh********",
    "videoId": "vplvh4wvqimx********"
  }
}
```