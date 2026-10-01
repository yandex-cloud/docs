---
title: Как добавить алерт для сертификата в {{ certificate-manager-full-name }}
description: Следуя этой инструкции, вы сможете добавить алерт о скором истечении срока действия сертификата или о его неработоспособности.
---

# Добавить алерт для сертификата

Вы можете добавить алерты об истечении срока действия сертификата или о его неработоспособности.

## Добавить алерт о скором истечении сертификата {#expired}

Чтобы создать алерт:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет создан алерт.
  1. [Перейдите]({{ link-monitoring }}) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
  1. На главной странице сервиса в блоке **{{ ui-key.yacloud_monitoring.homepage.title_service-features }}** нажмите **{{ ui-key.yacloud_monitoring.homepage.button_alerts-action }}**.
  1. В блоке **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.main-info }}** укажите основные параметры алерта:

     * **{{ ui-key.yacloud_monitoring.monitoring-alerts.list-table.name }}**. Задайте имя алерта.
     * **{{ ui-key.yacloud_monitoring.monitoring-alerts.label.type }}**. Укажите метод уведомлений.
     * (Опционально) Добавьте описание алерта.

  1. Укажите условия срабатывания алерта:

     1. В блоке **{{ ui-key.yacloud_monitoring.alert-template.section.type-settings }}** начните строить запрос для отображения метрики. В форме построения запроса последовательно введите:

        * `service = certificate-manager`.
        * `name = certificate.days_until_expiration`.
        * `certificate = *`. Для отслеживания конкретного сертификата укажите его идентификатор.
        * (Опционально) Если выбрано больше одного сертификата, то используйте функцию `series_min()`, выбирающую наименьшее значение.

     1. В блоке **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.alert-conditions }}** настройте дополнительные параметры алерта:

        * **{{ ui-key.yacloud_monitoring.monitoring-alerts.threshold-table.evaluation-type }}**. Функция агрегации, применяемая к значениям метрик во временном окне. При расчете значений функции используются значения метрик без прореживания.
        * **{{ ui-key.yacloud_monitoring.monitoring-alerts.threshold-table.trigger-condition }}**. Условие — **{{ ui-key.yacloud_monitoring.alert.title_comparison-lte }}**, число дней для **{{ ui-key.yacloud_monitoring.monitoring-alerts.status.warn }}** = `14`, для **{{ ui-key.yacloud_monitoring.monitoring-alerts.status.alarm }}** = `4`.
        * **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.evaluation-window-key-value }}**. Временное окно, в котором рассчитывается алерт. Подробнее в разделе [Окно вычисления](../../monitoring/concepts/alerting/alert.md#evaluation-window).
        * **{{ ui-key.yacloud_monitoring.alert-template.field.delay-key-value }}**. Сдвиг временного окна назад во времени. Полезно для агрегированных метрик, так как сбор отдельных метрик агрегата распределен по времени. Подробнее в разделе [Задержка вычисления](../../monitoring/concepts/alerting/alert.md#evaluation-delay).

        
        Подробнее в разделе [{#T}](../../monitoring/concepts/alerting/alert.md#condition).


     1. В блоке **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.notification-channels }}** укажите канал уведомлений. Если у вас нет канала уведомлений, [создайте его](../../monitoring/operations/alert/create-channel.md).
     1. Нажмите **{{ ui-key.yacloud_monitoring.actions.common.create }}**. Алерт появится в списке.

{% endlist %}

## Добавить алерт о неработоспособности сертификата {#inoperable}

Чтобы создать алерт:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет создан алерт.
  1. [Перейдите]({{ link-monitoring }}) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
  1. На главной странице сервиса в блоке **{{ ui-key.yacloud_monitoring.homepage.title_service-features }}** нажмите **{{ ui-key.yacloud_monitoring.homepage.button_alerts-action }}**.
  1. В блоке **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.main-info }}** укажите основные параметры алерта:

     * **{{ ui-key.yacloud_monitoring.monitoring-alerts.list-table.name }}**. Задайте имя алерта.
     * **{{ ui-key.yacloud_monitoring.monitoring-alerts.label.type }}**. Укажите метод уведомлений.
     * (Опционально) Добавьте описание алерта.

  1. Укажите условия срабатывания алерта:

     1. В блоке **{{ ui-key.yacloud_monitoring.alert-template.section.type-settings }}** начните строить запрос для отображения метрики. В форме построения запроса последовательно введите:

        * `service = certificate-manager`.
        * `name = certificate.is_out_of_order`.
        * `certificate = *`. Для отслеживания конкретного сертификата укажите его идентификатор.
        * (Опционально) Если выбрано больше одного сертификата, то используйте функцию `series_sum()`, которая суммирует значения.

     1. В блоке **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.alert-conditions }}** настройте дополнительные параметры алерта:

        * **{{ ui-key.yacloud_monitoring.monitoring-alerts.threshold-table.evaluation-type }}**. Функция агрегации, применяемая к значениям метрик во временном окне. При расчете значений функции используются значения метрик без прореживания.
        * **{{ ui-key.yacloud_monitoring.monitoring-alerts.threshold-table.trigger-condition }}**. Условие — **{{ ui-key.yacloud_monitoring.alert.title_comparison-gt }}**, количество неработоспособных сертификатов для **{{ ui-key.yacloud_monitoring.monitoring-alerts.status.alarm }}** = `0`.
        * **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.evaluation-window-key-value }}**. Временное окно, в котором рассчитывается алерт. Подробнее в разделе [Окно вычисления](../../monitoring/concepts/alerting/alert.md#evaluation-window).
        * **{{ ui-key.yacloud_monitoring.alert-template.field.delay-key-value }}**. Сдвиг временного окна назад во времени. Полезно для агрегированных метрик, так как сбор отдельных метрик агрегата распределен по времени. Подробнее в разделе [Задержка вычисления](../../monitoring/concepts/alerting/alert.md#evaluation-delay).

        
        Подробнее в разделе [{#T}](../../monitoring/concepts/alerting/alert.md#condition).


     1. В блоке **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.notification-channels }}** укажите канал уведомлений. Если у вас нет канала уведомлений, [создайте его](../../monitoring/operations/alert/create-channel.md).
     1. Нажмите **{{ ui-key.yacloud_monitoring.actions.common.create }}**. Алерт появится в списке.

{% endlist %}
