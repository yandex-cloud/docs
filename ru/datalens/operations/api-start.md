# Работа с Public API


{{ datalens-name }} предоставляет публичное API [https://api.datalens.tech](https://api.datalens.tech) для автоматизации операций с дашбордами, чартами, датасетами и подключениями.

{{ datalens-name }} Public API — это набор методов, аналогичный тем, что используются в веб-интерфейсе {{ datalens-name }}. API описывается OpenAPI-спецификацией и аутентифицируется через IAM-токены Yandex Cloud.

Для работы с API требуется [IAM-токен](../../iam/operations/iam-token/create) и [идентификатор организации](../settings/index.md#service-settings).

Например, подставьте свои значения <IAM_TOKEN>, <ORG_ID> и <ENTRY_ID> в следующий запрос, чтобы получить список всех связанных с сущностью объектов:

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


