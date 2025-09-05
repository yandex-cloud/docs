```bash
curl \
  --request GET \
  --header "X-Request-Id: $(uuidgen -t)" \
  --header "Authorization: Bearer ${IAM_TOKEN?}" \
  'https://{{ api-host-quota-manager }}/quota-manager/v1/quotaRequests?page_size=1&resource.id=<идентификатор_облака>&resource.type=resource-manager.cloud&filter=status%20in%20(%27CANCELED%27%2C%20%27PENDING%27)&page_size=100'
```

Фильтр выбирает запросы, которые были отменены (`CANCELED`) или находятся в ожидании (`PENDING`).