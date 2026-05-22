# Добавить алерт для сертификата

Вы можете добавить алерты об истечении сертификата или о его неработоспособности.

## Добавить алерт о скором истечении сертификата {#expired}

Чтобы создать алерт:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет создан алерт.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
  1. На главной странице сервиса в блоке **{{ ui-key.yacloud_monitoring.homepage.title_service-features }}** нажмите **{{ ui-key.yacloud_monitoring.homepage.button_alerts-action }}**.
  1. В блоке **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.main-info }}** укажите основные параметры алерта:
     * **{{ ui-key.yacloud_monitoring.monitoring-alerts.list-table.name }}**. Задайте имя канала.
     * **{{ ui-key.yacloud_monitoring.monitoring-alerts.label.type }}**. Укажите метод уведомлений.
  1. Укажите условия срабатывания алерта:
     1. В блоке **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.metrics }}** выберите метрику, над которой будет создан алерт:
        * `service = Certificate Manager`.
        * `name = certificate.days_until_expiration`.
        * `certificate = *`. Для отслеживания конкретного сертификата укажите его идентификатор.
        * (Опционально) Если выбрано больше одного сертификата, то используйте функцию `series_min()`, выбирающую наименьшее значение.
     1. В блоке **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.alert-conditions }}** настройте основные и дополнительные параметры алерта:
        * **{{ ui-key.yacloud_monitoring.monitoring-alerts.threshold-table.evaluation-type }}**.
        * **{{ ui-key.yacloud_monitoring.monitoring-alerts.threshold-table.trigger-condition }}**. Условие — **{{ ui-key.yacloud_monitoring.alert.title_comparison-lte }}**, число дней для **{{ ui-key.yacloud_monitoring.monitoring-alerts.status.warn }}** = `14`, для **{{ ui-key.yacloud_monitoring.monitoring-alerts.status.alarm }}** = `4`. 
        * **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.evaluation-window-key-value }}**.

        
        Подробнее в разделе [{#T}](../../monitoring/concepts/alerting/alert.md#condition).


     1. Укажите канал уведомлений. Если у вас нет канала уведомлений, [создайте его](../../monitoring/operations/alert/create-channel.md).
     1. Нажмите **{{ ui-key.yacloud_monitoring.actions.common.create }}**. Алерт появится в списке.

{% endlist %}

## Добавить алерт о неработоспособности сертификата {#inoperable}

Чтобы создать алерт:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором будет создан алерт.
  1. [Перейдите](../../console/operations/select-service.md#select-service) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
  1. На главной странице сервиса в блоке **{{ ui-key.yacloud_monitoring.homepage.title_service-features }}** нажмите **{{ ui-key.yacloud_monitoring.homepage.button_alerts-action }}**.
  1. В блоке **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.main-info }}** укажите основные параметры алерта:
     * **{{ ui-key.yacloud_monitoring.monitoring-alerts.list-table.name }}**. Задайте имя канала.
     * **{{ ui-key.yacloud_monitoring.monitoring-alerts.label.type }}**. Укажите метод уведомлений.
  1. Укажите условия срабатывания алерта:
     1. В блоке **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.metrics }}** выберите метрику, над которой будет создан алерт:
        * `service = Certificate Manager`.
        * `name = certificate.is_out_of_order`.
        * `certificate = *`. Для отслеживания конкретного сертификата укажите его идентификатор.
        * (Опционально) Если выбрано больше одного сертификата, то используйте суммирующую функцию `series_sum()`.
     1. В блоке **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.alert-conditions }}** настройте основные и дополнительные параметры алерта:
        * **{{ ui-key.yacloud_monitoring.monitoring-alerts.threshold-table.evaluation-type }}**.
        * **{{ ui-key.yacloud_monitoring.monitoring-alerts.threshold-table.trigger-condition }}**. Условие — **{{ ui-key.yacloud_monitoring.alert.title_comparison-gt }}**, количество неработоспособных сертификатов для **{{ ui-key.yacloud_monitoring.monitoring-alerts.status.alarm }}** = `0`.
        * **{{ ui-key.yacloud_monitoring.alert.label_evaluation-window }}**.

        
        Подробнее в разделе [{#T}](../../monitoring/concepts/alerting/alert.md#condition). 


     1. Укажите канал уведомлений. Если у вас нет канала уведомлений, [создайте его](../../monitoring/operations/alert/create-channel.md).
     1. Нажмите **{{ ui-key.yacloud_monitoring.actions.common.create }}**. Алерт появится в списке.

{% endlist %}