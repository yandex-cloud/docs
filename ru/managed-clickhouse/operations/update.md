# Изменение настроек кластера

После создания кластера вы можете:

* [Изменить класс хостов](#change-resource-preset).

* [Увеличить размер хранилища](#change-disk-size) (доступно только для сетевого хранилища, `network-hdd` и `network-ssd`).

* [Настроить серверы](#change-clickhouse-config) {{ CH }} согласно [документации {{ CH }}](https://clickhouse.yandex/docs/ru/operations/server_settings/settings/).

* [Изменить дополнительные настройки кластера](#change-additional-settings).

## Изменить класс хостов {#change-resource-preset}

{% list tabs %}

- Консоль управления

  1. Перейдите на страницу каталога и выберите сервис **{{ mch-name }}**.
  1. Выберите кластер и нажмите кнопку **Изменить кластер** на панели сверху.
  1. Чтобы изменить класс хостов {{ CH }}, в блоке **Класс хоста** выберите нужный класс.
  1. Чтобы изменить класс хостов {{ ZK }}:

      1. Нажмите кнопку **Настроить {{ ZK }}**.

      1. В блоке **Класс хоста {{ ZK }}** выберите нужный класс для хоста {{ ZK }}.

  1. Нажмите кнопку **Сохранить изменения**.

  {% note info %}

  Изменить класс хостов {{ ZK }} можно только если для кластера [включена отказоустойчивость](zk-hosts.md#add-zk).

  {% endnote %}

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы изменить [класс хостов](../concepts/instance-types.md) для кластера:

  1. Посмотрите описание команды CLI для изменения кластера:

     ```
     $ {{ yc-mdb-ch }} cluster update --help
     ```

  1. Запросите список доступных классов хостов (в колонке `ZONES` указаны зоны доступности, в которых можно выбрать соответствующий класс):


     ```bash
     $ {{ yc-mdb-ch }} resource-preset list

     +-----------+--------------------------------+-------+----------+
     |    ID     |            ZONE IDS            | CORES |  MEMORY  |
     +-----------+--------------------------------+-------+----------+
     | s1.micro  | ru-central1-a, ru-central1-b,  |     2 | 8.0 GB   |
     |           | ru-central1-c                  |       |          |
     | ...                                                           |
     +-----------+--------------------------------+-------+----------+
     ```

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

- Консоль управления

  1. Перейдите на страницу каталога и выберите сервис **{{ mch-name }}**.
  1. Выберите кластер и нажмите кнопку **Изменить кластер** на панели сверху.
  1. В разделе **Размер хранилища** укажите необходимое значение.
  1. Нажмите кнопку **Сохранить изменения**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы увеличить размер хранилища для кластера:


  1. Проверьте, что нужный кластер использует именно сетевое хранилище (увеличить размер локального хранилища пока невозможно). Для этого запросите информацию о кластере и найдите поле `disk_type_id` — его значение должно быть `network-hdd` или `network-ssd`:

     ```
     $ {{ yc-mdb-ch }} cluster get <имя кластера>

     id: c7qkvr3u78qiopj3u4k2
     folder_id: b1g0ftj57rrjk9thribv
     ...
     config:
       clickhouse:
         resources:
           resource_preset_id: s1.micro
           disk_size: "21474836480"
           disk_type_id: network-ssd
     ...
     ```

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

{% list tabs %}

- Консоль управления

  1. Перейдите на страницу каталога и выберите сервис **{{ mch-name }}**.
  1. Выберите кластер и нажмите кнопку **Изменить кластер** на панели сверху.
  1. Измените настройки {{ CH }}, нажав на кнопку **Настроить** в блоке **Настройки СУБД**:

     {% include [mch-additional-properties](../../_includes/mdb/mch-additional-properties.md) %}

  1. Нажмите кнопку **Сохранить изменения**.

- API

  Воспользуйтесь методом API [update](../api-ref/Cluster/update.md): передайте в запросе нужные значения в параметре `configSpec.clickhouse.config`.

  Все поддерживаемые настройки описаны [в справочнике API](../api-ref/Cluster/update.md).

{% endlist %}

## Изменить дополнительные настройки кластера {#change-additional-settings}

{% list tabs %}

- Консоль управления

  1. Перейдите на страницу каталога и выберите сервис **{{ mch-name }}**.
  1. Выберите кластер и нажмите кнопку **Изменить кластер** на панели сверху.
  1. Измените дополнительные настройки кластера:

     {% include [mch-extra-settings](../../_includes/mdb/mch-extra-settings-web-console.md) %}

  1. Нажмите кнопку **Сохранить изменения**.

- API

  Воспользуйтесь методом API [update](../api-ref/Cluster/update.md): передайте в запросе нужные значения в параметрах `configSpec.access` и `configSpec.backupWindowStart`.

  Все поддерживаемые настройки описаны [в справочнике API](../api-ref/Cluster/update.md).

{% endlist %}
