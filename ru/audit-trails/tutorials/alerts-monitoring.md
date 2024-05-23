# Настройка алертов в {{ monitoring-full-name }}

Из руководства вы узнаете, как отслеживать состояние [трейлов](../concepts/trail.md) с помощью [алертов](../../monitoring/concepts/alerting.md#alert).

Чтобы начать отслеживать статус трейлов:

1. [Подготовьте облако к работе](#before-you-begin).
1. [Создайте канал уведомлений](#create-channel).
1. [Настройте алерты](#setup-alerts).

Если алерты вам больше не нужны, [удалите их](#clear-out).

## Подготовьте облако к работе {#before-you-begin}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

## Создайте канал уведомлений {#create-channel}

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

## Настройте алерты {#setup-alerts}

Вы можете настроить один или несколько алертов.

Более подробная информация о порядке [создания алерта](../../monitoring/operations/alert/create-alert.md) и о [параметрах алерта](../../monitoring/concepts/alerting.md#alert-parameters) приведена в документации {{ monitoring-full-name }}.

### Переход трейла в неактивное состояние {#deactivating-trail}

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

### Прекращение доставки аудитных логов в объект назначения {#stopping-logs}

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

### Изменение числа трейлов {#number-trails}

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

Алерт создан.

### Израсходование квоты трейлов на облако {#trail-quota}

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

Алерт создан.

### Попытки неавторизованного доступа {#unauthorized-access}

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

Алерт создан.

## Как удалить созданные ресурсы {#clear-out}

Чтобы перестать отслеживать состояние трейлов, [удалите](../../monitoring/operations/alert/delete-alert.md) алерт.
