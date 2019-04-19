# Изменение настроек кластера

После создания кластера вы можете:

* [Изменить класс хостов](#change-resource-preset).

* [Увеличить размер хранилища](#change-disk-size) (доступно только для сетевого хранилища, `network-hdd` и `network-nvme`).

* [Настраивать серверы](#change-postgresql-config) [!KEYREF MY] согласно [документации [!KEYREF MY]](https://www.postgresql.org/docs/10/runtime-config.html).


## Изменить класс хостов {#change-resource-preset}

---

**[!TAB CLI]**

[!INCLUDE [cli-install](../../_includes/cli-install.md)]

[!INCLUDE [default-catalogue](../../_includes/default-catalogue.md)]

Чтобы изменить [класс хостов](../concepts/instance-types.md) для кластера:

1. Посмотрите описание команды CLI для изменения кластера:

    ```
    $ [!KEYREF yc-mdb-my] cluster update --help
    ```

2. Запросите список доступных классов хостов (в колонке `ZONES` указаны зоны доступности, в которых можно выбрать соответствующий класс):

   ```
   $ [!KEYREF yc-mdb-my] resource-preset list
   
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

3. Укажите нужный класс в команде изменения кластера:

    ```
    $ [!KEYREF yc-mdb-my] cluster update <имя кластера>
         --resource-preset <ID класса>
    ```

    [!KEYREF mmy-short-name] запустит операцию изменения класса хостов для кластера.


**[!TAB API]**

Изменить [класс хостов](../concepts/instance-types.md) кластера можно с помощью метода API [update](../api-ref/Cluster/update.md): передайте в запросе нужное значение в параметре `configSpec.clickhouse.resources.resourcePresetId`.

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
    $ [!KEYREF yc-mdb-my] cluster update --help
    ```

2. Проверьте, что в облаке хватает квоты на увеличение хранилища: откройте страницу [Квоты](https://console.cloud.yandex.ru/?section=quotas) для вашего облака и проверьте, что в секции [!KEYREF mmy-full-name] не исчерпано место в строке **space**.

3. Проверьте, что нужный кластер использует именно сетевое хранилище (увеличить размер локального хранилища пока невозможно). Для этого запросите информацию о кластере и найдите поле `disk_type_id` — его значение должно быть `network-hdd` или `network-nvme`:

    ```
    $ [!KEYREF yc-mdb-my] cluster get <имя кластера>
    
    id: c7qkvr3u78qiopj3u4k2
    folder_id: b1g0ftj57rrjk9thribv
    ...
    config:
      ...
      resources:
        resource_preset_id: s1.nano
        disk_size: "10737418240"
        disk_type_id: network-nvme
    ...
    ```

4. Укажите нужный объем хранилища в команде изменения кластера (должен быть не меньше, чем значение `disk_size` в свойствах кластера):

    ```
    $ [!KEYREF yc-mdb-my] cluster update <имя кластера>
         --disk-size <размер хранилища в ГБ>
    ```

    Если все условия выполнены, [!KEYREF mmy-short-name] запустит операцию по увеличению объема хранилища.


**[!TAB API]**

Изменить размер хранилища для кластера можно с помощью метода API [update](../api-ref/Cluster/update.md): передайте в запросе нужные значения в параметре `configSpec.resources.diskSize`.

Проверьте, что в облаке хватает квоты на увеличение хранилища: откройте страницу [Квоты](https://console.cloud.yandex.ru/?section=quotas) для вашего облака и проверьте, что в секции [!KEYREF mmy-full-name] не исчерпано место в строке **space**.

---


## Изменить настройки [!KEYREF MY] {#change-postgresql-config}

Вы можете изменить настройки СУБД для хостов вашего кластера. Все поддерживаемые настройки описаны [в справочнике API](../api-ref/Cluster/update.md).

---

**[!TAB CLI]**

[!INCLUDE [cli-install](../../_includes/cli-install.md)]

[!INCLUDE [default-catalogue](../../_includes/default-catalogue.md)]

Чтобы изменить настройки сервера [!KEYREF MY]:

1. Посмотрите описание команды CLI для изменения конфигурации кластера:

    ```
    $ [!KEYREF yc-mdb-my] cluster update-config --help
    ```

2. Установите нужные значения параметров.

   Все поддерживаемые параметры перечислены в [формате запроса для метода update](../api-ref/Cluster/update.md), в поле `mysql_config_5_7`. Чтобы указать имя параметра в вызове CLI, преобразуйте его имя из вида <q>lowerCamelCase</q> в <q>snake_case</q>, например, параметр `logMinDurationStatement` из запроса к API преобразуется в `log_min_duration_statement` для команды CLI:
   
   ```
   $ [!KEYREF yc-mdb-my] cluster update-config <имя кластера>
        --set log_min_duration_statement=100,<имя параметра>=<значение>,... 
   ```
 
   [!KEYREF mmy-short-name] запустит операцию по изменению настроек кластера.


**[!TAB API]**

Изменить настройки СУБД для кластера можно с помощью метода API [update](../api-ref/Cluster/update.md): передайте в запросе нужные значения в параметре `configSpec.postgresqlConfig_10.config`.

---
