# Получить информацию о Routing Instance

{% note info %}

Для выполнения операции необходима роль [cloud-router.viewer](../security/index.md#cloudrouter-viewer).

{% endnote %}

{% list tabs group=instructions %}

- CLI {#cli}

  Вы можете посмотреть информацию о Routing Instance с помощью следующих команд:
  * [yc cloudrouter routing-instance get](../../cli/cli-ref/cloudrouter/cli-ref/routing-instance/get.md) — позволяет получить информацию о Routing Instance по его имени или идентификатору.
  * [yc cloudrouter routing-instance get-by-cic-private-connection-id](../../cli/cli-ref/cloudrouter/cli-ref/routing-instance/get-by-cic-private-connection-id.md) — позволяет получить информацию о Routing Instance по идентификатору [приватного соединения](../../interconnect/concepts/priv-con.md) Yandex Cloud Interconnect, которое подключено к Routing Instance.
  * [yc cloudrouter routing-instance get-by-vpc-network-id](../../cli/cli-ref/cloudrouter/cli-ref/routing-instance/get-by-vpc-network-id.md) — позволяет получить информацию о Routing Instance по идентификатору [облачной сети](../../vpc/concepts/network.md#network), с которой Routing Instance обеспечивает сетевую связность.

  **yc cloudrouter routing-instance get**

  1. Посмотрите описание команды CLI для получения информации о Routing Instance:

      ```bash
      yc cloudrouter routing-instance get --help
      ```

  1. Получите список Routing Instance в заданном [каталоге](../../resource-manager/concepts/resources-hierarchy.md#folder):

      ```bash
      yc cloudrouter routing-instance list \
        --folder-id <идентификатор_каталога>
      ```

      Результат:

      ```text
      +----------------------+--------------------+--------+-----------------------+
      |          ID          |        NAME        | STATUS | PRIVATE CONNECTION ID |
      +----------------------+--------------------+--------+-----------------------+
      | cf3jqdc4gjpx******** | routing-instance   | ACTIVE | euuiog88zphg********, |
      |                      |                    |        | euucr7p47329********  |
      +----------------------+--------------------+--------+-----------------------+
      ```

  1. Получите информацию о Routing Instance, указав его идентификатор, полученный на предыдущем шаге:

      ```bash
      yc cloudrouter routing-instance get cf3jqdc4gjpx********
      ```

      {% cut "Результат:" %}

      ```yml
      id: cf3jqdc4gjpx********
      name: routing-instance
      description: '-'
      folder_id: b1gqf2hjizv2********
      region_id: ru-central1
      vpc_info:
        - vpc_network_id: enp0qpdijf4h********
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
        - vpc_network_id: enp3vifnkc6********
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
        - cic_private_connection_id: euuiog88zphg********
        - cic_private_connection_id: euucr7p47329********
      status: ACTIVE
      ```
      
      
      
      Где:
      
      * `id` — идентификатор Routing Instance.
      * `name` — название RI.
      * `description` — описание RI.
      * `folder_id` — идентификатор облачного каталога, в котором создан RI.
      * `region_id` — идентификатор региона, в котором создан RI.
      * `vpc_info` — информация о виртуальных сетях и IP-префиксах в них с группировкой префиксов по [зонам доступности](../../overview/concepts/geo-scope.md). В RI может быть подключена одна или несколько [виртуальных сетей](../../vpc/concepts/network.md).
      * `cic_private_connection_info` — информация о [приватных соединениях](../../interconnect/concepts/priv-con.md), которые подключены к данному RI.
      * `status` — состояние RI. Может принимать следующие значения: 
        * `ACTIVE` — рабочее состояние RI.
        * `CREATING` — RI создается.
        * `UPDATING` — RI обновляется.
        * `DELETING` — RI удаляется.

      {% endcut %}

  **yc cloudrouter routing-instance get-by-cic-private-connection-id**

  1. Посмотрите описание команды CLI для получения информации о Routing Instance:

      ```bash
      yc cloudrouter routing-instance get-by-cic-private-connection-id --help
      ```
  1. Получите список приватных соединений в заданном каталоге:

      ```bash
      yc cic private-connection list \
        --folder-id <идентификатор_каталога>
      ```

      Результат:

      ```text
      +----------------------+------+----------------------+
      |          ID          | NAME | TRUNK CONNECTION ID  |
      +----------------------+------+----------------------+
      | cf3r5ke20fo0******** |      | cf3dcodot14p******** |
      | cf3r3mfr4bm5******** |      | cf3dcodot14p******** |
      +----------------------+------+----------------------+
      ```
  1. Получите информацию о Routing Instance, указав идентификатор подключенного к нему приватного соединения:

      ```bash
      yc cloudrouter routing-instance get-by-cic-private-connection-id \
        --cic-prc-id cf3r5ke20fo0********
      ```

      {% cut "Результат:" %}

      ```yml
      id: cf3jqdc4gjpx********
      name: routing-instance
      description: '-'
      folder_id: b1gqf2hjizv2********
      region_id: ru-central1
      vpc_info:
        - vpc_network_id: enp0qpdijf4h********
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
        - vpc_network_id: enp3vifnkc6********
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
        - cic_private_connection_id: euuiog88zphg********
        - cic_private_connection_id: euucr7p47329********
      status: ACTIVE
      ```
      
      
      
      Где:
      
      * `id` — идентификатор Routing Instance.
      * `name` — название RI.
      * `description` — описание RI.
      * `folder_id` — идентификатор облачного каталога, в котором создан RI.
      * `region_id` — идентификатор региона, в котором создан RI.
      * `vpc_info` — информация о виртуальных сетях и IP-префиксах в них с группировкой префиксов по [зонам доступности](../../overview/concepts/geo-scope.md). В RI может быть подключена одна или несколько [виртуальных сетей](../../vpc/concepts/network.md).
      * `cic_private_connection_info` — информация о [приватных соединениях](../../interconnect/concepts/priv-con.md), которые подключены к данному RI.
      * `status` — состояние RI. Может принимать следующие значения: 
        * `ACTIVE` — рабочее состояние RI.
        * `CREATING` — RI создается.
        * `UPDATING` — RI обновляется.
        * `DELETING` — RI удаляется.

      {% endcut %}

  **yc cloudrouter routing-instance get-by-vpc-network-id**

  1. Посмотрите описание команды CLI для получения информации о Routing Instance:

      ```bash
      yc cloudrouter routing-instance get-by-vpc-network-id --help
      ```
  1. Получите список облачных сетей в заданном каталоге:

      ```bash
      yc vpc network list \
        --folder-id <идентификатор_каталога>
      ```

      Результат:

      ```
      +----------------------+-------------+
      |          ID          |    NAME     |
      +----------------------+-------------+
      | enpcfncr6uld******** | my-network1 |
      | enpcuntrql7d******** | my-network2 |
      +----------------------+-------------+
      ```
  1. Получите информацию о Routing Instance, указав идентификатор облачной сети, с которой он обеспечивает сетевую связность:

      ```bash
      yc cloudrouter routing-instance get-by-vpc-network-id \
        --vpc-id enpcfncr6uld********
      ```

      {% cut "Результат:" %}

      ```yml
      id: cf3jqdc4gjpx********
      name: routing-instance
      description: '-'
      folder_id: b1gqf2hjizv2********
      region_id: ru-central1
      vpc_info:
        - vpc_network_id: enp0qpdijf4h********
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
        - vpc_network_id: enp3vifnkc6********
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
        - cic_private_connection_id: euuiog88zphg********
        - cic_private_connection_id: euucr7p47329********
      status: ACTIVE
      ```
      
      
      
      Где:
      
      * `id` — идентификатор Routing Instance.
      * `name` — название RI.
      * `description` — описание RI.
      * `folder_id` — идентификатор облачного каталога, в котором создан RI.
      * `region_id` — идентификатор региона, в котором создан RI.
      * `vpc_info` — информация о виртуальных сетях и IP-префиксах в них с группировкой префиксов по [зонам доступности](../../overview/concepts/geo-scope.md). В RI может быть подключена одна или несколько [виртуальных сетей](../../vpc/concepts/network.md).
      * `cic_private_connection_info` — информация о [приватных соединениях](../../interconnect/concepts/priv-con.md), которые подключены к данному RI.
      * `status` — состояние RI. Может принимать следующие значения: 
        * `ACTIVE` — рабочее состояние RI.
        * `CREATING` — RI создается.
        * `UPDATING` — RI обновляется.
        * `DELETING` — RI удаляется.

      {% endcut %}

{% endlist %}