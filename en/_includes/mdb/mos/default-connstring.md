```bash
curl \
    --user <username>:<password> \
    --cacert ~/.opensearch/root.crt \
    --request GET 'https://c-<ID of {{ OS }} host with DATA role>.rw.{{ dns-zone }}:9200/'
```
