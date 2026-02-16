In the left-hand panel, select ![seal-check](../../_assets/console-icons/seal-check.svg) **{{ ui-key.yacloud_org.security-center.label_comp }}**.

In the window that opens, you will see a list with info on security requirement sets used to verify the infrastructure's compliance in the selected environment. The list contains the following information:

* **{{ ui-key.yacloud_org.security.comp.SetsTable.field_set_title }}**: Name of the industry security standard or regulation that matches the requirement set.
* **{{ ui-key.yacloud_org.security.comp.SetsTable.field_count_rules }}**: Number of control rules in the requirement set.
* **{{ ui-key.yacloud_org.security.comp.SetsTable.field_execution }}**: Percentage of rules that are followed from the total rules in the requirement set. The `100%` value means full compliance with the relevant security standard or regulation. 

    If you disabled compliance checks of the environment resources against the requirement set, this field will contain `{{ ui-key.yacloud_org.security.comp.SetsTable.not_verified }}`.

    {% include [rule-set-enable-disable-notice](./rule-set-enable-disable-notice.md) %}