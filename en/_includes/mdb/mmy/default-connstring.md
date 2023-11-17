```bash
mysql --host=<{{ MY }}_host_name>.{{ dns-zone }} \
      --port={{ port-mmy }} \
      --ssl-ca=~/.mysql/root.crt \
      --ssl-mode=VERIFY_IDENTITY \
      --user=<username> \
      --password \
      <DB_name>
```
