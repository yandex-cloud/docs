```bash
curl \
  --request POST \
  --url 'https://video.{{ api-host }}/video/v1/channels' \
  --header 'Authorization: Bearer <IAM_token>' \
  --header 'Content-Type: application/json' \
  --data '{
    "organization_id": "<organization_ID>",
    "title": "<channel_name>"
  }'
```