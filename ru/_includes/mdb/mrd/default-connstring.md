```bash
redis-cli \
    -hostname c-<идентификатор кластера>.rw.{{ dns-zone }} \
    -password <пароль> \
    -port {{ port-mrd-tls }} \
    --tls \
    --cacert ~/.redis/{{ crt-local-file }}
```
