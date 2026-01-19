```bash
redis-cli \
    -h c-<идентификатор_кластера>.rw.{{ dns-zone }} \
    -a <пароль> \
    -p {{ port-mrd-tls }} \
    --tls \
    --cacert ~/.redis/{{ crt-local-file }}
```
