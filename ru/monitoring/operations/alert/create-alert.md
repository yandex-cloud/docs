---
title: Создание алерта
description: Следуя данной инструкции, вы сможете создать алерт.
---

# Создание алерта


<iframe width="640" height="360" src="https://runtime.strm.yandex.ru/player/video/vplvhs7kf62l7u2rvu75?autoplay=0&mute=0" allow="autoplay; fullscreen; picture-in-picture; encrypted-media" frameborder="0" scrolling="no"></iframe>

[Смотреть видео на YouTube](https://www.youtube.com/watch?v=UJ0MxX4BqeM).



1. На главной странице сервиса {{ monitoring-short-name }} нажмите **{{ ui-key.yacloud_monitoring.homepage.button_alerts-action }}**.
1. Укажите основные параметры алерта:

    * **{{ ui-key.yacloud_monitoring.alert.title_name }}**. Задайте название алерта.
    * **{{ ui-key.yacloud_monitoring.alert.title_description }}**. Опишите назначение алерта.

1. Опишите [запросы](../../concepts/alerting/alert.md#queries).
1. Настройте [условия срабатывания](../../concepts/alerting/alert.md#condition) алерта:

    * **{{ ui-key.yacloud_monitoring.monitoring-alerts.label.query-to-check }}**.
    * **{{ ui-key.yacloud_monitoring.monitoring-alerts.threshold-table.evaluation-type }}**.
    * **{{ ui-key.yacloud_monitoring.monitoring-alerts.threshold-table.trigger-condition }}**.
    * Пороги срабатывания **{{ ui-key.yacloud_monitoring.monitoring-alerts.status.warn }}** и **{{ ui-key.yacloud_monitoring.monitoring-alerts.status.alarm }}**.
    * **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.evaluation-window }}**.
    * **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.time-shift }}**.

    Подробнее в разделе [{#T}](../../concepts/alerting/alert.md#condition).

1. Задайте [политики обработки отсутствия данных](../../concepts/alerting/alert.md#no-data-policy) или оставьте значения по умолчанию.
1. Укажите [аннотации](../../concepts/alerting/annotation.md) к алерту.
1. Настройте [уведомления](../../concepts/alerting/notification-channel.md). Если у вас нет канала уведомлений, [создайте его](create-channel.md).
1. Нажмите **{{ ui-key.yacloud_monitoring.actions.common.create }}**. Алерт появится в списке.

Чтобы следить за состоянием алерта, добавьте его [виджет на дашборд](../dashboard/add-widget.md).
