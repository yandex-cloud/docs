Правила в профиле безопасности применяются к трафику согласно приоритету: чем меньше число, тем выше приоритет.

**Рекомендуемый порядок приоритетов**

1. Разрешающее правило для служебных маршрутов капчи.
1. Разрешающие правила с условиями на трафик.
1. Блокирующие правила с условиями на трафик.
1. Правила Smart Protection и WAF + Smart Protection в режиме `{{ ui-key.yacloud.smart-web-security.overview.cell_mode-api }}` с условиями на трафик для эндпоинтов, где нельзя показывать капчу.
1. Правила Smart Protection и WAF + Smart Protection в режиме `{{ ui-key.yacloud.smart-web-security.overview.cell_mode-full }}` с условиями на трафик.
1. Правила Smart Protection и WAF + Smart Protection в режиме `{{ ui-key.yacloud.smart-web-security.overview.cell_mode-full }}` на весь трафик.

**Пример настройки правил**

Приоритет | Имя правила | Действие | Описание правила
--- | --- | --- | ---
8000 | allow-captcha | `{{ ui-key.yacloud.smart-web-security.form.label_action-allow }}` | Правило для разрешения служебных путей капчи
9000 | allow-by-list | `{{ ui-key.yacloud.smart-web-security.form.label_action-allow }}` | Базовое для белых IP-адресов
9100 | block-by-list | `{{ ui-key.yacloud.smart-web-security.form.label_action-deny }}` | Базовое для черных IP-адресов
9200 | block-by-geo | `{{ ui-key.yacloud.smart-web-security.form.label_action-deny }}` | Базовое по регионам
900000 | api-protection | `{{ ui-key.yacloud.smart-web-security.overview.cell_mode-api }}` | Smart Protection для публичного API
999900 | sp-rule-1 | `{{ ui-key.yacloud.smart-web-security.overview.cell_mode-full }}` | Smart Protection из готового шаблона
1000000 |  | `{{ ui-key.yacloud.smart-web-security.form.label_action-allow }}` | Базовое по умолчанию

Для базового правила по умолчанию устанавливается действие `{{ ui-key.yacloud.smart-web-security.form.label_action-allow }}`, пока остальные правила находятся в режиме **{{ ui-key.yacloud.smart-web-security.overview.column_dry-run-rule }}**. При переключении правил в боевой режим установите базовому правилу по умолчанию действие `{{ ui-key.yacloud.smart-web-security.form.label_action-deny }}`.
