# Изменение настроек кластера

После создания кластера вы можете:

- [Изменить класс хостов](#change-resource-preset).

- [Увеличить размер хранилища](#change-disk-size) (доступно только для сетевого хранилища, `network-hdd` и `network-ssd`).

- [Настроить серверы](#change-mongod-config) {{ MG }} согласно [документации {{ MG }}](https://docs.mongodb.com/manual/reference/configuration-options/).

- [Изменить дополнительные настройки кластера](#change-additional-settings).

- [{#T}](#change-sg-set).

## Изменить класс хостов {#change-resource-preset}

{% include [mmg-settings-dependence](../../_includes/mdb/mmg/note-info-settings-dependence.md) %}

{% list tabs %}

- Консоль управления

  1. Перейдите на страницу каталога и выберите сервис **{{ mmg-name }}**.
  1. Выберите кластер и нажмите кнопку **Изменить кластер** на панели сверху.
  1. Чтобы изменить класс хостов {{ MG }}, в блоке **Класс хоста** выберите нужный класс.
  1. Нажмите кнопку **Сохранить изменения**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы изменить [класс хостов](../concepts/instance-types.md) для кластера:

  1. Посмотрите описание команды CLI для изменения кластера:

      ```
      $ {{ yc-mdb-mg }} cluster update --help
      ```

  1. Запросите список доступных классов хостов (в колонке `ZONES` указаны зоны доступности, в которых можно выбрать соответствующий класс):

     {% if audience != "internal" %}

     ```bash
     $ {{ yc-mdb-mg }} resource-preset list

     +-----------+--------------------------------+-------+----------+
     |    ID     |            ZONE IDS            | CORES |  MEMORY  |
     +-----------+--------------------------------+-------+----------+
     | s1.micro  | ru-central1-a, ru-central1-b,  |     2 | 8.0 GB   |
     |           | ru-central1-c                  |       |          |
     | ...                                                           |
     +-----------+--------------------------------+-------+----------+
     ```

     {% else %}

     ```
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


  1. Укажите нужный класс в команде изменения кластера:

      ```
      $ {{ yc-mdb-mg }} cluster update <имя кластера>
           --mongod-resource-preset <ID класса>
      ```

      {{ mmg-short-name }} запустит операцию изменения класса хостов для кластера.

- Terraform
  
  Чтобы изменить [класс хостов](../concepts/instance-types.md) для кластера:
  
  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.
  
      О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).
  
  1. Измените в описании кластера {{ mmg-name }} значение параметра `resource_preset_id` в блоке `resources`:
  
      ```hcl
      resource "yandex_mdb_mongodb_cluster" "<имя кластера>" {
        ...
        resources {
            resource_preset_id = "<класс хостов {{ MG }}>"
            ...
        }
      }
      ```
  
  1. Проверьте корректность настроек.
  
      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}
  
  1. Подтвердите изменение ресурсов.
  
      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}
 
  Подробнее см. в [документации провайдера {{ TF }}](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/mdb_mongodb_cluster).

- API

  Изменить [класс хостов](../concepts/instance-types.md) кластера можно с помощью метода API [update](../api-ref/Cluster/update.md): передайте в запросе нужные значения в параметре `configSpec.mongodbSpec_4_2.mongod.resources.resourcePresetId`.

  Список поддерживаемых значений запрашивайте методом [list](../api-ref/ResourcePreset/list.md) для ресурсов `ResourcePreset`.

{% endlist %}

## Увеличить размер хранилища {#change-disk-size}

{% list tabs %}

- Консоль управления

  1. Перейдите на страницу каталога и выберите сервис **{{ mmg-name }}**.
  1. Выберите кластер и нажмите кнопку **Изменить кластер** на панели сверху.
  1. В разделе **Размер хранилища** укажите необходимое значение.
  1. Нажмите кнопку **Сохранить изменения**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы увеличить размер хранилища для кластера:

  1. Посмотрите описание команды CLI для изменения кластера:

      ```
      $ {{ yc-mdb-mg }} cluster update --help
      ```

  1. Проверьте, что в облаке хватает квоты на увеличение хранилища: откройте страницу [Квоты]({{ link-console-quotas }}) для вашего облака и проверьте, что в секции {{ mmg-full-name }} не исчерпано место в строке **space**.

  1. Проверьте, что нужный кластер использует именно сетевое хранилище (увеличить размер локального хранилища пока невозможно). Для этого запросите информацию о кластере и найдите поле `disk_type_id` — его значение должно быть `network-hdd` или `network-ssd`:

      ```
      $ {{ yc-mdb-mg }} cluster get <имя кластера>

      id: c7qkvr3u78qiopj3u4k2
      folder_id: b1g0ftj57rrjk9thribv
      ...
      config:
        mongodb_4_4:
          mongod:
            config:
              user_config: {}
            resources:
              resource_preset_id: s1.micro
              disk_size: "21474836480"
              disk_type_id: network-ssd
      ...
      ```

  1. Укажите нужный объем хранилища в команде изменения кластера (должен быть не меньше, чем значение `disk_size` в свойствах кластера):

      ```
      $ {{ yc-mdb-mg }} cluster update <имя кластера>
           --mongod-disk-size <размер хранилища в ГБ>
      ```

      Если все условия выполнены, {{ mmg-short-name }} запустит операцию по увеличению объема хранилища.
  
- Terraform
    
  Чтобы увеличить размер хранилища для кластера:
    
  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.
    
      О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).
    
  1. Измените в описании кластера {{ mmg-name }} значение параметра `disk_size` в блоке `resources`:
    
      ```hcl
      resource "yandex_mdb_mongodb_cluster" "<имя кластера>" {
        ...
        resources {
          disk_size = <размер хранилища, ГБ>
          ...
        }
      }
      ```
    
    1. Проверьте корректность настроек.
    
        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}
    
    1. Подтвердите изменение ресурсов.
    
        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}
   
    Подробнее см. в [документации провайдера {{ TF }}](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/mdb_mongodb_cluster).

- API

  Изменить размер хранилища для кластера можно с помощью метода API [update](../api-ref/Cluster/update.md): передайте в запросе нужные значения в параметре `configSpec.mongodbSpec_4_2.mongod.resources.diskSize`.

  Проверьте, что в облаке хватает квоты на увеличение хранилища: откройте страницу [Квоты]({{ link-console-quotas }}) для вашего облака и проверьте, что в секции {{ mmg-full-name }} не исчерпано место в строке **space**.

{% endlist %}

## Изменить настройки {{ MG }} {#change-mongod-config}

Вы можете изменить настройки СУБД для хостов вашего кластера.

{% include [mmg-settings-dependence](../../_includes/mdb/mmg/note-info-settings-dependence.md) %}

{% list tabs %}

- Консоль управления

  1. Перейдите на страницу каталога и выберите сервис **{{ mmg-name }}**.
  1. Выберите кластер и нажмите кнопку **Изменить кластер** на панели сверху.
  1. Измените [настройки {{ MG }}](../concepts/settings-list.md#dbms-cluster-settings), нажав кнопку **Настроить** в блоке **Настройки СУБД**.
  1. Нажмите кнопку **Сохранить изменения**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы изменить [настройки {{ MG }}](../concepts/settings-list.md#dbms-cluster-settings) для кластера, используйте команду:

  ```
  $ {{ yc-mdb-mg }} cluster update-config
  ```

  Например, для установки значения параметра [net.maxIncomingConnections](https://docs.mongodb.com/manual/reference/configuration-options/#mongodb-setting-net.maxIncomingConnections) в `4096`, выполните следующую команду:

  ```
  $ {{ yc-mdb-mg }} cluster update-config <имя кластера>
      --set net.max_incoming_connections=4096
  ```

  {{ mmg-short-name }} запустит операцию изменения настроек СУБД для кластера. Если изменяемая настройка применяется только с перезапуском СУБД, то {{ mmg-short-name }} последовательно перезапустит СУБД на всех хостах кластера.

- API

  Изменить [настройки {{ MG }}](../concepts/settings-list.md#dbms-cluster-settings) для кластера можно с помощью метода API [update](../api-ref/Cluster/update.md): передайте в запросе нужные значения в параметре `configSpec.mongodbSpec_4_2.mongod.config`.

  Все поддерживаемые настройки описаны [в справочнике API](../api-ref/Cluster/update.md).

{% endlist %}

## Изменить дополнительные настройки кластера {#change-additional-settings}

{% list tabs %}

- Консоль управления

  1. Перейдите на страницу каталога и выберите сервис **{{ mmg-name }}**.
  1. Выберите кластер и нажмите кнопку **Изменить кластер** на панели сверху.
  1. Измените дополнительные настройки кластера:

     {% include [mmg-extra-settings](../../_includes/mdb/mmg-extra-settings.md) %}
     
  1. Нажмите кнопку **Сохранить изменения**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы изменить дополнительные настройки кластера:

    1. Посмотрите описание команды CLI для изменения кластера:

        ```bash
        {{ yc-mdb-mg }} cluster update --help
        ```

    1. Выполните команду, передав список настроек, которые хотите изменить:

        ```bash
        {{ yc-mdb-mg }} cluster update <имя кластера> \
            --backup-retain-period-days=<срок хранения> \
            --backup-window-start <время начала резервного копирования> \
            --maintenance-window type=<weekly или anytime>
        ```

    Вы можете изменить следующие настройки:

    * `--backup-retain-period` — срок хранения автоматических резервных копий (в днях).

      Значение параметра `<срок хранения>` задается в диапазоне от {{ mmg-backup-retention-min }} до {{ mmg-backup-retention-max }} (по умолчанию — {{ mmg-backup-retention }}). Эта функциональность находится на стадии [Preview](../../overview/concepts/launch-stages.md). Подробнее см. в разделе [{#T}](../concepts/backup.md).

      Изменение срока хранения затрагивает как новые автоматические резервные копии, так и уже существующие.

      Например, если изначальный срок хранения был 7 дней и оставшееся время жизни отдельной автоматической резервной копии при таком сроке — 1 день, то при увеличении срока хранения до 9 дней, оставшееся время жизни этой резервной копии будет уже 3 дня.

    {% include [backup-window-start](../../_includes/mdb/cli-additional-settings/backup-window-start.md) %}

    {% include [maintenance-window](../../_includes/mdb/cli-additional-settings/maintenance-window.md) %}

    Имя кластера можно [получить со списком кластеров в каталоге](cluster-list.md#list-clusters).

- Terraform

  Чтобы изменить дополнительные настройки кластера:

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.
      
       О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).

    1. Чтобы изменить время начала резервного копирования, добавьте к описанию кластера {{ mmg-name }} блок `backup_window_start` в секции `cluster_config`:
  
        ```hcl
        resource "yandex_mdb_mongodb_cluster" "<имя кластера>" {
          ...
          cluster_config {
            backup_window_start {
              hours   = <Час начала резервного копирования>
              minutes = <Минута начала резервного копирования>
            }
            ...
          }
          ...
        }
        ```

    1. Чтобы разрешить доступ [из сервиса {{ datalens-full-name }}](../../datalens/concepts/index.md), добавьте к описанию кластера {{ mmg-name }} блок `access` в секции `cluster_config`:
  
        ```hcl
        resource "yandex_mdb_mongodb_cluster" "<имя кластера>" {
          ...
          cluster_config {
            ...
            access {
              data_lens = <Доступ из DataLens: true или false>
            }
          ...
        }
        ```

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

       {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  Подробнее см. в [документации провайдера {{ TF }}](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/mdb_mongodb_cluster).

- API

  Воспользуйтесь методом API [update](../api-ref/Cluster/update.md): передайте в запросе нужные значения в параметрах `configSpec.access` и `configSpec.backupWindowStart`.

{% endlist %}

## Изменить группы безопасности {#change-sg-set}

{% list tabs %}

- Консоль управления

    1. Перейдите на страницу каталога и выберите сервис **{{ mmg-name }}**.
    1. Выберите кластер и нажмите кнопку **Изменить кластер** на панели сверху.
    1. В блоке **Сетевые настройки** выберите группы безопасности для сетевого трафика кластера.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы изменить список [групп безопасности](../concepts/network.md#security-groups) для кластера:

    1. Посмотрите описание команды CLI для изменения кластера:

        ```bash
        {{ yc-mdb-mg }} cluster update --help
        ```

    1. Укажите нужные группы безопасности в команде изменения кластера:

        ```bash
        {{ yc-mdb-mg }} cluster update <имя кластера> \
           --security-group-ids <список групп безопасности>
        ```

- Terraform

  Чтобы изменить список [групп безопасности](../concepts/network.md#security-groups) кластера:

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.
      
       О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).

    1. Измените в описании кластера {{ mmg-name }} значение параметра `security_group_ids`:
  
        ```hcl
        resource "yandex_mdb_mongodb_cluster" "<имя кластера>" {
          ...
          security_group_ids = [ <Список идентификаторов групп безопасности> ]
          ...
        }
        ```

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

       {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  Подробнее см. в [документации провайдера {{ TF }}](https://registry.terraform.io/providers/yandex-cloud/yandex/latest/docs/resources/mdb_mongodb_cluster).

- API

  Чтобы изменить список [групп безопасности](../concepts/network.md#security-groups) кластера, воспользуйтесь методом API `update` и передайте в запросе:

    - Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md).
    - Список групп в параметре `securityGroupIds`.
    - Список настроек, которые необходимо изменить, в параметре `updateMask`. Если не задать этот параметр, метод API сбросит на значения по умолчанию все настройки кластера, которые не были явно указаны в запросе.

{% endlist %}

{% note warning %}

Может потребоваться дополнительная [настройка групп безопасности](connect.md#configuring-security-groups) для подключения к кластеру.

{% endnote %}
