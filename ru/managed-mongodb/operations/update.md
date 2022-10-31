# Изменение настроек {{ MG }}-кластера 

После создания кластера вы можете:

- [Изменить класс хостов](#change-resource-preset).

- [{#T}](#change-disk-size).

- [Настроить серверы](#change-mongod-config) {{ MG }} согласно [документации {{ MG }}](https://docs.mongodb.com/manual/reference/configuration-options/).

- [Изменить дополнительные настройки кластера](#change-additional-settings).

- [Переместить кластер](#move-cluster) в другой каталог.


- [{#T}](#change-sg-set).


## Изменить класс хостов {#change-resource-preset}

{% include [mmg-settings-dependence](../../_includes/mdb/mmg/note-info-settings-dependence.md) %}

{% list tabs %}

- Консоль управления

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ mmg-name }}**.

  1. Выберите кластер и нажмите кнопку **Изменить кластер** на панели сверху.

  1. {% include [mmg-settings-host-class](../../_includes/mdb/mmg/settings-host-class.md) %}

  1. Нажмите кнопку **Сохранить изменения**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы изменить [класс хостов](../concepts/instance-types.md) для кластера:

  1. Посмотрите описание команды CLI для изменения кластера:

      ```
      {{ yc-mdb-mg }} cluster update --help
      ```

  1. Запросите список доступных классов хостов (в колонке `ZONES` указаны зоны доступности, в которых можно выбрать соответствующий класс):

     
     ```bash
     {{ yc-mdb-mg }} resource-preset list

     +-----------+--------------------------------+-------+----------+
     |    ID     |            ZONE IDS            | CORES |  MEMORY  |
     +-----------+--------------------------------+-------+----------+
     | s1.micro  | {{ region-id }}-a, {{ region-id }}-b,  |     2 | 8.0 GB   |
     |           | {{ region-id }}-c                  |       |          |
     | ...                                                           |
     +-----------+--------------------------------+-------+----------+
     ```



  1. Укажите нужный класс в команде изменения кластера:

      ```
      {{ yc-mdb-mg }} cluster update <имя кластера>
           --mongod-resource-preset <ID класса>
      ```

      {{ mmg-short-name }} запустит операцию изменения класса хостов для кластера.

- {{ TF }}

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
 
  Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-mmg }}).

  {% include [Terraform timeouts](../../_includes/mdb/mmg/terraform/timeouts.md) %}

- API

  Воспользуйтесь методом API [update](../api-ref/Cluster/update.md) и передайте в запросе:

  * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](./cluster-list.md#list-clusters).
  * Класс хоста в параметре `configSpec.mongodbSpec_<версия {{ MG }}>.mongod.resources.resourcePresetId`.

      Чтобы получить список поддерживаемых значений, воспользуйтесь методом [list](../api-ref/ResourcePreset/list.md) для ресурсов `ResourcePreset`.

  * Список настроек, которые необходимо изменить, в параметре `updateMask`.

  {% [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Увеличить размер хранилища {#change-disk-size}

{% include [note-increase-disk-size](../../_includes/mdb/note-increase-disk-size.md) %}

{% list tabs %}

- Консоль управления

  Чтобы увеличить размер хранилища для кластера:

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ mmg-name }}**.
  1. Выберите кластер и нажмите кнопку **Изменить кластер** на панели сверху.
  1. В разделе **Размер хранилища** укажите необходимое значение.
  1. Нажмите кнопку **Сохранить изменения**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы увеличить размер хранилища для кластера:

  1. Посмотрите описание команды CLI для изменения кластера:

      ```bash
      {{ yc-mdb-mg }} cluster update --help
      ```

  1. Укажите нужный объем хранилища в команде изменения кластера. Новый объем должен быть не меньше, чем текущее значение `disk_size` в свойствах кластера.

      ```bash
      {{ yc-mdb-mg }} cluster update <имя или идентификатор кластера> \
        --mongod-disk-size <размер хранилища в гигабайтах>
      ```

      Если все условия выполнены, {{ mmg-short-name }} запустит операцию по увеличению объема хранилища.
  
- {{ TF }}

  Чтобы увеличить размер хранилища для кластера:

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.
    
      О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).
    
  1. Измените в описании кластера {{ mmg-name }} значение параметра `disk_size` в блоке `resources`:
    
      ```hcl
      resource "yandex_mdb_mongodb_cluster" "<имя кластера>" {
        ...
        resources {
          disk_size = <размер хранилища в гигабайтах>
          ...
        }
      }
      ```
    
    1. Проверьте корректность настроек.
    
        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}
    
    1. Подтвердите изменение ресурсов.
    
        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}
   
    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-mmg }}).

    {% include [Terraform timeouts](../../_includes/mdb/mmg/terraform/timeouts.md) %}

