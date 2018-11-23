# Изменение настроек кластера

После создания кластера вы можете:

- [Изменить класс хостов](#change-resource-preset).
- [Увеличить размер хранилища](#change-disk-size) (доступно только для сетевого хранилища, `network-nvme`).
- [Настраивать серверы](#change-clickhouse-config) [!KEYREF CH] согласно [документации [!KEYREF CH]](https://clickhouse.yandex/docs/ru/operations/server_settings/settings/).


## Изменить класс хостов {#change-resource-preset}

---

**[!TAB CLI]**

[!INCLUDE [cli-install](../../_includes/cli-install.md)]

[!INCLUDE [default-catalogue](../../_includes/default-catalogue.md)]

Чтобы изменить [класс хостов](../concepts/instance-types.md) для кластера:

1. Посмотрите описание команды CLI для изменения кластера:

   ```
   $ [!KEYREF yc-mdb-ch] cluster update --help
   ```

1. Запросите список доступных классов хостов (в колонке `ZONES` указаны зоны доступности, в которых можно выбрать соответствующий класс):

   ```
   $ [!KEYREF yc-mdb-ch] resource-preset list
   
   +-----------+--------------------------------+-------+--------------+
   |    ID     |              ZONES             | CORES |    MEMORY    |
   +-----------+--------------------------------+-------+--------------+
   | s1.nano   | ru-central1-a, ru-central1-b,  |     1 |   4294967296 |
   |           | ru-central1-c                  |       |              |
   | s1.micro  | ru-central1-a, ru-central1-b,  |     2 |   8589934592 |
   |           | ru-central1-c                  |       |              |
   | ...                                                               |
   +-----------+--------------------------------+-------+--------------+
   ```   

1. Укажите нужный класс в команде изменения кластера:

   ```
   $ [!KEYREF yc-mdb-ch] cluster update <имя кластера>
        --clickhouse-resource-preset <ID класса>
   ```
   
   [!KEYREF mdb-short-name] запустит операцию изменения класса хостов для кластера.
   
   Класс хоста ZooKeeper можно изменить аналогичным параметром, `--zookeeper-resource-preset`.

**[!TAB API]**

Изменить [класс хостов](../concepts/instance-types.md) кластера можно с помощью метода API [update](../api-ref/Cluster/update.md): передайте в запросе нужные значения в параметре `configSpec.clickhouse.resources.resourcePresetId` (для ZooKeeper — `configSpec.zookeeper.resources.resourcePresetId`).

Список поддерживаемых значений запрашивайте методом [list](../api-ref/ResourcePreset/list.md) для ресурсов `ResourcePreset`.

---


## Увеличить размер хранилища {#change-disk-size}

---

**[!TAB CLI]**

[!INCLUDE [cli-install](../../_includes/cli-install.md)]

[!INCLUDE [default-catalogue](../../_includes/default-catalogue.md)]

Чтобы увеличить размер хранилища для кластера:

1. Посмотрите описание команды CLI для изменения кластера:

   ```
   $ [!KEYREF yc-mdb-ch] cluster update --help
   ```

1. Проверьте, что в облаке хватает квоты на увеличение хранилища: откройте страницу [Квоты](https://console.cloud.yandex.ru/?section=quotas) для вашего облака и проверьте, что в секции [!KEYREF mdb-full-name] не исчерпано место в строке **space**.

1. Проверьте, что нужный кластер использует именно сетевое хранилище (увеличить размер локального хранилища пока невозможно). Для этого запросите информацию о кластере и найдите поле `disk_type_id` — его значение должно быть `network-nvme`:

   ```
   $ [!KEYREF yc-mdb-ch] cluster get <имя кластера>
   
   id: c7qkvr3u78qiopj3u4k2
   folder_id: b1g0ftj57rrjk9thribv
   ...
   config:
     clickhouse:
       resources:
         resource_preset_id: s1.nano
         disk_size: "21474836480"
         disk_type_id: network-nvme
   ...
   ```

1. Укажите нужный объем хранилища в команде изменения кластера (должен быть не меньше, чем значение `disk_size` в свойствах кластера):

   ```
   $ [!KEYREF yc-mdb-ch] cluster update <имя кластера>
        --clickhouse-disk-size <размер хранилища в ГБ>
   ```
   
   Если все условия выполнены, [!KEYREF mdb-short-name] запустит операцию по увеличению объема хранилища.
   
   Объем хранилища для ZooKeeper можно изменить аналогичным параметром, `--zookeeper-disk-size`.

**[!TAB API]**

Изменить размер хранилища для кластера можно с помощью метода API [update](../api-ref/Cluster/update.md): передайте в запросе нужные значения в параметре `configSpec.clickhouse.resources.diskSize` (для ZooKeeper — `configSpec.zookeeper.resources.diskSize`).

Проверьте, что в облаке хватает квоты на увеличение хранилища: откройте страницу [Квоты](https://console.cloud.yandex.ru/?section=quotas) для вашего облака и проверьте, что в секции [!KEYREF mdb-full-name] не исчерпано место в строке **space**.

---


## Изменить настройки [!KEYREF CH] {#change-clickhouse-config}

Вы можете изменить настройки СУБД для хостов вашего кластера. Все поддерживаемые настройки описаны [в справочнике API](../api-ref/Cluster/update.md).

---

**[!TAB API]**

Изменить настройки СУБД для кластера можно с помощью метода API [update](../api-ref/Cluster/update.md): передайте в запросе нужные значения в параметре `configSpec.clickhouse.config`.

---
