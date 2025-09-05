```bash
curl \
  --request POST \
  --header "X-Request-Id: $(uuidgen -t)" \
  --header "Authorization: Bearer ${IAM_TOKEN?}" \
  --data "{\"quota_ids\": [ \"iam.accessKeys.count\" ]}" \
  'https://{{ api-host-quota-manager }}/quota-manager/v1/quotaRequests/<идентификатор_запроса>/cancel'
```