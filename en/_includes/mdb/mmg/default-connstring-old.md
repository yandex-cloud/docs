
```bash
mongo --norc \
      --ssl \
      --sslCAFile ~/.mongodb/root.crt \
      --host '<FQDN_of_{{ MG }}_host_1>:{{ port-mmg }},...,<FQDN_of_{{ MG }}_host_N>:{{ port-mmg }}' \
      --username <DB_username> \
      --password <DB_user_password> \
      <DB_name>
```

