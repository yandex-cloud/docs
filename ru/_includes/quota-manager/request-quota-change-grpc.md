```bash
grpcurl \
  -H "X-Request-Id: $(uuidgen -t)" \
  -H "Authorization: Bearer ${IAM_TOKEN?}" \
  -d "{\"resource\": {\"id\": \"<идентификатор_облака>\", \"type\": \"resource-manager.cloud\"}, \"desired_quota_limits\": [{\"quota_id\": \"iam.accessKeys.count\", \"desired_limit\": \"1001\"}]}" \
  {{ api-host-quota-manager }}:443 yandex.cloud.quotamanager.v1.QuotaRequestService/Create
```