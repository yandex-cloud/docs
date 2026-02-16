```bash
curl \
  --request GET \
  --header "X-Request-Id: $(uuidgen -t)" \
  --header "Authorization: Bearer ${IAM_TOKEN?}" \
  'https://{{ api-host-quota-manager }}/quota-manager/v1/quotaLimits?service=iam&resource.id=<идентификатор_облака>&resource.type=resource-manager.cloud'
```
