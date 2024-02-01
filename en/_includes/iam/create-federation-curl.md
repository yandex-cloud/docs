To create a federation, use the [create](../../organization/api-ref/Federation/create.md) REST API method for the [Federation](../../organization/api-ref/Federation/index.md) resource or the [FederationService/Create](../../organization/api-ref/grpc/federation_service#Create) gRPC API call and provide a file with the request parameters in your request.

Sample request:

```bash
curl -X POST \
  -H "Content-Type: application/json" \
  -H "Authorization: Bearer <IAM_token>" \
  -d '@body.json' \
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
