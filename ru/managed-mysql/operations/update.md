---
title: "Инструкция по изменению настроек {{ MY }}-кластера в {{ mmy-full-name }}"
description: "Из статьи вы узнаете, как изменить настройки {{ MY }}-кластера."
---

# Изменение настроек {{ MY }}-кластера

После создания кластера вы можете:

* [Изменить класс хостов](#change-resource-preset).

* [{#T}](#change-disk-size).

* [Изменить настройки {{ MY }}](#change-mysql-config).

    {% note warning %}

    Вы не можете менять настройки {{ MY }} с помощью команд SQL.

    {% endnote %}

* [Изменить дополнительные настройки кластера](#change-additional-settings).

* [Переместить кластер](#move-cluster) в другой каталог.


* [{#T}](#change-sg-set).


Если вы хотите переместить кластер в другую зону доступности, обратитесь к [инструкции](host-migration.md). В результате вы перенесете хосты кластера.

## Изменить класс хостов {#change-resource-preset}

Выбор класса хостов в кластерах {{ mmy-short-name }} ограничен квотами на количество CPU и объем памяти, которые доступны кластерам БД в вашем облаке. Чтобы проверить используемые ресурсы, откройте страницу [Квоты]({{ link-console-quotas }}) и найдите блок **{{ ui-key.yacloud.iam.folder.dashboard.label_mdb }}**.

{% include [mmy-settings-dependence](../../_includes/mdb/mmy/note-info-settings-dependence.md) %}

{% list tabs %}

- Консоль управления

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Выберите кластер и нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}** на панели сверху.
  1. Чтобы изменить класс хостов {{ MY }}, в блоке **{{ ui-key.yacloud.mdb.forms.section_resource }}** выберите нужный класс.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы изменить [класс хостов](../concepts/instance-types.md) для кластера:

  1. Посмотрите описание команды CLI для изменения кластера:

      ```bash
      {{ yc-mdb-my }} cluster update --help
      ```

  1. Запросите список доступных классов хостов (в колонке `ZONES` указаны зоны доступности, в которых можно выбрать соответствующий класс):

     
     ```bash
     {{ yc-mdb-my }} resource-preset list
     ```

     Результат:

     ```text
     +-----------+--------------------------------+-------+----------+
     |    ID     |            ZONE IDS            | CORES |  MEMORY  |
     +-----------+--------------------------------+-------+----------+
     | s1.micro  | {{ region-id }}-a, {{ region-id }}-b,  |     2 | 8.0 GB   |
     |           | {{ region-id }}-c                  |       |          |
     | ...                                                           |
     +-----------+--------------------------------+-------+----------+
     ```


  1. Укажите нужный класс в команде изменения кластера:

      ```bash
      {{ yc-mdb-my }} cluster update <имя_или_идентификатор_кластера>
        --resource-preset <идентификатор_класса>
      ```

      {{ mmy-short-name }} запустит операцию изменения класса хостов для кластера.

- {{ TF }}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

      О том, как создать такой файл, см. в разделе [{#T}](./cluster-create.md).

  1. Измените в описании кластера {{ mmy-name }} значение параметра `resource_preset_id` в блоке `resources`:

      ```hcl
      resource "yandex_mdb_mysql_cluster" "<имя_кластера>" {
        ...
        resources {
          resource_preset_id = "<класс_хоста>"
          ...
        }
      }
      ```

  1. Проверьте корректность настроек.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-mmy }}).

    {% include [Terraform timeouts](../../_includes/mdb/mmy/terraform/timeouts.md) %}

- API

    Чтобы изменить [класс хостов](../concepts/instance-types.md), воспользуйтесь методом REST API [update](../api-ref/Cluster/update.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Update](../api-ref/grpc/cluster_service.md#Update) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md).
    * Нужный класс хостов в параметре `configSpec.resources.resourcePresetId`. Список поддерживаемых значений запрашивайте методом [list](../api-ref/ResourcePreset/list.md) для ресурсов `ResourcePreset`.
    * Список настроек, которые необходимо изменить (в данном случае — `configSpec.resources.resourcePresetId`), в параметре `updateMask`.

    {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Увеличить размер хранилища {#change-disk-size}

{% include [note-increase-disk-size](../../_includes/mdb/note-increase-disk-size.md) %}

{% list tabs %}

- Консоль управления

  Чтобы увеличить размер хранилища для кластера:

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Выберите кластер и нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}** на панели сверху.
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_disk }}** укажите необходимое значение.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы увеличить размер хранилища для кластера:

  1. Посмотрите описание команды CLI для изменения кластера:

      ```bash
      {{ yc-mdb-my }} cluster update --help
      ```

  1. Укажите нужный размер хранилища в команде изменения кластера (должен быть не меньше, чем значение `disk_size` в свойствах кластера):

      ```bash
      {{ yc-mdb-my }} cluster update <имя_или_идентификатор_кластера> \
        --disk-size <размер_хранилища_ГБ>
      ```

- {{ TF }}

  Чтобы увеличить размер хранилища для кластера:

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

      О том, как создать такой файл, см. в разделе [{#T}](./cluster-create.md).

  1. Измените значение параметра `disk_size` в блоке `resources`:

      ```hcl
      resource "yandex_mdb_mysql_cluster" "<имя_кластера>" {
        ...
        resources {
          disk_size = <размер_хранилища_ГБ>
          ...
        }
      }
      ```

  1. Проверьте корректность настроек.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-mmy }}).

  {% include [Terraform timeouts](../../_includes/mdb/mmy/terraform/timeouts.md) %}

- API

    Чтобы увеличить размер хранилища для кластера, воспользуйтесь методом REST API [update](../api-ref/Cluster/update.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Update](../api-ref/grpc/cluster_service.md#Update) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md).
    * Размер хранилища в параметре `configSpec.resources.diskSize`.
    * Список изменяемых полей конфигурации кластера в параметре `updateMask` (в данном случае — `configSpec.resources.diskSize`).

    {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Изменить настройки {{ MY }} {#change-mysql-config}

{% include [mmy-settings-dependence](../../_includes/mdb/mmy/note-info-settings-dependence.md) %}  

{% list tabs %}

- Консоль управления

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Выберите кластер и нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}** на панели сверху.
  1. Измените [настройки {{ MY }}](../concepts/settings-list.md#dbms-cluster-settings), нажав на кнопку **{{ ui-key.yacloud.mdb.forms.button_configure-settings }}** в блоке **{{ ui-key.yacloud.mdb.forms.section_settings }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.component.mdb.settings.popup_settings-submit }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы изменить [настройки {{ MY }}](../concepts/settings-list.md#dbms-cluster-settings):

  1. Посмотрите описание команды CLI для изменения конфигурации кластера:

      ```bash
      {{ yc-mdb-my }} cluster update-config --help
      ```

  1. Установите нужные значения параметров.

     Все поддерживаемые параметры перечислены в [формате запроса для метода update](../api-ref/Cluster/update.md), в поле `mysql_config_5_7`. Чтобы указать имя параметра в вызове CLI, преобразуйте его имя из вида <q>lowerCamelCase</q> в <q>snake_case</q>, например, параметр `logMinDurationStatement` из запроса к API преобразуется в `log_min_duration_statement` для команды CLI:

     ```bash
     {{ yc-mdb-my }} cluster update-config <имя_кластера>
       --set log_min_duration_statement=100,<имя_параметра>=<значение>,...
     ```

     {{ mmy-short-name }} запустит операцию по изменению настроек кластера.

- {{ TF }}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

      О том, как создать такой файл, см. в разделе [{#T}](./cluster-create.md).

  1. Добавьте или измените в описании кластера {{ mmy-name }} параметры [настроек СУБД](../concepts/settings-list.md) в блоке `mysql_config`:

      ```hcl
      resource "yandex_mdb_mysql_cluster" "<имя_кластера>" {
        ...
        mysql_config = {
          <имя_настройки_{{ MY }}> = <значение>
          ...
        }
      }
      ```

  1. Проверьте корректность настроек.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_mysql_cluster#mysql-config).

  {% include [Terraform timeouts](../../_includes/mdb/mmy/terraform/timeouts.md) %}

- API

    Чтобы изменить настройки {{ MY }}, воспользуйтесь методом REST API [update](../api-ref/Cluster/update.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Update](../api-ref/grpc/cluster_service.md#Update) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md).
    * Массив с новыми настройками {{ MY }} в параметре:
        * `configSpec.mysqlConfig_5_7.sqlMode` для {{ MY }} версии 5.7.
        * `configSpec.mysqlConfig_8_0.sqlMode` для {{ MY }} версии 8.0.
    * Список изменяемых полей конфигурации кластера в параметре `updateMask`.

    {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Изменить дополнительные настройки кластера {#change-additional-settings}

{% list tabs %}

- Консоль управления

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Выберите кластер и нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}** на панели сверху.
  1. Измените дополнительные настройки кластера:

     {% include [mmy-extra-settings](../../_includes/mdb/mmy-extra-settings-web-console.md) %}

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы изменить дополнительные настройки кластера:

    1. Посмотрите описание команды CLI для изменения кластера:

        ```bash
        {{ yc-mdb-my }} cluster update --help
        ```

    1. Выполните команду, передав список настроек, которые хотите изменить:

                
        ```bash
        {{ yc-mdb-my }} cluster update <имя_или_идентификатор_кластера> \
          --backup-window-start <время_начала_резервного_копирования> \
          --backup-retain-period-days=<срок_хранения_копий> \
          --datalens-access=<доступ_из_{{ datalens-name }}> \
          --maintenance-window type=<тип_технического_обслуживания>,`
                              `day=<день_недели>,`
                              `hour=<час_дня> \
          --websql-access=<запросы_из_консоли_управления> \
          --deletion-protection=<защита_от_удаления>
        ```
        
        
    
    Вы можете изменить следующие настройки:

    {% include [backup-window-start](../../_includes/mdb/cli/backup-window-start.md) %}

    * `--backup-retain-period-days` — срок хранения автоматических резервных копий (в днях). Допустимые значения: от `7` до `60`. Значение по умолчанию — `7`.

    * `--datalens-access` — разрешает доступ из {{ datalens-name }}. Значение по умолчанию — `false`. Подробнее о настройке подключения см в разделе [{#T}](datalens-connect.md).

    * `--maintenance-window` — настройки времени [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров), где `type` — тип технического обслуживания:

        {% include [maintenance-window](../../_includes/mdb/cli/maintenance-window-description.md) %}

    * `--websql-access` — разрешает [выполнять SQL запросы](web-sql-query.md) из консоли управления. Значение по умолчанию — `false`.

    * {% include [Deletion protection](../../_includes/mdb/cli/deletion-protection.md) %}

        {% include [Ограничения защиты от удаления кластера](../../_includes/mdb/deletion-protection-limits-db.md) %}

    Имя кластера можно [получить со списком кластеров в каталоге](cluster-list.md#list-clusters).

- {{ TF }}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

      О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).

  1. Чтобы изменить время начала резервного копирования, добавьте к описанию кластера {{ mmy-name }} блок `backup_window_start`:

      ```hcl
      resource "yandex_mdb_mysql_cluster" "<имя_кластера>" {
        ...
        backup_window_start {
          hours   = <час>
          minutes = <минута>
        }
        ...
      }
      ```

      Где:

      * `hours` — час начала резервного копирования.
      * `minutes` — минута начала резервного копирования.

  1. Чтобы изменить срок хранения резервных копий, укажите в описании кластера параметр `backup_retain_period_days`:

      ```hcl
        resource "yandex_mdb_mysql_cluster" "<имя_кластера>" {
          ...
          backup_retain_period_days = <срок_хранения_копий>
          ...
        }
      ```

      Где `backup_retain_period_days` — срок хранения автоматических резервных копий в днях. Допустимые значения: от `7` до `60`. Значение по умолчанию — `7`.

  
  1. {% include [Access settings](../../_includes/mdb/mmy/terraform/access-settings.md) %}


  1. {% include [Maintenance window](../../_includes/mdb/mmy/terraform/maintenance-window.md) %}

  1. Чтобы включить защиту кластера от непреднамеренного удаления пользователем вашего облака, добавьте к описанию кластера поле `deletion_protection` со значением `true`:

      ```hcl
      resource "yandex_mdb_mysql_cluster" "<имя_кластера>" {
        ...
        deletion_protection = <защита_от_удаления>
      }
      ```

      Где `deletion_protection` — защита от удаления кластера: `true` или `false`.

      {% include [Ограничения защиты от удаления](../../_includes/mdb/deletion-protection-limits-db.md) %}

  1. Проверьте корректность настроек.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-mmy }}).

  {% include [Terraform timeouts](../../_includes/mdb/mmy/terraform/timeouts.md) %}

- API

    Чтобы изменить дополнительные настройки кластера, воспользуйтесь методом REST API [update](../api-ref/Cluster/update.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Update](../api-ref/grpc/cluster_service.md#Update) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
    * Настройку доступа к SQL-запросам из консоли управления в параметре `configSpec.access`.
    * Настройки окна резервного копирования в параметре `configSpec.backupWindowStart`.
    * Настройки времени [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров) в параметре `maintenanceWindow`.
    * Срок хранения автоматических резервных копий в параметре `configSpec.backupRetainPeriodDays`. Допустимые значения: от `7` до `60`. Значение по умолчанию — `7`.
    * Настройки защиты от удаления кластера в параметре `deletionProtection`.

      {% include [Ограничения защиты от удаления кластера](../../_includes/mdb/deletion-protection-limits-db.md) %}

    {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

    {% include [DataTransfer access](../../_includes/mdb/api/datatransfer-access-create.md) %}

    {% include [datalens access](../../_includes/mdb/api/datalens-access.md) %}

    Идентификатор кластера можно получить со [списком кластеров в каталоге](./cluster-list.md#list-clusters).

{% endlist %}

## Переместить кластер {#move-cluster}

{% list tabs %}

- Консоль управления

    1. Перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
    1. Нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) справа в строке кластера, который вы хотите переместить.
    1. Выберите пункт **{{ ui-key.yacloud.mdb.dialogs.popup_button_move-cluster }}**.
    1. Выберите каталог, в который вы хотите переместить кластер.
    1. Нажмите кнопку **{{ ui-key.yacloud.mdb.dialogs.popup_button_move-cluster }}**.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы переместить кластер:

    1. Посмотрите описание команды CLI для перемещения кластера:

        ```bash
        {{ yc-mdb-my }} cluster move --help
        ```

    1. Укажите каталог назначения в команде перемещения кластера:

        ```bash
        {{ yc-mdb-my }} cluster move <идентификатор_кластера> \
           --destination-folder-name=<имя_каталога_назначения>
        ```

        Идентификатор кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- {{ TF }}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [{#T}](./cluster-create.md).

    1. Измените или добавьте в описании кластера {{ mmy-name }} значение параметра `folder_id`:

        ```hcl
        resource "yandex_mdb_mysql_cluster" "<имя_кластера>" {
          ...
          folder_id = "<идентификатор_каталога_назначения>"
        }
        ```

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-mmy }}).

    {% include [Terraform timeouts](../../_includes/mdb/mmy/terraform/timeouts.md) %}

- API

    Чтобы переместить кластер, воспользуйтесь методом REST API [move](../api-ref/Cluster/move.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Move](../api-ref/grpc/cluster_service.md#Move) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
    * Идентификатор каталога назначения в параметре `destinationFolderId`.

{% endlist %}


## Изменить группы безопасности {#change-sg-set}

{% list tabs %}

- Консоль управления

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
    1. Выберите кластер и нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}** на панели сверху.
    1. В блоке **{{ ui-key.yacloud.mdb.forms.section_network }}** выберите группы безопасности для сетевого трафика кластера.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы изменить список [групп безопасности](../concepts/network.md#security-groups) для кластера:

    1. Посмотрите описание команды CLI для изменения кластера:

        ```bash
        {{ yc-mdb-my }} cluster update --help
        ```

    1. Укажите нужные группы безопасности в команде изменения кластера:

        ```bash
        {{ yc-mdb-my }} cluster update <имя_или_идентификатор_кластера> \
          --security-group-ids <список_идентификаторов_групп_безопасности>
        ```

- {{ TF }}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

      О том, как создать такой файл, см. в разделе [{#T}](./cluster-create.md).

  1. Измените в описании кластера {{ mmy-name }} значение параметра `security_group_ids`:

      ```hcl
      resource "yandex_mdb_mysql_cluster" "<имя_кластера>" {
        ...
        security_group_ids = [<список_идентификаторов_групп_безопасности>]
      }
      ```

  1. Проверьте корректность настроек.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-mmy }}).

  {% include [Terraform timeouts](../../_includes/mdb/mmy/terraform/timeouts.md) %}

- API

    Чтобы изменить список групп безопасности для кластера, воспользуйтесь методом REST API [update](../api-ref/Cluster/update.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Update](../api-ref/grpc/cluster_service.md#Update) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](./cluster-list.md#list-clusters).
    * Список идентификаторов групп безопасности в параметре `securityGroupIds`.
    * Список настроек, которые необходимо изменить (в данном случае — `securityGroupIds`), в параметре `updateMask`.

    {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

{% note warning %}

Может потребоваться дополнительная [настройка групп безопасности](connect.md#configure-security-groups) для подключения к кластеру.

{% endnote %}

