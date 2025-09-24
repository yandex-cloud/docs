```bash
grpcurl \
  -H "X-Request-Id: $(uuidgen -t)" \
  -H "Authorization: Bearer ${IAM_TOKEN?}" \
  -d "{ \"resource\": { \"id\": \"<cloud_ID>\", \"type\": \"resource-manager.cloud\" }, \"quota_id\": \"iam.accessKeys.count\"}" \
  {{ api-host-quota-manager }}:443 yandex.cloud.quotamanager.v1.QuotaLimitService/Get
```