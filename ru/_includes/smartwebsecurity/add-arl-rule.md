1. Введите имя правила.
1. (Опционально) Введите описание.
1. Задайте приоритет правила. Этот приоритет действует только на правила ARL и не зависит от приоритета правил в [профиле безопасности](../../smartwebsecurity/concepts/profiles.md).
1. (Опционально) Включите опцию **Включить dry run (только логирование)**, чтобы протестировать правило и оценить нагрузку на веб-сервис. В этом режиме запросы блокироваться не будут.

1. {% include [arl-rule-traffic-conditions](arl-rule-traffic-conditions.md) %}

1. В блоке **Подсчет запросов** выберите:

    {% include [arl-rule-request-count](arl-rule-request-count.md) %}

1. {% include [arl-rule-action-over-limit](arl-rule-action-over-limit.md) %}

1. (Опционально) Выберите или [создайте](../../smartwebsecurity/operations/template-create.md) шаблон ответа, который будет возвращаться клиенту при срабатывании правила. По умолчанию используется стандартный шаблон {{ yandex-cloud }}.

1. Нажмите кнопку **{{ ui-key.yacloud.smart-web-security.arl.label_save-rule }}**.