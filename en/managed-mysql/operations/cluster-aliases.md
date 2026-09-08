---
title: Managing {{ MY }} cluster aliases
description: You can create a custom network name for your {{ MY }} cluster as well as move the name to another cluster in your folder.
---

# Managing {{ MY }} cluster aliases

You can assign each {{ MY }} cluster an _alias_, which is a custom network name. An alias is mapped to a specific DNS record which always points to the master host of the cluster associated with the alias. This allows you to access the cluster using a human-readable name, regardless of internal host FQDNs. The alias must be unique within the folder. You can assign only one alias per cluster.

To switch your apps to another cluster in the same folder, all you need to do is change the cluster-alias association.

Alias format:

```text
c-<alias_name>-my-<folder_ID>.rw.{{ dns-zone }}
```

{% note info %}

When creating an alias, you only specify its name.

{% endnote %}


## Getting the cluster alias {#get-alias}

Viewing the alias requires the [managed-mysql.viewer](../security/index.md#managed-mysql-viewer) role or higher for the folder.

{% list tabs group=instructions %}

- Management console {#console}

  1. [Navigate]({{ link-console-main }}/link/managed-mysql) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Click the cluster name.

     The cluster alias is displayed in the **{{ ui-key.yacloud.mdb.cluster.hosts.section_cname-alias }}** field.


{% endlist %}

## Creating a cluster alias {#create-alias}

Creating an alias requires the [managed-mysql.editor](../security/index.md#managed-mysql-editor) role or higher for the folder.

{% include [dns-time-warn](../../_includes/mdb/note-alias-dns-time.md) %}

{% list tabs group=instructions %}

- Management console {#console}

  1. [Navigate]({{ link-console-main }}/link/managed-mysql) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Click the cluster name and click ![image-link](../../_assets/console-icons/link.svg) in the **{{ ui-key.yacloud.mdb.cluster.hosts.section_cname-alias }}** section.
  1. In the window that opens, specify a name for the cluster alias. Use only lowercase Latin letters, numbers, and hyphens. The alias may be up to 63 characters long.
  1. Click **{{ ui-key.yacloud.mdb.cluster.hosts.action_create-alias }}**.


{% endlist %}

## Moving an alias between clusters {#move-alias}

You can move an alias only between clusters in the same folder. Moving an alias requires the [managed-mysql.editor](../security/index.md#managed-mysql-editor) role or higher for the folder.

{% include [dns-time-warn](../../_includes/mdb/note-alias-dns-time.md) %}

{% list tabs group=instructions %}

- Management console {#console}

  1. [Navigate]({{ link-console-main }}/link/managed-mysql) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. You can move the alias in one of these two ways:

     * In the settings of the cluster with the alias:

        1. Click the name of the cluster whose alias you want to move to another cluster in your folder, and then ![image-shuffle](../../_assets/console-icons/shuffle.svg) in the **{{ ui-key.yacloud.mdb.cluster.hosts.section_cname-alias }}** section.
        1. In the window that opens, select the cluster to associate the alias with.

     * In the settings of the cluster to move the alias to.

        1. Click the name of the cluster to which you want to move the alias of another cluster in your folder, and then ![image-shuffle](../../_assets/console-icons/shuffle.svg) in the **{{ ui-key.yacloud.mdb.cluster.hosts.section_cname-alias }}** section.
        1. In the window that opens, select the cluster the alias is associated with.

  1. Confirm moving the cluster and click **{{ ui-key.yacloud.mdb.cluster.hosts.action_move-cluster-alias }}**.


{% endlist %}

## Deleting an alias {#delete-alias}

Deleting an alias requires the [managed-mysql.editor](../security/index.md#managed-mysql-editor) role or higher for the folder.

{% list tabs group=instructions %}

- Management console {#console}

  1. [Navigate]({{ link-console-main }}/link/managed-mysql) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Click the cluster name and then, ![image-link](../../_assets/console-icons/link-slash.svg) in the **{{ ui-key.yacloud.mdb.cluster.hosts.section_cname-alias }}** section.
  1. In the window that opens, confirm the alias deletion.


{% endlist %}
