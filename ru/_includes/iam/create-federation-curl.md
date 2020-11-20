Создайте федерацию с помощью метода [create](../../iam/api-ref/Federation/create.md):

```
$ curl -X POST \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer <IAM-токен>" \
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

В ответе, в свойстве `federationId`, будет указан идентификатор созданной федерации, сохраните его. Этот идентификатор понадобится на следующих шагах.