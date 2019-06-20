# How to manage backups

You can create backups and restore clusters from existing backups.

## Restoring clusters from backups {#restore}

When you restore a cluster from a backup, you create a new cluster with the data from the backup. If the folder has insufficient [resources](../concepts/limits.md) to create such a cluster, you will not be able to restore from the backup.

For a new cluster, you should set all the parameters that are required at creation, except for the cluster type (a {{ CH }} backup cannot be restored as a {{ MY }} cluster).

{% list tabs %}

- Management console
  
  1. Go to the folder page and click **{{ mmy-name }}**.
  1. Click on the name of the cluster you need and select the tab **Backup copies**.
  1. Click ![image](../../_assets/dots.svg) for the required backup and then click **Restore cluster**.
  
{% endlist %}

## Creating backups {#create-backup}

{% list tabs %}

- Management console
  
  1. Go to the folder page and click **{{ mmy-name }}**.
  1. Click on the name of the cluster you need and select the tab **Backup copies**.
  1. Click **Create a backup**.
  
{% endlist %}

## Getting a list of backups {#list-backups}

{% list tabs %}

- Management console
  
  1. Go to the folder page and click **{{ mmy-name }}**.
  1. Click on the name of the cluster you need and select the tab **Backup copies**.
  
{% endlist %}

## Getting information about a backup {#get-backup}

{% list tabs %}

- Management console
  
  1. Go to the folder page and click **{{ mmy-name }}**.
  1. Click on the name of the cluster you need and select the tab **Backup copies**.
  
{% endlist %}

