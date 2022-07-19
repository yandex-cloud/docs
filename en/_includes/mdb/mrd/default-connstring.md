```bash
redis-cli \
    -h c-<cluster ID>.rw.{{ dns-zone }} \
    -a <password> \
    -p {{ port-mrd-tls }} \
    --tls \
    --cacert ~/.redis/{{ crt-local-file }}
```
