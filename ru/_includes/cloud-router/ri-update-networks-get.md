Посмотрите информацию о Routing Instance, указав его идентификатор:

```bash
yc cloudrouter routing-instance get c3lgk007olse******** \
  --folder-id <идентификатор_каталога>
```

Результат:


```text
id: c3lgk007olse********
name: ri1
description: Routing instance 1
folder_id: b1gt6g8ht345********
region_id: {{ region-id }}
vpc_info:
  - vpc_network_id: enpcfncr6uld********
    az_infos:
      - manual_info:
          az_id: {{ region-id }}-d
          prefixes:
            - 192.168.7.0/24
      - manual_info:
          az_id: {{ region-id }}-a
          prefixes:
            - 192.168.2.0/24
      - manual_info:
          az_id: {{ region-id }}-b
          prefixes:
            - 192.168.15.0/24
  - vpc_network_id: enpt8ok6snlp********
    az_infos:
      - manual_info:
          az_id: {{ region-id }}-a
          prefixes:
            - 192.168.45.0/24
            - 192.168.46.0/24
cic_private_connection_info:
  - cic_private_connection_id: cf3or586ln29********
  - cic_private_connection_id: cf3uj9uph7b6********
status: UPDATING
created_at: "2025-12-23T07:30:19Z"
```
