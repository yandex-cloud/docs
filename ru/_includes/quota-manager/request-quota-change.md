```bash
curl \
  --request POST \
  --header "X-Request-Id: $(uuidgen -t)" \
  --header "Authorization: Bearer ${IAM_TOKEN?}" \
  --data '{"resource": {"id": "<идентификатор_облака>", "type": "resource-manager.cloud"}, "desired_quota_limits": [{"quota_id": "iam.accessKeys.count", "desired_limit": "1001"}]}' \
  'https://{{ api-host-quota-manager }}/quota-manager/v1/quotaRequests'
```