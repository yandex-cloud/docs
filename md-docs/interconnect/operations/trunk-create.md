[Документация Yandex Cloud](../../index.md) > [Yandex Cloud Interconnect](../index.md) > [Пошаговые инструкции](index.md) > Создать транковое подключение

# Создать новое транковое подключение

## Создать прямое транковое подключение {#direct}

{% note info %}

Для выполнения операции необходима роль [cic.editor](../security/index.md#cic-editor).

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) на панели сверху нажмите ![layout-side-content-left](../../_assets/console-icons/layout-side-content-left.svg) или ![chevron-down](../../_assets/console-icons/chevron-down.svg) и выберите нужный [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Cloud Interconnect**.
  1. На панели слева выберите ![pipeline](../../_assets/console-icons/pipeline.svg) **Транковые подключения** и нажмите кнопку **Создать транковое подключение**. В открывшемся окне:

      1. В поле **Ёмкость подключения** задайте величину [пакета трафика](../concepts/capacity.md) для создаваемого транкового подключения.
      1. В поле **Точка присутствия** выберите нужную [точку присутствия](../concepts/pops.md).
      1. В поле **Тип подключения** выберите `Прямое`.
      1. В поле **Тип трансивера** выберите тип трансивера, который будет использоваться на стороне Cloud Interconnect. На вашем оборудовании должен быть совместимый трансивер.
      1. (Опционально) В блоке **Общая информация** задайте:

          * **Имя**. Требования к имени:

              * длина — от 3 до 63 символов;
              * может содержать строчные буквы латинского алфавита, цифры и дефисы;
              * первый символ — буква, последний — не дефис.

              Если не указать имя, подключению будет присвоено имя, идентичное [идентификатору](../../api-design-guide/concepts/resources-identification.md) этого подключения.
          * Произвольное **Описание** подключения.
          * [**Метки**](../../resource-manager/concepts/labels.md) подключения.
      1. Чтобы защитить создаваемое подключение от случайного удаления, включите опцию **Защита от удаления**.
      1. Нажмите кнопку **Создать**.

- CLI {#cli}

  1. Посмотрите описание команды CLI для создания [транкового подключения](../concepts/trunk.md):

      ```bash
      yc cic trunk-connection create --help
      ```

  1. Создайте прямое транковое подключение в указанном каталоге:

      
      ```bash
      yc cic trunk-connection create \
        --name trunk-m9 \
        --description "Trunk M9" \
        --pop ru-msk-m9-0 \
        --capacity 1-gbps \
        --trunk-options type=direct,transceiver=10GBASE-LR \
        --deletion-protection \
        --folder-id b1gt6g8ht345******** \
        --async
      ```

      Ожидаемый результат:

      ```text
      id: cf3dcodot14p********
      name: trunk-m9
      description: Trunk M9
      cloud_id: b1gia87mbaom********
      folder_id: b1gt6g8ht345********
      region_id: ru-central1
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

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) на панели сверху нажмите ![layout-side-content-left](../../_assets/console-icons/layout-side-content-left.svg) или ![chevron-down](../../_assets/console-icons/chevron-down.svg) и выберите нужный [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Cloud Interconnect**.
  1. На панели слева выберите ![pipeline](../../_assets/console-icons/pipeline.svg) **Транковые подключения** и нажмите кнопку **Создать транковое подключение**. В открывшемся окне:

      1. В поле **Ёмкость подключения** задайте величину [пакета трафика](../concepts/capacity.md) для создаваемого транкового подключения.
      1. В поле **Точка присутствия** выберите нужную [точку присутствия](../concepts/pops.md).
      1. В поле **Тип подключения** выберите `Через партнёра` и в появившемся списке выберите нужного партнера.

          Вы можете выбрать только тех партнеров, которые подходят по емкости подключения и точке присутствия.
      1. (Опционально) В блоке **Общая информация** задайте:

          * **Имя**. Требования к имени:

              * длина — от 3 до 63 символов;
              * может содержать строчные буквы латинского алфавита, цифры и дефисы;
              * первый символ — буква, последний — не дефис.

              Если не указать имя, подключению будет присвоено имя, идентичное [идентификатору](../../api-design-guide/concepts/resources-identification.md) этого подключения.
          * Произвольное **Описание** подключения.
          * [**Метки**](../../resource-manager/concepts/labels.md) подключения.
      1. Чтобы защитить создаваемое подключение от случайного удаления, включите опцию **Защита от удаления**.
      1. Нажмите кнопку **Создать**.
      1. Создайте [новое обращение в поддержку](https://center.yandex.cloud/support) для информирования партнера о созданном транковом подключении.
         
         Обращение должно быть оформлено следующим образом:
         
         ```text
         Тема: [CIC] Уведомление партнера partnerID о созданном
         транковом подключении Cloud Interconnect.
         
         Текст обращения: Прошу уведомить партнера о параметрах созданного 
         транкового подключения trunk_id: euus5dfgchu2********
         ```
         
         {% note info %}
         
         В процессе обработки обращения инженер поддержки отправит уведомление партнеру о созданном транковом подключении.
         
         Партнеру будут отправлены следующие данные: `partner_joint_id`, `partner_vlan_id`, `capacity` и `service_key`.
         
         {% endnote %}

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
      yc cic trunk-connection create \
        --name trunk-m9 \
        --description "Trunk M9" \
        --pop ru-msk-m9-0 \
        --capacity 500-mbps \
        --trunk-options type=partner,partner-id=partnerID \
        --folder-id b1gt6g8ht345******** \
        --async
      ```

      {% note info %}

      При создании указывается идентификатор партнера и не указывается тип трансивера.

      {% endnote %}

      Ожидаемый результат:

      ```text
      id: cf3dcodot14p********
      name: trunk-m9
      description: Trunk M9
      cloud_id: b1gia87mbaom********
      folder_id: b1gt6g8ht345********
      region_id: ru-central1
      created_at: "2025-03-25T10:54:46Z"
      partner_joint_info:
        partner_id: partnerID
        service_key: euuclbdga6je********
      point_of_presence_id: ru-msk-m9-0
      capacity: CAPACITY_500_MBPS
      status: ACTIVE
      ```
  1. Создайте [новое обращение в поддержку](https://center.yandex.cloud/support) для информирования партнера о созданном транковом подключении.
     
     Обращение должно быть оформлено следующим образом:
     
     ```text
     Тема: [CIC] Уведомление партнера partnerID о созданном
     транковом подключении Cloud Interconnect.
     
     Текст обращения: Прошу уведомить партнера о параметрах созданного 
     транкового подключения trunk_id: euus5dfgchu2********
     ```
     
     {% note info %}
     
     В процессе обработки обращения инженер поддержки отправит уведомление партнеру о созданном транковом подключении.
     
     Партнеру будут отправлены следующие данные: `partner_joint_id`, `partner_vlan_id`, `capacity` и `service_key`.
     
     {% endnote %}

{% endlist %}



## Создать агрегированное (LAG) прямое транковое подключение {#lag}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления](https://console.yandex.cloud) на панели сверху нажмите ![layout-side-content-left](../../_assets/console-icons/layout-side-content-left.svg) или ![chevron-down](../../_assets/console-icons/chevron-down.svg) и выберите нужный [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder).
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **Cloud Interconnect**.
  1. На панели слева выберите ![pipeline](../../_assets/console-icons/pipeline.svg) **Транковые подключения** и нажмите кнопку **Создать транковое подключение**. В открывшемся окне:

      1. В поле **Ёмкость подключения** задайте величину [пакета трафика](../concepts/capacity.md) для создаваемого транкового подключения.
      1. В поле **Точка присутствия** выберите нужную [точку присутствия](../concepts/pops.md).
      1. В поле **Тип подключения** выберите `Прямое`.
      1. Чтобы использовать [агрегирование](../concepts/trunk.md#lag) каналов связи с помощью [протокола LACP](https://en.wikipedia.org/wiki/Link_aggregation#Link_Aggregation_Control_Protocol), включите опцию **LAG** и в появившемся поле **Количество портов** задайте количество сетевых портов, которые будут добавлены в группу агрегирования. В группу вы можете добавить до десяти сетевых портов.
      1. В поле **Тип трансивера** выберите тип трансивера, который будет использоваться на стороне Cloud Interconnect. На вашем оборудовании должен быть совместимый трансивер.

          При использовании агрегирования все физические порты в группе агрегирования должны использовать [трансиверы](../concepts/transceivers.md) только одного типа.
      1. (Опционально) В блоке **Общая информация** задайте:

          * **Имя**. Требования к имени:

              * длина — от 3 до 63 символов;
              * может содержать строчные буквы латинского алфавита, цифры и дефисы;
              * первый символ — буква, последний — не дефис.

              Если не указать имя, подключению будет присвоено имя, идентичное [идентификатору](../../api-design-guide/concepts/resources-identification.md) этого подключения.
          * Произвольное **Описание** подключения.
          * [**Метки**](../../resource-manager/concepts/labels.md) подключения.
      1. Чтобы защитить создаваемое подключение от случайного удаления, включите опцию **Защита от удаления**.
      1. Нажмите кнопку **Создать**.

- CLI {#cli}

  1. Посмотрите описание команды CLI для создания [транкового подключения](../concepts/trunk.md):

      ```bash
      yc cic trunk-connection create --help
      ```

  1. Создайте агрегированное (LAG) прямое транковое подключение в указанном каталоге:

      ```bash
      yc cic trunk-connection create \
        --name trunk-m9 \
        --description "Trunk M9" \
        --pop ru-msk-m9-0 \
        --capacity 1-gbps \
        --trunk-options type=lag,transceiver=10GBASE-LR,size=2 \
        --folder-id b1gt6g8ht345******** \
        --async
      ```

      {% note info %}

      При создании указывается тип трансивера и количество портов в агрегированном транке.

      {% endnote %}

      Ожидаемый результат:

      ```text
      id: cf3dcodot14p********
      name: trunk-m9
      description: Trunk M9
      cloud_id: b1gia87mbaom********
      folder_id: b1gt6g8ht345********
      region_id: ru-central1
      created_at: "2025-03-25T10:54:46Z"
      lag_direct_joint:
        lag_id: 15
        transceiver_type: TRANSCEIVER_TYPE_10GBASE_LR
        port_names: 10GE1/0/1, 10GE1/0/2 
      point_of_presence_id: ru-msk-m9-0
      capacity: CAPACITY_1_GBPS
      status: ACTIVE
      ```

{% endlist %}