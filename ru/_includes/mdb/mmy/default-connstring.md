```bash
mysql --host=<имя_хоста_{{ MY }}>.{{ dns-zone }} \
      --port={{ port-mmy }} \
      --ssl-ca=~/.mysql/root.crt \
      --ssl-mode=VERIFY_IDENTITY \
      --user=<имя_пользователя> \
      --password \
      <имя_БД>
```
