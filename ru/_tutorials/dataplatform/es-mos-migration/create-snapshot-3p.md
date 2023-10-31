```bash
curl --request PUT \
     "https://<IP-адрес_или_FQDN_хоста_с_ролью_DATA_в_кластере-источнике>:{{ port-mes }}/_snapshot/<имя_репозитория>/snapshot_1?wait_for_completion=false&pretty"
```