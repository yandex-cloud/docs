# Backups in {{ mgl-name }}

{{ mgl-name }} supports automatic and manual [instance](./index.md#instance) backups.

Apart from database, repository, and attachment contents, backup copies end up containing secrets: SSH keys, tokens, etc.

To restore an instance from a backup, contact [support]({{ link-console-support }}).

## Creating backups {#size}

A backup is automatically created every day. You cannot disable backups.

For more information about creating a backup manually, see [{#T}](../operations/instance/instance-backups.md).

If a backup fails (`Failed` status), [configure a separate security group](../operations/configure-security-group.md) and bind it to the {{ GL }} instance.

After a backup is created, it is compressed for storage. The exact backup size is not displayed.

Backups are only created on running instances.

## Storing backups {#storage}

Data backups are stored in object storage and do not take up space in instance storage.

By default, backups are stored for seven days. The retention period is set when [creating an instance](../operations/instance/instance-create.md#create) and can be from 7 to 60 days. You cannot change the backup retention period after the instance has been created. A stopped instance always contains at least one backup, even after the backup retention period expires.

When you delete an instance, a backup is automatically created and stored for two weeks.

The size of backups stored in {{ objstorage-full-name }} is charged according to the [Pricing policy](../pricing.md#prices-storage).