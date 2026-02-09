To learn more about a security control rule, click the table row with its name. You will see a window with rule details, which has the following tabs:

{% list tabs %}

- {{ ui-key.yacloud_org.security.controls.RulePageLayout.tab_overview_s9riS }}

  The **{{ ui-key.yacloud_org.security.controls.RulePageLayout.tab_overview_s9riS }}** tab contains:

  * Rule ID.
  * [Set of security requirements](../../security-deck/concepts/standard-compliance/index.md#security-rule-sets) the rule applies to.
  * Date and time of the most recent security check.
  * Check method:

      * `automatic`: Rule is checked automatically once every eight hours.
      * `manual`: Rule has to be checked manually.
  * Details on the monitored features, their configurations, or actions performed with them.

- {{ ui-key.yacloud_org.security.controls.RulePageLayout.tab_violations_dkbdT }}

  The **{{ ui-key.yacloud_org.security.controls.RulePageLayout.tab_violations_dkbdT }}** tab lists control rule violations detected during the checks. Detected violations will not appear in this list if they satisfy the [exception](../../security-deck/concepts/cspm.md#exceptions) criteria specified for the rule.

- {{ ui-key.yacloud_org.security.controls.ControlsPage.exceptions_kw1u7 }}

  The **{{ ui-key.yacloud_org.security.controls.ControlsPage.exceptions_kw1u7 }}** tab lists all [exceptions](../../security-deck/concepts/cspm.md#exceptions) defined for the rule along with controls for exception [management](../../security-deck/operations/cspm/manage-exceptions.md).

- {{ ui-key.yacloud_org.security.controls.RulePageLayout.tab_recommendations_qq61Z }}

  The **{{ ui-key.yacloud_org.security.controls.RulePageLayout.tab_recommendations_qq61Z }}** tab provides guides and solutions to assist you with rule compliance.

{% endlist %}