For each rule, the table displays the following information:

{% include [table-columns-tip](./table-columns-tip.md) %}

* {% include [sec-rules-criticality-levels](./sec-rules-criticality-levels.md) %}
* **{{ ui-key.yacloud_org.security.controls.rule-result.controlRule_kr2Bv }}**: Rule name and brief summary. To [learn more](../../security-deck/operations/td/view-rules.md#detailed-info) about a rule, click the table row with its name.
* **{{ ui-key.yacloud_org.security.controls.rule-result.standards_iv6a5 }}**: Icon(s) for the [security standards](../../security-deck/concepts/workspace.md#standards) that are using this rule. If the icon is colored, it means the rule is checked for the corresponding standard. If the icon is gray, it means it is not.
* **{{ ui-key.yacloud_org.security.controls.rule-result.verificationMethod_dS9B2 }}**: How the infrastructure controlled in the workspace is checked for compliance with this rule:

    * `Automatic`: Rule is checked automatically once every eight hours.
    * `Manual`: Rule has to be checked manually. Click the row with the rule to find a guide and details.
* **{{ ui-key.yacloud_org.security.controls.ExceptionDrawer.resources_field_id }}**: Rule ID in {{ yandex-cloud }}.