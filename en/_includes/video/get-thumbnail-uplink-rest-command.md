```bash
curl \
  --request POST \
  --url 'https://video.{{ api-host }}/video/v1/thumbnails/<thumbnail_ID>:generateUploadURL' \
  --header 'Authorization: Bearer <IAM_token>'
```