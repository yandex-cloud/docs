1. [Создайте группу безопасности](../../vpc/operations/security-group-create.md) [агента](../../load-testing/concepts/agent.md) `agent-sg`.
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