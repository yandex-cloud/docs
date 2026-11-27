---
title: Хранилище в {{ mos-full-name }}
description: Из статьи вы узнаете, какие типы дисков есть в {{ mos-name }} и познакомитесь с особенностями выбора типа хранилища при создании кластера.
alternate:
  - href: ru/managed-opensearch/concepts/storage.md
    type: text/markdown
    title: Markdown version
---

# Хранилище в {{ mos-name }}



{{ mos-name }} позволяет использовать сетевые и локальные диски для организации хранилища кластеров баз данных. Сетевые диски реализованы на базе сетевых блоков — виртуальных дисков в инфраструктуре {{ yandex-cloud }}. Локальные диски физически размещаются в серверах кластера.

{% include [storage-type](../../_includes/mdb/mos/storage-type.md) %}

## Выбор типа хранилища при создании кластера {#storage-type-selection}

Количество хостов с ролью `DATA`, которые можно создать вместе с кластером {{ OS }}, зависит от выбранного типа хранилища:

* Вы можете создать кластер только из трех или более хостов при использовании следующих типов дисков:

    * локальные SSD-диски (`local-ssd`);
    * нереплицируемые SSD-диски (`network-ssd-nonreplicated`).
    
   Хранилище на локальных SSD-дисках влияет на тарификацию кластера: он тарифицируется, даже если остановлен. Подробнее в [правилах тарификации](../pricing.md).

* Вы можете добавить любое количество хостов в пределах текущей квоты при использовании следующих типов дисков:

   * сетевые HDD-диски (`network-hdd`);
   * сетевые SSD-диски (`network-ssd`);
   * сверхбыстрые сетевые SSD-диски с тремя репликами (`network-ssd-io-m3`).

Подробнее об ограничениях на количество хостов в кластере в разделе [Квоты и лимиты](./limits.md).

Для обеспечения [высокой доступности кластера](high-availability.md) вы можете настроить [репликацию индексов](scalability-and-resilience.md#replication) (только для многохостовых конфигураций кластера).


## Управление дисковым пространством {#manage-storage-space}

Когда хранилище заполняется на 95%, хосты кластера автоматически переходят в режим read-only. В этом режиме запросы на запись данных завершаются ошибкой. Чтобы вывести хосты из режима read-only, [увеличьте](../operations/host-groups.md#update-host-group) размер хранилища или обратитесь в [техническую поддержку]({{ link-console-support }}).

### Отслеживание перехода в read-only {#read-only-monitor}

Чтобы отслеживать степень заполнения хранилища кластера, настройте алерты в {{ monium-full-name }}:

1. [Перейдите]({{ link-monium }}) в **{{ ui-key.yacloud.iam.folder.dashboard.label_monium }}**.
1. На панели сверху выберите [проект](../../monium/concepts/glossary.md#project), в котором будет создан алерт.

    Это может быть как проект, автоматически созданный для [каталога](../../resource-manager/concepts/resources-hierarchy.md#folder) (`folder__<идентификатор_каталога>`), так и другой доступный проект.
1. [Создайте канал уведомлений](../../monium/operations/alert/create-channel.md).
1. [Создайте алерт](../../monium/operations/alert/create-alert.md) со следующими параметрами:

   1. **{{ ui-key.yacloud_monitoring.alert.title_name }}** — задайте название алерта.

   1. В блоке **Настройки алерта** задайте метки запроса:

      * `project = folder__<идентификатор_каталога>` — проект каталога, в котором находится кластер {{ mos-name }}.

          {% include [query-select-different-project](../../_includes/monium/query-select-different-project.md) %}

      * `cluster = default`.
      * `service = __managed-opensearch__`.
      * `name = disk.free_bytes`.
      * `resource_id = <идентификатор_кластера>` — идентификатор кластера {{ mos-name }}. Его можно [получить со списком кластеров в каталоге](../operations/cluster-list.md#list-clusters).
      * `host = <fqdn_хоста>` — хост, свободное место на котором нужно отслеживать.

   1. **{{ ui-key.yacloud_monitoring.alert.title_conditions }}** — задайте условие уменьшения свободного дискового пространства, при котором сработает алерт:

      * **{{ ui-key.yacloud_monitoring.alert.label_evaluation-type }}** — `{{ ui-key.yacloud_monitoring.alert-template.threshold-type.min }}` (минимальное значение метрики за период).
      * **{{ ui-key.yacloud_monitoring.monitoring-alerts.threshold-table.trigger-condition }}** — `{{ ui-key.yacloud_monitoring.alert.title_comparison-lte }}`.
      * **{{ ui-key.yacloud_monitoring.alert.status_warn }}** — свободное место в байтах, соответствующее 10% размера хранилища хоста (90% занято).
      * **{{ ui-key.yacloud_monitoring.alert.status_alarm }}** — свободное место в байтах, соответствующее 5% размера хранилища хоста (95% занято).
      * **{{ ui-key.yacloud_monitoring.alert.label_evaluation-window }}** — период, за который вычисляется минимальное значение метрики.
      * **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.time-shift }}** — предпочтительный сдвиг по времени назад в секундах. Позволяет исключить срабатывания алерта, когда в нем указано несколько метрик и они собираются с разным интервалом. Подробнее о задержке вычисления в [документации {{ monium-full-name }}](../../monium/concepts/alerting/alert.md#evaluation-delay).

      Например, для хранилища размером 100 ГБ укажите порог `10737418240` байтов для `{{ ui-key.yacloud_monitoring.alert.status_warn }}` и `5368709120` байтов для `{{ ui-key.yacloud_monitoring.alert.status_alarm }}`. При изменении размера хранилища пересчитайте пороги.

   1. **Уведомления** — добавьте созданный ранее канал уведомлений.

1. Нажмите **{{ ui-key.yacloud_monitoring.actions.common.create }}**.

### Автоматическое увеличение размера хранилища {#auto-rescale}

Автоматическое увеличение размера хранилища позволяет избежать ситуаций, когда свободное место на диске закончилось и хосты перешли в режим read-only. Хранилище увеличивается, когда достигнут установленный порог срабатывания — процент от общего объема хранилища. Есть два порога:

* Порог для планового увеличения. Когда он достигнут, объем хранилища увеличивается во время ближайшего [окна обслуживания](maintenance.md#maintenance-window). Если задан этот порог, [настройте](../operations/update.md#change-additional-settings) расписание обслуживания.
* Порог для незамедлительного увеличения. Когда он достигнут, объем хранилища увеличивается немедленно.

Можно использовать один либо оба порога. Если заданы оба, порог для незамедлительного увеличения должен быть выше, чем порог для планового.

{% include [storage-resize-steps](../../_includes/mdb/mos/storage-resize-steps.md) %}

Настроить автоматическое увеличение размера хранилища можно при [создании кластера](../operations/cluster-create.md), а также при [создании](../operations/host-groups.md#add-host-group) или [изменении](../operations/host-groups.md#update-host-group) группы хостов.


{% include [warn-storage-resize](../../_includes/mdb/mos/warn-storage-resize.md) %}



## Шифрование диска {#disk-encryption}

{% include [disk-encryption](../../_includes/mdb/disk-encryption.md) %}

