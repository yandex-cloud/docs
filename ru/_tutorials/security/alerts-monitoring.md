# Настройка дашбордов и алертов в {{ monitoring-full-name }}

Из руководства вы узнаете, как отслеживать состояние [трейлов](../../audit-trails/concepts/trail.md) с помощью [дашбордов](../../monitoring/concepts/visualization/dashboard.md) и [алертов](../../monitoring/concepts/alerting.md#alert) [{{ monitoring-full-name }}](../../monitoring/).

Руководство предполагает, что у вас уже развернута инфраструктура: 

* Есть ресурсы {{ yandex-cloud }}, для которых вы собираете события безопасности.
* Создан [трейл](../../audit-trails/concepts/trail.md) {{ at-name }} для сбора событий.
* Настроен [приемник](../../audit-trails/concepts/trail.md#target) для хранения и управления событиями: [бакет](../../storage/concepts/bucket.md), [поток данных](../../data-streams/concepts/glossary.md#stream-concepts) или [лог-группа](../../logging/concepts/log-group.md)

Чтобы начать отслеживать статус трейлов:

* [Настройте алерты](#setup-alerts).
* [Настройте дашборд](#setup-dashboard).

Если ресурсы вам больше не нужны, [удалите их](#clear-out).

## Настройте алерты {#setup-alerts}

### Создайте канал уведомлений {#create-channel}

Чтобы получать уведомления о срабатывании алерта:

1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите создать канал уведомлений.
1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
1. На панели слева выберите **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.channels.title }}**.
1. В правом верхнем углу нажмите кнопку **{{ ui-key.yacloud_monitoring.channel.button_new-channel }}**.
1. Укажите параметры канала:
    * В поле **{{ ui-key.yacloud_monitoring.channel.field_name }}** укажите `alerts-channel`.
    * В поле **{{ ui-key.yacloud_monitoring.channel.field_method }}** укажите метод уведомлений.
    * В поле **{{ ui-key.yacloud_monitoring.channel.field_recipients }}** перечислите получателей уведомлений.
1. Нажмите кнопку **{{ ui-key.yacloud_monitoring.channel.button_create }}**. 

Канал появится в списке.

### Добавьте алерты {#add-alerts}

Вы можете настроить один или несколько алертов.

Более подробная информация о порядке [создания алерта](../../monitoring/operations/alert/create-alert.md) и о [параметрах алерта](../../monitoring/concepts/alerting.md#alert-parameters) приведена в документации {{ monitoring-full-name }}.

#### Переход трейла в неактивное состояние {#deactivating-trail}

Алерт отправит уведомление о том, что трейл переходит в неактивный статус.

1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите создать алерт.
1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
1. На панели слева выберите **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.alerts.title }}**.
1. В правом верхнем углу нажмите кнопку **{{ ui-key.yacloud_monitoring.alert.button_create-alert }}**.
1. В поле **{{ ui-key.yacloud_monitoring.alert.title_name }}** укажите `deactivating-trail-alert`. 
1. В блоке **{{ ui-key.yacloud_monitoring.alert.section_metrics }}** справа от имени каталога нажмите ![image](../../_assets/console-icons/plus.svg) и укажите:
    1. `service = Audit Trails`. 
    1. `name = trail.status`.
    1. `status != ACTIVE`.
    1. `trail = <имя_трейла>`.
1. В блоке **{{ ui-key.yacloud_monitoring.alert.section_alert-conditions }}** укажите:
    1. **{{ ui-key.yacloud_monitoring.alert.label_trigger-condition }}** — `{{ ui-key.yacloud_monitoring.alert.title_comparison-ne }}`.
    1. **{{ ui-key.yacloud_monitoring.alert.label_alarm }}** — `0`.
1. В блоке **{{ ui-key.yacloud_monitoring.alert.section_notifications }}** нажмите кнопку **{{ ui-key.yacloud_monitoring.alert.button_add-channel }}** и выберите канал уведомления, [созданный ранее](#create-channel).
1. Нажмите кнопку **{{ ui-key.yacloud_monitoring.alert.button_create-alert }}**. 

Алерт создан.

#### Прекращение доставки аудитных логов в объект назначения {#stopping-logs}

Алерт отправит уведомление о том, что трейл прекратил загружать аудитные логи в объект назначения, например, по причине нехватки свободного места в бакете.

Параметр **{{ ui-key.yacloud_monitoring.alert.label_evaluation-window }}** зависит от конкретного трейла. В зависимости от типа и количества ресурсов в блоке сбора аудитных логов трейла, частота загрузки аудитных логов в объект назначения будет варьироваться. 

1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите создать алерт.
1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
1. На панели слева выберите **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.alerts.title }}**.
1. В правом верхнем углу нажмите кнопку **{{ ui-key.yacloud_monitoring.alert.button_create-alert }}**.
1. В поле **{{ ui-key.yacloud_monitoring.alert.title_name }}** укажите `stopping-logs-alert`. 
1. В блоке **{{ ui-key.yacloud_monitoring.alert.section_metrics }}** справа от имени каталога нажмите ![image](../../_assets/console-icons/plus.svg) и укажите:
    1. `service = Audit Trails`. 
    1. `name = trail.delivered_events_count`.
    1. `trail = <имя_трейла>`.
1. В блоке **{{ ui-key.yacloud_monitoring.alert.section_alert-conditions }}** укажите:
    1. **{{ ui-key.yacloud_monitoring.alert.label_trigger-condition }}** — `{{ ui-key.yacloud_monitoring.alert.title_comparison-eq }}`.
    1. **{{ ui-key.yacloud_monitoring.alert.label_alarm }}** — `0`.
    1. **{{ ui-key.yacloud_monitoring.alert.label_evaluation-window }}** — `<значение_для_трейла>`.
1. В блоке **{{ ui-key.yacloud_monitoring.alert.section_notifications }}** нажмите кнопку **{{ ui-key.yacloud_monitoring.alert.button_add-channel }}** и выберите канал уведомления, [созданный ранее](#create-channel).
1. Нажмите кнопку **{{ ui-key.yacloud_monitoring.alert.button_create-alert }}**. 

Алерт создан.

#### Изменение числа трейлов {#number-trails}

Алерт отправит уведомление о том, что число трейлов в облаке изменилось.

1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите создать алерт.
1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
1. На панели слева выберите **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.alerts.title }}**.
1. В правом верхнем углу нажмите кнопку **{{ ui-key.yacloud_monitoring.alert.button_create-alert }}**.
1. В поле **{{ ui-key.yacloud_monitoring.alert.title_name }}** укажите `number-trails-alert`. 
1. В блоке **{{ ui-key.yacloud_monitoring.alert.section_metrics }}** справа от имени каталога нажмите ![image](../../_assets/console-icons/plus.svg) и укажите:
    1. `service = Audit Trails`. 
    1. `name = quota.trails_count.usage`.
