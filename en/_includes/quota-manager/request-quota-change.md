```bash
curl -X POST \
-H "X-Request-Id: $(uuidgen -t)" \
-H "Authorization: Bearer ${IAM_TOKEN?}" \
-d '{"resource": {"id": "b1gflhy********", "type": "resource-manager.cloud"}, "desired_quota_limits": [{"quota_id": "iam.accessKeys.count", "desired_limit": "100000"}]}' \
'https://{{ api-host-quota-manager }}/quota-manager/v1/quotaRequests'
```