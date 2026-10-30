```bash
clickhouse-client --host <FQDN_любого_хоста_{{ CH }}> \
                  --secure \
                  --user <имя_пользователя> \
                  --database <имя_БД> \
                  --port {{ port-mch-cli }} \
                  --ask-password
```
