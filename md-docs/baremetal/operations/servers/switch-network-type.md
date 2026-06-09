# Изменить тип сети, подключенной к сетевому интерфейсу

Если [сетевой интерфейс](../../concepts/servers.md#network-interfaces) сервера поддерживает подключение как к [приватной](../../concepts/private-network.md), так и к [публичной](../../concepts/public-network.md) сети, то для такого интерфейса вы можете изменять тип сети с публичной на приватную или наоборот.

{% note alert %}

При изменении типа сети, к которой подключен сетевой интерфейс, физически этот интерфейс остается подключенным к тому же коммутатору [уровня](../../concepts/network.md) `Leaf`, к которому он был подключен ранее. Это означает, что при замене для интерфейса публичной сети на приватную доступ к приватной сети с использованием этого интерфейса будет осуществляться через коммутатор, к которому подключены публичные сетевые интерфейсы других серверов в данной стойке дата-центра.

В свою очередь, это означает, что при выходе из строя такого коммутатора или сетевой атаке на любой из серверов в стойке прохождение приватного сетевого трафика через этот измененный интерфейс может оказаться ограничено.

Данное ограничение не относится к серверам с резервированием сетевого подключения [MC-LAG](../../concepts/mc-lag.md).

{% endnote %}

Чтобы изменить тип сети, к которой подключен сетевой интерфейс:

{% list tabs group=instructions %}

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  1. Посмотрите описание команды для изменения сервера:

      ```bash
      yc baremetal server update --help
      ```
  1. Получите список серверов {{ baremetal-name }} в каталоге по умолчанию:

      ```bash
      yc baremetal server list
      ```

      Результат:

      ```text
      +----------------------+---------------+---------+-------+---------------------+
      |          ID          |      NAME     | STATUS  | DISKS |     CREATED AT      |
      +----------------------+---------------+---------+-------+---------------------+
      | ly5zeaqeklpg******** | sample-server | RUNNING |       | 2026-05-15 11:46:38 |
      +----------------------+---------------+---------+-------+---------------------+
      ```
  1. Определите интерфейс сервера, который поддерживает подключение как к приватной, так и к публичной сети. Алгоритм действий будет зависеть от типа конфигурации сервера ([готовая](../../concepts/server-configurations.md) или [своя](../../concepts/server-custom-configurations.md)):

      {% list tabs group=bms_server_type %}

      - Готовая конфигурация {#standard}

        1. Получите подробную информацию о сервере, указав его имя или идентификатор:

            ```bash
            yc baremetal server get sample-server
            ```

            Результат:

            ```yaml
            id: ly5zeaqeklpg********
            ...
            network_interfaces:
              - private_subnet:
                  private_subnet_id: ly5lpb2vydo7********
                private_interface:
                  native_subnet_id: ly5lpb2vydo7********
                  mac_limit: "5"
                id: ly5zjjc2vfpi********
                mac_address: b4:2e:99:58:2b:a6
                configuration_network_interface_id: ly5oc5p4u6vg********
              - private_subnet:
                  private_subnet_id: ly5lpb2vydo7********
                private_interface:
                  native_subnet_id: ly5lpb2vydo7********
                  mac_limit: "5"
                id: ly5mzklkjpa5********
                mac_address: b4:2e:99:58:2b:a8
                configuration_network_interface_id: ly5dmh2u3qwe********
            configuration_id: ly5tdlrmwezt********
            created_at: "2026-05-15T11:46:38.842525Z"
            ```

            Как видно из результата, на сервере установлены два сетевых интерфейса, оба из которых подключены к приватной сети (приватная подсеть `ly5lpb2vydo7********`):

            * интерфейс с идентификатором `ly5zjjc2vfpi********`, которому соответствует [конфигурация](../../concepts/server-configurations.md#components) сетевого интерфейса с идентификатором `ly5oc5p4u6vg********`;
            * интерфейс с идентификатором `ly5mzklkjpa5********`, которому соответствует конфигурация сетевого интерфейса с идентификатором `ly5dmh2u3qwe********`;

            Идентификатор конфигурации сервера (`configuration_id`) — `ly5tdlrmwezt********`. Сохраните это значение, оно понадобится при выполнении следующей команды.
        1. Получите подробную информацию о [конфигурации](../../concepts/server-configurations.md#components) сервера, чтобы выяснить, какой из двух сетевых интерфейсов поддерживает подключение к разным типам сетей (`PRIVATE`,`PUBLIC`). Для этого выполните команду, указав сохраненный ранее идентификатор конфигурации сервера:

            ```bash
            yc baremetal configuration get ly5tdlrmwezt********
            ```

            Результат:
            
            ```yaml
            id: ly5tdlrmwezt********
            name: LA-i107-S-1/10G
            memory_gib: "16"
            cpu:
              name: Xeon D-1521
              vendor: Intel
              cores: "8"
              physical_cores: "4"
              frequency_mhz: "2400"
            disk_drives:
              - type: SSD
                disk_count: "2"
                disk_size_gib: "838"
            network_capacity_gbps: "10"
            cpu_num: "1"
            network_interfaces:
            - id: ly5oc5p4u6vg********
              name: iface0
              configuration_id: ly5tdlrmwezt********
              link_speed_gbps: '1'
              available_modes:
              - PRIVATE
            - id: ly5dmh2u3qwe********
              name: iface1
              configuration_id: ly5tdlrmwezt********
              link_speed_gbps: '1'
              available_modes:
              - PUBLIC
              - PRIVATE
            ```

            Как видно из результата, для указанной конфигурации сервера подключение к приватной и публичной сети (`PRIVATE`,`PUBLIC`) поддерживает интерфейс с идентификатором конфигурации сетевого интерфейса `ly5dmh2u3qwe********`.

            Как видно из результата команды `yc baremetal server get`, полученного ранее, идентификатору конфигурации сетевого интерфейса `ly5dmh2u3qwe********` соответствует сетевой интерфейс сервера с идентификатором `ly5mzklkjpa5********`. Следовательно, изменить тип привязанной сети можно только для этого интерфейса.

      - Своя конфигурация {#custom}

        1. Получите подробную информацию о сервере, указав его имя или идентификатор:

            ```bash
            yc baremetal server get sample-server
            ```

            Результат:

            ```yaml
            id: ly5zeaqeklpg********
            ...
            network_interfaces:
              - private_subnet:
                  private_subnet_id: ly5lpb2vydo7********
                private_interface:
                  native_subnet_id: ly5lpb2vydo7********
                  mac_limit: "5"
                id: ly5zjjc2vfpi********
                mac_address: b4:2e:99:58:2b:a6
                configuration_network_interface_id: ly5oc5p4u6vg********
              - private_subnet:
                  private_subnet_id: ly5lpb2vydo7********
                private_interface:
                  native_subnet_id: ly5lpb2vydo7********
                  mac_limit: "5"
                id: ly5mzklkjpa5********
                mac_address: b4:2e:99:58:2b:a8
                configuration_network_interface_id: ly5dmh2u3qwe********
            configuration:
              custom_configuration:
                cpu:
                  cores: "8"
                  frequency_mhz: "2600"
                  name: Xeon E5-2650V2
                  physical_cores: "8"
                  vendor: Intel
                cpu_num: "2"
                disk_drives:
                  - disk_count: "2"
                    disk_size_gib: "3725"
                    type: HDD
                id: ly5x6w3htlgx********
                memory_gib: "128"
                mounting_availability: UNAVAILABLE
                name: custom-ly5x6w3htlgx********
                network_capacity_gbps: "1"
                network_interfaces:
                  - id: ly5oc5p4u6vg********
                    name: iface0
                    configuration_id: ly5x6w3htlgx********
                    link_speed_gbps: '1'
                    available_modes:
                      - PRIVATE
                  - id: ly5dmh2u3qwe********
                    name: iface1
                    configuration_id: ly5x6w3htlgx********
                    link_speed_gbps: '1'
                    available_modes:
                      - PRIVATE
                      - PUBLIC
            created_at: "2026-05-18T07:42:32.835148Z"
            ```

            Как видно из результата:
            * На сервере установлены (раздел `network_interfaces`) два сетевых интерфейса, оба из которых подключены к приватной сети (приватная подсеть `ly5lpb2vydo7********`):

                * интерфейс с идентификатором `ly5zjjc2vfpi********`, которому соответствует [конфигурация](../../concepts/server-configurations.md#components) сетевого интерфейса с идентификатором `ly5oc5p4u6vg********`;
                * интерфейс с идентификатором `ly5mzklkjpa5********`, которому соответствует конфигурация сетевого интерфейса с идентификатором `ly5dmh2u3qwe********`;
            * [Конфигурация](../../concepts/server-configurations.md#components) сетевого интерфейса (раздел `configuration.custom_configuration.network_interfaces`), позволяющая подключаться к разным типам сетей (`PRIVATE`,`PUBLIC`), имеет идентификатор (значение поля `id`) `ly5dmh2u3qwe********`.
            * В разделе `network_interfaces` идентификатору конфигурации сетевого интерфейса `ly5dmh2u3qwe********` по значению поля `configuration_network_interface_id` соответствует сетевой интерфейс сервера с идентификатором `ly5mzklkjpa5********`. Следовательно, изменить тип привязанной сети можно только для этого интерфейса.

      {% endlist %}

  1. Получите список подсетей, к которым можно привязать сетевой интерфейс сервера в каталоге по умолчанию:

      {% note warning %}
      
      Сервер и подключаемые к нему приватные подсети должны относиться к одному [пулу](../../concepts/servers.md#server-pools) серверов.
      
      {% endnote %}

      {% list tabs group=bms_network_type %}

      - Подключить публичную сеть {#public}

        Если сетевой интерфейс нужно подключить к публичной сети, получите список публичных подсетей, выполнив команду:

        ```bash
        yc baremetal public-subnet list
        ```

        Результат:

        ```text
        +----------------------+------+---------------+-------------------+
        |          ID          | NAME |    ZONE-ID    | HARDWARE-POOL-IDS |
        +----------------------+------+---------------+-------------------+
        | ly57sgipg23b******** |      | {{ region-id }}-m | {{ region-id }}-m4    |
        +----------------------+------+---------------+-------------------+
        ```

      - Подключить приватную сеть {#private}

        Если сетевой интерфейс нужно подключить к приватной сети, получите список приватных подсетей, выполнив команду:

        ```bash
        yc baremetal private-subnet list
        ```

        Результат:

        ```text
        +----------------------+----------------------+--------+--------------------------------+
        |          ID          |         NAME         | STATUS |          VRF-OPTIONS           |
        +----------------------+----------------------+--------+--------------------------------+
        | ly5lpb2vydo7******** | m4-subnet            | READY  | vrf_id: ly5xox6z2fyn********,  |
        |                      |                      |        | cidr: 192.168.20.0/24,         |
        |                      |                      |        | gateway_ip: 192.168.20.1       |
        | ly5v3mfr4bm5******** | m3-subnet            | READY  | vrf_id: ly5xox6z2fyn********,  |
        |                      |                      |        | cidr: 192.168.21.0/24,         |
        |                      |                      |        | gateway_ip: 192.168.21.1,      |
        |                      |                      |        | start_ip: 192.168.21.1,        |
        |                      |                      |        | end_ip: 192.168.21.254         |
        +----------------------+----------------------+--------+--------------------------------+
        ```

      {% endlist %}

  1. Измените тип сети, подключенной к сетевому интерфейсу сервера, указав идентификатор сервера, идентификаторы обоих сетевых интерфейсов и подсетей, которые должны быть к ним привязаны:

      {% note info %}
      
      Чтобы изменить тип сети, подключенной к сетевому интерфейсу сервера {{ baremetal-name }}, необходима роль [baremetal.editor](../../security/index.md#baremetal-editor) или выше.
      
      {% endnote %}

      {% list tabs group=bms_network_type %}

      - Подключить публичную сеть {#public}

        В приведенном примере сетевой интерфейс, поддерживающий подключение к разным типам сетей, подключается к публичной сети, а настройки другого интерфейса остаются без изменений:

        ```bash
        yc baremetal server update \
          --id=ly5zeaqeklpg******** \
          --network-interfaces='id=ly5zjjc2vfpi********,private-subnet-id=ly5lpb2vydo7********' \
          --network-interfaces='id=ly5mzklkjpa5********,public-subnet-id=ly57sgipg23b********' \
          --async
        ```

      - Подключить приватную сеть {#private}

        В приведенном примере сетевой интерфейс, поддерживающий подключение к разным типам сетей, подключается к приватной сети, а настройки другого интерфейса остаются без изменений:

        ```bash
        yc baremetal server update \
          --id=ly5zeaqeklpg******** \
          --network-interfaces='id=ly5zjjc2vfpi********,private-subnet-id=ly5lpb2vydo7********' \
          --network-interfaces='id=ly5mzklkjpa5********,private-subnet-id=ly5lpb2vydo7********' \
          --async
        ```

      {% endlist %}

      Результат:

      ```bash
      id: ly5mroq72gok********
      description: Server update
      created_at: "2026-05-18T05:44:28.751844Z"
      created_by: ajeol2afu1js********
      modified_at: "2026-05-18T05:44:28.751844Z"
      metadata:
        '@type': type.googleapis.com/yandex.cloud.baremetal.v1alpha.UpdateServerMetadata
        server_id: ly5zeaqeklpg********
      ```
  1. Дождитесь завершения операции (обычно занимает около пяти минут) и повторно получите информацию о сервере, чтобы убедиться, что сеть, к которой подключен интерфейс, была изменена:

      ```bash
      yc baremetal server get sample-server
      ```

      Результат:

      ```yaml
      id: ly5zeaqeklpg********
      ...
      network_interfaces:
        - private_subnet:
            private_subnet_id: ly5lpb2vydo7********
          private_interface:
            native_subnet_id: ly5lpb2vydo7********
            mac_limit: "5"
          id: ly5zjjc2vfpi********
          mac_address: b4:2e:99:58:2b:a6
          configuration_network_interface_id: ly5oc5p4u6vg********
        - public_subnet:
            public_subnet_id: ly57sgipg23b********
          public_interface:
            ip_address: 185.184.***.***
            native_subnet_id: ly57sgipg23b********
            mac_limit: "5"
          id: ly5mzklkjpa5********
          mac_address: b4:2e:99:58:2b:a8
          ip_address: 185.184.***.***
          configuration_network_interface_id: ly5dmh2u3qwe********
      ...
      ```

- API {#api}

  Чтобы воспользоваться примерами, установите утилиту [cURL](https://curl.haxx.se) и [получите](../../../iam/operations/index.md#authentication) IAM-токен, необходимый для аутентификации в [API](../../../api-design-guide/index.md) {{ yandex-cloud }}.

  {% note tip %}

  Перед выполнением запросов из примеров удобнее сохранить [IAM-токен](../../../iam/concepts/authorization/iam-token.md) в переменную окружения.

  {% endnote %}

  Алгоритм действий при изменении типа сети, подключенной к сетевому интерфейсу, будет зависеть от типа конфигурации сервера ([готовая](../../concepts/server-configurations.md) или [своя](../../concepts/server-custom-configurations.md)):

  {% list tabs group=bms_server_type %}

  - Готовая конфигурация {#standard}

    1. Получите информацию о сервере, указав в запросе его [идентификатор](*server_id):

        ```bash
        curl \
          --request GET \
          --header "Authorization: Bearer <IAM-токен>" \
          "https://baremetal.{{ api-host }}/baremetal/v1alpha/servers/<идентификатор_сервера>"
        ```

        Результат:

        ```json
        {
          ...
          "networkInterfaces": [
            {
              "privateSubnet": {
                "privateSubnetId": "ly5lpb2vydo7********"
              },
              "privateInterface": {
                "nativeSubnetId": "ly5lpb2vydo7********",
                "macLimit": "5"
              },
              "id": "ly5zjjc2vfpi********",
              "macAddress": "b4:2e:99:58:2b:a6",
              "configurationNetworkInterfaceId": "ly5oc5p4u6vg********"
            },
            {
              "privateSubnet": {
                "privateSubnetId": "ly5lpb2vydo7********"
              },
              "privateInterface": {
                "nativeSubnetId": "ly5lpb2vydo7********",
                "macLimit": "5"
              },
              "id": "ly5mzklkjpa5********",
              "macAddress": "b4:2e:99:58:2b:a8",
              "configurationNetworkInterfaceId": "ly5dmh2u3qwe********"
            }
          ],
            "id": "ly5zeaqeklpg********",
            "cloudId": "b1gia87mbaom********",
            "folderId": "b1gt6g8ht345********",
            "name": "sample-server",
            "zoneId": "{{ region-id }}-m",
            "hardwarePoolId": "{{ region-id }}-m4",
            "status": "RUNNING",
            "configurationId": "ly5tdlrmwezt********",
            "createdAt": "2026-05-15T11:46:38.842525Z"
        }
        ```

        Как видно из примера, на сервере установлены два сетевых интерфейса, оба из которых подключены к приватной сети (приватная подсеть `ly5lpb2vydo7********`):

        * интерфейс с идентификатором `ly5zjjc2vfpi********`, которому соответствует [конфигурация](../../concepts/server-configurations.md#components) сетевого интерфейса с идентификатором `ly5oc5p4u6vg********`;
        * интерфейс с идентификатором `ly5mzklkjpa5********`, которому соответствует конфигурация сетевого интерфейса с идентификатором `ly5dmh2u3qwe********`;

        Идентификатор конфигурации сервера (`configurationId`) — `ly5tdlrmwezt********`. Сохраните это значение, оно понадобится при выполнении следующего запроса.
    1. Получите подробную информацию о [конфигурации](../../concepts/server-configurations.md#components) сервера, чтобы выяснить, какой из двух сетевых интерфейсов поддерживает подключение к разным типам сетей (`PRIVATE`,`PUBLIC`). Для этого выполните запрос, указав сохраненный ранее идентификатор конфигурации сервера:

        ```bash
        curl \
          --request GET \
          --header "Authorization: Bearer <IAM-токен>" \
          "https://baremetal.{{ api-host }}/baremetal/v1alpha/configurations/ly5tdlrmwezt********"
        ```

        Результат:

        ```json
        {
          "cpu": {
            "name": "Xeon D-1521",
            "vendor": "Intel",
            "cores": "8",
            "physicalCores": "4",
            "frequencyMhz": "2400"
          },
          "diskDrives": [
            {
              "type": "SSD",
              "diskCount": "2",
              "diskSizeGib": "838"
            }
          ],
          "id": "ly5tdlrmwezt********",
          "name": "LA-i107-S-1/10G",
          "memoryGib": "16",
          "networkCapacityGbps": "10",
          "cpuNum": "1",
          "networkInterfaces": [
            {
              "id": "ly5oc5p4u6vg********",
              "name": "iface0",
              "configurationId": "ly5tdlrmwezt********",
              "linkSpeedGbps": "1",
              "availableModes": [
                "PRIVATE"
              ]
            },
            {
              "id": "ly5dmh2u3qwe********",
              "name": "iface1",
              "configurationId": "ly5tdlrmwezt********",
              "linkSpeedGbps": "1",
              "availableModes": [
                "PRIVATE",
                "PUBLIC"
              ]
            }
          ],
          "mountingAvailability": "UNAVAILABLE"
        }
        ```

        Как видно из результата, для указанной конфигурации сервера подключение к приватной и публичной сети (`PRIVATE`,`PUBLIC`) поддерживает интерфейс с идентификатором конфигурации сетевого интерфейса `ly5dmh2u3qwe********`.

        Как видно из результата предыдущего запроса на получение информации о сервере, идентификатору конфигурации сетевого интерфейса `ly5dmh2u3qwe********` соответствует сетевой интерфейс сервера с идентификатором `ly5mzklkjpa5********`. Следовательно, изменить тип привязанной сети можно только для этого интерфейса.

  - Своя конфигурация {#custom}

    1. Получите информацию о сервере, указав в запросе его [идентификатор](*server_id):

        ```bash
        curl \
          --request GET \
          --header "Authorization: Bearer <IAM-токен>" \
          "https://baremetal.{{ api-host }}/baremetal/v1alpha/servers/<идентификатор_сервера>"
        ```

        Результат:

        ```json
        {
          ...
          "networkInterfaces": [
            {
              "privateSubnet": {
                "privateSubnetId": "ly5lpb2vydo7********"
              },
              "privateInterface": {
                "nativeSubnetId": "ly5lpb2vydo7********",
                "macLimit": "5"
              },
              "id": "ly5zjjc2vfpi********",
              "macAddress": "b4:2e:99:58:2b:a6",
              "configurationNetworkInterfaceId": "ly5oc5p4u6vg********"
            },
            {
              "privateSubnet": {
                "privateSubnetId": "ly5lpb2vydo7********"
              },
              "privateInterface": {
                "nativeSubnetId": "ly5lpb2vydo7********",
                "macLimit": "5"
              },
              "id": "ly5mzklkjpa5********",
              "macAddress": "b4:2e:99:58:2b:a8",
              "configurationNetworkInterfaceId": "ly5dmh2u3qwe********"
            }
          ],
          "customConfiguration": {
            "id": "ly5vpv5ktwut********",
            "name": "custom-ly5vpv5ktwut********",
            "memoryGib": "128",
            "cpu": {
              "name": "Xeon E5-2650V2",
              "vendor": "Intel",
              "cores": "8",
              "physicalCores": "8",
              "frequencyMhz": "2600"
            },
            "diskDrives": [
              {
                "type": "HDD",
                "diskCount": "2",
                "diskSizeGib": "3725"
              }
            ],
            "cpuNum": "2",
            "networkInterfaces": [
              {
                "id": "ly5oc5p4u6vg********",
                "name": "iface0",
                "configurationId": "ly5vpv5ktwut********",
                "linkSpeedGbps": "1",
                "availableModes": [
                  "PRIVATE"
                ]
              },
              {
                "id": "ly5dmh2u3qwe********",
                "name": "iface1",
                "configurationId": "ly5vpv5ktwut********",
                "linkSpeedGbps": "1",
                "availableModes": [
                  "PRIVATE",
                  "PUBLIC"
                ]
              }
            ],
            "mountingAvailability": "UNAVAILABLE"
          },
          "id": "ly5zeaqeklpg********",
          "cloudId": "b1gia87mbaom********",
          "folderId": "b1gt6g8ht345********",
          "name": "sample-server",
          "zoneId": "{{ region-id }}-m",
          "hardwarePoolId": "{{ region-id }}-m4",
          "status": "RUNNING",
          "createdAt": "2026-05-15T11:46:38.842525Z"
        }
        ```

        Как видно из результата:
        * На сервере установлены (раздел `networkInterfaces`) два сетевых интерфейса, оба из которых подключены к приватной сети (приватная подсеть `ly5lpb2vydo7********`):

            * интерфейс с идентификатором `ly5zjjc2vfpi********`, которому соответствует [конфигурация](../../concepts/server-configurations.md#components) сетевого интерфейса с идентификатором `ly5oc5p4u6vg********`;
            * интерфейс с идентификатором `ly5mzklkjpa5********`, которому соответствует конфигурация сетевого интерфейса с идентификатором `ly5dmh2u3qwe********`;
        * [Конфигурация](../../concepts/server-configurations.md#components) сетевого интерфейса (раздел `customConfiguration.networkInterfaces`), позволяющая подключаться к разным типам сетей (`PRIVATE`,`PUBLIC`), имеет идентификатор (значение поля `id`) `ly5dmh2u3qwe********`.
        * В разделе `networkInterfaces` идентификатору конфигурации сетевого интерфейса `ly5dmh2u3qwe********` по значению поля `configurationNetworkInterfaceId` соответствует сетевой интерфейс сервера с идентификатором `ly5mzklkjpa5********`. Следовательно, изменить тип привязанной сети можно только для этого интерфейса.
 
  {% endlist %}

  1. Измените тип сети, подключенной к сетевому интерфейсу сервера, указав идентификатор сервера, идентификаторы обоих сетевых интерфейсов и подсетей, которые должны быть к ним привязаны:

      {% note info %}
      
      Чтобы изменить тип сети, подключенной к сетевому интерфейсу сервера {{ baremetal-name }}, необходима роль [baremetal.editor](../../security/index.md#baremetal-editor) или выше.
      
      {% endnote %}

      {% list tabs group=bms_network_type %}

      - Подключить публичную сеть {#public}

        В приведенном примере сетевой интерфейс, поддерживающий подключение к разным типам сетей, подключается к публичной сети, а настройки другого интерфейса остаются без изменений.

        Выполните запрос, указав идентификаторы сервера, его сетевых интерфейсов и [подсетей](*subnets):

        {% note warning %}
        
        Сервер и подключаемые к нему приватные подсети должны относиться к одному [пулу](../../concepts/servers.md#server-pools) серверов.
        
        {% endnote %}

        ```bash
        curl \
          --request PATCH \
          --header "Authorization: Bearer <IAM-токен>" \
          "https://baremetal.{{ api-host }}/baremetal/v1alpha/servers/<идентификатор_сервера>" \
          --data \
                  '''
                  {
                    "updateMask": {
                      "paths": [
                        "network_interfaces"
                      ]
                    },
                    "networkInterfaces": [
                      {
                        "id": "ly5zjjc2vfpi********",
                        "privateInterface": {
                          "nativeSubnetId": "ly5lpb2vydo7********"
                        }
                      },
                      {
                        "id": "ly5mzklkjpa5********",
                        "publicInterface": {
                          "nativeSubnet": {
                            "subnetId": "ly57sgipg23b********"
                          }
                        }
                      }
                    ]
                  }
                  '''
        ```

      - Подключить приватную сеть {#private}

        В приведенном примере сетевой интерфейс, поддерживающий подключение к разным типам сетей, подключается к приватной сети, а настройки другого интерфейса остаются без изменений.

        Выполните запрос, указав идентификаторы сервера, его сетевых интерфейсов и [подсетей](*subnets):

        {% note warning %}
        
        Сервер и подключаемые к нему приватные подсети должны относиться к одному [пулу](../../concepts/servers.md#server-pools) серверов.
        
        {% endnote %}

        ```bash
        curl \
          --request PATCH \
          --header "Authorization: Bearer <IAM-токен>" \
          "https://baremetal.{{ api-host }}/baremetal/v1alpha/servers/<идентификатор_сервера>" \
          --data \
                  '''
                  {
                    "updateMask": {
                      "paths": [
                        "network_interfaces"
                      ]
                    },
                    "networkInterfaces": [
                      {
                        "id": "ly5zjjc2vfpi********",
                        "privateInterface": {
                          "nativeSubnetId": "ly5lpb2vydo7********"
                        }
                      },
                      {
                        "id": "ly5mzklkjpa55xikrktd",
                        "privateInterface": {
                          "nativeSubnetId": "ly5lpb2vydo7********"
                        }
                      }
                    ]
                  }
                  '''
        ```

      {% endlist %}

      Результат:

      ```json
      {
        "done": false,
        "metadata": {
          "@type": "type.googleapis.com/yandex.cloud.baremetal.v1alpha.UpdateServerMetadata",
          "serverId": "ly5zeaqeklpg********"
        },
        "id": "ly56w27i7ehd********",
        "description": "Server update",
        "createdAt": "2026-05-18T18:28:52.058175Z",
        "createdBy": "ajeol2afu1js********",
        "modifiedAt": "2026-05-18T18:28:52.058175Z"
      }
      ```
  1. Дождитесь завершения операции (обычно занимает около пяти минут) и повторно получите информацию о сервере, чтобы убедиться, что сеть, к которой подключен интерфейс, была изменена.

{% endlist %}

[*server_id]: Получить идентификатор сервера можно в [консоли управления]({{ link-console-main }}) или с помощью команды [{{ yandex-cloud }} CLI](../../../cli/cli-ref/baremetal/cli-ref/server/list.md) `yc baremetal server list`.

[*subnets]: * Получить идентификаторы приватных подсетей можно в [консоли управления]({{ link-console-main }}) или с помощью команды [{{ yandex-cloud }} CLI](../../../cli/cli-ref/baremetal/cli-ref/private-subnet/list.md) `yc baremetal private-subnet list`.
* Получить идентификаторы публичных подсетей можно в [консоли управления]({{ link-console-main }}) или с помощью команды [{{ yandex-cloud }} CLI](../../../cli/cli-ref/baremetal/cli-ref/public-subnet/list.md) `yc baremetal public-subnet list`.