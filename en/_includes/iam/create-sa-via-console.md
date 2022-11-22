1. Log in to the [management console]({{link-console-main}}).
1. Click the line with the name of the folder where you want to create a service account.
1. Go to the **Service accounts** tab.
1. Click **Create service account**.
1. Enter the name of the service account.

   Name format requirements:

   {% include [name-format](../name-format.md) %}

   {% include [sa-uniq-name](sa-uniq-name.md) %}

1. To assign the service account a [role](../../iam/concepts/access-control/roles.md) for the current folder, click **Add role** and select a role such as `editor`.

   To assign a role for another resource, use the CLI or API by following the instructions [{#T}](../../iam/operations/sa/assign-role-for-sa.md).

1. Click **Create**.
