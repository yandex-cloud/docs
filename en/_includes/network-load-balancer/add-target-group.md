Under **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.section_target-groups }}**, add a [target group](../../network-load-balancer/concepts/target-resources.md):

1. Click **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.label_add-target-group }}**.
1. Select a target group or [сreate a new one](../../network-load-balancer/operations/target-group-create.md):

    1. In the **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.label_target-group-id }}** field, select ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud.load-balancer.network-load-balancer.form.button_create-target-group }}**.
    1. In the window that opens, enter a target group name.
    1. Optionally, enter the target group description and add labels.
    1. Add VMs to the target group.
    1. Click **{{ ui-key.yacloud.common.create }}**.

1. {% include [configure-health-check](configure-health-check.md) %}