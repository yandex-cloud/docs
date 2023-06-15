# Deleting a backup

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where the backup is located.
   1. Select **{{ backup-name }}**.
   1. Go to the ![backups](../../../_assets/backup/backups.svg) **Backups** tab.
   1. Next to the backup you wish to delete, click ![image](../../../_assets/options.svg) and select **Delete**.
   1. Confirm the deletion.

{% endlist %}

{% note info %}

To delete backups, make sure the folder contains at least one VM connected to {{ backup-name }}. If there are no such VMs, [create](../create-vm.md) a new one with a connection to {{ backup-name }} and delete the backups.

{% endnote %}

