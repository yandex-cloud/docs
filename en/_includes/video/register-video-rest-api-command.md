```bash
curl \
  --request POST \
  --url 'https://video.{{ api-host }}/video/v1/videos' \
  --header 'Authorization: Bearer <IAM_token>' \
  --header 'Content-Type: application/json' \
  --data '{
    "channel_id": "<channel_ID>",
    "title": "<video_name>",
    "tusd": {
      "file_size": <video_file_size>,
      "file_name": "<video_file_name>"
    },
    "public_access": {}
  }'
```