1. В блоке **{{ ui-key.yacloud_monitoring.alert.section_alert-conditions }}** укажите:
    1. **{{ ui-key.yacloud_monitoring.alert.label_trigger-condition }}** — `{{ ui-key.yacloud_monitoring.alert.title_comparison-ne }}`.
    1. **{{ ui-key.yacloud_monitoring.alert.label_alarm }}** — `<количество_трейлов>`.
1. В блоке **{{ ui-key.yacloud_monitoring.alert.section_notifications }}** нажмите кнопку **{{ ui-key.yacloud_monitoring.alert.button_add-channel }}** и выберите канал уведомления, [созданный ранее](#create-channel).
1. Нажмите кнопку **{{ ui-key.yacloud_monitoring.alert.button_create-alert }}**.

#### Израсходование квоты трейлов на облако {#trail-quota}

Алерт отправит уведомление о том, что квота на количество трейлов в облаке израсходована более чем на 80%.
   
1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите создать алерт.
1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
1. На панели слева выберите **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.alerts.title }}**.
1. В правом верхнем углу нажмите кнопку **{{ ui-key.yacloud_monitoring.alert.button_create-alert }}**.
1. В поле **{{ ui-key.yacloud_monitoring.alert.title_name }}** укажите `trail-quota-alert`. 
1. В блоке **{{ ui-key.yacloud_monitoring.alert.section_metrics }}** справа от имени каталога нажмите ![image](../../_assets/console-icons/plus.svg) и укажите:
    1. `service = Audit Trails`. 
    1. `name = quota.trails_count.usage`.
1. В блоке **{{ ui-key.yacloud_monitoring.alert.section_alert-conditions }}** укажите:
    1. **{{ ui-key.yacloud_monitoring.alert.label_trigger-condition }}** — `{{ ui-key.yacloud_monitoring.alert.title_comparison-gt }}`.
    1. **{{ ui-key.yacloud_monitoring.alert.label_alarm }}** — `<число_равное_80%_от_квоты>`.
