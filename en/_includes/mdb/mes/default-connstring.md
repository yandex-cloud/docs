```bash
curl \
    --user <username>:<password> \
    --cacert ~/.elasticsearch/root.crt \
    --request GET 'https://c-<{{ ES }}_cluster_ID>.rw.{{ dns-zone }}:9200/'
```
