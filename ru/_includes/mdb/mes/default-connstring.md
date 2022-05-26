```bash
curl \
    --user <имя пользователя>:<пароль> \
    --cacert ~/.elasticsearch/root.crt \
    --request GET 'https://c-<идентификатор кластера {{ ES }}>.rw.{{ dns-zone }}:9200/'
```
