
```bash
mongo --norc \
      --ssl \
      --sslCAFile ~/.mongodb/root.crt \
      --host '<FQDN_of_Yandex_StoreDoc_host_1>:{{ port-mmg }},...,<FQDN_of_Yandex_StoreDoc_host_N>:{{ port-mmg }}' \
      --username <DB_username> \
      --password <DB_user_password> \
      <DB_name>
```

