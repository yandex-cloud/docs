# Алерты/уведомления

#### Как уменьшить число ложных срабатываний алерта? {#reduce-false-alerts}

Вы можете увеличить [окно вычисления](../../monitoring/concepts/alerting/alert.md#evaluation-window) или поменять [функцию агрегации](../../monitoring/concepts/alerting/alert.md#aggregation) в параметрах [алерта](../../monitoring/concepts/alerting/alert.md#alert-parameters).

#### Какое значение указывать в пороге? {#threshold-values}

Значение порога задают в единицах измерения выбранной метрики.

Например, для порога свободного места на диске кластера баз данных значение указывается в байтах. Значение порога удобно задавать, передвигая ползунок на графике с реальными данными. Значение порога для **{{ ui-key.yacloud_monitoring.alert-template.threshold-status.warn }}** не должно превышать значение порога для **{{ ui-key.yacloud_monitoring.alert-template.threshold-status.alarm }}**.

#### Как задать получателя алерта? {#alert-recipient}

В [канале уведомлений](../../monitoring/concepts/alerting/notification-channel.md) поддерживаются следующие методы:

{% include [channels](../../_includes/monitoring/channels.md) %}

{% include [account-info](../../_includes/monitoring/account-info.md) %}

#### Почему пользователю не приходят алерты? {#alert-receive-failed}

Если алерт срабатывает, но уведомления не приходят:

1. Проверьте получателей, метод отправки и статусы алерта, для которых включены уведомления, в [параметрах канала](../../monium/concepts/alerting/notification-channel.md#channel-parameters). Там же описаны требования к правам получателя и настройкам его аккаунта.
1. Убедитесь, что в [настройках консоли управления]({{ link-console-settings }}) указаны правильные адрес электронной почты и номер телефона и включены уведомления мониторинга. Проверьте также адрес почты в профиле Яндекс ID или федеративного аккаунта.
1. Проверьте [статус отправки](../../monium/concepts/alerting/notification-channel.md#dispatch-statuses). Статус `{{ ui-key.yacloud_monitoring.channel.status-description_resource_exhausted }}` означает, что достигнуто ограничение метода отправки. В {{ monium-name }} действует [лимит](../../monium/concepts/limits.md#limits-metrics-alerts) — 100 SMS на один номер в сутки.
1. Проверьте папку **Спам** в почте и на телефоне, а также список заблокированных номеров. Если установлен фильтр SMS, временно отключите его и проверьте доставку повторно. Если SMS по-прежнему не приходят, уточните у мобильного оператора, поступали ли сообщения на ваш номер.

#### Что делать, если нет данных? {#alert-no-data}

При отсутствии данных отображается временная шкала за последний час. Чтобы увидеть данные, измените время в [окне вычисления](../../monitoring/concepts/alerting/alert.md#evaluation-window) — в него должна войти последняя точка.

Если ошибок функций нет, то данные не будут отображаться. Подробнее в разделе [Обработка отсутствия данных](../../monitoring/concepts/alerting/alert.md#no-data-policy).
