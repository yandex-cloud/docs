```bash
mysql --host=<FQDN of host {{ MY }}> \
      --port={{ port-mmy }} \
      --ssl-ca=~/.mysql/root.crt \
      --ssl-mode=VERIFY_IDENTITY \
      --user=<user name> \
      --password \
      <DB name>
```
