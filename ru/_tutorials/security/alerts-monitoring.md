# Настройка дашбордов и алертов в {{ monium-full-name }}

В руководстве описано, как отслеживать состояние [трейлов](../../audit-trails/concepts/trail.md) с помощью [дашбордов](../../monium/concepts/visualization/dashboard.md) и [алертов](../../monium/concepts/alerting/alert.md) [{{ monium-full-name }}](../../monium/).

Руководство предполагает, что у вас уже развернута инфраструктура:

* Есть ресурсы {{ yandex-cloud }}, события безопасности которых нужно собирать.
* Создан [трейл](../../audit-trails/concepts/trail.md) {{ at-name }} для сбора событий.
* Настроен [объект назначения](../../audit-trails/concepts/trail.md#target) для хранения аудитных логов: [бакет](../../storage/concepts/bucket.md), [поток данных](../../data-streams/concepts/glossary.md#stream-concepts) или [лог-группа](../../logging/concepts/log-group.md).

Чтобы начать отслеживать статус трейлов:

* [Настройте алерты](#setup-alerts).
* [Настройте дашборд](#setup-dashboard).

Если ресурсы вам больше не нужны, [удалите их](#clear-out).

## Настройте алерты {#setup-alerts}

Выберите [проект {{ monium-name }}](../../monium/collector/project.md) для каталога, в котором находится трейл: `folder__<идентификатор_каталога>`. В этом проекте доступны метрики трейла и квоты трейлов на облако — `quota.trails_count.usage` и `quota.trails_count.limit`. Канал уведомлений и алерты создавайте в этом же проекте.

### Создайте канал уведомлений {#create-channel}

Чтобы получать уведомления о срабатывании алерта:

{% list tabs group=instructions %}

- Интерфейс {{ monium-name }} {#console}

  1. Перейдите на главную страницу [{{ monium-name }}]({{ link-monium }}).
  1. В верхней панели нажмите название текущего проекта и выберите проект каталога с трейлом.
  1. На панели слева выберите ![alt](../../_assets/console-icons/shield-exclamation.svg) **Алерты и SLO** → ![alt](../../_assets/console-icons/bell.svg) **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.notification-methods.title }}**.
  1. В правом верхнем углу нажмите кнопку **{{ ui-key.yacloud_monitoring.actions.common.create }}** и выберите **{{ ui-key.yacloud_monitoring.notification-methods.create-button.channel }}**.
  1. Укажите параметры канала:
     * В поле **{{ ui-key.yacloud_monitoring.channel.field_name }}** укажите `alerts-channel`.
     * В поле **{{ ui-key.yacloud_monitoring.channel.field_method }}** выберите метод уведомлений и заполните его параметры.
     * В поле **По умолчанию для уровней** оставьте все уровни невыбранными: далее вы подключите канал к конкретным алертам.
  1. Нажмите кнопку **{{ ui-key.yacloud_monitoring.actions.common.save }}**.

{% endlist %}

Канал появится в списке.

### Добавьте алерты {#add-alerts}

Вы можете настроить один или несколько алертов.

Подробнее о [создании алерта](../../monium/operations/alert/create-alert.md) и его [параметрах](../../monium/concepts/alerting/alert.md#alert-parameters) в документации {{ monium-name }}.

#### Переход трейла в неактивное состояние {#deactivating-trail}

Алерт отправит уведомление о том, что трейл переходит в неактивный статус.

{% list tabs group=instructions %}

- Интерфейс {{ monium-name }} {#console}

  1. Перейдите на главную страницу [{{ monium-name }}]({{ link-monium }}).
  1. В верхней панели нажмите название текущего проекта и выберите проект каталога с трейлом.
  1. На панели слева выберите ![alt](../../_assets/console-icons/shield-exclamation.svg) **Алерты и SLO** → ![alt](../../_assets/console-icons/megaphone.svg) **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.alerts.title }}**.
  1. В правом верхнем углу нажмите кнопку **{{ ui-key.yacloud_monitoring.monitoring-alerts.header.create-button }}** и выберите **{{ ui-key.yacloud_monitoring.monitoring-alerts.button.create-custom-title }}**.
  1. В поле **{{ ui-key.yacloud_monitoring.alert.title_name }}** укажите `deactivating-trail-alert`.
  1. В блоке **{{ ui-key.yacloud_monitoring.alert.title_alerts-config }}** задайте метки запроса `A`:

     * `project = folder__<идентификатор_каталога>` — проект каталога с трейлом.
     * `cluster = default`.
     * `service = __audit-trails__`.
     * `name = trail.status`.
     * `status != ACTIVE`.
     * `trail = <идентификатор_трейла>`.

  1. В блоке **Условия срабатывания** задайте параметры:

     * **Запрос для проверки** — `A`.
     * **Функция агрегации** — **{{ ui-key.yacloud_monitoring.monitoring-alerts.threshold-type.last-non-nan }}**.
     * **{{ ui-key.yacloud_monitoring.monitoring-alerts.threshold-table.trigger-condition }}** — **{{ ui-key.yacloud_monitoring.alert.title_comparison-ne }}**.
     * **{{ ui-key.yacloud_monitoring.alert.label_warning }}** — очистите поле: в примере используется только порог `Alarm`.
     * **{{ ui-key.yacloud_monitoring.alert.label_alarm }}** — `0`.
     * **{{ ui-key.yacloud_monitoring.alert.label_evaluation-window }}** — `5m`.

  1. В блоке **Обработка отсутствия данных** для параметров **Отсутствие точек в окне вычисления** и **Отсутствие метрик по селектору** выберите `No data`. Это позволит отличать отсутствие данных от нулевого значения метрики.

  1. В блоке **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.notification-channels }}** нажмите **{{ ui-key.yacloud_monitoring.actions.common.edit }}**. Добавьте канал `alerts-channel`, [созданный ранее](#create-channel), и выберите статусы срабатывания: `Alarm`, `No data` и `OK`.
  1. Нажмите **{{ ui-key.yacloud_monitoring.monitoring-alerts.action.calculate-alert }}**. Убедитесь, что запрос возвращает нужные метрики и статус алерта соответствует их значениям.
  1. Нажмите кнопку **{{ ui-key.yacloud_monitoring.actions.common.create }}**.

{% endlist %}

Алерт создан.

#### Прекращение доставки аудитных логов в объект назначения {#stopping-logs}

Алерт перейдет в статус `Alarm`, если все значения частоты доставки событий за окно вычисления равны нулю. Например, доставка может прекратиться из-за нехватки свободного места в бакете.

Нулевая частота доставки также возможна, если новых событий нет. Используйте этот алерт для трейлов с регулярным потоком событий. При срабатывании сравните [частоту обработки и доставки событий](#create-missing-events-chart) и проверьте [лог диагностики](../../audit-trails/concepts/diagnostics.md).

Для параметра **{{ ui-key.yacloud_monitoring.alert.label_evaluation-window }}** задайте интервал, превышающий обычные паузы между доставками, например `15m`. Выберите его по графику доставки событий: частота зависит от активности ресурсов в области сбора трейла.

{% list tabs group=instructions %}

- Интерфейс {{ monium-name }} {#console}

  1. Перейдите на главную страницу [{{ monium-name }}]({{ link-monium }}).
  1. В верхней панели нажмите название текущего проекта и выберите проект каталога с трейлом.
  1. На панели слева выберите ![alt](../../_assets/console-icons/shield-exclamation.svg) **Алерты и SLO** → ![alt](../../_assets/console-icons/megaphone.svg) **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.alerts.title }}**.
  1. В правом верхнем углу нажмите кнопку **{{ ui-key.yacloud_monitoring.monitoring-alerts.header.create-button }}** и выберите **{{ ui-key.yacloud_monitoring.monitoring-alerts.button.create-custom-title }}**.
  1. В поле **{{ ui-key.yacloud_monitoring.alert.title_name }}** укажите `stopping-logs-alert`.
  1. В блоке **{{ ui-key.yacloud_monitoring.alert.title_alerts-config }}** задайте метки запроса `A`:

     * `project = folder__<идентификатор_каталога>` — проект каталога с трейлом.
     * `cluster = default`.
     * `service = __audit-trails__`.
     * `name = trail.delivered_events_count`.
     * `trail = <идентификатор_трейла>`.

  1. В блоке **Условия срабатывания** задайте параметры:

     * **Запрос для проверки** — `A`.
     * **Функция агрегации** — **{{ ui-key.yacloud_monitoring.monitoring-alerts.threshold-type.at-all-times }}**.
     * **{{ ui-key.yacloud_monitoring.monitoring-alerts.threshold-table.trigger-condition }}** — **{{ ui-key.yacloud_monitoring.alert.title_comparison-eq }}**.
     * **{{ ui-key.yacloud_monitoring.alert.label_warning }}** — очистите поле: в примере используется только порог `Alarm`.
     * **{{ ui-key.yacloud_monitoring.alert.label_alarm }}** — `0`.
     * **{{ ui-key.yacloud_monitoring.alert.label_evaluation-window }}** — `<окно_вычисления>`.

  1. В блоке **Обработка отсутствия данных** для параметров **Отсутствие точек в окне вычисления** и **Отсутствие метрик по селектору** выберите `No data`. Это позволит отличать отсутствие данных от нулевого значения метрики.

  1. В блоке **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.notification-channels }}** нажмите **{{ ui-key.yacloud_monitoring.actions.common.edit }}**. Добавьте канал `alerts-channel`, [созданный ранее](#create-channel), и выберите статусы срабатывания: `Alarm`, `No data` и `OK`.
  1. Нажмите **{{ ui-key.yacloud_monitoring.monitoring-alerts.action.calculate-alert }}**. Убедитесь, что запрос возвращает нужные метрики и статус алерта соответствует их значениям.
  1. Нажмите кнопку **{{ ui-key.yacloud_monitoring.actions.common.create }}**.

{% endlist %}

Алерт создан.

#### Изменение количества трейлов {#number-trails}

Алерт отправит уведомление о том, что число трейлов в облаке изменилось.

{% list tabs group=instructions %}

- Интерфейс {{ monium-name }} {#console}

  1. Перейдите на главную страницу [{{ monium-name }}]({{ link-monium }}).
  1. В верхней панели нажмите название текущего проекта и выберите проект каталога с трейлом.
  1. На панели слева выберите ![alt](../../_assets/console-icons/shield-exclamation.svg) **Алерты и SLO** → ![alt](../../_assets/console-icons/megaphone.svg) **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.alerts.title }}**.
  1. В правом верхнем углу нажмите кнопку **{{ ui-key.yacloud_monitoring.monitoring-alerts.header.create-button }}** и выберите **{{ ui-key.yacloud_monitoring.monitoring-alerts.button.create-custom-title }}**.
  1. В поле **{{ ui-key.yacloud_monitoring.alert.title_name }}** укажите `number-trails-alert`.
  1. В блоке **{{ ui-key.yacloud_monitoring.alert.title_alerts-config }}** задайте метки запроса `A`:

     * `project = folder__<идентификатор_каталога>` — проект каталога с трейлом.
     * `cluster = default`.
     * `service = __audit-trails__`.
     * `name = quota.trails_count.usage`.

  1. В блоке **Условия срабатывания** задайте параметры:

     * **Запрос для проверки** — `A`.
     * **Функция агрегации** — **{{ ui-key.yacloud_monitoring.monitoring-alerts.threshold-type.last-non-nan }}**.
     * **{{ ui-key.yacloud_monitoring.monitoring-alerts.threshold-table.trigger-condition }}** — **{{ ui-key.yacloud_monitoring.alert.title_comparison-ne }}**.
     * **{{ ui-key.yacloud_monitoring.alert.label_warning }}** — очистите поле: в примере используется только порог `Alarm`.
     * **{{ ui-key.yacloud_monitoring.alert.label_alarm }}** — `<текущее_количество_трейлов>`.
     * **{{ ui-key.yacloud_monitoring.alert.label_evaluation-window }}** — `5m`.

  1. В блоке **Обработка отсутствия данных** для параметров **Отсутствие точек в окне вычисления** и **Отсутствие метрик по селектору** выберите `No data`. Это позволит отличать отсутствие данных от нулевого значения метрики.

  1. В блоке **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.notification-channels }}** нажмите **{{ ui-key.yacloud_monitoring.actions.common.edit }}**. Добавьте канал `alerts-channel`, [созданный ранее](#create-channel), и выберите статусы срабатывания: `Alarm`, `No data` и `OK`.
  1. Нажмите **{{ ui-key.yacloud_monitoring.monitoring-alerts.action.calculate-alert }}**. Убедитесь, что запрос возвращает нужные метрики и статус алерта соответствует их значениям.
  1. Нажмите кнопку **{{ ui-key.yacloud_monitoring.actions.common.create }}**.

{% endlist %}

#### Использование квоты трейлов в облаке {#trail-quota}

Алерт отправит уведомление, когда будет использовано более 80% квоты на количество трейлов в облаке.

{% list tabs group=instructions %}

- Интерфейс {{ monium-name }} {#console}

  1. Перейдите на главную страницу [{{ monium-name }}]({{ link-monium }}).
  1. В верхней панели нажмите название текущего проекта и выберите проект каталога с трейлом.
  1. На панели слева выберите ![alt](../../_assets/console-icons/shield-exclamation.svg) **Алерты и SLO** → ![alt](../../_assets/console-icons/megaphone.svg) **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.alerts.title }}**.
  1. В правом верхнем углу нажмите кнопку **{{ ui-key.yacloud_monitoring.monitoring-alerts.header.create-button }}** и выберите **{{ ui-key.yacloud_monitoring.monitoring-alerts.button.create-custom-title }}**.
  1. В поле **{{ ui-key.yacloud_monitoring.alert.title_name }}** укажите `trail-quota-alert`.
  1. В блоке **{{ ui-key.yacloud_monitoring.alert.title_alerts-config }}** задайте метки запроса `A`:

     * `project = folder__<идентификатор_каталога>` — проект каталога с трейлом.
     * `cluster = default`.
     * `service = __audit-trails__`.
     * `name = quota.trails_count.usage`.

  1. В блоке **Условия срабатывания** задайте параметры:

     * **Запрос для проверки** — `A`.
     * **Функция агрегации** — **{{ ui-key.yacloud_monitoring.monitoring-alerts.threshold-type.last-non-nan }}**.
     * **{{ ui-key.yacloud_monitoring.monitoring-alerts.threshold-table.trigger-condition }}** — **{{ ui-key.yacloud_monitoring.alert.title_comparison-gt }}**.
     * **{{ ui-key.yacloud_monitoring.alert.label_warning }}** — очистите поле: в примере используется только порог `Alarm`.
     * **{{ ui-key.yacloud_monitoring.alert.label_alarm }}** — `<порог_количества_трейлов>`.
     * **{{ ui-key.yacloud_monitoring.alert.label_evaluation-window }}** — `5m`.

     Рассчитайте порог как `0,8 × quota.trails_count.limit`, где `quota.trails_count.limit` — текущая квота трейлов на облако. При изменении квоты обновите порог.

  1. В блоке **Обработка отсутствия данных** для параметров **Отсутствие точек в окне вычисления** и **Отсутствие метрик по селектору** выберите `No data`. Это позволит отличать отсутствие данных от нулевого значения метрики.

  1. В блоке **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.notification-channels }}** нажмите **{{ ui-key.yacloud_monitoring.actions.common.edit }}**. Добавьте канал `alerts-channel`, [созданный ранее](#create-channel), и выберите статусы срабатывания: `Alarm`, `No data` и `OK`.
  1. Нажмите **{{ ui-key.yacloud_monitoring.monitoring-alerts.action.calculate-alert }}**. Убедитесь, что запрос возвращает нужные метрики и статус алерта соответствует их значениям.
  1. Нажмите кнопку **{{ ui-key.yacloud_monitoring.actions.common.create }}**.

{% endlist %}

## Настройте дашборд {#setup-dashboard}

Готовые графики для наблюдения за состоянием трейлов находятся в [консоли управления]({{ link-console-main }}) → сервис **{{ at-name }}** → раздел ![image](../../_assets/console-icons/display-pulse.svg) **{{ ui-key.yacloud.common.monitoring }}**.

Чтобы отслеживать не только состояние трейлов, но и состояние объектов назначения, куда они доставляют аудитные логи, создайте дашборд в {{ monium-name }}.

### Создайте дашборд {#create-dashboard}

{% list tabs group=instructions %}

- Интерфейс {{ monium-name }} {#console}

  1. Перейдите на главную страницу [{{ monium-name }}]({{ link-monium }}).
  1. В верхней панели нажмите название текущего проекта и выберите проект каталога с трейлом.
  1. На панели слева выберите ![image](../../_assets/console-icons/layout-cells-large.svg) **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.dashboards.title }}**.
  1. Нажмите **{{ ui-key.yacloud_monitoring.actions.common.create }}**.
  1. Справа вверху нажмите ![image](../../_assets/console-icons/floppy-disk.svg) **{{ ui-key.yacloud_monitoring.navigation.dialogs.title_save-dashboard }}**.
  1. В открывшемся окне введите название дашборда, например `missing-events`, и нажмите **{{ ui-key.yacloud_monitoring.actions.common.save }}**.

