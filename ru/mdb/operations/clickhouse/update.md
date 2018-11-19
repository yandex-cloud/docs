# Изменение настроек кластера

После создания кластера вы можете:

- Изменить [класс хостов](../../concepts/instance-types.md).
- Увеличить размер хранилища (доступно только для сетевого хранилища, `network-nvme`).
- Изменить имя кластера.
- Настраивать серверы [!KEYREF CH] согласно [документации [!KEYREF CH]](https://clickhouse.yandex/docs/ru/operations/server_settings/settings/).


## Изменить класс хостов

---

**[!TAB CLI]**

[!INCLUDE [cli-install](../../../_includes/cli-install.md)]

[!INCLUDE [default-catalogue](../../../_includes/default-catalogue.md)]

Чтобы изменить класс хостов для кластера:

1. Посмотрите описание команды CLI для изменения кластера:

   ```
   $ [yc-mdb-ch] cluster update --help
   ```

1. Запросите список доступных классов хостов (в колонке `FOLDER ID` указаны зоны доступности, в которых можно выбрать соответствующий класс):

   ```
   $ [yc-mdb-ch] resource-preset list
   
   +-----------+--------------------------------+-------+--------------+
   |    ID     |           FOLDER ID            | CORES |    MEMORY    |
   +-----------+--------------------------------+-------+--------------+
   | s1.nano   | ru-central1-a, ru-central1-b,  |     1 |   4294967296 |
   |           | ru-central1-c                  |       |              |
   | s1.micro  | ru-central1-a, ru-central1-b,  |     2 |   8589934592 |
   |           | ru-central1-c                  |       |              |
   | s1.small  | ru-central1-a, ru-central1-b,  |     4 |  17179869184 |
   |           | ru-central1-c                  |       |              |
   | s1.medium | ru-central1-a, ru-central1-b,  |     8 |  34359738368 |
   |           | ru-central1-c                  |       |              |
   | s1.large  | ru-central1-a, ru-central1-b,  |    16 |  68719476736 |
   |           | ru-central1-c                  |       |              |
   | s1.xlarge | ru-central1-a, ru-central1-b,  |    32 | 137438953472 |
   |           | ru-central1-c                  |       |              |
   +-----------+--------------------------------+-------+--------------+
   ```   

1. Укажите нужный класс в команде изменения кластера:

   ```
   $ [yc-mdb-ch] cluster update <имя кластера>
        --clickhouse-resource-preset <ID класса>
   ```

---


## Увеличить размер хранилища

---

**[!TAB CLI]**

[!INCLUDE [cli-install](../../../_includes/cli-install.md)]

[!INCLUDE [default-catalogue](../../../_includes/default-catalogue.md)]

Чтобы увеличить размер хранилища для кластера:

1. Посмотрите описание команды CLI для изменения кластера:

   ```
   $ [yc-mdb-ch] cluster update --help
   ```

1. Проверьте, что у вас хватает квоты на увеличение хранилища: откройте [страницу Квоты](https://console.cloud.yandex.ru/?section=quotas) для вашего облака и проверьте, что в секции [!KEYREF mdb-full-name] не исчерпано место в строке **space**.

1. Проверьте, что нужный кластер использует именно сетевое хранилище (увеличить размер локального хранилища пока невозможно). Для этого запросите информацию о кластере и найдите поле `disk_type_id` — его значение должно быть `network-nvme`:

   ```
   $ [yc-mdb-ch] cluster get <имя кластера>
   
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
   $ [yc-mdb-ch] cluster update <имя кластера>
        --clickhouse-disk-size <размер хранилища в ГБ>
   ```
   
   Если все условия выполнены, [!KEYREF mdb-short-name] запустит операцию по увеличению объема хранилища. 
---