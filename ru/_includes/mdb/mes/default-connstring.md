```bash
curl \
    --user <имя_пользователя>:<пароль> \
    --cacert ~/.elasticsearch/root.crt \
    --request GET 'https://c-<идентификатор_кластера_{{ ES }}>.rw.{{ dns-zone }}:9200/'
```
