For each rule, the table displays the following information:

{% note tip %}

If you need to, you can change the info columns displayed in the table. Do it by clicking ![gear](../../_assets/console-icons/gear.svg) in the row with the table column headers, selecting the info columns you need, and clicking **{{ ui-key.yacloud_org.common.apply }}**.

{% endnote %}

* ![traffic-light](../../_assets/console-icons/traffic-light.svg): Rule criticality level. This icon indicates how security-critical the rule is:

    * ![cspm-rule-notice-icon](../../_assets/security-deck/cspm-rule-notice-icon.svg): {{ ui-key.yacloud_org.shared.components.severity_info_biSRh }}
    * ![cspm-low-severity-icon](../../_assets/security-deck/cspm-low-severity-icon.svg): {{ ui-key.yacloud_org.shared.components.severity_low_tqf9A }}
    * ![cspm-moderate-severity-icon](../../_assets/security-deck/cspm-moderate-severity-icon.svg): {{ ui-key.yacloud_org.shared.components.severity_medium_8LZ4w }}
    * ![cspm-high-severity-icon](../../_assets/security-deck/cspm-high-severity-icon.svg): {{ ui-key.yacloud_org.shared.components.severity_high_cahHH }}
* **{{ ui-key.yacloud_org.security.controls.rule-result.controlRule_kr2Bv }}**: Rule name and brief summary. To [learn more](../../security-deck/operations/cspm/view-rules.md#detailed-info) about a rule, click the table row with its name.
* **{{ ui-key.yacloud_org.security.controls.rule-result.standards_iv6a5 }}**: Icon(s) for the [security standards](../../security-deck/concepts/workspace.md#standards) that are using this rule. If the icon is colored, it means the rule is checked for the corresponding standard. If the icon is gray, it means it is not.
* **{{ ui-key.yacloud_org.security.controls.rule-result.verificationMethod_dS9B2 }}**: How the infrastructure controlled in the workspace is checked for compliance with this rule:

    * `automatic`: Rule is checked automatically once every eight hours.
    * `manual`: Manual check of rule compliance is required. Click the row with the rule to find a guide and details.
* **{{ ui-key.yacloud_org.security.controls.ExceptionDrawer.resources_field_id }}**: Rule ID in {{ yandex-cloud }}.
* **{{ ui-key.yacloud_org.security.controls.rule-result.violations_q7AcU }}**: Number of rule violations detected.