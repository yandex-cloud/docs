1. Введите имя правила.
1. (опционально) Введите описание.
1. Задайте приоритет правила. Этот приоритет действует только на правила ARL и не зависит от приоритета правил в [профиле безопасности](../../smartwebsecurity/concepts/profiles.md).
1. (опционально) Включите опцию **Включить dry run (только логирование)**, чтобы протестировать правило и оценить нагрузку на веб-сервис. В этом режиме запросы блокироваться не будут.

1. {% include [arl-rule-traffic-conditions](../../_includes/smartwebsecurity/arl-rule-traffic-conditions.md) %}

1. В блоке **Подсчет запросов** выберите:

    {% include [arl-rule-request-count](../../_includes/smartwebsecurity/arl-rule-request-count.md) %}

1. Нажмите кнопку **{{ ui-key.yacloud.smart-web-security.arl.label_save-rule }}**.