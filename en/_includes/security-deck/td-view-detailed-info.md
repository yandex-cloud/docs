To learn more about a security control rule, click the table row with its name. You will see a window with rule details, which has the following tabs:

{% list tabs %}

- {{ ui-key.yacloud_org.security.controls.RulePageLayout.tab_overview_s9riS }}

  The **{{ ui-key.yacloud_org.security.controls.RulePageLayout.tab_overview_s9riS }}** tab contains:

  * Rule category (ID of the {{ sd-name }} module that uses the rule).
  * Rule ID.
  * [Set of security requirements](../../security-deck/concepts/standard-compliance/index.md#security-rule-sets) the rule applies to.
  * Date and time of the most recent security check.
  * Rule type (check method):

      * `Automatic`: Rule is checked automatically once every eight hours.
      * `Manual`: Rule has to be checked manually.
  * Details on the monitored features, their configurations, or actions performed with them.

- {{ ui-key.yacloud_org.security.controls.ControlsPage.exceptions_kw1u7 }}

  The **{{ ui-key.yacloud_org.security.controls.ControlsPage.exceptions_kw1u7 }}** tab lists all [exceptions](../../security-deck/concepts/threat-detector.md#exceptions) defined for the rule along with controls for exception [management](../../security-deck/operations/td/manage-exceptions.md).

- {{ ui-key.yacloud_org.security.controls.RulePageLayout.tab_recommendations_qq61Z }}

  The **{{ ui-key.yacloud_org.security.controls.RulePageLayout.tab_recommendations_qq61Z }}** tab provides guides and solutions to assist you with rule compliance.

{% endlist %}