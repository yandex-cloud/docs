```bash
curl -X GET \
-H "X-Request-Id: $(uuidgen -t)" \
-H "Authorization: Bearer ${IAM_TOKEN?}" \
'https://{{ api-host-quota-manager }}/quota-manager/v1/quotaRequests/atd1sftc071****/operations'
```