```bash
curl -X GET \
-H "X-Request-Id: $(uuidgen -t)" \
-H "Authorization: Bearer ${IAM_TOKEN?}" \
'https://{{ api-host-quota-manager }}/quota-manager/v1/quotaRequests?page_size=1&resource.id=b1gflhy********&resource.type=resource-manager.cloud'
```