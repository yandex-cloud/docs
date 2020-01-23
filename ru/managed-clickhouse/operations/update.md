# Изменение настроек кластера

После создания кластера вы можете:

* [Изменить класс хостов](#change-resource-preset).

* [Увеличить размер хранилища](#change-disk-size) (доступно только для сетевого хранилища, `network-hdd` и `network-ssd`).

* [Настраивать серверы](#change-clickhouse-config) {{ CH }} согласно [документации {{ CH }}](https://clickhouse.yandex/docs/ru/operations/server_settings/settings/).


## Изменить класс хостов {#change-resource-preset}

{% list tabs %}

- CLI
  
  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  Чтобы изменить [класс хостов](../concepts/instance-types.md) для кластера:
  
  1. Посмотрите описание команды CLI для изменения кластера:
  
     ```
     $ {{ yc-mdb-ch }} cluster update --help
     ```
  
  1. Запросите список доступных классов хостов (в колонке `ZONES` указаны зоны доступности, в которых можно выбрать соответствующий класс):
  
     {% if audience != "internal" %}
     
     ```bash
     $ {{ yc-mdb-ch }} resource-preset list
     
     +-----------+--------------------------------+-------+----------+
     |    ID     |            ZONE IDS            | CORES |  MEMORY  |
     +-----------+--------------------------------+-------+----------+
     | s1.nano   | ru-central1-a, ru-central1-b,  |     1 | 4.0 GB   |
     |           | ru-central1-c                  |       |          |
     | s1.micro  | ru-central1-a, ru-central1-b,  |     2 | 8.0 GB   |
     |           | ru-central1-c                  |       |          |
     | ...                                                           |
     +-----------+--------------------------------+-------+----------+
     ```
     
     {% else %}
     
     ```bash
     $ {{ yc-mdb-ch }} resource-preset list
     
     +------------+---------------+-------+----------+
     |     ID     |   ZONE IDS    | CORES |  MEMORY  |
     +------------+---------------+-------+----------+
     | db1.nano   | man, sas, vla |     1 | 2.0 GB   |
     | db1.micro  | man, sas, vla |     1 | 8.0 GB   |
     | db1.small  | man, sas, vla |     2 | 16.0 GB  |
     | db1.medium | man, sas, vla |     4 | 32.0 GB  |
     | db1.large  | man, sas, vla |     8 | 64.0 GB  |
     | db1.xlarge | man, sas, vla |    16 | 128.0 GB |
     +------------+---------------+-------+----------+
     ```
     
     {% endif %}
  
  3. Укажите нужный класс в команде изменения кластера:
  
     ```
     $ {{ yc-mdb-ch }} cluster update <имя кластера>
          --clickhouse-resource-preset <ID класса>
     ```
     
     {{ mch-short-name }} запустит операцию изменения класса хостов для кластера.
     
     Для хоста {{ZK}} класс можно задать в аналогичном параметре, `--zookeeper-resource-preset`.
  
- API
  
  Изменить [класс хостов](../concepts/instance-types.md) кластера можно с помощью метода API [update](../api-ref/Cluster/update.md): передайте в запросе нужные значения в параметре `configSpec.clickhouse.resources.resourcePresetId` (для ZooKeeper — `configSpec.zookeeper.resources.resourcePresetId`).
  
  Список поддерживаемых значений запрашивайте методом [list](../api-ref/ResourcePreset/list.md) для ресурсов `ResourcePreset`.
  
{% endlist %}


## Увеличить размер хранилища {#change-disk-size}

{% list tabs %}

- CLI
  
  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  Чтобы увеличить размер хранилища для кластера:
  
  {% if audience != "internal" %}
  
  1. Проверьте, что нужный кластер использует именно сетевое хранилище (увеличить размер локального хранилища пока невозможно). Для этого запросите информацию о кластере и найдите поле `disk_type_id` — его значение должно быть `network-hdd` или `network-ssd`:
  
     ```
     $ {{ yc-mdb-ch }} cluster get <имя кластера>
     
     id: c7qkvr3u78qiopj3u4k2
     folder_id: b1g0ftj57rrjk9thribv
     ...
     config:
       clickhouse:
         resources:
           resource_preset_id: s1.nano
           disk_size: "21474836480"
           disk_type_id: network-ssd
     ...
     ```
     
  {% endif %}
  
  1. Посмотрите описание команды CLI для изменения кластера:
  
     ```
     $ {{ yc-mdb-ch }} cluster update --help
     ```

  1. Проверьте, что в облаке хватает квоты на увеличение хранилища: откройте страницу [Квоты]({{ link-console-quotas }}) для вашего облака и проверьте, что в секции {{ mch-full-name }} не исчерпано место в строке **space**.

  1. Укажите нужный объем хранилища в команде изменения кластера (должен быть не меньше, чем значение `disk_size` в свойствах кластера):
  
     ```
     $ {{ yc-mdb-ch }} cluster update <имя кластера>
          --clickhouse-disk-size <размер хранилища в ГБ>
     ```
     
     Если все условия выполнены, {{ mch-short-name }} запустит операцию по увеличению объема хранилища.
     
     Объем хранилища для ZooKeeper можно изменить аналогичным параметром, `--zookeeper-disk-size`.
  
- API
  
  Изменить размер хранилища для кластера можно с помощью метода API [update](../api-ref/Cluster/update.md): передайте в запросе нужные значения в параметре `configSpec.clickhouse.resources.diskSize` (для ZooKeeper — `configSpec.zookeeper.resources.diskSize`).
  
  Проверьте, что в облаке хватает квоты на увеличение хранилища: откройте страницу [Квоты]({{link-console-quotas}}) для вашего облака и проверьте, что в секции {{ mch-full-name }} не исчерпано место в строке **space**.
  
{% endlist %}



## Изменить настройки {{ CH }} {#change-clickhouse-config}

Вы можете изменить настройки СУБД для хостов вашего кластера.

{% list tabs %}

- Консоль управления

  1. Перейдите на страницу каталога и выберите сервис **{{ mch-name }}**.
  1. Выберите кластер и нажмите кнопку **Изменить кластер** на панели сверху.
  1. Нажмите кнопку **Настроить** в блоке **Настройки СУБД**. 
  1. Настройте параметры кластера:
  
     {% include [mch-additional-properties](../../_includes/mdb/mch-additional-properties.md) %}
    
  1. Нажмите кнопку **Сохранить**.


- API
  
  Изменить настройки СУБД для кластера можно с помощью метода API [update](../api-ref/Cluster/update.md): передайте в запросе нужные значения в параметре `configSpec.clickhouse.config`. Все поддерживаемые настройки описаны [в справочнике API](../api-ref/Cluster/update.md).
  
{% endlist %}
