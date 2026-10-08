---
title: Создание SLO-алерта
description: Следуя данной инструкции, вы сможете создать алерт на основе SLO.
---

# Создание SLO-алерта

SLO-алерты отслеживают показатели выбранного [SLO](../../slo/index.md): остаток и фактический расход [бюджета ошибок (Error Budget)](../../slo/index.md#basic-terms), а также коэффициент Burn Rate. Используйте эти алерты, чтобы вовремя заметить риск нарушения SLO и оценить влияние инцидента на надежность сервиса.

Перед созданием SLO-алерта [создайте и настройте SLO](../../slo/management.md#config). Для алерта типа **Burn Rate** в исходном SLO должен быть [включен расчет Burn Rate](../../slo/management.md#burn-rate). Без него алерт перейдет в статус `No data`.

{% include [alert-viewer-role](../../../_includes/monium/alert-viewer-role.md) %}

{% list tabs group=instructions %}

- Интерфейс {{ monium-name }} {#console}

  1. На главной странице [{{ monium-name }}]({{ link-monium }}) слева выберите ![alt](../../../_assets/console-icons/shield-exclamation.svg) **Алерты и SLO** → ![alt](../../../_assets/console-icons/megaphone.svg) **{{ ui-key.yacloud_monitoring.aside-navigation.menu-item.alerts.title }}**.
  1. Вверху справа нажмите **{{ ui-key.yacloud_monitoring.homepage.button_alerts-action }}** → **{{ ui-key.yacloud_monitoring.monitoring-alerts.button.create-slo-title }}**.
  1. Укажите основные параметры алерта:

      {% include [alert-basic-parameters](../../../_includes/monium/alert-basic-parameters.md) %}

  1. В поле **{{ ui-key.yacloud_monitoring.monitoring-alerts.label.slo-alert-type }}** выберите:

      * **{{ ui-key.yacloud_monitoring.monitoring-alerts.slo-type.error-budget-key-value }}** — контролирует остаток бюджета ошибок или его фактический расход за окно алерта.
      * **Burn Rate** — контролирует скорость расхода бюджета ошибок. Подходит для дежурства и быстрого обнаружения инцидентов.

      Подробнее о различиях проверок в разделе [SLO-алерты](../../concepts/alerting/alert.md#slo-alerts).

  1. В блоке **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.alert-config }}** выберите проект, в котором находится SLO, и сам SLO. Проект SLO может отличаться от проекта алерта. Собственные запросы к метрикам задавать не нужно.
  1. В блоке **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.alert-conditions }}** настройте параметры, при которых будет изменяться статус алерта.

      Задайте хотя бы один порог: **{{ ui-key.yacloud_monitoring.monitoring-alerts.slo.warn-threshold }}** или **{{ ui-key.yacloud_monitoring.monitoring-alerts.slo.alarm-threshold }}**.

      Для типа **{{ ui-key.yacloud_monitoring.monitoring-alerts.slo-type.error-budget-key-value }}** в поле **{{ ui-key.yacloud_monitoring.monitoring-alerts.slo.alert-type-key-value }}** выберите один из методов:

      * **{{ ui-key.yacloud_monitoring.monitoring-alerts.slo.alert-type.absolute }}** — проверка среднего остатка бюджета за окно вычисления алерта. Укажите минимальный допустимый остаток в процентах. Например, задайте `20%` для **{{ ui-key.yacloud_monitoring.monitoring-alerts.slo.warn-threshold }}** и `10%` для **{{ ui-key.yacloud_monitoring.monitoring-alerts.slo.alarm-threshold }}**. Если заданы оба порога, значение **{{ ui-key.yacloud_monitoring.monitoring-alerts.slo.alarm-threshold }}** должно быть меньше значения **{{ ui-key.yacloud_monitoring.monitoring-alerts.slo.warn-threshold }}**.
      * **{{ ui-key.yacloud_monitoring.monitoring-alerts.slo.alert-type.diff }}** — проверка разности остатков бюджета в начале и конце окна. Задайте **{{ ui-key.yacloud_monitoring.monitoring-alerts.title.evaluation-window-key-value }}** и пороги допустимого расхода в процентах. Например, при окне `1h` и пороге **{{ ui-key.yacloud_monitoring.monitoring-alerts.slo.alarm-threshold }}**, равном `5%`, алерт сработает, если за час потрачено больше 5% бюджета. Если заданы оба порога, значение **{{ ui-key.yacloud_monitoring.monitoring-alerts.slo.alarm-threshold }}** должно быть больше значения **{{ ui-key.yacloud_monitoring.monitoring-alerts.slo.warn-threshold }}**.

      Для типа **Burn Rate** настройте окно вычисления и пороги:

      1. Выберите длинное окно вычисления. Короткое окно определяется автоматически и составляет 1/12 длинного: например, `5m` для длинного окна `1h`.
      1. Выберите способ задания порогов: коэффициент Burn Rate или процент расхода бюджета за окно алерта.
      1. Укажите выбранные пороги в заданных единицах. Если заданы оба, значение **{{ ui-key.yacloud_monitoring.monitoring-alerts.slo.alarm-threshold }}** должно быть больше значения **{{ ui-key.yacloud_monitoring.monitoring-alerts.slo.warn-threshold }}**. Например, для SLO с окном 30 дней коэффициент `14.4` на окне `1h` соответствует расходу 2% бюджета за час.

      Алерт типа Burn Rate срабатывает, когда коэффициенты на длинном и коротком окнах превышают соответствующий порог. Подробнее об [окнах проверки](../../concepts/alerting/alert.md#slo-burn-rate-windows) и [способах задания порогов](../../concepts/alerting/alert.md#slo-burn-rate-thresholds).

  1. Настройте [прореживание данных](../../concepts/alerting/alert.md#decimation) или оставьте значения по умолчанию.
  1. Задайте [политики обработки отсутствия данных](../../concepts/alerting/alert.md#no-data-policy). Чтобы отличать отсутствие данных от выполнения SLO, установите `No data` для отсутствия метрик и отсутствия точек в окне вычисления.

  1. (Опционально) Укажите [аннотации](../../concepts/alerting/annotation.md) к алерту.
  1. (Опционально) Для сортировки и поиска алертов добавьте лейблы в формате `ключ=значение`.

      Разделяйте пары `ключ=значение` запятыми. Чтобы использовать лейблы в другом алерте или в строке поиска, нажмите кнопку **{{ ui-key.yacloud_monitoring.monitoring-alerts.labels.tokenized-input.copy-button }}**.

  1. (Опционально) В блоке **Ссылки** добавьте ссылки на связанные ресурсы.
  1. Настройте [уведомления](../../concepts/alerting/notification-channel.md). Если у вас нет канала уведомлений, [создайте его](create-channel.md).

      Если для выбранного уровня алерта настроены способы уведомлений по умолчанию, они применяются и при пустой таблице уведомлений. Для настройки нажмите **{{ ui-key.yacloud_monitoring.monitoring-alerts.label.edit-notify-methods }}**. Проверьте значения параметров **{{ ui-key.yacloud_monitoring.monitoring-alerts.channel-table.notify-statuses }}** и **{{ ui-key.yacloud_monitoring.monitoring-alerts.channel-table.repeat }}**.

      Чтобы не получать уведомление при каждой смене статуса, включите **{{ ui-key.yacloud_monitoring.monitoring-alerts.flap-suppressor.checkbox }}**. Используйте настройку для SLO с низким трафиком, когда статус может кратковременно меняться из-за небольшого числа событий. Подробнее о подавлении шума в разделе [{#T}](../../concepts/alerting/alert.md#noise-suppression).

  1. Проверьте результат вычисления алерта.

      {% include [alert-check-result](../../../_includes/monium/alert-check-result.md) %}

  1. Нажмите **{{ ui-key.yacloud_monitoring.actions.common.create }}**. Алерт появится в списке.

{% endlist %}
