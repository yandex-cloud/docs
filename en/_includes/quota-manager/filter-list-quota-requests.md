```bash
curl -X GET \
-H "X-Request-Id: $(uuidgen -t)" \
-H "Authorization: Bearer ${IAM_TOKEN?}" \
'https://{{ api-host-quota-manager }}/quota-manager/v1/quotaRequests?\
page_size=1&\
resource.id=b1gflhy********&\
resource.type=resource-manager.cloud\
filter=status%20in%20(%27CANCELED%27%2C%20%27PROCESSED%27)'
```

The filter selects requests that were canceled (`CANCELED`) or processed (`PROCESSED`).