
```bash
mongo --norc \
      --ssl \
      --sslCAFile ~/.mongodb/root.crt \
      --host '<FQDN_хоста_1_{{ MG }}>:{{ port-mmg }},...,<FQDN_хоста_N_{{ MG }}>:{{ port-mmg }}' \
      --username <имя_пользователя_БД> \
      --password <пароль_пользователя_БД> \
      <имя_БД>
```

