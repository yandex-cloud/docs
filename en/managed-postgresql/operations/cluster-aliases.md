---
title: Managing {{ PG }} cluster aliases
description: You can create a custom network name for your {{ MY }} cluster or assign the name to a different cluster in your folder.
---

# Managing {{ PG }} cluster aliases

An _alias_ is a custom network name you can assign to each {{ PG }} cluster. An alias is mapped to a dedicated DNS record which always points to the cluster’s master host. This allows you to access the cluster using a human-readable name without the internal master host FQDN. An alias must be unique within a folder. You can assign only one alias to each cluster.

To connect your applications to a different cluster within the same folder, simply update the cluster-alias association.

Alias format:

```text
c-<alias_name>-pg-<folder_ID>.rw.{{ dns-zone }}
```

{% note info %}

When creating an alias, you only need to specify its name.

{% endnote %}


## Getting the cluster alias {#get-alias}

To view the alias, you need the [managed-postgresql.viewer](../security/index.md#managed-postgresql-viewer) role or higher for the folder.

{% list tabs group=instructions %}

- Management console {#console}

  1. [Navigate]({{ link-console-main }}/link/managed-postgresql) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Click the cluster name.

     The cluster alias is displayed in the **{{ ui-key.yacloud.mdb.cluster.hosts.section_cname-alias }}** field.


{% endlist %}

## Creating a cluster alias {#create-alias}

To create an alias, you need the [managed-postgresql.editor](../security/index.md#managed-postgresql-editor) role or higher for the folder.

{% include [dns-time-warn](../../_includes/mdb/note-alias-dns-time.md) %}

{% list tabs group=instructions %}

- Management console {#console}

  1. [Navigate]({{ link-console-main }}/link/managed-postgresql) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Click the cluster name, then click ![image-link](../../_assets/console-icons/link.svg) in the **{{ ui-key.yacloud.mdb.cluster.hosts.section_cname-alias }}** section.
  1. In the window that opens, specify a name for the cluster alias. Use only lowercase Latin letters, numbers, and hyphens. The alias may be up to 63 characters long.
  1. Click **{{ ui-key.yacloud.mdb.cluster.hosts.action_create-alias }}**.


{% endlist %}

## Reassigning an alias between clusters {#move-alias}

You can only reassign an alias between clusters within the same folder. To reassign an alias, you need the [managed-postgresql.editor](../security/index.md#managed-postgresql-editor) role or higher for the folder.

{% include [dns-time-warn](../../_includes/mdb/note-alias-dns-time.md) %}

{% list tabs group=instructions %}

- Management console {#console}

  1. [Navigate]({{ link-console-main }}/link/managed-postgresql) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. You can reassign an alias using one of the two methods:

     * From the settings of the cluster the alias is assigned to.

        1. Click the name of the cluster whose alias you want to assign to another cluster within your folder, and click ![image-shuffle](../../_assets/console-icons/shuffle.svg) in the **{{ ui-key.yacloud.mdb.cluster.hosts.section_cname-alias }}** section.
        1. In the window that opens, select the new cluster for the alias.

     * From the target cluster settings.

        1. Click the name of the target cluster within your folder, and click ![image-shuffle](../../_assets/console-icons/shuffle.svg) in the **{{ ui-key.yacloud.mdb.cluster.hosts.section_cname-alias }}** section.
        1. In the window that opens, select the cluster the alias is currently assigned to.

  1. Confirm reassigning the alias and click **{{ ui-key.yacloud.mdb.cluster.hosts.action_move-cluster-alias }}**.


{% endlist %}

## Deleting an alias {#delete-alias}

To delete an alias, you need the [managed-postgresql.editor](../security/index.md#managed-postgresql-editor) role or higher for the folder.

{% list tabs group=instructions %}

- Management console {#console}

  1. [Navigate]({{ link-console-main }}/link/managed-postgresql) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Click the cluster name, then click ![image-link](../../_assets/console-icons/link-slash.svg) in the **{{ ui-key.yacloud.mdb.cluster.hosts.section_cname-alias }}** section.
  1. In the window that opens, confirm the alias deletion.


{% endlist %}
