```bash
curl \
  --request GET \
  --header 'Authorization: Bearer <IAM_token>' \
  --url 'https://video.{{ api-host }}/video/v1/videos/<video_ID>:getPlayerURL'
```