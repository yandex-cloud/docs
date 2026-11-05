```bash
curl \
  --request POST \
  --url 'https://video.{{ api-host }}/video/v1/episodes' \
  --header 'Authorization: Bearer <IAM-токен>' \
  --header 'Content-Type: application/json' \
  --data '{
    "line_id": "<идентификатор_трансляции>",
    "title": "<имя_эпизода>",
    "public_access": {},
    "start_time": "<время_начала_эпизода>",
    "finish_time": "<время_окончания_эпизода>"
  }'
```
