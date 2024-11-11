To create a federation, use the [create](../../organization/saml/api-ref/Federation/create.md) REST API method for the [Federation](../../organization/saml/api-ref/Federation/index.md) resource or the [FederationService/Create](../../organization/saml/api-ref/grpc/Federation/create.md) gRPC API call and provide a file with the request parameters in your request.

Request example:

```bash
curl \
  --request POST \
  --header "Content-Type: application/json" \
  --header "Authorization: Bearer <IAM_token>" \
  --data '@body.json' \
  https://organization-manager.{{ api-host }}/organization-manager/v1/saml/federations
```

Response example:

```bash
{
 "done": true,
 "metadata": {
  "@type": "type.googleapis.com/yandex.cloud.organization-manager.v1.saml.CreateFederationMetadata",
  "federationId": "ajeobmje4dgj********"
 }
```

The `federationId` property contains the ID of the federation you created; make sure to save it, you will need it later.
