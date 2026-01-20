1. In the [management console]({{ link-console-main }}), click ![image](../../_assets/console-icons/chevron-down.svg) in the top panel and select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder).
1. In the left-hand panel, click ![image](../../_assets/console-icons/dots-9.svg) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
1. Click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
1. Enter a name for the service account.

   Follow these naming requirements:

   {% include [name-format](../name-format.md) %}

   {% include [sa-uniq-name](sa-uniq-name.md) %}

1. To assign the service account a [role](../../iam/concepts/access-control/roles.md) for the current folder, click **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** and select a role, e.g., `editor`.

   To assign a role for another resource, use the CLI or API following this [{#T}](../../iam/operations/sa/assign-role-for-sa.md) guide.

1. Click **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.