1. В блоке **{{ ui-key.yacloud_monitoring.alert.section_notifications }}** нажмите кнопку **{{ ui-key.yacloud_monitoring.alert.button_add-channel }}** и выберите канал уведомления, [созданный ранее](#create-channel).
1. Нажмите кнопку **{{ ui-key.yacloud_monitoring.alert.button_create-alert }}**.

#### Попытки неавторизованного доступа {#unauthorized-access}

Алерт отправит уведомление о том, что к одному из ресурсов трейла был отправлен неавторизованный запрос.

1. В [консоли управления]({{ link-console-main }}) перейдите в каталог, в котором хотите создать алерт.
1. Выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
1. На панели слева выберите **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.alerts.title }}**.
1. В правом верхнем углу нажмите кнопку **{{ ui-key.yacloud_monitoring.alert.button_create-alert }}**.
1. В поле **{{ ui-key.yacloud_monitoring.alert.title_name }}** укажите `unauthorized-access-alert`. 
1. В блоке **{{ ui-key.yacloud_monitoring.alert.section_metrics }}** справа от имени каталога нажмите ![image](../../_assets/console-icons/plus.svg) и укажите:
    1. `service = Audit Trails`. 
    1. `name = trail.unauthorized_events_count`.
1. В блоке **{{ ui-key.yacloud_monitoring.alert.section_alert-conditions }}** укажите:
    1. **{{ ui-key.yacloud_monitoring.alert.label_trigger-condition }}** — `{{ ui-key.yacloud_monitoring.alert.title_comparison-gt }}`.
    1. **{{ ui-key.yacloud_monitoring.alert.label_alarm }}** — `0`.
1. В блоке **{{ ui-key.yacloud_monitoring.alert.section_notifications }}** нажмите кнопку **{{ ui-key.yacloud_monitoring.alert.button_add-channel }}** и выберите канал уведомления, [созданный ранее](#create-channel).
1. Нажмите кнопку **{{ ui-key.yacloud_monitoring.alert.button_create-alert }}**.

## Настройте дашборд {#setup-dashboard}

Готовые графики для наблюдения за состоянием трейлов находятся в [консоли управления]({{ link-console-main }}) → сервис **{{ at-name }}** → раздел ![image](../../_assets/console-icons/display-pulse.svg) **{{ ui-key.yacloud.common.monitoring }}**.

Чтобы отслеживать не только состояние трейлов, но и состояние хранилища трейлов, создайте комплексный дашборд в сервисе {{ monitoring-name }}.

### Создайте дашборд {#create-dashboard}

{% list tabs group=instructions %}

- Интерфейс {{ monitoring-short-name }} {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором находятся нужные трейлы.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
  1. Перейдите на вкладку **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.dashboards.title }}**.
  1. Нажмите **{{ ui-key.yacloud_monitoring.actions.common.create }}**.
  1. Справа вверху нажмите **{{ ui-key.yacloud_monitoring.actions.common.save }}**.
  1. В открывшемся окне введите название дашборда, например `missing-events`, и нажмите **{{ ui-key.yacloud_monitoring.actions.common.save }}**.

{% endlist %}

### Создайте график для отслеживания пропущенных событий {#create-missing-events-chart}

Вы можете отслеживать пропущенные события по [метрикам {{ at-name }}](../../audit-trails/concepts/user-metrics.md):

* `trail.processed_events_count` — частота, с которой события принимаются в обработку.
* `trail.delivered_events_count` — частота, с которой события доставляются в объект назначения.

Скопируйте готовый график для отслеживания пропущенных событий на ваш дашборд:

1. Откройте дашборд трейла в {{ monitoring-name }}:

    {% list tabs group=instructions %}

    - Консоль управления {#console}

      1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_audit-trails }}**.
      1. На панели слева выберите ![image](../../_assets/console-icons/route.svg) **{{ ui-key.yacloud.audit-trails.label_trails }}**.
      1. Выберите нужный трейл.
      1. Перейдите на панель ![image](../../_assets/console-icons/display-pulse.svg) **{{ ui-key.yacloud.common.monitoring }}** для выбранного трейла.
      1. Справа вверху нажмите **{{ ui-key.yacloud.monitoring.button_open-in-monitoring }}**.

          Откроется интерфейс {{ monitoring-short-name }}.

    {% endlist %}

