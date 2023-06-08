1. [Create](../../vpc/operations/security-group-create.md) the test target's security group named `load-target-sg`.
1. [Add a rule](../../vpc/operations/security-group-add-rule.md) for incoming traffic when generating load to the test target:
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-any }}`.
   * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}`.
   *
      Select `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-list }}`. Specify the [security group](../../vpc/concepts/security-groups.md) where the test target is located.

   This rule allows agents to generate load to this target or enable additional monitoring tools.