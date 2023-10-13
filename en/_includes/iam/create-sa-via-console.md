1. Log in to the [management console]({{link-console-main}}).
1. Click the line with the name of the folder where you want to create a service account.
1. At the top of the screen, go to the **{{ ui-key.yacloud.iam.folder.switch_service-accounts }}** tab.
1. Click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
1. Enter the name of the service account.

   The name format requirements are as follows:

   {% include [name-format](../name-format.md) %}

   {% include [sa-uniq-name](sa-uniq-name.md) %}

1. To assign the service account a [role](../../iam/concepts/access-control/roles.md) for the current folder, click **{{ ui-key.yacloud.iam.folder.service-account.label_add-role }}** and select a role such as `editor`.

   To assign a role for another resource, use the CLI or API by following the instructions [{#T}](../../iam/operations/sa/assign-role-for-sa.md).

1. Click **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.
