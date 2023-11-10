```bash
curl --request PUT \
     "https://<IP_or_FQDN_of_the_DATA_host_in_the_source_cluster>:{{ port-mes }}/_snapshot/<repository_name>/snapshot_1?wait_for_completion=false&pretty"
```
