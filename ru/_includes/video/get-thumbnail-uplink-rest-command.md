```bash
curl \
  --request POST \
  --url 'https://video.{{ api-host }}/video/v1/thumbnails/<идентификатор_обложки>:generateUploadURL' \
  --header 'Authorization: Bearer <IAM-токен>'
```