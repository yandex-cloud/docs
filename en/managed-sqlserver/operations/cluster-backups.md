# Managing backups

You can create [backups](../concepts/backup.md) and restore clusters from existing backups.

## Getting a list of backups {#list-backups}

{% list tabs %}


- API

  To get a list of cluster backups, use the `listBackups` API method and pass the cluster ID in the `clusterId` request parameter.

  To get a list of backups for all the **{{ mms-name }}** clusters in the folder, use the `list` API method and pass the folder ID in the `folderId` request parameter.

  To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}

## Getting information about backups {#get-backup}

{% list tabs %}


- API

  To get information about a backup, use the `get` API method and pass the backup ID in the `backupId` request parameter. To find out the ID, [get a list of backups](#list-backups).

{% endlist %}

## Creating backups {#create-backup}

{% list tabs %}


- API

  Use the `backup` API method and pass the cluster ID in the `clusterId` request parameter.

  To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).

{% endlist %}

## Restoring clusters from backups {#restore}

When you restore a cluster from a backup, you create a new cluster with the data from the backup. If the folder has insufficient [resources](../concepts/limits.md) to create such a cluster, you will not be able to restore from the backup.

For a new cluster, you need to set up all its [parameters required at creation](cluster-create.md#create-cluster).

{% list tabs %}


- API

  Use the `restore` API method and pass the following in the request:
  - ID of the desired backup, in the `backupId` parameter. To find out the ID, [get a list of backups](#list-backups).
  - Timestamp of the moment to which the cluster should be restored, in the `time` parameter.
  - The name of the new cluster that will contain the data recovered from the backup. The cluster name must be unique within the folder.

{% endlist %}

## Edit the backup start time {#set-backup-window}

{% list tabs %}


- API

  To change the backup start time for a cluster, use the `update` method and pass the following in the request:
  - The cluster ID, in the `clusterId` parameter. To find out the cluster ID, [get a list of clusters in the folder](cluster-list.md#list-clusters).
  - The new backup start time, in the `configSpec.backupWindowStart` parameter.
  - List of cluster configuration fields to be changed (in this case, `configSpec.backupWindowStart`), in the `updateMask` parameter.

  {% note warning %}

  This API method resets any cluster settings that aren't passed explicitly in the request to their defaults. To avoid this, list the settings you want to change in the `updateMask` parameter (in a single line, separated by commas).

  {% endnote %}

{% endlist %}