1. Скопируйте график:

    {% list tabs group=instructions %}

    - Интерфейс {{ monitoring-short-name }} {#console}

      1. Найдите график **Processed versus delivered events**.
      1. Справа от названия графика нажмите ![horizontal-ellipsis](../../_assets/horizontal-ellipsis.svg) → **{{ ui-key.yacloud_monitoring.dashboard.widget.copy }}**.
      1. Укажите название, например `Processed versus delivered events — <имя_трейла>`.
      1. Выберите облако, каталог и укажите дашборд, который вы [создали ранее](#create-dashboard).
      1. Нажмите **{{ ui-key.yacloud_monitoring.component.add-to-dashboard-form.action.copy-and-go }}**.

          Откроется ваш дашборд с новым графиком на нем.

    {% endlist %}

При необходимости аналогичным способом добавьте на дашборд графики из других трейлов.

### Изучите график для отслеживания пропущенных событий {#investigate-missing-events-chart}

Обратите внимание на отставание **Delivered events** от **Processed events**. В норме могут встречаться кратковременные провалы с последующими всплесками. Если сохраняется устойчивое отставание в 1 час и более, проверьте статус и [лог диагностики](../../audit-trails/concepts/diagnostics.md) трейла.

#### Узнайте статус трейла {#get-trail-status}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_audit-trails }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/route.svg) **{{ ui-key.yacloud.audit-trails.label_trails }}**.
  1. Выберите трейл. На странице **{{ ui-key.yacloud.audit-trails.label_trail }}** отобразится подробная информация о трейле.

{% endlist %}

Статус `Active` при устойчивом отставании **Delivered events** от **Processed events** означает, что трейл работает нормально, но по каким-то причинам данные поступают в объект назначения с задержкой. В этом случае проверьте статус и логи объекта назначения:

* [{#T}](../../storage/operations/buckets/get-info.md)
* [Получение информации о лог-группе](../../logging/operations/index.md#log-group-info)
* [{#T}](../../data-streams/operations/index.md)

Статус `Error` сообщает об ошибке в работе трейла. В этом случае изучите лог диагностики трейла.

#### Изучите лог диагностики трейла {#get-trail-status}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_audit-trails }}**.
  1. На панели слева выберите ![image](../../_assets/console-icons/route.svg) **{{ ui-key.yacloud.audit-trails.label_trails }}**.
  1. Выберите трейл.
  1. Перейдите на панель ![image](../../_assets/console-icons/receipt.svg) **{{ ui-key.yacloud.audit-trails.logs }}** и изучите лог.
  1. [Ознакомьтесь](../../audit-trails/operations/error.md) с рекомендациями по обработке ошибок.

{% endlist %}

### Создайте график для объекта назначения {#create-destination-chart}

Дополнительно к графику для отслеживания пропущенных событий можно добавить график для объекта назначения:

* **{{ objstorage-name }}**

    Пропуск событий может быть связан с исчерпанием места, доступного для хранения логов. Это может произойти, если трейл отправляет логи в бакет с ограниченным размером. Чтобы отслеживать доступное место в бакете, создайте график по [метрике](../../monitoring/metrics-ref/storage-ref.md) `space_usage` и добавьте метрику `max-size` в качестве порогового значения.

    Метрика `max-size` недоступна, если у бакета не задан максимальный размер. В таком случае необходимо самостоятельно контролировать исчерпание [квоты](../../storage/concepts/limits.md#storage-quotas) на объем хранилища в одном облаке.

* **{{ cloud-logging-name }}**

    [Добавьте на дашборд](../../logging/tutorials/log-group-record-monitoring.md) график по [метрике](../../monitoring/metrics-ref/logging-ref.md) `group.service.ingested_records_per_second` — она отображает реальную скорость записи логов в лог-группу. Сравнение этой величины с установленной [квотой](../../logging/concepts/limits.md#logging-quotas) `Максимальная скорость записи` помогает определить, не достигает ли поток логов максимально разрешенной скорости. Дополнительный график по метрике `group.service.ingest_requests_per_second` со статусом `ERROR` позволит вовремя обнаружить ошибки при записи.


* **{{ yds-name }}** — см. документацию [{{ ydb-full-name }}](../../ydb/):
  * [{#T}](../../ydb/metrics.md)
  * [{#T}](../../ydb/concepts/limits.md)

Подробнее о решении проблем с записью данных см. в разделе [{#T}](../../data-streams/tutorials/slow-writes-debug.md).



## Как удалить созданные ресурсы {#clear-out}

* [Удалите алерты](../../monitoring/operations/alert/delete-alert.md)
* [Удалите дашборд](../../monitoring/operations/dashboard/delete-dashboard.md)