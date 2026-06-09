# Настройка групп безопасности агента тестирования

{% note warning %}

С 1 июля 2026 года сервис {{ load-testing-name }} прекращает работу. Подробнее на странице [Закрытие сервиса Yandex Load Testing](../sunset.md).

{% endnote %}


{% note warning %}

Группы безопасности необходимо создать и настроить перед созданием [агента](../concepts/agent.md). Так вы сможете ограничить доступы с агента.

{% endnote %}

1. [Создайте группу безопасности](../../vpc/operations/security-group-create.md) [агента](../concepts/agent.md) `agent-sg`.
1. [Добавьте правила](../../vpc/operations/security-group-add-rule.md):
   1. Правило для исходящего HTTPS-трафика к публичному API {{ load-testing-name }}:
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `443`.
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`.
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`.

      Это позволит подключить агент к сервису {{ load-testing-name }}, чтобы управлять тестами из интерфейса и получать результаты тестирования.
   1. Правило для входящего [SSH-трафика](../../glossary/ssh-keygen.md):
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `22`.
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`.
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`.

      Это позволит подключаться к агенту по протоколу SSH и управлять тестами из консоли или собирать отладочную информацию.
   1. Правило для исходящего трафика при подаче нагрузки к цели тестирования:
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-any }}`.
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}`.
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}`.
        Выберите `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-list }}`. Укажите [группу безопасности](../../vpc/concepts/security-groups.md), в которой находится нужная цель тестирования.

      Создайте такое правило для каждой цели тестирования с уникальной группой безопасности.

Если планируется использовать несколько групп безопасности для агента, разрешите весь трафик между этими группами.
Чтобы назначить еще одну группу безопасности, [отредактируйте](../../compute/operations/vm-control/vm-update.md) сетевые настройки виртуальной машины в {{ compute-full-name }}.

{% note info %}

Вы можете задать более детальные правила для групп безопасности, например, разрешающие трафик только в определенных подсетях.

Важно, чтобы группы безопасности были корректно настроены для всех подсетей, в которых будут размещены агенты, генерирующие трафик.

{% endnote %}