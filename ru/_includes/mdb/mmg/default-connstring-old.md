
```bash
mongo --norc \
      --ssl \
      --sslCAFile ~/.mongodb/root.crt \
      --host '<FQDN хоста 1 {{ MG }}>:{{ port-mmg }},...,<FQDN хоста N {{ MG }}>:{{ port-mmg }}' \
      --username <имя пользователя БД> \
      --password <пароль пользователя БД> \
      <имя БД>
```
