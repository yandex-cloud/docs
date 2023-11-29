---
title: "Управление дисковым пространством"
description: "При заполнении хранилища более чем на 97% хост автоматически переходит в режим read-only. Вы можете отслеживать степень заполнения хранилища, настраивать автоматическое увеличение его размера, отключать режим read-only"
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


{% list tabs %}

- Консоль управления

    Чтобы увеличить размер хранилища для кластера:

    1. Перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
    1. Выберите кластер и нажмите кнопку ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}** на панели сверху.
    1. В блоке **{{ ui-key.yacloud.mdb.forms.section_disk }}** укажите необходимое значение.
    1. Нажмите кнопку **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

- CLI

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

- {{ TF }}

    Чтобы увеличить размер хранилища для кластера:

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).

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

- API

    Чтобы увеличить размер хранилища для кластера, воспользуйтесь методом REST API [update](../api-ref/Cluster/update.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Update](../api-ref/grpc/cluster_service.md#Update) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор кластера, [получите список кластеров в каталоге](./cluster-list.md#list-clusters).
    * Новый размер хранилища в параметре `configSpec.resources.diskSize`.
    * Список настроек, которые необходимо изменить (в данном случае — `configSpec.resources.diskSize`), в параметре `updateMask`.

    {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Настроить автоматическое увеличение размера хранилища {#disk-size-autoscale}

{% include [settings-dependence-on-storage](../../_includes/mdb/mpg/settings-dependence-on-storage.md) %}

{% include [note-increase-disk-size](../../_includes/mdb/note-increase-disk-size.md) %}


{% include [warn-storage-resize](../../_includes/mdb/mpg/warn-storage-resize.md) %}


{% list tabs %}

- Консоль управления

    1. Перейдите на страницу каталога и выберите сервис **{{ mpg-name }}**.
    1. Выберите кластер и нажмите кнопку **Изменить кластер** на панели сверху.
    1. В блоке **Автоматическое увеличение размера хранилища**:

        1. В поле **Увеличивать размер** задайте процент заполнения хранилища, при превышении которого хранилище будет увеличено. Можно задать правила для увеличения:

            * в следующее окно обслуживания;
            * незамедлительно.

            Можно задать оба правила, но порог для незамедлительного увеличения должен быть выше порога для увеличения в окно обслуживания.

        1. В поле **Новый размер хранилища** укажите, какой размер хранилища будет установлен при выполнении любого из заданных условий.

    1. Нажмите кнопку **Сохранить изменения**.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы настроить автоматическое увеличение размера хранилища:

    1. Посмотрите описание команды CLI для изменения кластера:

        ```bash
        {{ yc-mdb-pg }} cluster update --help
        ```

    1. Укажите новый размер хранилища и условия для его увеличения в команде изменения кластера.

        Новый размер хранилища должен быть больше, чем значение `disk_size` в свойствах кластера. Процент для незамедлительного увеличения хранилища должен быть больше процента для увеличения в следующее окно обслуживания.

        ```bash
        {{ yc-mdb-pg }} cluster update <идентификатор_или_имя_кластера> \
            --disk-size-autoscaling disk-size-limit=<новый_размер_хранилища_в_байтах>,`
                                   `planned-usage-threshold=<процент_для_планового_увеличения>,`
                                   `emergency-usage-threshold=<процент_для_незамедлительного_увеличения>
        ```

- API

    Чтобы разрешить автоматическое увеличение размера хранилища, воспользуйтесь методом REST API [update](../api-ref/Cluster/update.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Update](../api-ref/grpc/cluster_service.md#Update) и передайте в запросе:

    {% include [api-storage-resize](../../_includes/mdb/mpg/api-storage-resize.md) %}

{% endlist %}

{% include [storage-resize-maintenance](../../_includes/mdb/mpg/storage-resize-maintenance.md) %}

{% include [storage-resize-reset](../../_includes/mdb/mpg/storage-resize-reset.md) %}
