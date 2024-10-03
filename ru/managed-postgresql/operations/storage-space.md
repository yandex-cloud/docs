---
title: Управление дисковым пространством
description: При заполнении хранилища более чем на 97% хост автоматически переходит в режим read-only. Вы можете отслеживать степень заполнения хранилища, настраивать автоматическое увеличение его размера, отключать режим read-only
---

# Управление дисковым пространством

При заполнении [хранилища](../concepts/storage.md) более чем на 97% хост автоматически переходит в режим read-only. 
Чтобы избежать проблем с операциями записи в базу данных, воспользуйтесь одним из способов:


* [Настройте алерты в {{ monitoring-full-name }}](#set-alert), чтобы отслеживать степень заполнения хранилища.


* [Выведите кластер из режима read-only вручную](#read-only-solutions) и освободите место в хранилище, удалив часть данных.
* [Увеличьте размер хранилища](#change-disk-size), чтобы снять режим read-only автоматически.
* [Настройте автоматическое увеличение размера хранилища](#disk-size-autoscale).


## Настроить алерты в {{ monitoring-full-name }} {#set-alert}

1. Перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
1. Выберите сервис **{{ ui-key.yacloud_monitoring.services.label_postgresql }}**.
1. [Создайте канал уведомлений](../../monitoring/operations/alert/create-channel.md).
1. [Создайте алерт](../../monitoring/operations/alert/create-alert.md) со следующими параметрами:

    1. **{{ ui-key.yacloud_monitoring.alert.section_metrics }}** — задайте параметры метрики:

        * облако;
        * каталог;
        * сервис **{{ ui-key.yacloud_monitoring.services.label_postgresql }}**;
        * идентификатор кластера {{ mpg-name }};

            Идентификатор кластера можно [получить со списком кластеров в каталоге](../operations/cluster-list.md#list-clusters).

        * метка `disk.free_bytes`.

    1. **{{ ui-key.yacloud_monitoring.alert.title_conditions }}** — задайте условие `{{ ui-key.yacloud_monitoring.alert.title_comparison-lte }}` для процента заполнения свободного дискового пространства, при котором сработает алерт:

        * **{{ ui-key.yacloud_monitoring.alert.label_evaluation-type }}** — `{{ ui-key.yacloud_monitoring.alert-template.threshold-type.min }}` (минимальное значение метрики за период).
        * **{{ ui-key.yacloud_monitoring.alert.status_warn }}** — `90` (90% от размера хранилища).
        * **{{ ui-key.yacloud_monitoring.alert.status_alarm }}** — `95` (95% от размера хранилища).
        * **{{ ui-key.yacloud_monitoring.alert.label_evaluation-window }}** — желаемый период, с которым будет обновляться значение метрики.

    1. Добавьте созданный ранее канал уведомлений.


## Вывести кластер из режима read-only вручную {#read-only-solutions}

{% note alert %}

Не допускайте, чтобы во время выполнения указанных ниже действий свободное дисковое пространство уменьшилось до нуля. Поскольку предохранительный механизм отключен, {{ PG }} в этом случае аварийно завершит работу, а кластер станет неработоспособным.

{% endnote %}

Чтобы отключить режим read-only:

1. [Подключитесь к БД](../operations/connect.md) любым удобным способом.

1. Откройте транзакцию и внутри нее выполните команду:

    ```sql
    SET LOCAL transaction_read_only TO off;
    ```

1. В рамках этой же транзакции удалите ненужные данные с помощью операторов `DROP` или `TRUNCATE`. Не используйте оператор `DELETE` — при его использовании строки отмечаются как удаленные, но не удаляются из базы физически.

1. Зафиксируйте транзакцию и перезапустите все подключения к базе.

> Например, если ваша база содержит ненужную таблицу `ExcessDataTable1`, удалите ее с помощью транзакции:
>
> ```sql
> BEGIN;
> SET LOCAL transaction_read_only TO off;
> DROP TABLE ExcessDataTable1;
> COMMIT;
> ```

## Увеличить размер хранилища {#change-disk-size}

{% include [settings-dependence-on-storage](../../_includes/mdb/mpg/settings-dependence-on-storage.md) %}

{% include [note-increase-disk-size](../../_includes/mdb/note-increase-disk-size.md) %}


{% include [warn-storage-resize](../../_includes/mdb/mpg/warn-storage-resize.md) %}


{% list tabs group=instructions %}

- Консоль управления {#console}

    Чтобы увеличить размер хранилища для кластера:

    1. Перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
    1. Выберите кластер и нажмите кнопку ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}** на панели сверху.
    1. В блоке **{{ ui-key.yacloud.mdb.forms.section_disk }}** укажите необходимое значение.
    1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы увеличить размер хранилища для кластера:

    1. Посмотрите описание команды CLI для изменения кластера:

        ```bash
        {{ yc-mdb-pg }} cluster update --help
        ```

    1. Укажите нужный размер хранилища в команде изменения кластера (должен быть не меньше, чем значение `disk_size` в свойствах кластера):

        ```bash
        {{ yc-mdb-pg }} cluster update <имя_или_идентификатор_кластера> \
            --disk-size <размер_хранилища_ГБ>
        ```

- {{ TF }} {#tf}

    Чтобы увеличить размер хранилища для кластера:

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

        Полный список доступных для изменения полей конфигурации кластера {{ mpg-name }} см. в [документации провайдера {{ TF }}]({{ tf-provider-mpg }}).

    1. Измените в описании кластера {{ mpg-name }} значение атрибута `disk_size` в блоке `config.resources`:

        ```hcl
        resource "yandex_mdb_postgresql_cluster" "<имя_кластера>" {
          ...
          config {
            resources {
              disk_size = <размер_хранилища_в_гигабайтах>
              ...
            }
          }
        }
        ```

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

        {% include [Terraform timeouts](../../_includes/mdb/mpg/terraform/timeouts.md) %}

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [Cluster.update](../api-ref/Cluster/update.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

     {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

     ```bash
     curl \
       --request PATCH \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/<идентификатор_кластера>' \
       --data '{
                 "updateMask": "configSpec.resources.diskSize",
                 "configSpec": {
                   "resources": {
                     "diskSize": "<размер_хранилища_в_байтах>"
                   }
                 }
               }'
     ```

     Где:

     * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

       В данном случае передается только один параметр.

     * `configSpec.resources.diskSize` — новый размер хранилища в байтах.

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/update.md#responses).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Воспользуйтесь вызовом [ClusterService/Update](../api-ref/grpc/cluster_service.md#Update) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

     {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<идентификатор_кластера>",
             "update_mask": {
               "paths": [
                 "config_spec.resources.disk_size"
               ]
             },
             "config_spec": {
               "resources": {
                 "disk_size": "<размер_хранилища_в_байтах>"
               }
             }
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.postgresql.v1.ClusterService.Update
     ```

     Где:

     * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

       В данном случае передается только один параметр.

     * `config_spec.resources.disk_size` — новый размер хранилища в байтах.

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/cluster_service.md#Cluster3).

{% endlist %}

## Настроить автоматическое увеличение размера хранилища {#disk-size-autoscale}

{% include [settings-dependence-on-storage](../../_includes/mdb/mpg/settings-dependence-on-storage.md) %}

{% include [note-increase-disk-size](../../_includes/mdb/note-increase-disk-size.md) %}


{% include [warn-storage-resize](../../_includes/mdb/mpg/warn-storage-resize.md) %}


{% list tabs group=instructions %}

- Консоль управления {#console}

    1. Перейдите на страницу каталога и выберите сервис **{{ mpg-name }}**.
    1. Выберите кластер и нажмите кнопку **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** на панели сверху.
    1. В блоке **{{ ui-key.yacloud.mdb.cluster.section_disk-scaling }}**:

        1. В поле **{{ ui-key.yacloud.mdb.cluster.field_thresholds }}** задайте процент заполнения хранилища, при превышении которого хранилище будет увеличено. Можно задать правила для увеличения:

            * в следующее [окно обслуживания](../concepts/maintenance.md#maintenance-window);
            * незамедлительно.

            Можно задать оба правила, но порог для незамедлительного увеличения должен быть выше порога для увеличения в окно обслуживания.

        1. В поле **{{ ui-key.yacloud.mdb.cluster.field_diskSizeLimit }}** укажите максимальный размер хранилища, который может быть установлен при автоматическом увеличении размера хранилища.

    1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы настроить автоматическое увеличение размера хранилища:

    1. Посмотрите описание команды CLI для изменения кластера:

        ```bash
        {{ yc-mdb-pg }} cluster update --help
        ```

    1. Укажите максимальный размер хранилища и условия для его увеличения в команде изменения кластера.

        Максимальный размер хранилища должен быть больше, чем значение `disk_size` в свойствах кластера. Процент для незамедлительного увеличения хранилища должен быть больше процента для увеличения в следующее [окно обслуживания](../concepts/maintenance.md#maintenance-window).

        ```bash
        {{ yc-mdb-pg }} cluster update <идентификатор_или_имя_кластера> \
            --disk-size-autoscaling disk-size-limit=<максимальный_размер_хранилища_в_байтах>,`
                                   `planned-usage-threshold=<процент_для_планового_увеличения>,`
                                   `emergency-usage-threshold=<процент_для_незамедлительного_увеличения>
        ```

        Если настроено увеличение хранилища в окно обслуживания, настройте расписание окна обслуживания.

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [Cluster.update](../api-ref/Cluster/update.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

     {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

     ```bash
     curl \
       --request PATCH \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/<идентификатор_кластера>' \
       --data '{
                 "updateMask": "configSpec.diskSizeAutoscaling,maintenanceWindow",
                 "configSpec": {
                   "diskSizeAutoscaling": {
                     "plannedUsageThreshold": "<процент_для_планового_увеличения>",
                     "emergencyUsageThreshold": "<процент_для_незамедлительного_увеличения>",
                     "diskSizeLimit": "<максимальный_размер_хранилища_в_байтах>"
                   }
                 },
                 "maintenanceWindow": {
                   "weeklyMaintenanceWindow": {
                     "day": "<день_недели>",
                     "hour": "<час>"
                   }
                 }
               }'
     ```

     Где:

     * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

       В данном случае надо передать только параметры `configSpec.diskSizeAutoscaling` и `maintenanceWindow`.

     * `configSpec.diskSizeAutoscaling` — настройки автоматического увеличения размера хранилища:

       * `plannedUsageThreshold` — процент заполнения хранилища, при котором хранилище будет увеличено в следующее окно обслуживания.

         Значение задается в процентах от `0` до `100`. По умолчанию — `0` (автоматическое расширение отключено).

         Если вы задали этот параметр, настройте расписание окна технического обслуживания в параметре `maintenanceWindow`.

       * `emergencyUsageThreshold` — процент заполнения хранилища, при котором хранилище будет увеличено немедленно.

         Значение задается в процентах от `0` до `100`. По умолчанию — `0` (автоматическое расширение отключено). Должно быть не меньше значения `plannedUsageThreshold`.

       * `diskSizeLimit` — максимальный размер хранилища (в байтах), который может быть установлен при достижении одного из заданных процентов заполнения.

     * `maintenanceWindow` — расписание окна технического обслуживания. Нужно, только если вы задали параметр `plannedUsageThreshold`. Содержит следующие параметры:

       * `day` — день недели в формате `DDD`, когда должно проходить обслуживание.
       * `hour` — час в формате `HH`, когда должно проходить обслуживание. Возможные значения: от `1` до `24`.

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/Cluster/update.md#responses).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Воспользуйтесь вызовом [ClusterService/Update](../api-ref/grpc/cluster_service.md#Update) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

     {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<идентификатор_кластера>",
             "update_mask": {
               "paths": [
                 "config_spec.disk_size_autoscaling",
                 "maintenance_window"
               ]
             },
             "config_spec": {
               "disk_size_autoscaling": {
                 "planned_usage_threshold": "<процент_для_планового_увеличения>",
                 "emergency_usage_threshold": "<процент_для_незамедлительного_увеличения>",
                 "disk_size_limit": "<максимальный_размер_хранилища_в_байтах>"
               }
             },
             "maintenance_window": {
               "weekly_maintenance_window": {
                 "day": "<день_недели>",
                 "hour": "<час>"
               }
             }
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.postgresql.v1.ClusterService.Update
     ```

     Где:

     * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

       В данном случае надо передать только параметры `config_spec.disk_size_autoscaling` и `maintenance_window`.

     * `config_spec.disk_size_autoscaling` — настройки автоматического увеличения размера хранилища:

       * `planned_usage_threshold` — процент заполнения хранилища, при котором хранилище будет увеличено в следующее окно обслуживания.

         Значение задается в процентах от `0` до `100`. По умолчанию — `0` (автоматическое расширение отключено).

         Если вы задали этот параметр, настройте расписание окна технического обслуживания в параметре `maintenance_window`.

       * `emergency_usage_threshold` — процент заполнения хранилища, при котором хранилище будет увеличено немедленно.

         Значение задается в процентах от `0` до `100`. По умолчанию — `0` (автоматическое расширение отключено). Должно быть не меньше значения `planned_usage_threshold`.

       * `disk_size_limit` — максимальный размер хранилища (в байтах), который может быть установлен при достижении одного из заданных процентов заполнения.

     * `maintenance_window` — расписание окна технического обслуживания. Нужно, только если вы задали параметр `planned_usage_threshold`. Содержит следующие параметры:

       * `day` — день недели в формате `DDD`, когда должно проходить обслуживание.
       * `hour` — час в формате `HH`, когда должно проходить обслуживание. Возможные значения: от `1` до `24`.

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/cluster_service.md#Cluster3).

{% endlist %}

{% include [storage-resize-steps](../../_includes/mdb/mpg/storage-resize-steps.md) %}
