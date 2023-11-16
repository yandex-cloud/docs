```bash
redis-cli \
    -h c-<cluster_ID>.rw.{{ dns-zone }} \
    -a <password> \
    -p {{ port-mrd-tls }} \
    --tls \
    --cacert ~/.redis/{{ crt-local-file }}
```
