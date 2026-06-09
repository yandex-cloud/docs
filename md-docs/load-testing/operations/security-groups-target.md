# Настройка групп безопасности цели тестирования

{% note warning %}

С 1 июля 2026 года сервис {{ load-testing-name }} прекращает работу. Подробнее на странице [Закрытие сервиса Yandex Load Testing](../sunset.md).

{% endnote %}


1. [Создайте](../../vpc/operations/security-group-create.md) группу безопасности цели тестирования `load-target-sg`.
1. [Добавьте правило](../../vpc/operations/security-group-add-rule.md) для входящего трафика при подаче нагрузки к цели тестирования:
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-any }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}`.
      Выберите `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-list }}`. Укажите [группу безопасности](../../vpc/concepts/security-groups.md), в которой находится нужная цель тестирования.

    Это правило позволит агентам подавать нагрузку на эту цель или подключать дополнительные средства мониторинга.

{% note info %}

Вы можете задать более детальные правила для групп безопасности, например, разрешающие трафик только в определенных подсетях.

Важно, чтобы группы безопасности были корректно настроены для всех подсетей, в которых будут размещены цели тестирования.

{% endnote %}