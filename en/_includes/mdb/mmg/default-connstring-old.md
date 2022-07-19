

```bash
mongo --norc \
      --ssl \
      --sslCAFile ~/.mongodb/root.crt \
      --host '<FQDN of host 1 {{ MG }}>:{{ port-mmg }},...,<FQDN of host N {{ MG }}>:{{ port-mmg }}' \
      --username <DB user name> \
      --password <DB user password> \
      <DB name>
```

