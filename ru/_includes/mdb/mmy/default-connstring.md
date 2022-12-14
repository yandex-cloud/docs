```bash
mysql --host=<имя хоста {{ MY }}>.{{ dns-zone }} \
      --port={{ port-mmy }} \
      --ssl-ca=~/.mysql/root.crt \
      --ssl-mode=VERIFY_IDENTITY \
      --user=<имя пользователя> \
      --password \
      <имя БД>
```
