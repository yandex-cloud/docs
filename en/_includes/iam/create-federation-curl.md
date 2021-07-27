Create a federation using the [create](../../iam/api-ref/Federation/create) method:

```
$ curl -X POST \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer <IAM token>" \
  -d '@body.json' \
  https://iam.api.cloud.yandex.net/iam/v1/saml/federations
{
 "done": true,
 "metadata": {
  "@type": "type.googleapis.com/yandex.cloud.iam.v1.saml.CreateFederationMetadata",
  "federationId": "ajeobmje4dgj0belagb9"
 },
 ...
```

The `federationId` property of the response contains the federation ID to save. You'll need this ID in the next steps.

