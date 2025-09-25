
```bash
mongo --norc \
      --ssl \
      --sslCAFile ~/.mongodb/root.crt \
      --host '<Yandex_StoreDoc_host_1_FQDN>:{{ port-mmg }},...,<Yandex_StoreDoc_host_N_FQDN>:{{ port-mmg }}' \
      --username <DB_username> \
      --password <DB_user_password> \
      <DB_name>
```

