1. Введите имя правила.
1. (опционально) Введите описание.
1. Задайте приоритет правила. Правило будет иметь больший приоритет, чем преднастроенные.

    {% include [preconfigured-rules-priority](./preconfigured-rules-priority.md) %}

1. (опционально) Включите опцию **{{ ui-key.yacloud.smart-web-security.overview.column_dry-run-rule }} (dry run)**, если вы хотите фиксировать информацию о трафике, который соответствует заданным условиям, но не применять к нему никаких действий.
1. Выберите тип правила:
    * [**{{ ui-key.yacloud.smart-web-security.overview.label_base-rule }}**](../../smartwebsecurity/concepts/rules.md#base-rules) — правило, которое разрешает или запрещает трафик по заданным условиям.
    * [**{{ ui-key.yacloud.smart-web-security.overview.label_smart-protection-rule }}**](../../smartwebsecurity/concepts/rules.md#smart-protection-rules) — правило, которое отправляет трафик на автоматический анализ с помощью алгоритмов машинного обучения и поведенческого анализа. Подозрительные запросы отправляются в [{{ captcha-full-name }}](../../smartcaptcha/) для дополнительной верификации.
1. Выберите [действие](../../smartwebsecurity/concepts/rules.md#rule-action):
    * Для базового правила: `{{ ui-key.yacloud.smart-web-security.overview.cell_sec-action-deny }}` или `{{ ui-key.yacloud.smart-web-security.overview.cell_sec-action-allow }}` трафик, параметры которого соответствуют условиям.
    * Для правила Smart Protection:
      * `{{ ui-key.yacloud.smart-web-security.overview.cell_mode-full }}` — трафик проверяется на основе ML-моделей и поведенческого анализа. Подозрительные запросы отправляются в {{ captcha-name }}.
      * `{{ ui-key.yacloud.smart-web-security.overview.cell_mode-api }}` — трафик проверяется на основе ML-моделей и поведенческого анализа. Подозрительные запросы блокируются.
1. В поле **{{ ui-key.yacloud.smart-web-security.overview.column_rule-conditions }}** выберите условия, которым должен соответствовать трафик, чтобы попасть под действие правила. В появившихся ниже полях задайте дополнительные параметры выбранных условий. Подробнее см. [Условия действия правила](../../smartwebsecurity/concepts/conditions.md).
      
    Вы можете задать несколько условий одного типа. Для разных типов условий действуют разные логические операторы: _и_ или _или_. Чтобы добавить более одного условия определенного типа нажмите кнопки ![plus-sign](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.component.condition-column.condition_and }}** или ![plus-sign](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.component.condition-column.condition_or }}**.
1. Нажмите кнопку **{{ ui-key.yacloud.common.add }}**.