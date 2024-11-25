```bash
curl \
  --request GET \
  --url 'https://video.{{ api-host }}/video/v1/channels?organizationId=<organization_ID>' \
  --header 'Authorization: Bearer <IAM_token>'
```

Where:
* `<organization_ID>`: Organization ID you got before you started.
* `<IAM_token>`: IAM token you got before you started.

Result:

```text
{
 "channels": [
  {
   "id": "vplc3neipzso********",
   "organizationId": "bpfaidqca8vd********",
   "title": "my-first-channel",
   "description": "My very first {{ video-name }} channel",
   "createdAt": "2023-07-07T10:51:48.658737Z",
   "updatedAt": "2023-07-07T10:51:48.658737Z"
  },
  {
   "id": "vplc3vssjcxh********",
   "organizationId": "bpfaidqca8vd********",
   "title": "my-work-channel",
   "createdAt": "2023-08-09T23:32:55.372456Z",
   "updatedAt": "2023-08-09T23:32:55.372456Z"
  },
  {
   "id": "vplc4cfwamlx********",
   "organizationId": "bpfaidqca8vd********",
   "title": "my-personal-channel",
   "createdAt": "2024-03-14T13:48:34.535821Z",
   "updatedAt": "2024-03-14T13:48:34.535821Z"
  },
 ]
}
```

Save the `id` of the channel to whose storage you want to upload the thumbnail.