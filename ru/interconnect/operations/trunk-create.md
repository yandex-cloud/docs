---
title: Как создать транковое подключение в {{ interconnect-name }}
description: Следуя этой инструкции, вы сможете создать транковое подключение в {{ interconnect-name }}.
---

# Создать новое транковое подключение

{% include [cic-cr-access](../../_includes/interconnect/cic-cr-access.md) %}

## Создать прямое транковое подключение {#direct}

{% note info %}

Для выполнения операции необходима роль [cic.editor](../security/index.md#cic-editor).

{% endnote %}

{% list tabs group=instructions %}

- CLI {#cli}

  1. Посмотрите описание команды CLI для создания [транкового подключения](../concepts/trunk.md):

      ```bash
      yc cic trunk-connection create --help
      ```

  1. Создайте прямое транковое подключение в указанном каталоге:

      
      ```bash
      yc cic trunk-connection create --name trunk-m9 \
        --description "Trunk M9" \ 
        --pop ru-msk-m9-0 \
        --capacity 1-gbps \
        --trunk-options type=direct,transceiver=10GBASE-LR \ 
        --deletion-protection \
        --folder-id b1gqf**********jiz2w \
        --async
      ```

      Ожидаемый результат:

      ```text
      id: cf3td**********nufvr
      name: trunk-m9
      description: Trunk M9
      cloud_id: b1g7a**********kd23p
      folder_id: b1gqf**********jiz2w
      region_id: {{ region-id }}
      created_at: "2025-03-25T10:54:46Z"
      single_port_direct_joint:
        transceiver_type: TRANSCEIVER_TYPE_10GBASE_LR
        port_name: 25GE1/0/12
      point_of_presence_id: ru-msk-m9-0
      capacity: CAPACITY_1_GBPS
      status: ACTIVE
      ```



      где,
      * `id` — идентификатор транкового подключения.
      * `name` — название транкового подключения.
      * `description` — описание транкового подключения.
      * `cloud_id` — идентификатор облака, в каталоге которого было создано транковое подключение.
      * `folder_id` — идентификатор облачного каталога, в котором было создано транковое подключение.
      * `region_id` — регион облака, в котором создано транковое подключение.
      * Тип транкового подключения:
        * `single_port_direct_joint` — прямое транковое подключение:
           * `transceiver_type` — тип используемого [трансивера](../concepts/transceivers.md).
           * `port_name` — номер порта (портов), выделенных на сетевом устройстве для транкового подключения.
           * `access_device_name` — имя сетевого устройства, на котором были выделены порты для транкового подключения.
        * `lag_direct_joint` — агрегированное (LAG) прямое транковое подключение:
           * `transceiver_type` — тип используемого [трансивера](../concepts/transceivers.md).
           * `lag_id` — идентификатор агрегированного подключения.
           * `port_names` — список физических портов в LAG.
        * `partner_joint_info` — транковое подключение через партнера:
           * `partner_id` — идентификатор партнера.
           * `service_key` — сервисный ключ для транкового подключения через партнера.
      * `point_of_presence_id` — идентификатор [точки присутствия](../concepts/pops.md). При создании транка нужное значение необходимо выбрать из столбца «Метка» [таблицы](../concepts/pops.md).
      * `capacity` — величина [пакета трафика](../concepts/capacity.md) для данного транкового подключения. При создании транка нужное значение необходимо выбрать из столбца «Метка» [таблицы](../concepts/capacity.md).
      * `status` — состояние ресурса. Целевое состояние — `ACTIVE`.
      * `created_at` — дата и время создания ресурса.
      * `deletion-protection` — защита ресурса от случайного удаления. Ресурс невозможно будет удалить без предварительного снятия этого флага.
      * `async` — выполнение операции в асинхронном режиме. Рекомендуется все операции по изменению состояния ресурса выполнять в этом режиме.

{% endlist %}



## Создать транковое подключение через партнера {#partner}

{% list tabs group=instructions %}

- CLI {#cli}

  1. Посмотрите описание команды CLI для создания [транкового подключения](../concepts/trunk.md):

      ```bash
      yc cic trunk-connection create --help
      ```

  1. Получите идентификатор нужного партнерского соединения (`ID`):

      ```bash
      yc cic partner list
      ``` 

  1. Создайте транковое подключение через партнера в указанном каталоге:

      ```bash
      yc cic trunk-connection create --name trunk-m9 \
        --description "Trunk M9" \
        --pop ru-msk-m9-0 \
        --capacity 500-mbps \
        --trunk-options type=partner,partner-id=partnerID \
        --folder-id b1gqf**********jiz2w \
        --async
      ```

      {% note info %}

      При создании указывается идентификатор партнера и не указывается тип трансивера.

      {% endnote %}

      Ожидаемый результат:

      ```text
      id: cf3td**********nufvr
      name: trunk-m9
      description: Trunk M9
      cloud_id: b1g7a**********kd23p
      folder_id: b1gqf**********jiz2w
      region_id: ru-central1
      created_at: "2025-03-25T10:54:46Z"
      partner_joint_info:
        partner_id: partnerID
        service_key: euucl**********bdga6
      point_of_presence_id: ru-msk-m9-0
      capacity: CAPACITY_500_MBPS
      status: ACTIVE
      ```

  1. Создайте [новое обращение в поддержку]({{ link-console-support }}) для информирования партнера о созданном транковом подключении.

      Обращение должно быть оформлено следующим образом:

      ```text
      Тема: [CIC] Уведомление партнера partnerID о созданном
      транковом подключении Cloud Interconnect.

      Текст обращения: Прошу уведомить партнера о параметрах созданного 
      транкового подключения trunk_id: euus5dfgchu2********
      ```

      {% note info %}

      В процессе обработки обращения, инженер поддержки отправит уведомление партнеру о созданном транковом подключении. 

      Партнеру будут отправлены следующие данные: `partner_joint_id`, `partner_vlan_id`, `capacity` и `service_key`.

      {% endnote %}

{% endlist %}

