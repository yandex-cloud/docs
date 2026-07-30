To view detailed information about a specific {{ k8s }} control rule, click the table row with its name. The detailed info window that opens includes the following tabs:

{% list tabs %}

- {{ ui-key.yacloud_org.security.controls.RulePageLayout.tab_overview_s9riS }}

  The **{{ ui-key.yacloud_org.security.controls.RulePageLayout.tab_overview_s9riS }}** tab contains:

  * Rule ID.
  * [Security requirements](../../security-deck/concepts/standard-compliance/index.md#security-rule-sets) the rule applies to.
  * Date and time of last security check.
  * Rule type:

      * `Runtime`: Rule type applied to container runtimes and {{ k8s }} nodes.
      * `Admission`: Rule type applied to {{ k8s }} cluster resources. The `Admission` type rules have two operating modes:

          {% include [kspm-admission-modes](./kspm-admission-modes.md) %}

      * `HostSecurity`: [CIS Benchmark™](../../security-deck/concepts/standard-compliance/cis-kubernetes-benchmark.md) rule type applied to components on {{ k8s }} worker nodes.

  * Details on the monitored features, their configurations, or actions performed with them.

- {{ ui-key.yacloud_org.security.controls.RulePageLayout.tab_violations_dkbdT }}

  The **{{ ui-key.yacloud_org.security.controls.RulePageLayout.tab_violations_dkbdT }}** tab lists control rule violations detected during the checks. Detected violations will not appear in this list if they satisfy the [exception](../../security-deck/concepts/cspm.md#exceptions) criteria specified for the rule.

- {{ ui-key.yacloud_org.security.controls.RulePageLayout.tab_recommendations_qq61Z }}

  The **{{ ui-key.yacloud_org.security.controls.RulePageLayout.tab_recommendations_qq61Z }}** tab provides guides and solutions to assist you with rule compliance.

{% endlist %}