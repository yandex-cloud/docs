1. Введите имя правила.
1. (опционально) Введите описание.
1. Задайте приоритет правила. Добавляемое правило будет иметь более высокий приоритет, чем преднастроенные правила.

    {% include [preconfigured-rules-priority](./preconfigured-rules-priority.md) %}

1. (опционально) Включите опцию **{{ ui-key.yacloud.smart-web-security.overview.column_dry-run-rule }} (dry run)**, если вы хотите только фиксировать информацию о трафике, который соответствует заданным условиям, но не применять к нему никаких действий.
1. Выберите тип правила:
    * [**{{ ui-key.yacloud.smart-web-security.overview.label_base-rule }}**](../../smartwebsecurity/concepts/rules.md#base-rules) — правило, которое по заданным условиям разрешает, запрещает или отправляет трафик в [{{ captcha-full-name }}](../../smartcaptcha/).
    * [**{{ ui-key.yacloud.smart-web-security.overview.label_smart-protection-rule }}**](../../smartwebsecurity/concepts/rules.md#smart-protection-rules) — правило, которое отправляет трафик на автоматический анализ с помощью алгоритмов машинного обучения и поведенческого анализа. Подозрительные запросы отправляются в {{ captcha-full-name }} для дополнительной верификации.
    * [**{{ ui-key.yacloud.smart-web-security.overview.label_waf-rule }}**](../../smartwebsecurity/concepts/rules.md#waf-rules) — правило, которое подключает набор правил из профиля WAF. Подозрительные запросы отправляются в {{ captcha-full-name }}.

        Для правила WAF выберите или [создайте профиль WAF](../../smartwebsecurity/operations/waf-profile-create.md).
1. Выберите [действие](../../smartwebsecurity/concepts/rules.md#rule-action):
    * Для базового правила: 
      * `{{ ui-key.yacloud.smart-web-security.overview.cell_sec-action-deny }}`;
      * `{{ ui-key.yacloud.smart-web-security.overview.cell_sec-action-allow }}`;
      * `Показать капчу` — будет показана капча, выбранная в профиле безопасности.
    * Для правила Smart Protection или WAF:

      * `{{ ui-key.yacloud.smart-web-security.overview.cell_mode-full }}` — после проверки подозрительные запросы отправляются в {{ captcha-name }}.
      * `{{ ui-key.yacloud.smart-web-security.overview.cell_mode-api }}` — после проверки подозрительные запросы блокируются.

1. {% include [arl-rule-traffic-conditions](../../_includes/smartwebsecurity/arl-rule-traffic-conditions.md) %}

1. Нажмите кнопку **{{ ui-key.yacloud.common.add }}**.