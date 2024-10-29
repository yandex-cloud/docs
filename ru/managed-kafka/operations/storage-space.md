---
title: Управление дисковым пространством
description: Вы можете отслеживать степень заполнения хранилища и увеличивать его размер вручную или автоматически.
---

# Управление дисковым пространством в кластере {{ mkf-name }}

При заполнении [хранилища](../concepts/storage.md) более чем на 97% хост автоматически переходит в режим read-only. Чтобы избежать проблем с операциями записи в базу данных, воспользуйтесь одним из способов:


* [Настройте алерты в {{ monitoring-full-name }}](#set-alert), чтобы отслеживать степень заполнения хранилища.


* [Увеличьте размер хранилища](#change-disk-size), чтобы снять режим read-only автоматически.
* [Настройте автоматическое увеличение размера хранилища](#disk-size-autoscale).


## Настроить алерты в {{ monitoring-full-name }} {#set-alert}

1. Перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
1. [Создайте канал уведомлений](../../monitoring/operations/alert/create-channel.md).
1. [Создайте алерт](../../monitoring/operations/alert/create-alert.md) со следующими параметрами:

    1. **{{ ui-key.yacloud_monitoring.alert.section_metrics }}** — задайте параметры метрики:

        * облако;
        * каталог;
        * сервис **{{ ui-key.yacloud_monitoring.services.label_managed-kafka }}**;
        * идентификатор кластера {{ mpg-name }};

            Идентификатор кластера можно [получить со списком кластеров в каталоге](../operations/cluster-list.md#list-clusters).

        * метка `disk.free_bytes`.

    1. **{{ ui-key.yacloud_monitoring.alert.title_conditions }}** — задайте условие для заполнения свободного дискового пространства, при котором сработает алерт:

        * **{{ ui-key.yacloud_monitoring.alert.label_evaluation-type }}** — `{{ ui-key.yacloud_monitoring.alert-template.threshold-type.min }}` (минимальное значение метрики за период).
        * **{{ ui-key.yacloud_monitoring.monitoring-alerts.threshold-table.trigger-condition }}** — `{{ ui-key.yacloud_monitoring.alert.title_comparison-lte }}`.
        * **{{ ui-key.yacloud_monitoring.alert.status_warn }}** — `95` (95% от размера хранилища).
        * **{{ ui-key.yacloud_monitoring.alert.status_alarm }}** — `90` (90% от размера хранилища).
        * **{{ ui-key.yacloud_monitoring.alert.label_evaluation-window }}** — желаемый период, с которым будет обновляться значение метрики.
        * **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.time-shift }}** — предпочтительный сдвиг по времени назад в секундах. Позволяет исключить срабатывания алерта, когда в нем указано несколько метрик и они собираются с разным интервалом. Подробнее о задержке вычисления см. в [документации {{ monitoring-full-name }}](../../monitoring/concepts/alerting/alert.md#evaluation-delay).

    1. **Уведомления** — добавьте созданный ранее канал уведомлений.


## Увеличить размер хранилища {#change-disk-size}

{% include [note-increase-disk-size](../../_includes/mdb/note-increase-disk-size.md) %}

{% list tabs group=instructions %}

* Консоль управления {#console}

    Чтобы увеличить размер хранилища для кластера:

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
    1. В строке с нужным кластером нажмите ![image](../../_assets/console-icons/ellipsis.svg), затем выберите ![pencil](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}**.
    1. Измените настройки в блоке **{{ ui-key.yacloud.mdb.forms.section_storage }}**.

        Тип диска для кластера {{ KF }} нельзя изменить после создания.

    1. Нажмите кнопку **{{ ui-key.yacloud.common.save }}**.

* CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы увеличить размер хранилища для хостов:

    1. Посмотрите описание команды CLI для изменения кластера:

        ```bash
        {{ yc-mdb-kf }} cluster update --help
        ```

    1. Чтобы изменить объем хранилища хостов-брокеров, выполните команду:

        ```bash
        {{ yc-mdb-kf }} cluster update <имя_или_идентификатор_кластера> \
           --disk-size <объем_хранилища>
        ```

        Если не указаны единицы размера, то используются гигабайты.

    1. Чтобы изменить объем хранилища хостов {{ ZK }}, выполните команду:

        ```bash
        {{ yc-mdb-kf }} cluster update <имя_или_идентификатор_кластера> \
           --zookeeper-disk-size <размер_диска>
        ```

        Если не указаны единицы размера, то используются гигабайты.

    Тип диска для кластера {{ KF }} нельзя изменить после создания.

* {{ TF }} {#tf}

  Чтобы увеличить размер хранилища для кластера:

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

    1. Измените в описании кластера {{ mkf-name }} значение параметра `disk_size` в блоках `kafka.resources` и `zookeeper.resources` для хостов {{ KF }} и {{ ZK }} соответственно:

        ```hcl
        resource "yandex_mdb_kafka_cluster" "<имя_кластера>" {
          ...
          kafka {
            resources {
              disk_size = <размер_хранилища_ГБ>
              ...
            }
            ...
          }
          zookeeper {
            resources {
              disk_size = <размер_хранилища_ГБ>
              ...
            }
          }
        }
        ```

        Тип диска для кластера {{ KF }} нельзя изменить после создания.

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_kafka_cluster).

    {% include [Terraform timeouts](../../_includes/mdb/mkf/terraform/cluster-timeouts.md) %}

* API {#api}

    Чтобы увеличить размер хранилища для кластера, воспользуйтесь методом REST API [update](../api-ref/Cluster/update.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Update](../api-ref/grpc/Cluster/update.md) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
    * Новые настройки хранилища в параметре `configSpec.kafka.resources` (`configSpec.zookeeper.resources` — для хостов {{ ZK }}).
    * Список настроек, которые необходимо изменить, в параметре `updateMask`.

    Тип диска для кластера {{ KF }} нельзя изменить после создания.

    {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Настроить автоматическое увеличение размера хранилища {#disk-size-autoscale}

Чтобы место на диске кластера не заканчивалось, настройте [автоматическое увеличение размера хранилища](../concepts/storage.md#auto-rescale).

{% include [note-increase-disk-size](../../_includes/mdb/note-increase-disk-size.md) %}


{% include [warn-storage-resize](../../_includes/mdb/mpg/warn-storage-resize.md) %}


{% list tabs group=instructions %}

* Консоль управления {#console}

    1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-kafka }}**.
    1. В строке с нужным кластером нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg), затем выберите **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}**.
    1. В блоке **{{ ui-key.yacloud.mdb.cluster.section_disk-scaling }}** задайте [пороги заполненности](../concepts/storage.md#auto-rescale) хранилища, при достижении которых его размер будет увеличиваться: 
    
        {% include [autoscale-settings](../../_includes/mdb/mkf/autoscale-settings.md) %}        

* CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Чтобы настроить автоматическое увеличение размера хранилища:

    1. Посмотрите описание команды CLI для изменения кластера:

        ```bash
        {{ yc-mdb-kf }} cluster update --help
        ```

    1. Укажите максимальный размер хранилища и условия для его увеличения в команде изменения кластера:

        ```bash
        {{ yc-mdb-kf }} cluster update <идентификатор_или_имя_кластера> \
           --disk-size-autoscaling planned-usage-threshold=<процент_для_планового_увеличения>,`
                                  `emergency-usage-threshold=<процент_для_незамедлительного_увеличения>,`
                                  `disk-size-limit=<максимальный_размер_хранилища_в_байтах>
        ```

        {% include [description-of-parameters](../../_includes/mdb/mkf/disk-auto-scaling.md) %}

* API {#api}

    Чтобы разрешить автоматическое увеличение размера хранилища, воспользуйтесь методом REST API [update](../api-ref/Cluster/update.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Update](../api-ref/grpc/Cluster/update.md) и передайте в запросе:

    {% include [api-storage-resize](../../_includes/mdb/mpg/api-storage-resize.md) %}

{% endlist %}

{% include [storage-resize-steps](../../_includes/mdb/mkf/storage-resize-steps.md) %}


{% include [warn-storage-resize](../../_includes/mdb/mpg/warn-storage-resize.md) %}

