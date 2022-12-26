```bash
curl \
    --user admin:<password> \
    --cacert ~/.opensearch/root.crt \
    --request GET 'https://<ID of {{ OS }} host with DATA role>.{{ dns-zone }}:{{ port-mos }}/'
```
