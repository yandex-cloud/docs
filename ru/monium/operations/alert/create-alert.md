---
title: Создание алерта
description: Следуя данной инструкции, вы сможете создать алерт.
---

# Создание алерта

{% note info %}

Для просмотра [алертов](../../concepts/alerting/alert.md) необходима роль `viewer` или выше на облако.

{% endnote %}

1. На главной странице [{{ monium-name }}]({{ link-monium }}) слева выберите **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.alerts.title }}**.
1. Вверху справа нажмите **{{ ui-key.yacloud_monitoring.homepage.button_alerts-action }}** → **{{ ui-key.yacloud_monitoring.monitoring-alerts.button.create-custom-title }}**.
1. Укажите основные параметры алерта:

    * **{{ ui-key.yacloud_monitoring.alert.title_name }}**. Задайте название алерта.
    * **ID**. Задайте уникальный идентификатор алерта.
    * **Тип**. Выберите тип алерта.
    * **{{ ui-key.yacloud_monitoring.alert.title_description }}**. Опишите назначение алерта.

1. Опишите [запросы](../../concepts/alerting/alert.md#queries).
1. Настройте [условия срабатывания](../../concepts/alerting/alert.md#condition) алерта:

    * **{{ ui-key.yacloud_monitoring.monitoring-alerts.label.query-to-check }}**.
    * **{{ ui-key.yacloud_monitoring.monitoring-alerts.threshold-table.evaluation-type }}**.
    * **{{ ui-key.yacloud_monitoring.monitoring-alerts.threshold-table.trigger-condition }}**.
    * Пороги срабатывания **{{ ui-key.yacloud_monitoring.monitoring-alerts.status.warn }}** и **{{ ui-key.yacloud_monitoring.monitoring-alerts.status.alarm }}**.
    * **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.evaluation-window-key-value }}**.
    * **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.time-shift }}**.

    Подробнее в разделе [{#T}](../../concepts/alerting/alert.md#condition).

1. Настройте [прореживание данных](../../concepts/decimation.md).
1. Чтобы создать [мультиалерты](../../concepts/alerting/alert.md#multi-alerts, в разделе **Разложение по меткам** добавьте метки.
1. Задайте [политики обработки отсутствия данных](../../concepts/alerting/alert.md#no-data-policy) или оставьте значения по умолчанию.
1. Укажите [аннотации](../../concepts/alerting/annotation.md) к алерту.

1. Для сортировки и поиска алертов добавьте лейблы в формате `ключ=значение`.
   
     Можно добавить несколько лейблов, для этого после ввода пары `ключ=значение` нажмите клавишу `Enter`. Чтобы использовать лейблы в другом алерте или в строке поиска, нажмите кнопку **Скопировать все лейблы**.

1. Настройте [уведомления](../../concepts/alerting/notification-channel.md). Если у вас нет канала уведомлений, [создайте его](create-channel.md).
1. Нажмите **{{ ui-key.yacloud_monitoring.actions.common.create }}**. Алерт появится в списке.

Чтобы следить за состоянием алерта, добавьте его [виджет на дашборд](../dashboard/add-widget.md).
