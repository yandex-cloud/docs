```bash
curl --request PUT \
     "https://<IP адрес или FQDN хоста с ролью DATA в кластере-источнике>:{{ port-mes }}/_snapshot/<имя репозитория>/snapshot_1?wait_for_completion=false&pretty"
```