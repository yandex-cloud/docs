```bash
curl \
  --request GET \
  --header 'Authorization: Bearer <IAM-токен>' \
  --url 'https://video.{{ api-host }}/video/v1/videos/<идентификатор_видео>:getPlayerURL'
```