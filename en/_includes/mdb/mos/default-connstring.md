```bash
curl \
    --user admin:<password> \
    --cacert ~/.opensearch/root.crt \
    --request GET 'https://<FQDN of the {{ OS }} host with the DATA role>:{{ port-mos }}/'
```
