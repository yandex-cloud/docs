```bash
grpcurl \
  -H "X-Request-Id: $(uuidgen -t)" \
  -H "Authorization: Bearer ${IAM_TOKEN?}" \
  -d "{\"quota_request_id\": \"<идентификатор_запроса>\"}" \
  {{ api-host-quota-manager }}:443 yandex.cloud.quotamanager.v1.QuotaRequestService/Get
```