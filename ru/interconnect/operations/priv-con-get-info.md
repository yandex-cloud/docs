---
title: Как получить информацию о приватном соединении {{ interconnect-name }}
description: Следуя этой инструкции, вы сможете получить информацию о приватном соединении {{ interconnect-name }}.
---

# Получить информацию о приватном соединении

{% note info %}

Для выполнения операции необходима роль [cic.viewer](../security/index.md#cic-viewer).

{% endnote %}

{% list tabs group=instructions %}

- CLI {#cli}

  1. Посмотрите описание команды CLI для получения информации о [приватном соединении](../concepts/priv-con.md):

      ```bash
      yc cic private-connection get --help
      ```

  1. Получите список приватных соединений в указанном каталоге:

     ```bash
      yc cic private-connection list --folder-id b1gqf2hjizv2jw******
      ```

      Результат:

      ```text
      +----------------------+--------------------+----------------------+
      |          ID          |        NAME        | TRUNK CONNECTION ID  |
      +----------------------+--------------------+----------------------+
      | euuiog88zphgsq****** | customer-name-prc1 | euuqqctbrflq3i****** |
      | euucr7p47329kq****** | customer-name-prc2 | euuvdjl5shd0fv****** |
      +----------------------+--------------------+----------------------+      
      ```

  1. Получите информацию о приватном соединении, указав его идентификатор, полученный на предыдущем шаге:

      ```bash
      # yc cic private-connection get <идентификатор_приватного_соединения>
      yc cic private-connection get euuiog88zphgsq******
      ```

      Результат:

      ```yml
      id: euuiog88zphgsq******
      name: customer-name-prc1
      folder_id: b1gqf2hjizv2jw******
      region_id: ru-central1
      trunk_connection_id: euuqqctbrflq3i******
      vlan_id: "1531"
      ipv4_peering:
        peering_subnet: 10.211.10.0/30
        peer_ip: 10.211.10.1
        cloud_ip: 10.211.10.2
        peer_bgp_asn: "64515"
        cloud_bgp_asn: "200350"
      ```

      где,
      * `id` — идентификатор приватного соединения.
      * `name` — название приватного соединения.
      * `folder_id` — идентификатор облачного каталога в котором создано приватное соединение.
      * `region_id` — регион облака в котором создано приватное соединение.
      * `trunk_connection_id` — идентификатор транкового подключения к которому относится данное приватное соединение.
      * `vlan_id` — идентификатор VLAN для данного приватного соединения.
      * параметры IP и BGP связности для стыковой подсети данного приватного соединения:
         * `peering_subnet` — [стыковая подсеть](../../interconnect/concepts/priv-con.md#priv-address) для BGP-пиринга.
         * `peer_ip` — IP адрес из стыковой (пиринговой) подсети на оборудовании клиента.
         * `cloud_ip` — IP адрес из стыковой (пиринговой) подсети на оборудовании {{ yandex-cloud }}.
         * `peer_bgp_asn` — номер [BGP ASN](../../interconnect/concepts/priv-con.md#bgp-asn) на оборудовании клиента.
         * `cloud_bgp_asn` — номер BGP ASN на оборудовании {{ yandex-cloud }}.

{% endlist %}
