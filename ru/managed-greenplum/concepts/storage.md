# Типы дисков в {{ mgp-name }}


{{ mgp-name }} позволяет использовать сетевые и локальные диски для организации хранилища кластеров баз данных. Сетевые диски реализованы на базе сетевых блоков — виртуальных дисков в инфраструктуре {{ yandex-cloud }}. Локальные диски физически размещаются в серверах кластера.

{% include [storage-type](../../_includes/mdb/mgp/storage-type.md) %}

В кластере {{ mgp-name }} тип дисков у хостов-мастеров и хостов-сегментов может отличаться.

{% include [ice-lake-local-ssd-note](../../_includes/ice-lake-local-ssd-note.md) %}

## Особенности хранилища на локальных SSD-дисках {#local-storage-features}

Хранилище на локальных SSD-дисках не обеспечивает отказоустойчивости хранения данных, а также влияет на тарификацию кластера в целом: кластер с таким хранилищем тарифицируется, даже если он остановлен. Подробнее — в [правилах тарификации](../pricing).


## Управление дисковым пространством {#manage-storage-space}

При заполнении хранилища любого хоста более чем на 95% кластер автоматически переходит в режим read-only. При этом для всех баз данных через запрос `ALTER DATABASE` выставляется настройка `DEFAULT_TRANSACTION_READ_ONLY = TRUE`.

В этом режиме запросы на вставку (`INSERT`), удаление (`DELETE`) или обновление (`UPDATE`) данных завершаются ошибкой.


### Отслеживание перехода в read-only {#read-only-monitor}

Чтобы отслеживать степень заполнения хранилища на хостах кластера, настройте алерты в {{ monitoring-full-name }}:

1. Перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
1. Выберите сервис **{{ mgp-name }}**.
1. [Создайте канал уведомлений](../../monitoring/operations/alert/create-channel.md).
1. [Создайте алерт](../../monitoring/operations/alert/create-alert.md) со следующими параметрами:

    1. **{{ ui-key.yacloud.common.metric }}** — задайте параметры метрики:

        * облако;
        * каталог;
        * сервис **{{ mgp-name }}**;
        * идентификатор кластера {{ mgp-name }};

            Идентификатор кластера можно [получить со списком кластеров в каталоге](../operations/cluster-list.md#list-clusters).

        * метка `disk.free_bytes`.

    1. **{{ ui-key.yacloud_monitoring.alert.label_trigger-condition }}** — задайте условие `{{ ui-key.yacloud_monitoring.alert.title_comparison-lte }}` для процента заполнения свободного дискового пространства, при котором сработает алерт:

        * 95% от размера хранилища для `{{ ui-key.yacloud_monitoring.alert.status_alarm }}`;
        * 90% от размера хранилища для `{{ ui-key.yacloud_monitoring.alert.status_warn }}`.

    1. **{{ ui-key.datalens.component.chartkit-alerts.view.section_additional-settings }}**:

        * **{{ ui-key.yacloud_monitoring.service.field.function }}** — `{{ ui-key.yacloud_monitoring.alert.title_aggregation-min }}` (минимальное значение метрики за период).
        * **{{ ui-key.yacloud_monitoring.alert-template.field.evaluation-window }}** — желаемый период, с которым будет обновляться значение метрики.

    1. Добавьте созданный ранее канал уведомлений.


### Вывод кластера из режима read-only {#read-only-solutions}

Если кластер перешел в режим read-only:

* [Увеличьте размер хранилища](../operations/update.md#change-disk-size), чтобы выйти за пороговое значение. Тогда {{ yandex-cloud }} снимет режим read-only автоматически.

* Вручную отключите режим read-only и освободите место в хранилище, удалив часть данных.

    {% note alert %}

    Не допускайте, чтобы в процессе этих действий свободное дисковое пространство уменьшилось до нуля. Поскольку предохранительный механизм отключен, {{ GP }} в этом случае аварийно завершит работу, а кластер станет неработоспособным.

    {% endnote %}

Чтобы отключить режим read-only вручную, обратитесь в [техническую поддержку]({{ link-console-support }}) или следуйте инструкции:

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

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
