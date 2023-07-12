# Алерты/уведомления

#### Как уменьшить число ложных срабатываний алерта? {#reduce-false-alerts}

Вы можете увеличить [окно вычисления](../../monitoring/concepts/alerting.md#evaluation-window) или поменять [функцию агрегации](../../monitoring/concepts/alerting.md#aggregation) в параметрах [алерта](../../monitoring/concepts/alerting.md#alert).

#### Какое значение указывать в пороге? {#threshold-values}

Значение порога задают в единицах измерения выбранной метрики.

Например, для порога свободного места на диске кластера баз данных значение указывается в байтах. Значение порога удобно задавать, передвигая ползунок на графике с реальными данными. Значение порога для **Warning** не должно превышать значение порога для **Alarm**.

#### Как задать получателя алерта? {#alert-recipient}

В [канале уведомлений](../../monitoring/concepts/alerting.md#channel-parameters) поддерживаются следующие методы:
* email;
* SMS;
* push-уведомления в [мобильном приложении](../../overview/mobile-app/index.md) {{ yandex-cloud }}.

{% include [account-info](../../_includes/monitoring/account-info.md) %}

#### Почему пользователю не приходят алерты? {#alert-receive-failed}

Проверьте настройки почтового ящика и номера телефона в аккаунте пользователя в [канале уведомлений](../../monitoring/concepts/alerting.md#channel-parameters).

{% include [notifications-requirements](../../_includes/monitoring/notifications-requirements.md) %}