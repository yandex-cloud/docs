---
title: Как получить информацию о транковых подключениях в {{ interconnect-name }}
---

# Получить информацию о транковых подключениях

{% include [cic-api-access](../../_includes/interconnect/cic-api-access.md) %}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для получения информации о [транковых подключениях](../concepts/trunk.md):

      ```bash
      yc cic trunk get --help
      ```

  1. Получите список транковых подключений в указанном каталоге:

      ```bash
      yc cic trunk list --folder-id b1gqf2hjizv2jwj4dnga 
      ```

      Результат:

      ```text
      +----------------------+--------------------+----------------------------+------------------+----------+
      |          ID          |        NAME        | POINT OF PRESENCE ID (POP) | TRANSCEIVER TYPE | CAPACITY |
      +----------------------+--------------------+----------------------------+------------------+----------+
      | euuqqctbrflq3ir4n4p2 | customer-name-m9   | ru-msk-m9-0                | 10GBASE-LR       | 5 GBPS   |
      | euuvdjl5shd0fv7bqt38 | customer-name-ost  | ru-msk-ost-0               | 10GBASE-LR       | 5 GBPS   |
      +----------------------+--------------------+----------------------------+------------------+----------+
      ```

  1. Получите информацию о транковом подключении, указав его идентификатор, полученный на предыдущем шаге:

      ```bash
      # yc cic trunk get <ID транка>
      yc cic trunk get euuqqctbrflq3ir4n4p2
      ```

      Результат:

      ```yml
      id: euuqqctbrflq3ir4n4p2
      name: customer-name-m9
      folder_id: b1gqf2hjizv2jwj4dnga
      region_id: ru-central1
      single_port_direct_joint:
        transceiver_type: TRANSCEIVER_TYPE_10GBASE_LR
        port_name: 25GE1/0/2
        access_device_name: m9-cicext1
      point_of_presence_id: ru-msk-m9-0
      capacity: CAPACITY_5_GBPS
      ```

      где,
      * `id` - идентификатор транкового подключения.
      * `name` - название транкового подключения.
      * `folder_id` - идентификатор облачного каталога в котором было создано транковое подключение.
      * `region_id` - регион облака в котором создано транковое подключение.
      * Тип транкового подключения:
        * `single_port_direct_joint` - прямое транковое подключение:
           * `transceiver_type` - тип используемого [трансивера](../concepts/transceivers.md).
           * `port_name` - номер порта (портов), которые выделены на сетевом устройстве для транкового подключения.
           * `access_device_name` - имя сетевого устройства на котором были выделены порты для транкового подключения.
        * `lag_direct_joint` - агрегированное (LAG) прямое транковое подключение:
           * `transceiver_type` - тип используемого [трансивера](../concepts/transceivers.md).
           * `lag_id` - идентификатор агрегированного подключения.
           * `port_names` - список физических портов в LAG.
        * `partner_joint_info` - партнерское транковое подключение:
           * `partner_id` - идентификатор партнера.
           * `service_key` - сервисный ключ для партнерского транкового подключения.
      * `point_of_presence_id` - идентификатор [точки присутствия](../concepts/pops.md).
      * `capacity` - величина [пакета трафика](../concepts/capacity.md) для данного транкового подключения. 

{% endlist %}
