```bash
grpcurl \
  -H "X-Request-Id: $(uuidgen -t)" \
  -H "Authorization: Bearer ${IAM_TOKEN?}" \
  -d "{\"resource\": {\"id\": \"<cloud_ID>\", \"type\": \"resource-manager.cloud\"}, \"filter\": \"status in ('CANCELED', 'PENDING')\"}" \
  {{ api-host-quota-manager }}:443 yandex.cloud.quotamanager.v1.QuotaRequestService/List
```

The filter selects `CANCELED` or `PENDING` requests.