{% endlist %}

### Создайте график для отслеживания доставки событий {#create-missing-events-chart}

Динамику обработки и доставки событий можно отслеживать по [метрикам {{ at-name }}](../../audit-trails/concepts/user-metrics.md):

* `trail.processed_events_count` — частота событий, принятых в обработку.
* `trail.delivered_events_count` — частота событий, доставленных в объект назначения.

Скопируйте на дашборд готовый график, который сравнивает частоту обработки и доставки событий:

1. Откройте дашборд трейла в {{ monium-name }}:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      1. Откройте [консоль управления]({{ link-console-main }}).
      1. [Перейдите]({{ link-console-main }}/link/audit-trails) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_audit-trails }}**.
      1. На панели слева выберите ![image](../../_assets/console-icons/route.svg) **{{ ui-key.yacloud.audit-trails.label_trails }}**.
      1. Выберите нужный трейл.
      1. Перейдите на вкладку **{{ ui-key.yacloud.common.monitoring }}** для выбранного трейла.
      1. Справа вверху нажмите **{{ ui-key.yacloud.monitoring.button_open-in-monitoring }}**.

          Откроется интерфейс {{ monium-name }}.

    {% endlist %}

1. Скопируйте график:

    {% list tabs group=instructions %}

    - Интерфейс {{ monium-name }} {#console}

      1. Найдите график **Processed versus delivered events**.
      1. Справа от названия графика нажмите ![horizontal-ellipsis](../../_assets/horizontal-ellipsis.svg) → **{{ ui-key.yacloud_monitoring.dashboard.widget.copy }}**.
      1. Укажите название, например `Processed versus delivered events — <имя_трейла>`.
      1. Выберите проект и дашборд, который вы [создали ранее](#create-dashboard).
      1. Нажмите **{{ ui-key.yacloud_monitoring.component.add-to-dashboard-form.action.copy-and-go }}**.

          Откроется ваш дашборд с новым графиком.

    {% endlist %}

При необходимости аналогичным способом добавьте на дашборд графики из других трейлов.

### Изучите график доставки событий {#investigate-missing-events-chart}

Обратите внимание на отставание **Delivered events** от **Processed events**. На графике могут быть кратковременные провалы, за которыми следуют всплески: трейл может временно накапливать события, а затем доставлять их в объект назначения. Если отставание сохраняется час или дольше, проверьте статус и [лог диагностики](../../audit-trails/concepts/diagnostics.md) трейла.

#### Узнайте статус трейла {#get-trail-status}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Откройте [консоль управления]({{ link-console-main }}).
  1. [Перейдите]({{ link-console-main }}/link/audit-trails) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_audit-trails }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/route.svg) **{{ ui-key.yacloud.audit-trails.label_trails }}**.
  1. Выберите трейл. На странице **{{ ui-key.yacloud.audit-trails.label_trail }}** отобразится подробная информация о трейле.

