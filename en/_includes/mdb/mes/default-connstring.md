```bash
curl \
    --user <user name>:<password> \
    --cacert ~/.elasticsearch/root.crt \
    --request GET 'https://c-<cluster ID {{ ES }}>.rw.{{ dns-zone }}:9200/'
```
