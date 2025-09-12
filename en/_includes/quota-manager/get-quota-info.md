```bash
curl -X GET \
-H "X-Request-Id: $(uuidgen -t)" \
-H "Authorization: Bearer ${IAM_TOKEN?}" \
'https://{{ api-host-quota-manager }}/quota-manager/v1/quotaLimits/iam.accessKeys.count?resource.id=b1gflhy********&resource.type=resource-manager.cloud'
```