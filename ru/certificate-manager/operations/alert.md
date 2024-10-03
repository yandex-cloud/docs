# Добавить алерт для сертификата

Вы можете добавить алерты об истечении сертификата или о его неработоспособности.

## Добавить алерт о скором истечении сертификата {#expired}

Чтобы создать алерт:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите [каталог](../../resource-manager/concepts/resources-hierarchy.md#folder), в котором будет создан алерт.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
  1. На главной странице сервиса нажмите **{{ ui-key.yacloud_monitoring.alert.button_create-alert }}**.
  1. Укажите основные параметры алерта:
     * **{{ ui-key.yacloud.common.name }}**. Задайте имя канала.
     * **{{ ui-key.yacloud.common.description }}**. Укажите метод уведомлений.
  1. Укажите условия срабатывания алерта:
     1. Выберите метрику, над которой будет создан алерт:
        * `service = Certificate Manager`.
        * `name = certificate.days_until_expiration`.
        * `certificate = *`. Для отслеживания конкретного сертификата укажите его идентификатор.
        * (Опционально) Если выбрано больше одного сертификата, то используйте функцию `series_min()`, выбирающую наименьшее значение.
     1. Настройте основные и дополнительные параметры алерта:
        * **{{ ui-key.yacloud_monitoring.alert.label_trigger-condition }}**. Условие — меньше или равно, число дней для **{{ ui-key.yacloud_monitoring.alert.status_alarm }}** = `4`, для **{{ ui-key.yacloud_monitoring.alert.status_warn }}** = `14`. 
        * **{{ ui-key.yacloud_monitoring.alert.label_evaluation-type }}**.
        * **{{ ui-key.yacloud_monitoring.alert.label_evaluation-window }}**.


        Подробнее в разделе [{#T}](../../monitoring/concepts/alerting/alert.md#condition).


     1. Укажите канал уведомлений. Если у вас нет канала уведомлений, [создайте его](../../monitoring/operations/alert/create-channel.md).
     1. Нажмите **{{ ui-key.yacloud.common.create }}**. Алерт появится в списке.

{% endlist %}

## Добавить алерт о неработоспособности сертификата {#inoperable}

Чтобы создать алерт:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. В [консоли управления]({{ link-console-main }}) выберите каталог, в котором будет создан алерт.
  1. В списке сервисов выберите **{{ ui-key.yacloud.iam.folder.dashboard.label_monitoring }}**.
  1. На главной странице сервиса нажмите **{{ ui-key.yacloud_monitoring.alert.button_create-alert }}**.
  1. Укажите основные параметры алерта:
     * **{{ ui-key.yacloud.common.name }}**. Задайте имя канала.
     * **{{ ui-key.yacloud.common.description }}**. Укажите метод уведомлений.
  1. Укажите условия срабатывания алерта:
     1. Выберите метрику, над которой будет создан алерт:
        * `service = Certificate Manager`.
        * `name = certificate.is_out_of_order`.
        * `certificate = *`. Для отслеживания конкретного сертификата укажите его идентификатор.
        * (Опционально) Если выбрано больше одного сертификата, то используйте суммирующую функцию `series_sum()`.
     1. Настройте основные и дополнительные параметры алерта:
        * **{{ ui-key.yacloud_monitoring.alert.label_trigger-condition }}**. Условие — больше, количество неработоспособных сертификатов для **{{ ui-key.yacloud_monitoring.alert.status_alarm }}** = `0`. 
        * **{{ ui-key.yacloud_monitoring.alert.label_evaluation-type }}**.
        * **{{ ui-key.yacloud_monitoring.alert.label_evaluation-window }}**.


        Подробнее в разделе [{#T}](../../monitoring/concepts/alerting/alert.md#condition). 


     1. Укажите канал уведомлений. Если у вас нет канала уведомлений, [создайте его](../../monitoring/operations/alert/create-channel.md).
     1. Нажмите **{{ ui-key.yacloud.common.create }}**. Алерт появится в списке.

{% endlist %}