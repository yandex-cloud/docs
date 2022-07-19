Create a federation using the [create](../../organization/api-ref/Federation/create.md) method:

```bash
curl -X POST \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer <IAM token>" \
  -d '@body.json' \
  https://organization-manager.{{ api-host }}/organization-manager/v1/saml/federations
{
 "done": true,
 "metadata": {
  "@type": "type.googleapis.com/yandex.cloud.organization-manager.v1.saml.CreateFederationMetadata",
  "federationId": "ajeobmje4dgj0belagb9"
 },
 ...
```

The `federationId` property of the response contains the federation ID to save. You'll need this ID in the next steps.

