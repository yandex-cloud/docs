[Добавьте](../../../vpc/operations/security-group-add-rule.md) в группу безопасности, [примененную к группе узлов](../../../managed-kubernetes/operations/connect/security-groups.md#rules-internal-nodegroup), следующие правила:
  * Правило для входящего трафика, которое разрешает проверку сертификатов через веб-хук cert-manager:
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `10250`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.common.label_tcp }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.
  * Правило для исходящего трафика, которое разрешает подключение к серверам Let's Encrypt® для выпуска сертификатов:
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `443`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.common.label_tcp }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.