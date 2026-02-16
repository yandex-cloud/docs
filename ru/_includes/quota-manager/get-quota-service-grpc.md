```bash
grpcurl \
  -H "X-Request-Id: $(uuidgen -t)" \
  -H "Authorization: Bearer ${IAM_TOKEN?}" \
  -d "{ \"resource\": { \"id\": \"<идентификатор_облака>\", \"type\": \"resource-manager.cloud\" }, \"service\": \"iam\"}" \
  {{ api-host-quota-manager }}:443 yandex.cloud.quotamanager.v1.QuotaLimitService/List
```