To learn more about a security control rule, click the table row with its name. The detailed info window that opens includes the following tabs:

{% list tabs %}

- {{ ui-key.yacloud_org.security.controls.RulePageLayout.tab_overview_s9riS }}

  In addition to the data shown in the [general rule info](../../security-deck/concepts/cspm.md#general-info) table, the **{{ ui-key.yacloud_org.security.controls.RulePageLayout.tab_overview_s9riS }}** tab contains:
  
  * Date and time of the most recent security check.
  * Details on the monitored features, their configurations, or actions performed with them.

- {{ ui-key.yacloud_org.security.controls.RulePageLayout.tab_violations_dkbdT }}

  The **{{ ui-key.yacloud_org.security.controls.RulePageLayout.tab_violations_dkbdT }}** tab lists security violations detected during checks. Detected violations will not appear in this list if they satisfy the [exception](../../security-deck/concepts/cspm.md#exceptions) criteria specified for the rule.

- {{ ui-key.yacloud_org.security.controls.ControlsPage.exceptions_kw1u7 }}

  The **{{ ui-key.yacloud_org.security.controls.ControlsPage.exceptions_kw1u7 }}** tab lists all [exceptions](../../security-deck/concepts/cspm.md#exceptions) defined for the rule along with controls for exception [management](../../security-deck/operations/cspm/manage-exceptions.md).

- {{ ui-key.yacloud_org.security.controls.RulePageLayout.tab_recommendations_qq61Z }}

  The **{{ ui-key.yacloud_org.security.controls.RulePageLayout.tab_recommendations_qq61Z }}** tab provides guides and solutions to help you perform the actions required by the rule.

{% endlist %}