- API

  Чтобы увеличить размер хранилища для кластера, воспользуйтесь методом API [update](../api-ref/Cluster/update.md) и передайте в запросе:

  * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](./cluster-list.md#list-clusters).
  * Новый размер хранилища в параметре `configSpec.mongodbSpec_<версия {{ MG }}>.mongod.resources.diskSize`.
  * Список настроек, которые необходимо изменить, в параметре `updateMask`.

  {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Изменить настройки {{ MG }} {#change-mongod-config}

Вы можете изменить настройки СУБД для хостов вашего кластера.

{% include [mmg-settings-dependence](../../_includes/mdb/mmg/note-info-settings-dependence.md) %}

{% list tabs %}

- Консоль управления

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ mmg-name }}**.
  1. Выберите кластер и нажмите кнопку **Изменить кластер** на панели сверху.
  1. Чтобы изменить [настройки {{ MG }}](../concepts/settings-list.md#dbms-cluster-settings), нажмите кнопку **Настроить** в блоке **Настройки СУБД**.
  1. Нажмите кнопку **Сохранить изменения**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы изменить [настройки {{ MG }}](../concepts/settings-list.md#dbms-cluster-settings) для кластера, используйте команду:

  ```
  {{ yc-mdb-mg }} cluster update-config
  ```

  Например, для установки значения параметра [net.maxIncomingConnections](https://docs.mongodb.com/manual/reference/configuration-options/#mongodb-setting-net.maxIncomingConnections) в `4096`, выполните следующую команду:

  ```
  {{ yc-mdb-mg }} cluster update-config <имя кластера> \
     --set net.max_incoming_connections=4096
  ```

  {{ mmg-short-name }} запустит операцию изменения настроек СУБД для кластера. Если изменяемая настройка применяется только с перезапуском СУБД, то {{ mmg-short-name }} последовательно перезапустит СУБД на всех хостах кластера.

- API

  Воспользуйтесь методом API [update](../api-ref/Cluster/update.md) и передайте в запросе:

  * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](./cluster-list.md#list-clusters).
  * Нужные значения настроек {{ MG }} в параметре `configSpec.mongodbSpec_<верия {{ MG }}>.mongod.config`.

      Все поддерживаемые настройки описаны [в справочнике API](../api-ref/Cluster/update.md) и в разделе [{#T}](../concepts/settings-list.md).

  * Список настроек кластера, которые необходимо изменить, в параметре `updateMask`.

  {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Изменить дополнительные настройки кластера {#change-additional-settings}

{% list tabs %}

- Консоль управления

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ mmg-name }}**.
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
        {{ yc-mdb-mg }} cluster update <идентификатор или имя кластера> \
          --backup-retain-period-days=<срок хранения> \
          --backup-window-start <время начала резервного копирования> \
          --maintenance-window type=<тип технического обслуживания: anytime или weekly>,`
                               `day=<день недели для типа weekly>,`
                               `hour=<час дня для типа weekly>
        ```

    Вы можете изменить следующие настройки:

    * `--backup-retain-period` — срок хранения автоматических резервных копий (в днях).
      
      Значение параметра `<срок хранения>` задается в диапазоне от {{ mmg-backup-retention-min }} до {{ mmg-backup-retention-max }} (по умолчанию — {{ mmg-backup-retention }}). Эта функциональность находится на стадии [Preview](../../overview/concepts/launch-stages.md). Подробнее см. в разделе [{#T}](../concepts/backup.md).


      Изменение срока хранения затрагивает как новые автоматические резервные копии, так и уже существующие.

      Например, если изначальный срок хранения был 7 дней и оставшееся время жизни отдельной автоматической резервной копии при таком сроке — 1 день, то при увеличении срока хранения до 9 дней, оставшееся время жизни этой резервной копии будет уже 3 дня.

    {% include [backup-window-start](../../_includes/mdb/cli/backup-window-start.md) %}

    * `--maintenance-window` — настройки времени [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров):

        {% include [maintenance-window](../../_includes/mdb/cli/maintenance-window-description.md) %}

    * {% include [Deletion protection](../../_includes/mdb/cli/deletion-protection.md) %}

        {% include [Ограничения защиты от удаления кластера](../../_includes/mdb/deletion-protection-limits-db.md) %}

    Идентификатор и имя кластера можно [получить со списком кластеров в каталоге](cluster-list.md#list-clusters).

- {{ TF }}

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

    1. {% include [Maintenance window](../../_includes/mdb/mmg/terraform/maintenance-window.md) %}

    1. Чтобы включить защиту кластера от непреднамеренного удаления пользователем вашего облака, добавьте к описанию кластера поле `deletion_protection` со значением `true`:

        ```hcl
        resource "yandex_mdb_mongodb_cluster" "<имя кластера>" {
          ...
          deletion_protection = <защита от удаления кластера: true или false>
        }
        ```

        {% include [Ограничения защиты от удаления](../../_includes/mdb/deletion-protection-limits-db.md) %}

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

       {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-mmg }}).

  {% include [Terraform timeouts](../../_includes/mdb/mmg/terraform/timeouts.md) %}

- API

    Воспользуйтесь методом API [update](../api-ref/Cluster/update.md) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](./cluster-list.md#list-clusters).
    * Новое время начала резервного копирования в параметре `configSpec.backupWindowStart`.
    * Настройки доступа из других сервисов в параметре `configSpec.access`.
    * Настройки времени [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров) в параметре `maintenanceWindow`.
    * Настройки защиты от удаления кластера в параметре `deletionProtection`.

        {% include [Ограничения защиты от удаления кластера](../../_includes/mdb/deletion-protection-limits-db.md) %}

    * Список изменяемых полей конфигурации кластера в параметре `updateMask`.

    {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Переместить кластер {#move-cluster}

{% list tabs %}

- Консоль управления

    1. Перейдите на страницу каталога и выберите сервис **{{ mmg-name }}**.
    1. Нажмите на значок ![image](../../_assets/horizontal-ellipsis.svg) справа в строке кластера, который вы хотите переместить.
    1. Выберите пункт **Переместить**.
    1. Выберите каталог, в который вы хотите переместить кластер.
    1. Нажмите кнопку **Переместить**.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы переместить кластер:

    1. Посмотрите описание команды CLI для перемещения кластера:

        ```bash
        {{ yc-mdb-mg }} cluster move --help
        ```

    1. Укажите каталог назначения в команде перемещения кластера:

        ```bash
        {{ yc-mdb-mg }} cluster move <идентификатор кластера> \
           --destination-folder-name=<имя каталога назначения>
        ```

        Идентификатор кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- API

    Воспользуйтесь методом API [move](../api-ref/Cluster/move.md) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
    * Идентификатор каталога назначения в параметре `destinationFolderId`.

{% endlist %}


## Изменить группы безопасности {#change-sg-set}

{% list tabs %}

- Консоль управления

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ mmg-name }}**.
    1. Выберите кластер и нажмите кнопку **Изменить кластер** на панели сверху.
    1. В блоке **Сетевые настройки** выберите группы безопасности для сетевого трафика кластера.
    1. Нажмите кнопку **Сохранить изменения**.

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
        {{ yc-mdb-mg }} cluster update <идентификатор или имя кластера> \
          --security-group-ids <список групп безопасности>
        ```

- {{ TF }}

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

  Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-mmg }}).

  {% include [Terraform timeouts](../../_includes/mdb/mmg/terraform/timeouts.md) %}

- API

  Воспользуйтесь методом API [update](../api-ref/Cluster/update.md) и передайте в запросе:

  - Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md).
  - Список идентификаторов групп безопасности в параметре `securityGroupIds`.
  - Список изменяемых полей конфигурации кластера в параметре `updateMask`.

  {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

{% note warning %}

Может потребоваться дополнительная [настройка групп безопасности](connect/index.md#configuring-security-groups) для подключения к кластеру.

{% endnote %}

