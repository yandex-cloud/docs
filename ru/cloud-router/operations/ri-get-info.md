---
title: Как получить информацию о Routing Instance
---

# Получить информацию о Routing Instance

{% list tabs group=instructions %}

- CLI {#cli}

  1. Посмотрите описание команды CLI для получения информации о Routing Instance:

      ```bash
      yc cloudrouter routing-instance get --help
      ```

  1. Получите список `Routing Instance` (RI) для заданного каталога:

      ```bash
      yc cloudrouter routing-instance list --folder-id b1gqf2hjizv2jw****** 
      ```

      Результат:

      ```text
      +----------------------+--------------------+--------+-----------------------+
      |          ID          |        NAME        | STATUS | PRIVATE CONNECTION ID |
      +----------------------+--------------------+--------+-----------------------+
      | cf3jqdc4gjpxig****** | routing-instance   | ACTIVE | euuiog88zphgsq******, |
      |                      |                    |        | euucr7p47329kq******  |
      +----------------------+--------------------+--------+-----------------------+
      ```

  1. Получите информацию об RI, указав его идентификатор, полученный на предыдущем шаге:

      ```bash
      # yc cloudrouter routing-instance get <идентификатор RI>
      yc cloudrouter routing-instance get cf3jqdc4gjpxig******
      ```

      Результат:

      ```yml
      id: cf3jqdc4gjpxig******
      name: routing-instance
      description: '-'
      folder_id: b1gqf2hjizv2jw******
      region_id: ru-central1
      vpc_info:
        - vpc_network_id: enp0qpdijf4h2p******
          az_infos:
            - manual_info:
                az_id: ru-central1-a
                prefixes:
                  - 10.128.11.0/24
                  - 10.128.12.0/24
                  - 10.128.13.0/24
            - manual_info:
                az_id: ru-central1-b
                prefixes:
                  - 10.129.21.0/24
                  - 10.129.22.0/24
                  - 10.129.23.0/24
            - manual_info:
                az_id: ru-central1-d
                prefixes:
                  - 10.130.31.0/24
                  - 10.130.32.0/24
                  - 10.130.33.0/24
        - vpc_network_id: enp3vifnkc6l4******
          az_infos:
            - manual_info:
                az_id: ru-central1-a
                prefixes:
                  - 172.16.1.0/24
                  - 172.16.2.0/24
                  - 172.16.3.0/24
            - manual_info:
                az_id: ru-central1-b
                prefixes:
                  - 172.16.11.0/24
                  - 172.16.12.0/24
                  - 172.16.13.0/24
            - manual_info:
                az_id: ru-central1-d
                prefixes:
                  - 172.16.21.0/24
                  - 172.16.22.0/24
                  - 172.16.23.0/24
      cic_private_connection_info:
        - cic_private_connection_id: euuiog88zphgsq******
        - cic_private_connection_id: euucr7p47329kq******
      status: ACTIVE
      ```

      где,
      * `id` — идентификатор Routing Instance.
      * `name` — название RI.
      * `description` — описание RI.
      * `folder_id` — идентификатор облачного каталога в котором создан RI.
      * `region_id` — идентификатор региона в котором создан RI.
      * `vpc_info` — информация о виртуальных сетях и IP-префиксах в них с группировкой префиксов по [зонам доступности](../../overview/concepts/geo-scope.md). В RI может быть подключена одна или несколько [виртуальных сетей](../../vpc/concepts/network.md).
      * `cic_private_connection_info` — информация о [приватных подключениях](../../interconnect/concepts/priv-con.md), которые подключены к данному RI.
      * `status` — состояние RI. Может принимать следующие значения: 
        * `ACTIVE` — рабочее состояние RI.
        * `CREATING` — RI создается.
        * `UPDATING` — RI обновляется.
        * `DELETING` — RI удаляется.

{% endlist %}
