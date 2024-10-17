---
title: Как изменить настройки кластера {{ GP }} в {{ mgp-full-name }}
description: Следуя данной инструкции, вы сможете изменить настройки кластера {{ GP }}.
---

# Изменение настроек кластера {{ GP }}


После создания кластера вы можете:

* [{#T}](#change-name-and-description).

* [{#T}](#change-public-access).

* [{#T}](#change-additional-settings).

* [{#T}](#change-gp-settings).

* [{#T}](#change-resource-preset).

* [{#T}](#change-disk-size).

* [Настроить серверы {{ GP }} согласно документации {{ GP }}](#change-gp-settings).

Если вы хотите переместить кластер в другую зону доступности, [восстановите его из резервной копии](cluster-backups.md#restore). Во время восстановления укажите новую зону доступности. В результате вы перенесете хосты кластера.

Если вы используете [внешние источники данных](../concepts/external-tables.md) для работы по протоколу PXF, [узнайте, как настроить протокол](./pxf/settings.md). Так можно оптимизировать работу с внешними данными.

## Изменить имя и описание кластера {#change-name-and-description}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите [на страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
    1. Выберите кластер и нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}** в верхней части страницы.
    1. В блоке **{{ ui-key.yacloud.mdb.forms.section_base }}** задайте новые имя и описание кластера.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы изменить имя и описание кластера {{ GP }}:

  1. Посмотрите текущие имя (`name`) и описание (`description`) кластера:

     ```bash
     {{ yc-mdb-gp }} cluster get <имя_или_идентификатор_кластера>
     ```

  1. Посмотрите описание команды CLI для изменения конфигурации кластера:

      ```bash
      {{ yc-mdb-gp }} cluster update --help
      ```

  1. Задайте новое имя и описание кластера:

      ```bash
      {{ yc-mdb-gp }} cluster update <имя_или_идентификатор_кластера> \
         --new-name <новое_имя_кластера> \
         --description <новое_описание_кластера>
      ```

- API {#api}

    Чтобы изменить имя и описание кластера, воспользуйтесь методом REST API [update](../api-ref/Cluster/update.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Update](../api-ref/grpc/Cluster/update.md) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
    * Новое имя в параметре `name`.
    * Новое описание в параметре `description`.
    * Список изменяемых полей конфигурации кластера в параметре `updateMask` (в данном случае — `name`, `description`).

    {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Изменить настройку публичного доступа {#change-public-access}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите [на страницу каталога]({{ link-console-main }}) и выберите сервис **{{ mgp-name }}**.
    1. Выберите кластер и нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}** в верхней части страницы.
    1. В блоке **{{ ui-key.yacloud.mdb.forms.section_network-settings }}** установите или отключите опцию **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}**.
    1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы изменить настройку публичного доступа {{ GP }}:

  1. Посмотрите описание команды CLI для изменения конфигурации кластера:

      ```bash
      {{ yc-mdb-gp }} cluster update --help
      ```

  1. Задайте настройку публичного доступа в параметре `--assign-public-ip`:

      ```bash
      {{ yc-mdb-gp }} cluster update <имя_или_идентификатор_кластера> \
         --assign-public-ip=<публичный_доступ_к_кластеру>
      ```

      Где `assign-public-ip` — публичный доступ к кластеру: true или false.

- API {#api}

    Воспользуйтесь методом API [update](../api-ref/Cluster/update.md) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
    * Настройку публичного доступа в параметре `config.assignPublicIp`.
    * Список изменяемых полей конфигурации кластера в параметре `updateMask` (в данном случае — `name`, `description`).

    {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

{% note tip %}

Если вы включили публичный доступ к кластеру, но подключение через интернет не срабатывает:

* Проверьте [настройки групп безопасности](./connect#configuring-security-groups).
* Подождите некоторое время. Включение публичного доступа иногда вступает в силу не сразу.

{% endnote %}

## Изменить дополнительные настройки кластера {#change-additional-settings}

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
    1. Выберите кластер и нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}** на панели сверху.
    1. Измените дополнительные настройки кластера:

        * {% include [Backup time](../../_includes/mdb/console/backup-time.md) %}
        * **{{ ui-key.yacloud.mdb.forms.maintenance-window-type }}** — настройки времени [технического обслуживания](../concepts/maintenance.md):

            {% include [Maintenance window](../../_includes/mdb/console/maintenance-window-description.md) %}


        * {% include [Datalens access](../../_includes/mdb/console/datalens-access.md) %}
        * {% include [Query access](../../_includes/mdb/console/query-access.md) %}



        * {% include [Deletion protection](../../_includes/mdb/console/deletion-protection.md) %}

            {% include [Ограничения защиты от удаления](../../_includes/mdb/deletion-protection-limits-db.md) %}

        * **{{ ui-key.yacloud.greenplum.section_cloud-storage }}** — включает [расширение {{ YZ }}](https://github.com/yezzey-gp/yezzey/) от {{ yandex-cloud }}. Оно применяется, чтобы [выгрузить таблицы AO и AOCO](../tutorials/yezzey.md) с дисков кластера {{ mgp-name }} в холодное хранилище {{ objstorage-full-name }}. Так данные хранятся в служебном бакете в сжатом и зашифрованном виде. Это [более экономичный способ хранения](../../storage/pricing.md).

            Эту опцию нельзя отключить после сохранения настроек кластера.


            {% note info %}

            Функциональность находится на стадии [Preview](../../overview/concepts/launch-stages.md) и не тарифицируется.

            {% endnote %}


        * **{{ ui-key.yacloud.mdb.forms.section_pooler }}** — режим работы и параметры [менеджера подключений](../concepts/pooling.md):

            {% include [Pooling mode](../../_includes/mdb/mgp/pooling-mode.md) %}

    1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы изменить дополнительные настройки кластера:

    1. Посмотрите описание команды CLI для изменения кластера:

        ```bash
        {{ yc-mdb-gp }} cluster update --help
        ```

    1. Выполните команду, передав список настроек, которые хотите изменить:


        ```bash
        {{ yc-mdb-gp }} cluster update <имя_или_идентификатор_кластера> \
            --backup-window-start <время_начала_резервного_копирования> \
            --datalens-access=<доступ_из_{{ datalens-name }}> \
            --yandexquery-access=<доступ_из_Yandex_Query> \
            --maintenance-window type=<тип_технического_обслуживания>,`
                                `day=<день_недели>,`
                                `hour=<час_дня> \
            --assign-public-ip=<публичный_доступ_к_кластеру> \
            --deletion-protection
        ```




    Вы можете изменить следующие настройки:

    {% include [backup-window-start](../../_includes/mdb/cli/backup-window-start.md) %}


    * `--datalens-access` — доступ к кластеру из сервиса [{{ datalens-full-name }}](../../datalens/concepts/index.md): `true` или `false`.

    * `--yandexquery-access` — доступ к кластеру из сервиса [{{ yq-full-name }}](../../query/concepts/index.md): `true` или `false`.



    * `--maintenance-window` — настройки времени [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров), где `type` — тип технического обслуживания:

        {% include [maintenance-window](../../_includes/mdb/cli/maintenance-window-description.md) %}

    * `--assign-public-ip` — доступность кластера из интернета.

    * {% include [Deletion protection](../../_includes/mdb/cli/deletion-protection.md) %}

        {% include [Ограничения защиты от удаления кластера](../../_includes/mdb/deletion-protection-limits-db.md) %}

    Имя кластера можно [получить со списком кластеров в каталоге](cluster-list.md#list-clusters).

- API {#api}

    Чтобы изменить дополнительные настройки кластера, воспользуйтесь методом REST API [update](../api-ref/Cluster/update.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Update](../api-ref/grpc/Cluster/update.md) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
    * Публичный доступ в параметре `config.assignPublicIp`.
    * Окно резервного копирования в параметре `config.backupWindowStart`.


    * Доступ к кластеру из сервиса [{{ datalens-full-name }}](../../datalens/concepts/index.md) в параметре `config.access.dataLens`.
    * Доступ к кластеру из сервиса [{{ yq-full-name }}](../../query/concepts/index.md) в параметре `config.access.yandexQuery`.



    * Время [технического обслуживания](../concepts/maintenance.md) (в т. ч. для выключенных кластеров) в параметре `maintenanceWindow`.
    * Защиту от удаления кластера в параметре `deletionProtection`.

        {% include [Ограничения защиты от удаления](../../_includes/mdb/deletion-protection-limits-db.md) %}

    * Список изменяемых полей конфигурации кластера в параметре `updateMask`.

    {% include [note-api-updatemask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Изменить настройки регламентных операций технического обслуживания {#change-background-settings}

Вы можете изменить настройки [регламентных операций технического обслуживания](../concepts/maintenance.md#regular-ops) вашего кластера.

{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
    1. Выберите кластер и нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}** на панели сверху.
    1. В блоке **{{ ui-key.yacloud.greenplum.section_background-activities }}** измените параметры:

        {% include [background activities](../../_includes/mdb/mgp/background-activities-console.md) %}

    1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- API {#api}

    Чтобы изменить настройки регламентных операций технического обслуживания кластера, воспользуйтесь методом REST API [update](../api-ref/Cluster/update.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Update](../api-ref/grpc/Cluster/update.md) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
    * Новые значения параметров для объекта`configSpec.backgroundActivities.analyzeAndVacuum`:

        * `start.hours` — час начала операции `VACUUM` по UTC. Возможные значения: от `0` до `23`, по умолчанию — `19`.
        * `start.minutes` — минута начала операции `VACUUM` по UTC. Возможные значения: от `0` до `59`, по умолчанию — `0`.
        * `vacuumTimeout` — максимальная длительность выполнения операции `VACUUM`, в секундах. Возможные значения: от `7200` до `86399`, по умолчанию — `36000`. Когда указанное время истечет, операция `VACUUM` будет принудительно завершена.
        * `analyzeTimeout` — максимальная длительность выполнения операции `ANALYZE`, в секундах. Возможные значения: от `7200` до `86399`, по умолчанию — `36000`. Когда указанное время истечет, операция `ANALYZE` будет принудительно завершена.

    * Список изменяемых полей конфигурации кластера в параметре `updateMask`.

  {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Изменить настройки {{ GP }} {#change-gp-settings}

Вы можете изменить настройки СУБД для хостов вашего кластера.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
  1. Выберите кластер и нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}** на панели сверху.
  1. Измените [настройки {{ GP }}](../concepts/settings-list.md), нажав кнопку **{{ ui-key.yacloud.mdb.forms.button_configure-settings }}** в блоке **{{ ui-key.yacloud.mdb.forms.section_settings }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.component.mdb.settings.popup_settings-submit }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы изменить [настройки СУБД {{ GP }}](../concepts/settings-list.md):

  1. Посмотрите полный список настроек, установленных для кластера:

     ```bash
     {{ yc-mdb-gp }} cluster get <имя_или_идентификатор_кластера>
     ```

  1. Посмотрите описание команды CLI для изменения конфигурации кластера:

      ```bash
      {{ yc-mdb-gp }} cluster update-config --help
      ```

  1. Установите нужные значения параметров:

      Все поддерживаемые параметры перечислены в [формате запроса для метода update](../api-ref/Cluster/update.md), в поле `greenplumConfig_<версия_Greenplum>`. Чтобы указать имя параметра в вызове CLI, преобразуйте его имя из вида <q>lowerCamelCase</q> в <q>snake_case</q>, например, параметр `maxConnections` из запроса к API преобразуется в `max_connections` для команды CLI:

      ```bash
      {{ yc-mdb-gp }} cluster update-config <имя_или_идентификатор_кластера> \
         --set <имя_параметра1>=<значение1>,<имя_параметра2>=<значение2>,...
      ```

      {{ mgp-short-name }} запустит операцию по изменению настроек кластера.

- API {#api}

    Чтобы изменить настройки {{ GP }}, воспользуйтесь методом REST API [update](../api-ref/Cluster/update.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Update](../api-ref/grpc/Cluster/update.md) и передайте в запросе:

    * Новые значения в параметре `configSpec.greenplumConfig_<версия>`.
    * Список полей конфигурации кластера, подлежащих изменению, в параметре `updateMask`.

        {% include [note-api-updatemask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Изменить класс хостов {#change-resource-preset}

Вы можете изменить класс как хостов-мастеров, так и хостов-сегментов. При смене класса хостов:

* В кластере сменится первичный хост-мастер.
* Подключение по [особому FQDN](./connect.md#fqdn-master) не гарантирует стабильность соединения с БД: пользовательские сессии могут быть прерваны.

Рекомендуется изменять класс хостов только во время отсутствия рабочей нагрузки на кластер.

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
  1. Выберите кластер и нажмите кнопку ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}** на панели сверху.
  1. В блоке **{{ ui-key.yacloud.mdb.forms.section_resource }}** выберите нужный класс для хостов-мастеров или хостов-сегментов {{ GP }}.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы изменить [класс хостов](../concepts/instance-types.md) для кластера:

  1. Посмотрите описание команды CLI для изменения кластера:

      ```bash
      {{ yc-mdb-gp }} cluster update --help
      ```

  1. Запросите список доступных классов (в колонке `ZONE IDS` указаны зоны доступности, в которых можно выбрать соответствующий класс):
     * для хостов-мастеров:

        ```bash
        {{ yc-mdb-gp }} resource-preset list master
        ```

     * для хостов-сегментов:

        ```bash
        {{ yc-mdb-gp }} resource-preset list segment
        ```


     ```text
     +-------------+--------------------------------+--------------------------------+-------+----------+--------------------+---------------------+
     |     ID      |            ZONE IDS            |           DISK TYPES           | CORES |  MEMORY  | HOST COUNT DIVIDER | MAX SEGMENT IN HOST |
     +-------------+--------------------------------+--------------------------------+-------+----------+--------------------+---------------------+
     | i2.2xlarge  | {{ region-id }}-a, {{ region-id }}-b   | local-ssd,                     |    16 | 128.0 GB |                  1 |                   0 |
     |             |                                | network-ssd-nonreplicated      |       |          |                    |                     |
     | ...                                                                                                                                         |
     +-------------+--------------------------------+--------------------------------+-------+----------+--------------------+---------------------+
     ```


  1. Укажите нужные классы в команде изменения кластера:

      ```bash
      {{ yc-mdb-gp }} cluster update <имя_или_идентификатор_кластера> \
          --master-config resource-id=<идентификатор_класса_хостов-мастеров> \
          --segment-config resource-id=<идентификатор_класса_хостов-сегментов>
      ```

      {{ mgp-short-name }} запустит операцию изменения класса хостов для кластера.

- {{ TF }} {#tf}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

      О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

      Полный список доступных для изменения полей конфигурации кластера {{ mgp-name }} см. в [документации провайдера {{ TF }}]({{ tf-provider-mgp }}).

  1. Измените в описании кластера {{ mgp-name }} значение атрибута `resource_preset_id` в блоке `master_subcluster.resources` или `segment_subcluster.resources`:

      ```hcl
      resource "yandex_mdb_greenplum_cluster" "<имя_кластера>" {
        ...
        master_subcluster {
          resources {
            resource_preset_id = "<класс_хоста>"
            ...
          }
        segment_subcluster {
          resources {
            resource_preset_id = "<класс_хоста>"
            ...
          }
        }
      }
      ```

  1. Проверьте корректность настроек.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      {% include [Terraform timeouts](../../_includes/mdb/mgp/terraform-timeouts.md) %}

- API {#api}

  Чтобы изменить класс хостов для кластера, воспользуйтесь методом REST API [update](../api-ref/Cluster/update.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Update](../api-ref/grpc/Cluster/update.md) и передайте в запросе:

  * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор кластера, [получите список кластеров в каталоге](./cluster-list.md#list-clusters).
  * Идентификатор класса хоста-мастера в параметре `masterConfig.resources.resourcePresetId` или идентификатор класса хоста-сегмента в параметре `segmentConfig.resources.resourcePresetId`. Список поддерживаемых значений можно получить, воспользовавшись методом [list](../api-ref/ResourcePreset/list.md) для ресурса `ResourcePreset`.
  * Список настроек, которые необходимо изменить (в данном случае — `masterConfig.resources.resourcePresetId` или `segmentConfig.resources.resourcePresetId`), в параметре `updateMask`.

  {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Увеличить размер хранилища {#change-disk-size}

{% include [note-increase-disk-size](../../_includes/mdb/note-increase-disk-size.md) %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  Чтобы увеличить размер хранилища для кластера:

  1. В [консоли управления]({{ link-console-main }}) перейдите в каталог с нужным кластером.
  1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-greenplum }}**.
  1. Выберите нужный кластер.
  1. В верхней части страницы нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}**.
  1. Измените настройки в блоке **{{ ui-key.yacloud.mdb.forms.section_storage }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

- API {#api}

  Чтобы увеличить размер хранилища для кластера, воспользуйтесь методом REST API [update](../api-ref/Cluster/update.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Update](../api-ref/grpc/Cluster/update.md) и передайте в запросе:

  * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](./cluster-list.md#list-clusters).
  * Новый размер хранилища мастера и сегмента в параметрах `masterConfig.resources.diskSize` и `segmentConfig.resources.diskSize`.
  * Список изменяемых полей конфигурации кластера в параметре `updateMask`.

  {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
