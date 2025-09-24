```bash
grpcurl \
  -H "X-Request-Id: $(uuidgen -t)" \
  -H "Authorization: Bearer ${IAM_TOKEN?}" \
  -d "{ \"quota_request_id\": \"<request_ID>\"}" \
  quota-manager.api.cloud.yandex.net:443 yandex.cloud.quotamanager.v1.QuotaRequestService/ListOperations
```