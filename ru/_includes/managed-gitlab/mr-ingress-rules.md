#|
|| **Зачем нужно правило** | **Настройки правила** ||
|| Для управления раннером с инстанса {{ GL }} по протоколу SSH.
Обязательное правило. |
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} — `22`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} — `{{ ui-key.yacloud.common.label_tcp }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} — CIDR всех подсетей, где могут запускаться раннеры.
Вместо CIDR вы можете указать группу безопасности, созданную для раннеров.
||
|#
