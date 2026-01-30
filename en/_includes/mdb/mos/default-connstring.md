```bash
curl \
    --user admin:<password> \
    --cacert ~/.opensearch/root.crt \
    --request GET 'https://<FQDN_of_{{ OS }}_host_with_DATA_role>:{{ port-mos }}/'
```
