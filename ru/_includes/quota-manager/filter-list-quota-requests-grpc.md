```bash
grpcurl \
  -H "X-Request-Id: $(uuidgen -t)" \
  -H "Authorization: Bearer ${IAM_TOKEN?}" \
  -d "{\"resource\": {\"id\": \"<идентификатор_облака>\", \"type\": \"resource-manager.cloud\"}, \"filter\": \"status in ('CANCELED', 'PENDING')\"}" \
  {{ api-host-quota-manager }}:443 yandex.cloud.quotamanager.v1.QuotaRequestService/List
```

Фильтр выбирает запросы, которые были отменены (`CANCELED`) или находятся в ожидании (`PENDING`).