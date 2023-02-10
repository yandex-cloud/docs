# Алерты/уведомления

#### Как уменьшить число ложных срабатываний алерта? {#reduce-false-alerts}

Вы можете увеличить {% if audience == "external" %}[окно вычисления](../../monitoring/concepts/alerting.md#evaluation-window){% endif %}{% if audience == "internal" %}окно вычисления{% endif %} или поменять {% if audience == "external" %}[функцию агрегации](../../monitoring/concepts/alerting.md#aggregation){% endif %}{% if audience == "internal" %}функцию агрегации{% endif %} в параметрах {% if audience == "external" %}[алерта](../../monitoring/concepts/alerting.md#alert){% endif %}{% if audience == "internal" %}алерта{% endif %}.

#### Какое значение указывать в пороге? {#threshold-values}

Значение порога задают в единицах измерения выбранной метрики.

Например, для порога свободного места на диске кластера баз данных значение указывается в байтах. Значение порога удобно задавать, передвигая ползунок на графике с реальными данными. Значение порога для **Warning** не должно превышать значение порога для **Alarm**.

#### Как задать получателя алерта? {#alert-recipient}

В {% if audience == "external" %}[канале уведомлений](../../monitoring/concepts/alerting.md#channel-parameters){% endif %}{% if audience == "internal" %}канале уведомлений{% endif %} {% if product == "cloud-il" %}поддерживается только отправка уведомлений на электронную почту.{% endif %}{% if product == "yandex-cloud" %}поддерживаются следующие методы:
* email;
* SMS;
* push-уведомления в {% if audience == "external" %}[мобильном приложении](../../overview/mobile-app/index.md){% endif %}{% if audience == "internal" %}мобильном приложении{% endif %} {{ yandex-cloud }}.{% endif %}

В качестве получателя почтовых уведомлений нужно указать аккаунт в {{ yandex-cloud }}.{% if product == "yandex-cloud" %} Это может быть аккаунт владельца или специально добавленный для этих целей [дополнительный аккаунт](https://yandex.ru/support/id/authorization/lite.html).{% endif %}

{% if product == "yandex-cloud" %}

Если выбран метод SMS, телефонный номер должен быть привязан к аккаунту.

{% endif %}

#### Почему пользователю не приходят алерты? {#alert-receive-failed}

Проверьте настройки почтового ящика и номера телефона в аккаунте пользователя в {% if audience == "external" %}[канале уведомлений](../../monitoring/concepts/alerting.md#channel-parameters){% endif %}{% if audience == "internal" %}канале уведомлений{% endif %}.

Проверьте [настройки]({{ link-console-main }}/settings) консоли управления. В разделах **Настройки номера телефона** и **Настройки почтового ящика** должна быть включена опция `Мониторинг`.