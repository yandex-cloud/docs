#|
|| **Rule purpose** | **Rule settings** ||
|| To manage the runner from the {{ GL }} instance over SSH.
This is a required rule. |
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}: `22`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}: `{{ ui-key.yacloud.common.label_tcp }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
* {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}: CIDRs of all subnets where runners may run.
Instead of a CIDR, you can specify a security group created for runners.
||
|#
