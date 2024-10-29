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

Проверьте настройки почтового ящика и номера телефона в аккаунте пользователя в [канале уведомлений](../../monitoring/concepts/alerting/notification-channel.md).

{% include [notifications-requirements](../../_includes/monitoring/notifications-requirements.md) %}