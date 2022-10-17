```bash
curl \
    --user <имя пользователя>:<пароль> \
    --cacert ~/.opensearch/root.crt \
    --request GET 'https://c-<идентификатор кластера {{ OS }}>.rw.{{ dns-zone }}:9200/'
```
