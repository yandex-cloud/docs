# Backups in {{ mgl-name }}

{{ mgl-name }} supports automatic and manual [instance](./index.md#instance) backups.

Along with the database, repositories, and attachments, the backup contains secrets, such as SSH keys and tokens.

To restore an instance from a backup, contact [support]({{ link-console-support }}).

## Creating a backup {#size}

A backup is automatically created once a day. You cannot disable backups.

For more information about creating a backup manually, see [{#T}](../operations/instance/instance-backups.md).

If backup creation fails (the `Failed` status), [set up a dedicated security group](../operations/configure-security-group.md) and assign it to the {{ GL }} instance.

Once created, a backup is compressed for storage. The exact backup size is not displayed.

Backups are only created on running instances.

## Storing a backup {#storage}

Data backups are stored in object storage and do not take up space in the instance storage.

Backups are retained for seven days by default. The retention period is set when [creating the instance](../operations/instance/instance-create.md#create) and can range from 7 to 60 days. You cannot change the backup retention period after the instance has been created. A stopped instance always contains at least one backup, even after the backup retention period expires.

When you delete an instance, the system automatically creates its backup which is stored for two weeks.

You pay for the size of backups stored in {{ objstorage-full-name }} as per the relevant [pricing policy](../pricing.md#prices-storage).