1. Введите имя правила.
1. (Опционально) Введите описание.
1. Задайте приоритет правила. Добавляемое правило будет иметь более высокий приоритет, чем преднастроенные правила.

    {% include [preconfigured-rules-priority](./preconfigured-rules-priority.md) %}

    Приоритет правил описан в разделе [{#T}](../../smartwebsecurity/concepts/rules.md#rules-order).

1. (Опционально) Включите **{{ ui-key.yacloud.smart-web-security.overview.column_dry-run-rule }} (dry run)**, чтобы фиксировать информацию о трафике, который соответствует заданным условиям, но не применять к нему никаких действий.
1. Выберите тип правила:
    * [**{{ ui-key.yacloud.smart-web-security.overview.label_base-rule }}**](../../smartwebsecurity/concepts/rules.md#base-rules) — правило, которое по заданным условиям разрешает, запрещает или отправляет трафик в [{{ captcha-full-name }}](../../smartcaptcha/).
    * [**{{ ui-key.yacloud.smart-web-security.overview.label_smart-protection-rule }}**](../../smartwebsecurity/concepts/rules.md#smart-protection-rules) — правило, которое отправляет трафик на автоматический анализ с помощью алгоритмов машинного обучения и поведенческого анализа. В режиме полной защиты подозрительные запросы отправляются на [дополнительную проверку](../../smartwebsecurity/concepts/rules.md#client-checks), которую автоматически выбирает Smart Protection.
    * [**{{ ui-key.yacloud.smart-web-security.overview.label_waf-rule }}**](../../smartwebsecurity/concepts/rules.md#waf-rules) — правило, которое подключает набор правил из профиля WAF.

        Для правила WAF выберите или [создайте профиль WAF](../../smartwebsecurity/operations/waf-profile-create.md).
1. Выберите [режимы защиты](../../smartwebsecurity/concepts/profiles.md#protection-mode), в которых будет действовать правило:

    * **Все режимы** (по умолчанию).
    * **«Повышенная защита» и «Под атакой»**.
    * **«Под атакой»**.

1. Выберите [действие](../../smartwebsecurity/concepts/rules.md#rule-action):
    * Для базового правила: 
      * `{{ ui-key.yacloud.smart-web-security.overview.cell_sec-action-deny }}`;
      * `{{ ui-key.yacloud.smart-web-security.overview.cell_sec-action-allow }}`;
      * `{{ ui-key.yacloud.smart-web-security.overview.cell_sec-action-captcha }}` — будет показана капча, выбранная в профиле безопасности.
      
    
    * Для правила Smart Protection или WAF:

      * `{{ ui-key.yacloud.smart-web-security.overview.cell_mode-full }}` — подозрительные запросы отправляются на [дополнительную проверку](../../smartwebsecurity/concepts/rules.md#client-checks), которую автоматически выбирает Smart Protection.
      * `{{ ui-key.yacloud.smart-web-security.overview.cell_mode-api }}` — после проверки подозрительные запросы блокируются.

1. (Опционально) Выберите или [создайте](../../smartwebsecurity/operations/template-create.md) шаблон ответа, который будет возвращаться клиенту при срабатывании правила. По умолчанию используется стандартный шаблон {{ yandex-cloud }}.
1. {% include [arl-rule-traffic-conditions](../../_includes/smartwebsecurity/arl-rule-traffic-conditions.md) %}

1. Нажмите кнопку **{{ ui-key.yacloud.common.add }}**.
