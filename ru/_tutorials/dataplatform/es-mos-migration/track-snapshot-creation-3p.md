```bash
curl --request GET \
     "https://<IP адрес или FQDN хоста с ролью DATA в кластере-источнике>:{{ port-mes }}/_snapshot/<имя репозитория>/snapshot_1/_status?pretty"
```