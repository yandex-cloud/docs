# Получить информацию о транковых подключениях

{% note info %}

Для выполнения операции необходима роль [cic.viewer](../security/index.md#cic-viewer).

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) на панели сверху нажмите ![layout-side-content-left](../../_assets/console-icons/layout-side-content-left.svg) или ![chevron-down](../../_assets/console-icons/chevron-down.svg) и выберите нужный [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.ui.constants.label_interconnect_aUMcv }}**.
  1. На панели слева выберите ![pipeline](../../_assets/console-icons/pipeline.svg) **{{ ui-key.yacloud.interconnect.trunk-connection.trunk-connections_kBGNL }}**. В открывшемся окне будет представлен список всех транковых подключений в выбранном каталоге.
  1. Чтобы посмотреть подробную информацию об определенном транковом подключении, нажмите на соответствующую строку в списке. В открывшемся окне приведены следующие сведения:

      * На вкладке ![flag](../../_assets/console-icons/flag.svg) **{{ ui-key.yacloud.common.overview }}** — общие сведения о подключении: имя, идентификатор, статус, емкость, тип, точка присутствия, партнер {{ interconnect-name }} и тип трансивера.
      * На вкладке ![nodes-left](../../_assets/console-icons/nodes-left.svg) **{{ ui-key.yacloud.interconnect.private-connection.private-connections_daeaR }}** — список [приватных соединений](../concepts/priv-con.md) в данном транковом подключении.
      * На вкладке ![globe](../../_assets/console-icons/globe.svg) **{{ ui-key.yacloud.interconnect.public-connection.public-connections_7xYcV }}** — список [публичных соединений](../concepts/pub-con.md) в данном транковом подключении.
      * На вкладке ![display-pulse](../../_assets/console-icons/display-pulse.svg) **{{ ui-key.yacloud.common.monitoring }}** — [виджеты](../../monitoring/concepts/visualization/widget.md) {{ monitoring-full-name }}, позволяющие отслеживать состояние транкового подключения.
      * На вкладке ![list-check](../../_assets/console-icons/list-check.svg) **{{ ui-key.yacloud.common.operations-key-value }}** — список [операций](../../api-design-guide/concepts/about-async.md) с транковым подключением.

- CLI {#cli}

  1. Посмотрите описание команды CLI для получения информации о [транковых подключениях](../concepts/trunk.md):

      ```bash
      yc cic trunk get --help
      ```

  1. Получите список транковых подключений в указанном каталоге:

      ```bash
      yc cic trunk list --folder-id b1gt6g8ht345********
      ```

      Результат:

            
      ```text
      +----------------------+--------------------+----------------------------+------------------+----------+
      |          ID          |        NAME        | POINT OF PRESENCE ID (POP) | TRANSCEIVER TYPE | CAPACITY |
      +----------------------+--------------------+----------------------------+------------------+----------+
      | cf3dcodot14p******** | customer-name-m9   | ru-msk-m9-0                | 10GBASE-LR       | 1 GBPS   |
      | cf8hgt6sk1g8******** | customer-name-ost  | ru-msk-ost-0               | 10GBASE-LR       | 1 GBPS   |
      +----------------------+--------------------+----------------------------+------------------+----------+
      ```




  1. Получите информацию о транковом подключении, указав его идентификатор, полученный на предыдущем шаге:

      ```bash
      yc cic trunk get cf3dcodot14p********
      ```

      Результат:

      
      ```yml
      - id: cf3dcodot14p********
        name: customer-name-m9
        description: Trunk M9
        cloud_id: b1gia87mbaom********
        folder_id: b1gt6g8ht345********
        region_id: {{ region-id }}
        created_at: "2025-03-25T10:54:46Z"
        single_port_direct_joint:
          transceiver_type: TRANSCEIVER_TYPE_10GBASE_LR
          port_name: 25GE1/0/12
        point_of_presence_id: ru-msk-m9-0
        capacity: CAPACITY_1_GBPS
        status: ACTIVE
      ```



      Где:

      * `id` — идентификатор транкового подключения.
      * `name` — название транкового подключения.
      * `description` — описание транкового подключения.
      * `cloud_id` — идентификатор облака, в каталоге которого было создано транковое подключение.
      * `folder_id` — идентификатор облачного каталога в котором было создано транковое подключение.
      * `region_id` — регион облака в котором создано транковое подключение.
      * Тип транкового подключения:
        * `single_port_direct_joint` — прямое транковое подключение:
           * `transceiver_type` — тип используемого [трансивера](../concepts/transceivers.md).
           * `port_name` — номер порта (портов), которые выделены на сетевом устройстве для транкового подключения.
           * `access_device_name` — имя сетевого устройства на котором были выделены порты для транкового подключения.
        * `lag_direct_joint` — агрегированное (LAG) прямое транковое подключение:
           * `transceiver_type` — тип используемого [трансивера](../concepts/transceivers.md).
           * `lag_id` — идентификатор агрегированного подключения.
           * `port_names` — список физических портов в LAG.
        * `partner_joint_info` — транковое подключение через партнера:
           * `partner_id` — идентификатор партнера.
           * `service_key` — сервисный ключ для транкового подключения через партнера.
      * `point_of_presence_id` — идентификатор [точки присутствия](../concepts/pops.md).
      * `capacity` — величина [пакета трафика](../concepts/capacity.md) для данного транкового подключения. 
      * `status` — состояние транкового подключения. Целевое состояние — `ACTIVE`.
      * `created_at` — дата и время создания транкового подключения.

{% endlist %}