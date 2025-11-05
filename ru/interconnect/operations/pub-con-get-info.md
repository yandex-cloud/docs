---
title: Как получить информацию о публичных соединениях {{ interconnect-name }}
description: Следуя этой инструкции, вы сможете получить информацию о публичных соединениях {{ interconnect-name }}.
---

# Получить информацию о публичных соединениях

{% note info %}

Для выполнения операции необходима роль [cic.viewer](../security/index.md#cic-viewer).

{% endnote %}

{% list tabs group=instructions %}

- CLI {#cli}

  1. Посмотрите описание команды CLI для получения информации о [публичных соединениях](../concepts/pub-con.md):

      ```bash
      yc cic public-connection get --help
      ```

  1. Получите список публичных соединений в указанном каталоге:

      ```bash
      yc cic public-connection list --folder-id b1gqf2hjizv2jw******
      ```

      Результат:

      ```text
      +----------------------+--------------------+----------------------+---------------+
      |          ID          |        NAME        | TRUNK CONNECTION ID  | SERVICE TYPES |
      +----------------------+--------------------+----------------------+---------------+
      | euuiog88zphgsq****** | customer-name-pub1 | euuqqctbrflq3i****** | APIGW, ML     |
      | euucr7p47329kq****** | customer-name-pub2 | euuvdjl5shd0fv****** | APIGW, ML     |
      +----------------------+--------------------+----------------------+---------------+
      ```

  1. Получите информацию о публичном соединении, указав его идентификатор, полученный на предыдущем шаге:

      ```bash
      # yc cic public-connection get <идентификатор_публичного_соединения>
      yc cic public-connection get euuiog88zphgsq****** 
      ```

      Результат:

      ```text
      id: euuiog88zphgsq******
      name: customer-name-pub1
      folder_id: b1gqf2hjizv2jw******
      region_id: ru-central1
      trunk_connection_id: euuqqctbrflq3i******
      vlan_id: "1428"
      ipv4_peering:
        peering_subnet: 178.170.2xx.x2/31
        peer_ip: 178.170.2xx.x2
        cloud_ip: 178.170.2xx.x3
        peer_bgp_asn: "65001"
        cloud_bgp_asn: "200350"
      ipv4_allowed_service_types:
        - CLOUD_SERVICE_APIGW
        - CLOUD_SERVICE_ML
      ipv4_peer_announced_prefixes:
        - 178.170.2xx.x2/31
      ```

      где,
      * `id` — идентификатор публичного соединения.
      * `name` — название публичного соединения.
      * `folder_id` — идентификатор облачного каталога где было создано публичное соединение.
      * `region_id` — регион облака в котором создано публичное соединение.
      * `trunk_connection_id` — идентификатор транкового подключения к которому относится данное публичное соединение.
      * `vlan_id` — идентификатор VLAN для данного публичного соединения.
      * параметры IP и BGP связности для стыковой подсети данного публичного соединения:
         * `peering_subnet` — [стыковая подсеть](../../interconnect/concepts/pub-con.md#pub-address) для BGP-пиринга.
         * `peer_ip` — IP адрес из стыковой (пиринговой) подсети на оборудовании клиента.
         * `cloud_ip` — IP адрес из стыковой (пиринговой) подсети на оборудовании {{ yandex-cloud }}.
         * `peer_bgp_asn` — номер [BGP ASN](../../interconnect/concepts/priv-con.md#bgp-asn) на оборудовании клиента.
         * `cloud_bgp_asn` — номер BGP ASN на оборудовании {{ yandex-cloud }}.
      * `ipv4_allowed_service_types` — список идентификаторов сервисов, IP префиксы которых анонсируются в данном публичном соединении.
      * `ipv4_peer_announced_prefixes` — список клиентских IP префиксов (если они есть), от которых будет приниматься трафик в данное публичное соединение. 

{% endlist %}
