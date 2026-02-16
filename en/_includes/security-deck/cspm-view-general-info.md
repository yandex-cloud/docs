For each rule, the table displays the following information:

{% note tip %}

If required, you can modify the information columns displayed in the table. Do it by clicking ![gear](../../_assets/console-icons/gear.svg) in the row with the table column headers, selecting the info columns you need, and clicking **{{ ui-key.yacloud_org.common.apply }}**.

{% endnote %}

* {% include [sec-rules-criticality-levels](./sec-rules-criticality-levels.md) %}
* **{{ ui-key.yacloud_org.security.controls.rule-result.controlRule_kr2Bv }}**: Rule name and brief summary. To [learn more](../../security-deck/operations/cspm/view-rules.md#detailed-info) about a rule, click the table row with its name.
* **{{ ui-key.yacloud_org.security.controls.rule-result.standards_iv6a5 }}**: Icon(s) complying with the safety standards that implement this rule. If the icon is colored, it means the rule is checked for the corresponding standard. If the icon is gray, it means it is not.
* **{{ ui-key.yacloud_org.security.workspaces.label_rule-kind_3PswX }}**: Compliance check type for the controlled infrastructure in the workspace with this rule:

    * `automatic`: Rule is checked automatically once every eight hours.
    * `manual`: Rule has to be checked manually. Click the row with the rule to find a guide and details.
* **{{ ui-key.yacloud_org.security.controls.ExceptionDrawer.resources_field_id }}**: Rule ID in {{ yandex-cloud }}.
* **{{ ui-key.yacloud_org.security.controls.rule-result.violations_q7AcU }}**: Number of detected rule violations.