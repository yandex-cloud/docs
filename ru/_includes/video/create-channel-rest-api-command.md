```bash
curl \
  --request POST \
  --url 'https://video.{{ api-host }}/video/v1/channels' \
  --header 'Authorization: Bearer <IAM-токен>' \
  --header 'Content-Type: application/json' \
  --data '{
    "organization_id": "<идентификатор_организации>",
    "title": "<имя_канала>"
  }'
```