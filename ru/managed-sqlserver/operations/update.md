# Изменение настроек кластера

После создания кластера вы можете:

* [Изменить класс хостов](#change-resource-preset).
* [{#T}](#change-disk-size) (доступно только для [хранилищ](../concepts/storage.md) на сетевых HDD-дисках и сетевых SSD-дисках).
* [Изменить настройки](#change-sqlserver-config) {{ MS }} согласно документации {{ MS }}.
* [{#T}](#change-additional-settings).
* [Переместить кластер](#move-cluster) в другой каталог.
* [Изменить группы безопасности кластера](#change-sg-set).
* [{#T}](#service-account).

{% note warning %}

Вы не можете с помощью команд SQL изменять настройки {{ MS }}, в том числе управлять объектами уровня сервера `Linked Server`, `Login`, `Credential`, `SQL Server Agent Job`, `Maintenance Plan`, `Audit`, `Polybase`, `Replication`, `Backup devices`, `Server Triggers`, `Extended events`.

{% endnote %}

## Изменить класс хостов {#change-resource-preset}

{% list tabs %}

- Консоль управления

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ mms-name }}**.
  1. Выберите кластер и нажмите кнопку **Изменить кластер** на панели сверху.
  1. Выберите новый [класс хостов](../concepts/instance-types.md). При изменении класса хостов для кластера меняются характеристики всех уже созданных хостов.
  1. Нажмите кнопку **Сохранить изменения**.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы изменить [класс хостов](../concepts/instance-types.md) для кластера:

    1. Посмотрите описание команды CLI для изменения кластера:

        ```bash
        {{ yc-mdb-ms }} cluster update --help
        ```

    1. Запросите список доступных классов хостов (в колонке `ZONES IDS` указаны зоны доступности, в которых можно выбрать соответствующий класс):

        ```bash
        {{ yc-mdb-ms }} resource-preset list
        ```

        Результат:
        
        ```text
        +---------------+--------------------------------+-------+----------+
        |      ID       |            ZONE IDS            | CORES |  MEMORY  |
        +---------------+--------------------------------+-------+----------+
        | hm2.128xlarge | {{ region-id }}-a, {{ region-id }}-b,  |     8 | 128.0 GB |
        |               | {{ region-id }}-c                  |       |          |
        | hm2.160xlarge | {{ region-id }}-a, {{ region-id }}-b,  |    10 | 160.0 GB |
        |               | {{ region-id }}-c                  |       |          |
        | ...                                                               |
        +---------------+--------------------------------+-------+----------+
        ```


    1. Укажите нужный класс в команде изменения кластера:

        ```bash
        {{ yc-mdb-ms }} cluster update <идентификатор или имя кластера> \
           --resource-preset=<класс хоста>
        ```

        Идентификатор и имя кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

        {{ mms-short-name }} запустит операцию изменения класса хостов для кластера.

- {{ TF }}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [{#T}](./cluster-create.md).

    1. Измените в описании кластера {{ mms-name }} значение параметра `resource_preset_id` в блоке `resources`:

        ```hcl
        resource "yandex_mdb_sqlserver_cluster" "<имя кластера>" {
          ...
          resources {
            resource_preset_id = "<класс хоста>"
            ...
            }
        }
        ```

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-mms }}).

    {% include [Terraform timeouts](../../_includes/mdb/mms/terraform/timeouts.md) %}

- API

    Воспользуйтесь методом API [update](../api-ref/Cluster/update.md) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).

    * Новый класс хостов в параметре `configSpec.resources.resourcePresetId`.

        Чтобы узнать список поддерживаемых значений, воспользуйтесь методом [list](../api-ref/ResourcePreset/list.md) для объекта [ResourcePreset](../api-ref/ResourcePreset).

    * Список изменяемых полей конфигурации кластера в параметре `updateMask` (в данном случае — `configSpec.resources.resourcePresetId`).

    {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Увеличить размер хранилища {#change-disk-size}

Проверьте:

* Что нужный кластер использует хранилище на сетевых HDD-дисках или на сетевых SSD-дисках. Увеличить размер хранилища на локальных SSD-дисках или на нереплицируемых SSD-дисках невозможно.
* Что в облаке хватает квоты на увеличение хранилища. Откройте страницу [Квоты]({{ link-console-quotas }}) для вашего облака и проверьте, что в секции **Managed Databases** не исчерпано место в строке **Объем HDD-хранилищ** или **Объем SSD-хранилищ**.

{% list tabs %}

- Консоль управления

  Чтобы увеличить размер хранилища для кластера:

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ mms-name }}**.
  1. Выберите кластер и нажмите кнопку **Изменить кластер** на панели сверху.
  1. В разделе **Размер хранилища** укажите необходимое значение.
  1. Нажмите кнопку **Сохранить изменения**.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы увеличить размер хранилища для кластера:

    1. Посмотрите описание команды CLI для изменения кластера:

        ```bash
        {{ yc-mdb-ms }} cluster update --help
        ```

    1. Укажите нужный объем хранилища в команде изменения кластера:

        ```bash
        {{ yc-mdb-ms }} cluster update <идентификатор или имя кластера> \
           --disk-size=<объем хранилища, ГБ>
        ```

        Идентификатор и имя кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

        Если все условия выполнены, {{ mms-short-name }} запустит операцию по увеличению объема хранилища.

- {{ TF }}

  Чтобы увеличить размер хранилища для кластера:

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [{#T}](./cluster-create.md).

    1. Измените в описании кластера {{ mms-name }} значение параметра `disk_size` в блоке `resources`:

        ```hcl
        resource "yandex_mdb_sqlserver_cluster" "<имя кластера>" {
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

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-mms }}).

    {% include [Terraform timeouts](../../_includes/mdb/mms/terraform/timeouts.md) %}

- API

    Чтобы увеличить размер хранилища для кластера, воспользуйтесь методом API [update](../api-ref/Cluster/update.md) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
    * Новый размер хранилища (в байтах) в параметре `configSpec.resources.diskSize`.
    * Список изменяемых полей конфигурации кластера в параметре `updateMask` (в данном случае — `configSpec.resources.diskSize`).

    {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Изменить настройки {{ MS }} {#change-sqlserver-config}

{% list tabs %}

- Консоль управления

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ mms-name }}**.
  1. Выберите кластер и нажмите кнопку **Изменить кластер** на панели сверху.
  1. В блоке **Настройки СУБД** нажмите кнопку **Настроить**.
  1. Внесите необходимые изменения в настройки и нажмите кнопку **Сохранить**.
  1. Нажмите кнопку **Сохранить изменения**.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы изменить настройки {{ MS }}:

    1. Посмотрите полный список настроек, установленных для кластера:

        ```bash
        {{ yc-mdb-ms }} cluster get <идентификатор или имя кластера> --full
        ```

        Идентификатор и имя кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

    1. Посмотрите описание команды CLI для изменения конфигурации кластера:

        ```bash
        {{ yc-mdb-ms }} cluster update-config --help
        ```

    1. Установите нужные значения параметров:

        ```bash
        {{ yc-mdb-ms }} cluster update-config <идентификатор или имя кластера> \
           --set <имя параметра1>=<значение1>,...
        ```

        {{ mms-short-name }} запустит операцию по изменению настроек кластера.

        Все поддерживаемые параметры перечислены в [описании настроек {{ MS }}](../concepts/settings-list.md).

- {{ TF }}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [{#T}](./cluster-create.md).

    1. Измените в описании кластера {{ mms-name }} значения параметров в блоке `sqlserver_config`:

        ```hcl
        resource "yandex_mdb_sqlserver_cluster" "<имя кластера>" {
          ...
          sqlserver_config {
            ...
          }
        }
        ```

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-mms }}).

    {% include [Terraform timeouts](../../_includes/mdb/mms/terraform/timeouts.md) %}

- API

    Воспользуйтесь методом API [update](../api-ref/Cluster/update.md) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
    * Необходимые значения в параметре `configSpec.sqlserverConfig_<версия {{ MS }}>`.

        Список доступных для изменения настроек представлен в [описании API](../api-ref/Cluster/update.md) и в разделе [{#T}](../concepts/settings-list.md).

    * Список изменяемых полей конфигурации кластера в параметре `updateMask`.

    {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Изменить дополнительные настройки кластера {#change-additional-settings}

{% list tabs %}

- Консоль управления

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ mms-name }}**.
    1. Выберите кластер и нажмите кнопку **Редактировать** в верхней части страницы.
    1. Измените дополнительные настройки кластера:

        {% include [extra-settings](../../_includes/mdb/mms/extra-settings.md) %}

    1. Нажмите кнопку **Сохранить изменения**.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы изменить дополнительные настройки кластера:

    1. Посмотрите описание команды CLI для изменения кластера:

        ```bash
        {{ yc-mdb-ms }} cluster update --help
        ```

    1. Выполните команду, передав список настроек, которые хотите изменить:

        ```bash
        {{ yc-mdb-ms }} cluster update <идентификатор или имя кластера> \
           --backup-window-start=<время начала резервного копирования> \
           --deletion-protection=<защита от удаления кластера: true или false>
        ```

        Вы можете изменить следующие настройки:

        {% include [backup-window-start](../../_includes/mdb/cli/backup-window-start.md) %}

        * {% include [deletion-protection](../../_includes/mdb/cli/deletion-protection.md) %}

            {% include [deletion-protection-limits-db](../../_includes/mdb/deletion-protection-limits-db.md) %}

        Идентификатор и имя кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- {{ TF }}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).

    1. Чтобы изменить время начала резервного копирования, добавьте к описанию кластера {{ mms-name }} блок `backup_window_start`.

        ```hcl
        resource "yandex_mdb_sqlserver_cluster" "<имя кластера>" {
          ...
          backup_window_start {
            hours   = <Час начала резервного копирования>
            minutes = <Минута начала резервного копирования>
          }
          ...
        }
        ```

    1. Чтобы включить защиту кластера от непреднамеренного удаления пользователем вашего облака, добавьте к описанию кластера поле `deletion_protection` со значением `true`:

        ```hcl
        resource "yandex_mdb_sqlserver_cluster" "<имя кластера>" {
          ...
          deletion_protection = <защита от удаления кластера: true или false>
        }
        ```

        {% include [Ограничения защиты от удаления](../../_includes/mdb/deletion-protection-limits-db.md) %}

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-mms }}).

    {% include [Terraform timeouts](../../_includes/mdb/mms/terraform/timeouts.md) %}

- API

    Воспользуйтесь методом API [update](../api-ref/Cluster/update.md) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
    * Новое время начала резервного копирования в параметре `configSpec.backupWindowStart`.
    * Список изменяемых полей конфигурации кластера в параметре `updateMask` (в данном случае — `configSpec.backupWindowStart`).

    {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}


## Изменить группы безопасности {#change-sg-set}

{% list tabs %}

- Консоль управления

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ mms-name }}**.
    1. Выберите кластер и нажмите кнопку **Изменить кластер** на панели сверху.
    1. В блоке **Сетевые настройки** выберите группы безопасности для сетевого трафика кластера.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы изменить список [групп безопасности](../concepts/network.md#security-groups) для кластера:

    1. Посмотрите описание команды CLI для изменения кластера:

        ```bash
        {{ yc-mdb-ms }} cluster update --help
        ```

    1. Укажите нужные группы безопасности в команде изменения кластера:

        ```bash
        {{ yc-mdb-ms }} cluster update <идентификатор или имя кластера> \
           --security-group-ids=<список групп безопасности>
        ```

        Идентификатор и имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- {{ TF }}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [{#T}](./cluster-create.md).

    1. Измените в описании кластера {{ mms-name }} значение параметра `security_group_ids`:

        ```hcl
        resource "yandex_mdb_sqlserver_cluster" "<имя кластера>" {
          ...
          security_group_ids = [<список идентификаторов групп безопасности>]
        }
        ```

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-mms }}).

    {% include [Terraform timeouts](../../_includes/mdb/mms/terraform/timeouts.md) %}

- API

    Воспользуйтесь методом API [update](../api-ref/Cluster/update.md) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
    * Список идентификаторов групп безопасности в параметре `securityGroupIds`.
    * Список настроек, которые необходимо изменить, в параметре `updateMask`.

    {% include [Сброс настроек изменяемого объекта](../../_includes/note-api-updatemask.md) %}

{% endlist %}

{% note warning %}

Может потребоваться дополнительная [настройка групп безопасности](connect.md#configuring-security-groups) для подключения к кластеру.

{% endnote %}


## Привязать сервисный аккаунт {#service-account}

{% list tabs %}

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы привязать к кластеру [сервисный аккаунт](../../iam/concepts/users/service-accounts.md):

    1. Посмотрите описание команды CLI для изменения кластера:

        ```bash
        {{ yc-mdb-ms }} cluster update --help
        ```

    1. Передайте идентификатор сервисного аккаунта в параметре `--service-account-id` в команде изменения кластера:

        ```bash
        {{ yc-mdb-ms }} cluster update <идентификатор или имя кластера> \
           --service-account-id=<идентификатор сервисного аккаунта>
        ```

        Идентификатор и имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters). Чтобы узнать идентификатор сервисного аккаунта, воспользуйтесь [инструкцией](../../iam/operations/sa/get-id.md).

- API

    Чтобы привязать к кластеру [сервисный аккаунт](../../iam/concepts/users/service-accounts.md), воспользуйтесь методом API [update](../api-ref/Cluster/update.md) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
    * Идентификатор сервисного аккаунта в параметре `serviceAccountId`. Чтобы получить идентификатор, воспользуйтесь [инструкцией](../../iam/operations/sa/get-id.md).
    * Список настроек, которые необходимо изменить, в параметре `updateMask`.

    {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

