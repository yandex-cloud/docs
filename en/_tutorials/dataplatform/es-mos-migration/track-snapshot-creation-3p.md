```bash
curl --request GET \
     "https://<IP address or FQDN of the host with the DATA role in the source cluster>:{{ port-mes }}/_snapshot/<repository name>/snapshot_1/_status?pretty"
```