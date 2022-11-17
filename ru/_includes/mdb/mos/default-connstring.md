```bash
curl \
    --user <имя пользователя>:<пароль> \
    --cacert ~/.opensearch/root.crt \
    --request GET 'https://c-<идентификатор хоста {{ OS }} с ролью DATA>.rw.{{ dns-zone }}:9200/'
```
