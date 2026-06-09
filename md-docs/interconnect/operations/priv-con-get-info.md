# Получить информацию о приватном соединении

{% note info %}

Для выполнения операции необходима роль [cic.viewer](../security/index.md#cic-viewer).

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) на панели сверху нажмите ![layout-side-content-left](../../_assets/console-icons/layout-side-content-left.svg) или ![chevron-down](../../_assets/console-icons/chevron-down.svg) и выберите нужный [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.ui.constants.label_interconnect_aUMcv }}**.
  1. На панели слева выберите ![nodes-left](../../_assets/console-icons/nodes-left.svg) **{{ ui-key.yacloud.interconnect.private-connection.private-connections_daeaR }}**. В открывшемся окне будет представлен список всех приватных соединений в выбранном каталоге.
  1. Чтобы посмотреть подробную информацию об определенном приватном соединении, нажмите на соответствующую строку в списке.

- CLI {#cli}

  1. Посмотрите описание команды CLI для получения информации о [приватном соединении](../concepts/priv-con.md):

      ```bash
      yc cic private-connection get --help
      ```

  1. Получите список приватных соединений в указанном каталоге:

      ```bash
      yc cic private-connection list --folder-id b1gt6g8ht345********
      ```

      Результат:

      ```text
      +----------------------+--------------------+----------------------+
      |          ID          |        NAME        | TRUNK CONNECTION ID  |
      +----------------------+--------------------+----------------------+
      | euuiog88zphg******** | customer-name-prc1 | euuqqctbrflq******** |
      | euucr7p47329******** | customer-name-prc2 | euuvdjl5shd0******** |
      +----------------------+--------------------+----------------------+      
      ```

  1. Получите информацию о приватном соединении, указав его идентификатор, полученный на предыдущем шаге:

      ```bash
      yc cic private-connection get euuiog88zphg********
      ```

      Результат:

      ```yml
      id: euuiog88zphg********
      name: customer-name-prc1
      folder_id: b1gt6g8ht345********
      region_id: {{ region-id }}
      trunk_connection_id: euuqqctbrflq********
      vlan_id: "1531"
      ipv4_peering:
        peering_subnet: 10.211.10.0/30
        peer_ip: 10.211.10.1
        cloud_ip: 10.211.10.2
        peer_bgp_asn: "64515"
        cloud_bgp_asn: "{{ cic-bgp-asn }}"
      ```

      Где:

      * `id` — идентификатор приватного соединения.
      * `name` — название приватного соединения.
      * `folder_id` — идентификатор облачного каталога в котором создано приватное соединение.
      * `region_id` — регион облака в котором создано приватное соединение.
      * `trunk_connection_id` — идентификатор транкового подключения к которому относится данное приватное соединение.
      * `vlan_id` — идентификатор VLAN для данного приватного соединения.
      * параметры IP и BGP связности для стыковой подсети данного приватного соединения:
         * `peering_subnet` — [стыковая подсеть](../concepts/priv-con.md#priv-address) для BGP-пиринга.
         * `peer_ip` — IP адрес из стыковой (пиринговой) подсети на оборудовании клиента.
         * `cloud_ip` — IP адрес из стыковой (пиринговой) подсети на оборудовании {{ yandex-cloud }}.
         * `peer_bgp_asn` — номер [BGP ASN](../concepts/priv-con.md#bgp-asn) на оборудовании клиента.
         * `cloud_bgp_asn` — номер BGP ASN на оборудовании {{ yandex-cloud }}.

{% endlist %}