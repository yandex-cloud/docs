# Working with the Public API


{{ datalens-name }} provides a public API ([https://api.datalens.tech](https://api.datalens.tech)) to automate operations with dashboards, charts, datasets, and connections.

{{ datalens-name }} Public API is a collection of methods similar to that used in the {{ datalens-name }} web interface. This API is described by the OpenAPI specification and authenticated via the Yandex Cloud IAM tokens.

To use the API, you need an [IAM token](../../iam/operations/iam-token/create.md) and an [organization ID](../settings/index.md#service-settings).

For example, substitute your <IAM_TOKEN>, <ORG_ID>, and <ENTRY_ID> values into the following request to get a list of all objects associated with the entity:

```bash
curl -X 'POST' \
  'https://api.datalens.tech/rpc/getEntriesRelations' \
  -H 'accept: application/json' \
  -H 'x-dl-api-version: 0' \
  -H 'x-yacloud-subjecttoken: <IAM_TOKEN>' \
  -H 'x-dl-org-id: <ORG_ID>' \
  -H 'Content-Type: application/json' \
  -d '{
  "entryIds": [
    "<ENTRY_ID>"
  ]
}'
```


