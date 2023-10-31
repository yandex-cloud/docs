```bash
curl \
    --user admin:<пароль> \
    --cacert ~/.opensearch/root.crt \
    --request GET 'https://<FQDN_хоста_{{ OS }}_с_ролью_DATA>:{{ port-mos }}/'
```
