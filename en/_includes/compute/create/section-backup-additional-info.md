{% note info %}

If your account does not have the `backup.user` role or higher, you can connect the VM to {{ backup-name }} using a [service account](../../../iam/concepts/users/service-accounts.md) which has that role. 

To do this, expand the **{{ ui-key.yacloud.compute.instances.create.section_additional }}** section and select the service account under **{{ ui-key.yacloud.compute.instances.create.field_service-account }}**. If required, [create](../../../iam/operations/sa/create.md) a new service account and [assign](../../../iam/operations/sa/assign-role-for-sa.md) it the `backup.user` [role](../../../backup/security/index.md#backup-user).

{% endnote %}

{% note tip %}

{% include [cloud-backup-resources-note](../../../_includes/backup/cloud-backup-resources-note.md) %}

{% endnote %}

For more information, see [{#T}](../../../backup/concepts/vm-connection.md).