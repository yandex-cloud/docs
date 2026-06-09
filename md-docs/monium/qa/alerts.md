# Алерты/уведомления

#### Как уменьшить число ложных срабатываний алерта? {#reduce-false-alerts}

Вы можете увеличить [окно вычисления](../../monitoring/concepts/alerting/alert.md#evaluation-window) или поменять [функцию агрегации](../../monitoring/concepts/alerting/alert.md#aggregation) в параметрах [алерта](../../monitoring/concepts/alerting/alert.md#alert-parameters).

#### Какое значение указывать в пороге? {#threshold-values}

Значение порога задают в единицах измерения выбранной метрики.

Например, для порога свободного места на диске кластера баз данных значение указывается в байтах. Значение порога удобно задавать, передвигая ползунок на графике с реальными данными. Значение порога для **{{ ui-key.yacloud_monitoring.alert-template.threshold-status.warn }}** не должно превышать значение порога для **{{ ui-key.yacloud_monitoring.alert-template.threshold-status.alarm }}**.

#### Как задать получателя алерта? {#alert-recipient}

В [канале уведомлений](../../monitoring/concepts/alerting/notification-channel.md) поддерживаются следующие методы:

* `{{ ui-key.yacloud_monitoring.channel.title_method-email }}`.
* `{{ ui-key.yacloud_monitoring.channel.title_method-sms }}`.
* `{{ ui-key.yacloud_monitoring.channel.title_method-push }}` (в [мобильном приложении](../../overview/mobile-app/index.md) {{ yandex-cloud }}).
* `Telegram`.
* `{{ sf-name }}`.

В качестве получателя почтовых уведомлений нужно указать аккаунт в {{ yandex-cloud }}. Это может быть аккаунт владельца или специально добавленный для этих целей [дополнительный аккаунт](../../iam/concepts/index.md#accounts), например федеративный аккаунт или Яндекс ID.

#### Почему пользователю не приходят алерты? {#alert-receive-failed}

Проверьте настройки почтового ящика и номера телефона в аккаунте пользователя в [канале уведомлений](../../monitoring/concepts/alerting/notification-channel.md).

Чтобы получать уведомления, пользователь должен:

* иметь роль `monitoring.viewer` на каталог, в котором настроен алерт.
* в [настройках]({{ link-console-main }}/settings) консоли управления:
    * включить опцию **{{ ui-key.yacloud_components.settings.label_monitoring-name }}**;
    * указать адрес электронной почты, номер телефона и Telegram-аккаунт или группу.

#### Что делать, если нет данных? {#alert-no-data}

При отсутствии данных отображается временная шкала за последний час. Чтобы увидеть данные, измените время в [окне вычисления](../../monitoring/concepts/alerting/alert.md#evaluation-window) — в него должна войти последняя точка.

Если ошибок функций нет, то данные отображаться не будут. Подробнее см. в разделе [Обработка отсутствия данных](../../monitoring/concepts/alerting/alert.md#no-data-policy)