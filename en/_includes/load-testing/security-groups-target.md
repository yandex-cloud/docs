1. [Create](../../vpc/operations/security-group-create.md) a test target security group named `load-target-sg`.
1. [Add a rule](../../vpc/operations/security-group-add-rule.md) for inbound traffic when generating load to the test target:
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-any }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}`.
      Select `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-list }}`. Specify the [security group](../../vpc/concepts/security-groups.md) comprising the test target.

    This rule allows agents to generate load to the test target or use additional monitoring tools.