{% endlist %}

Статус `Active` означает, что трейл продолжает собирать аудитные логи с доступных ресурсов. Если при этом сохраняется отставание **Delivered events** от **Processed events**, проверьте состояние объекта назначения и его логи:

* [{#T}](../../storage/operations/buckets/get-info.md)
* [Получение информации о лог-группе](../../logging/operations/index.md#log-group-info)
* [{#T}](../../data-streams/operations/index.md)

Статус `Error` сообщает об ошибке в работе трейла. В этом случае изучите лог диагностики трейла.

#### Изучите лог диагностики трейла {#get-trail-diagnostics}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Откройте [консоль управления]({{ link-console-main }}).
  1. [Перейдите]({{ link-console-main }}/link/audit-trails) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_audit-trails }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/route.svg) **{{ ui-key.yacloud.audit-trails.label_trails }}**.
  1. Выберите трейл.
  1. Перейдите на панель ![image](../../_assets/console-icons/receipt.svg) **{{ ui-key.yacloud.audit-trails.logs }}** и изучите лог.
  1. [Ознакомьтесь](../../audit-trails/operations/error.md) с рекомендациями по обработке ошибок.

{% endlist %}

### Создайте график для объекта назначения {#create-destination-chart}

Дополнительно к графику сравнения обработки и доставки событий можно добавить график для объекта назначения:

* **{{ objstorage-name }}**

    Прекращение доставки логов может быть связано с достижением заданного максимального размера бакета. Чтобы отслеживать занятый объем и сравнивать его с ограничением, создайте график по [метрике](../../monitoring/metrics-ref/storage-ref.md) `space_usage` и добавьте метрику `max_size` в качестве порогового значения.

    Метрика `max_size` недоступна, если для бакета не задан максимальный размер. В таком случае контролируйте использование [квоты](../../storage/concepts/limits.md#storage-quotas) на объем хранилища в облаке.

* **{{ cloud-logging-name }}**

    [Добавьте на дашборд](../../logging/tutorials/log-group-record-monitoring.md) график по [метрике](../../monitoring/metrics-ref/logging-ref.md) `group.service.ingested_records_per_second` — она отображает скорость записи логов в лог-группу. Сравнение этой величины с установленной [квотой](../../logging/concepts/limits.md#logging-quotas) `Максимальная скорость записи` помогает определить, приближается ли поток логов к максимально разрешенной скорости. Дополнительный график по метрике `group.service.ingest_requests_per_second` со статусом `ERROR` позволит вовремя обнаружить ошибки при записи.


* **{{ yds-name }}** — подробнее в документации [{{ ydb-full-name }}](../../ydb/):
  * [{#T}](../../ydb/metrics.md)
  * [{#T}](../../ydb/concepts/limits.md)

  Подробнее о решении проблем с записью данных смотрите в разделе [{#T}](../../data-streams/tutorials/slow-writes-debug.md).

  {% note tip %}

  {% include [yds-compressing-events](../../_includes/audit-trails/yds-compressing-events.md) %}

  {% endnote %}



## Как удалить созданные ресурсы {#clear-out}

* [Удалите алерты](../../monium/operations/alert/delete-alert.md).
* Удалите дашборд:

  {% list tabs group=instructions %}

  - Интерфейс {{ monium-name }} {#console}

    1. Перейдите на главную страницу [{{ monium-name }}]({{ link-monium }}).
    1. В верхней панели выберите проект, в котором вы создали дашборд.
    1. На панели слева выберите ![image](../../_assets/console-icons/layout-cells-large.svg) **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.dashboards.title }}**.
    1. Напротив названия нужного дашборда нажмите ![image](../../_assets/console-icons/ellipsis.svg) → **{{ ui-key.yacloud.common.delete }}**.
    1. Подтвердите удаление.

  {% endlist %}
