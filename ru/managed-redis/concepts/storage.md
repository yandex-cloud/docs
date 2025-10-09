---
title: Хранилище в {{ mrd-full-name }}
description: Из статьи вы узнаете, какие типы дисков есть в {{ mrd-name }} и познакомитесь с особенностями выбора типа диска при создании кластера.
---

# Хранилище в {{ mrd-name }}



{{ mrd-name }} позволяет использовать сетевые и локальные диски для организации хранилища кластеров баз данных. Сетевые диски реализованы на базе сетевых блоков — виртуальных дисков в инфраструктуре {{ yandex-cloud }}. Локальные диски физически размещаются в серверах хостов БД.

{% include [storage-type](../../_includes/mdb/mrd/storage-type.md) %}

## Выбор типа диска при создании кластера {#storage-type-selection}

Количество хостов, которые можно создать вместе с кластером {{ VLK }}, зависит от выбранного типа диска и того, включено ли [шардирование](./sharding.md):

| Тип дисков                                                             | Нешардированный кластер  | Шардированный кластер    |
| ------------------------------------------------------------------------- | --------------------------------- | ----------------------------------|
| Сетевые SSD-диски (`network-ssd`), сверхбыстрые сетевые SSD-диски с тремя репликами (`network-ssd-io-m3`)                           | ⩾ 1 хоста                         | ⩾ 1 хоста (1 шард × 1 хост)     |
| Локальные SSD-диски (`local-ssd`)                           | ⩾ 3 хостов                        | ⩾ 2 хостов (1 шард × 2 хоста)    |
| Нереплицируемые SSD-диски (`network-ssd-nonreplicated`)     | ⩾ 3 хостов                        | ⩾ 3 хостов (1 шард × 3 хоста)    |

Шардированные кластеры с типом диска **local-ssd**, в которых на каждый шард приходится только один хост, не считаются отказоустойчивыми. Создать такой кластер нельзя.

Подробнее об ограничениях на количество хостов в кластере или шарде см. в разделе [Квоты и лимиты](./limits.md).


## Управление дисковым пространством {#manage-storage-space}

Когда хранилище заполняется на 100%, хосты кластера автоматически переходят в режим read-only. В этом режиме запросы на запись данных завершаются ошибкой. Чтобы вывести кластер из режима read-only, [увеличьте размер хранилища](../operations/update.md#change-disk-size) или обратитесь в [техническую поддержку]({{ link-console-support }}).

### Отслеживание перехода в read-only {#read-only-monitor}

Чтобы отслеживать степень заполнения хранилища кластера, настройте алерты в {{ monitoring-full-name }}:

1. Перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
1. [Создайте канал уведомлений](../../monitoring/operations/alert/create-channel.md).
1. [Создайте алерт](../../monitoring/operations/alert/create-alert.md) со следующими параметрами:

  1. **{{ ui-key.yacloud_monitoring.alert.section_metrics }}** — задайте параметры метрики:

      * Облако.
      * Каталог.
      * Сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-redis }}**.
      * Метка `disk.free_bytes`.
      * Нужный кластер {{ mrd-short-name }}. Имя и идентификатор кластера можно [получить со списком кластеров в каталоге](../operations/cluster-list.md#list-clusters).

  1. **{{ ui-key.yacloud_monitoring.alert.title_conditions }}** — задайте условие для заполнения свободного дискового пространства, при котором сработает алерт:

      * **{{ ui-key.yacloud_monitoring.alert.label_evaluation-type }}** — `{{ ui-key.yacloud_monitoring.alert-template.threshold-type.min }}` (минимальное значение метрики за период).
      * **{{ ui-key.yacloud_monitoring.monitoring-alerts.threshold-table.trigger-condition }}** — `{{ ui-key.yacloud_monitoring.alert.title_comparison-lte }}`.
      * **{{ ui-key.yacloud_monitoring.alert.status_warn }}** — `90` (90 % от размера хранилища).
      * **{{ ui-key.yacloud_monitoring.alert.status_alarm }}** — `95` (95 % от размера хранилища).
      * **{{ ui-key.yacloud_monitoring.alert.label_evaluation-window }}** — желаемый период, с которым будет обновляться значение метрики.
      * **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.time-shift }}** — предпочтительный сдвиг по времени назад в секундах. Позволяет исключить срабатывания алерта, когда в нем указано несколько метрик и они собираются с разным интервалом. Подробнее о задержке вычисления см. в [документации {{ monitoring-full-name }}](../../monitoring/concepts/alerting/alert.md#evaluation-delay).

  1. **Уведомления** — добавьте созданный ранее канал уведомлений.

### Автоматическое увеличение размера хранилища {#auto-rescale}

Автоматическое увеличение размера хранилища позволяет избежать ситуаций, когда свободное место на диске закончилось и хосты перешли в режим read-only. Хранилище увеличивается, когда достигнут установленный порог срабатывания — процент от общего объема хранилища. Есть два порога:

* Порог для планового увеличения. Когда он достигнут, объем хранилища увеличивается во время ближайшего [окна обслуживания](maintenance.md#maintenance-window). Если задан этот порог, [настройте](../operations/update.md#change-additional-settings) расписание обслуживания.
* Порог для незамедлительного увеличения. Когда он достигнут, объем хранилища увеличивается немедленно.

Можно использовать один либо оба порога. Если заданы оба, порог для незамедлительного увеличения должен быть выше, чем порог для планового.

{% include [storage-resize-steps](../../_includes/mdb/mrd/storage-resize-steps.md) %}

Настроить автоматическое увеличение размера хранилища можно при [создании](../operations/cluster-create.md) или [изменении](../operations/update.md#disk-size-autoscale) кластера.


{% include [warn-storage-resize](../../_includes/mdb/mrd/warn-storage-resize.md) %}



## Шифрование диска {#disk-encryption}

{% include [disk-encryption](../../_includes/mdb/disk-encryption.md) %}


## Примеры использования {#examples}

* [{#T}](../tutorials/redis-as-php-sessions-storage.md)
* [{#T}](../tutorials/data-migration.md)
