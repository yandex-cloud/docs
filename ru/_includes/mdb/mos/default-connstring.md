```bash
curl \
    --user admin:<пароль> \
    --cacert ~/.opensearch/root.crt \
    --request GET 'https://<идентификатор хоста {{ OS }} с ролью DATA>.{{ dns-zone }}:{{ port-mos }}/'
```
