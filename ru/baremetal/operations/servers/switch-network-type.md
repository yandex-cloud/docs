---
title: Изменение типа сети, привязанной к сетевому интерфейсу сервера {{ baremetal-full-name }}
description: Следуя данной инструкции, вы сможете изменить тип сети, привязанной к сетевому интерфейсу сервера {{ baremetal-full-name }}, с публичной на приватную и наоборот.
---

# Изменить тип сети, подключенной к сетевому интерфейсу

Если [сетевой интерфейс](../../concepts/servers.md#network-interfaces) сервера поддерживает подключение как к [приватной](../../concepts/private-network.md), так и к [публичной](../../concepts/public-network.md) сети, то для такого интерфейса вы можете изменять тип сети с публичной на приватную или наоборот.

{% include [switch-iface-network-type-ddos-warn](../../../_includes/baremetal/switch-iface-network-type-ddos-warn.md) %}

Чтобы изменить тип сети, к которой подключен сетевой интерфейс:

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды для изменения сервера:

     ```bash
     yc baremetal v2 server update --help
     ```

  1. Получите список серверов {{ baremetal-name }} в каталоге по умолчанию и сохраните идентификатор нужного сервера (`server_id`):

     ```bash
     yc baremetal v2 server list
     ```

  1. Получите подробную информацию о сервере, указав его идентификатор:

     ```bash
     yc baremetal v2 server get ly5zeaqeklpg******** --format yaml
     ```

     Пример результата:

     ```yaml
     server_id: ly5zeaqeklpg********
     network_interfaces:
       - network_interface_id: ly5zjjc2vfpi********
         private_interface:
           native_subnet_id: ly5lpb2vydo7********
           mac_limit: "5"
         configuration_network_interface_id: ly5oc5p4u6vg********
       - network_interface_id: ly5mzklkjpa5********
         private_interface:
           native_subnet_id: ly5lpb2vydo7********
           mac_limit: "5"
         configuration_network_interface_id: ly5dmh2u3qwe********
     stock_configuration_id: ly5tdlrmwezt********
     ```

     В этом примере оба интерфейса подключены к приватной подсети `ly5lpb2vydo7********`. Сохраните значения `network_interface_id` и соответствующие им `configuration_network_interface_id`.

  1. Определите, какой интерфейс поддерживает подключение как к приватной, так и к публичной сети. Действия зависят от [конфигурации сервера](../../concepts/server-configurations.md):

     {% list tabs group=bms_server_type %}

     - Готовая конфигурация {#standard}

       Получите информацию о конфигурации, указав значение `stock_configuration_id` из предыдущего шага:

       ```bash
       yc baremetal configuration get ly5tdlrmwezt********
       ```

       {% include [conf-get-cli-output](../../../_includes/baremetal/instruction-steps/conf-get-cli-output.md) %}

       В списке `network_interfaces` найдите конфигурацию интерфейса, для которой `available_modes` содержит `PRIVATE` и `PUBLIC`. В примере это `ly5dmh2u3qwe********`.

     - Своя конфигурация {#custom}

       В результате команды `yc baremetal v2 server get` найдите список `custom_configuration.network_interfaces`:

       ```yaml
       custom_configuration:
         configuration_id: ly5x6w3htlgx********
         network_interfaces:
           - id: ly5oc5p4u6vg********
             name: iface0
             available_modes:
               - PRIVATE
           - id: ly5dmh2u3qwe********
             name: iface1
             available_modes:
               - PRIVATE
               - PUBLIC
       ```

       Найдите конфигурацию интерфейса, для которой `available_modes` содержит `PRIVATE` и `PUBLIC`. В примере это `ly5dmh2u3qwe********`.

     {% endlist %}

     Сопоставьте найденный идентификатор с полем `configuration_network_interface_id` в списке интерфейсов сервера. В примере ему соответствует интерфейс `ly5mzklkjpa5********`, для которого можно изменить тип сети.

  1. Получите список подсетей, к которым можно подключить интерфейс сервера:

     {% include [server-priv-netwrk-same-pool-notice](../../../_includes/baremetal/server-priv-netwrk-same-pool-notice.md) %}

     {% list tabs group=bms_network_type %}

     - Подключить публичную сеть {#public}

       ```bash
       yc baremetal v2 public-subnet list
       ```

       Сохраните идентификатор нужной подсети (`public_subnet_id`).

     - Подключить приватную сеть {#private}

       ```bash
       yc baremetal v2 private-subnet list
       ```

       Сохраните идентификатор нужной подсети (`private_subnet_id`).

     {% endlist %}

  1. Измените тип сети, указав идентификатор сервера и полный список его сетевых интерфейсов:

     {% include [switch-network-role-notice](../../../_includes/baremetal/switch-network-role-notice.md) %}

     В примерах первый интерфейс сохраняет подключение к приватной сети, а для второго меняется тип сети. Если у интерфейсов настроены дополнительные приватные подсети (`vlan-subinterfaces`) или пакет трафика (`internet-traffic-plan`), передайте и эти настройки, чтобы сохранить их.

     {% list tabs group=bms_network_type %}

     - Подключить публичную сеть {#public}

       ```bash
       yc baremetal v2 server update \
         --id ly5zeaqeklpg******** \
         --update-mask network-interfaces \
         --server '{
           network-interfaces=[
             {
               network-interface-id="ly5zjjc2vfpi********",
               interface=private-interface={native-subnet-id="ly5lpb2vydo7********"}
             },
             {
               network-interface-id="ly5mzklkjpa5********",
               interface=public-interface={native-subnet-config=native-subnet={subnet-id="ly57sgipg23b********"}}
             }
           ]
         }' \
         --async
       ```

     - Подключить приватную сеть {#private}

       ```bash
       yc baremetal v2 server update \
         --id ly5zeaqeklpg******** \
         --update-mask network-interfaces \
         --server '{
           network-interfaces=[
             {
               network-interface-id="ly5zjjc2vfpi********",
               interface=private-interface={native-subnet-id="ly5lpb2vydo7********"}
             },
             {
               network-interface-id="ly5mzklkjpa5********",
               interface=private-interface={native-subnet-id="ly5lpb2vydo7********"}
             }
           ]
         }' \
         --async
       ```

     {% endlist %}

     Маска `--update-mask network-interfaces` ограничивает изменение сетевыми интерфейсами.

  1. Дождитесь завершения операции и повторно получите информацию о сервере:

     ```bash
     yc baremetal v2 server get ly5zeaqeklpg******** --format yaml
     ```

     Проверьте `private_interface` или `public_interface` у измененного интерфейса. Например, после подключения публичной сети результат содержит:

     ```yaml
     network_interfaces:
       - network_interface_id: ly5zjjc2vfpi********
         private_interface:
           native_subnet_id: ly5lpb2vydo7********
       - network_interface_id: ly5mzklkjpa5********
         public_interface:
           native_subnet_id: ly57sgipg23b********
           ip_address: 185.184.***.***
     ```

- API {#api}

  Чтобы воспользоваться примерами, установите утилиту [cURL](https://curl.haxx.se) и [получите](../../../iam/operations/index.md#authentication) IAM-токен, необходимый для аутентификации в [API](../../../api-design-guide/index.yaml) {{ yandex-cloud }}.

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

      {% include [switch-network-role-notice](../../../_includes/baremetal/switch-network-role-notice.md) %}

      {% list tabs group=bms_network_type %}

      - Подключить публичную сеть {#public}

        В приведенном примере сетевой интерфейс, поддерживающий подключение к разным типам сетей, подключается к публичной сети, а настройки другого интерфейса остаются без изменений.

        Выполните запрос, указав идентификаторы сервера, его сетевых интерфейсов и [подсетей](*subnets):

        {% include [server-priv-netwrk-same-pool-notice](../../../_includes/baremetal/server-priv-netwrk-same-pool-notice.md) %}

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

        {% include [server-priv-netwrk-same-pool-notice](../../../_includes/baremetal/server-priv-netwrk-same-pool-notice.md) %}

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

[*server_id]: Получить идентификатор сервера можно в [консоли управления]({{ link-console-main }}) или с помощью команды [{{ yandex-cloud }} CLI](../../../cli/cli-ref/baremetal/cli-ref/v2/server/list.md) `yc baremetal v2 server list`.

[*subnets]: * Получить идентификаторы приватных подсетей можно в [консоли управления]({{ link-console-main }}) или с помощью команды [{{ yandex-cloud }} CLI](../../../cli/cli-ref/baremetal/cli-ref/v2/private-subnet/list.md) `yc baremetal v2 private-subnet list`.
* Получить идентификаторы публичных подсетей можно в [консоли управления]({{ link-console-main }}) или с помощью команды [{{ yandex-cloud }} CLI](../../../cli/cli-ref/baremetal/cli-ref/v2/public-subnet/list.md) `yc baremetal v2 public-subnet list`.