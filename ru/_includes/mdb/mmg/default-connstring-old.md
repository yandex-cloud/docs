
```bash
mongo --norc \
      --ssl \
      --sslCAFile ~/.mongodb/root.crt \
      --host '<FQDN_хоста_1_Yandex_StoreDoc>:{{ port-mmg }},...,<FQDN_хоста_N_Yandex_StoreDoc>:{{ port-mmg }}' \
      --username <имя_пользователя_БД> \
      --password <пароль_пользователя_БД> \
      <имя_БД>
```

