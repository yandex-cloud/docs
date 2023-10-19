```bash
curl \
    --user admin:<пароль> \
    --cacert ~/.opensearch/root.crt \
    --request GET 'https://<FQDN хоста {{ OS }} с ролью DATA>:{{ port-mos }}/'
```
