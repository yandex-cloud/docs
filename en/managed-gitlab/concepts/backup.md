# Backups

{{ mgl-name }} supports automatic and manual [instance](./index.md#instance) backups.

In addition to database, repository, and attachment contents, backups include secrets: SSH keys, tokens, and so on.

To restore an instance from a backup, contact [technical support]({{ link-console-support }}).

## Creating backups {#size}

A backup is automatically created once a day. You cannot disable backups.

For more information about creating a backup manually, see [{#T}](../operations/instance/instance-backups.md).

After a backup is created, it's compressed for storage. The exact backup size isn't displayed.

Backups are only created on running instances.

## Storing backups {#storage}

Data backups are stored in object storage and do not take up space in instance storage.

By default, backups are stored for seven days. The retention period is set when [creating an instance](../operations/instance/instance-create.md#create) and can be from 7 to 60 days. You cannot change the backup retention period after the instance has been created. A stopped instance always contains at least one backup, even after the backup retention period expires.

Once you delete an instance, all of its backups are deleted.

The size of backups stored in {{ objstorage-full-name }} is charged according to the [Pricing policy](../pricing.md#prices-storage).