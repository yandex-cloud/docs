```bash
curl \
  --request POST \
  --header "X-Request-Id: $(uuidgen -t)" \
  --header "Authorization: Bearer ${IAM_TOKEN?}" \
  --header "Content-Type: application/json" \
  --data '{"resource": {"id": "<идентификатор_облака>", "type": "resource-manager.cloud"}, "desiredQuotaLimits": [{"quotaId": "iam.accessKeys.count", "desiredLimit": "1001"}]}' \
  'https://{{ api-host-quota-manager }}/quota-manager/v1/quotaRequests'
```
