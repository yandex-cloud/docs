1. Create an [agent](../../load-testing/concepts/agent.md) [security group](../../vpc/operations/security-group-create.md) named `agent-sg`.
1. [Add rules](../../vpc/operations/security-group-add-rule.md):
   1. Rule for outgoing HTTPS traffic to the {{ load-testing-name }} public API:
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `443`
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`

      This will allow connecting the agent to {{ load-testing-name }} to manage tests from the interface and get test results.
   1. Rule for incoming SSH traffic:
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `22`
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`

      This will allow you to connect to the agent over SSH and manage tests from the console or collect debugging information.
   1. Rule for outgoing traffic when generating load to the test target:
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-any }}`
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}`
      * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}`
         Select `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-list }}`. Specify the [security group](../../vpc/concepts/security-groups.md) where the test target is located.

      Create this rule for each test target with a unique security group.