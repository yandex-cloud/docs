```bash
curl \
    --user admin:<password> \
    --cacert ~/.opensearch/root.crt \
    --request GET 'https://<FQDN_of_the_{{ OS }}_host_with_the_DATA_role>:{{ port-mos }}/'
```
