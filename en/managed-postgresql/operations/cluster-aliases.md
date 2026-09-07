---
title: Managing {{ PG }} cluster aliases
description: You can create a custom network name for a {{ MY }} cluster, and move it to another cluster in your folder.
---

# Managing {{ PG }} cluster aliases

You can assign an _alias_ — a custom network name — to each {{ PG }} cluster. The alias corresponds to a separate DNS record that always points to the master host of the cluster the alias is linked to. This lets you access the cluster by a stable, human-readable name regardless of the master host's internal FQDN. The alias must be unique within the folder. You can assign only one alias per cluster.

To switch your applications to a different cluster in the same folder, you only need to relink the alias to that cluster.

Alias format:

```text
c-<alias_name>-pg-<folder_ID>.rw.{{ dns-zone }}
```

{% note info %}

When you create an alias, you only specify its name.

{% endnote %}


## Get a cluster alias {#get-alias}

To view an alias, you need the [managed-postgresql.viewer](../security/index.md#managed-postgresql-viewer) role or higher for the folder.

{% list tabs group=instructions %}

- Management console {#console}

  1. [Navigate]({{ link-console-main }}/link/managed-postgresql) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Click the name of the cluster you need.

     The cluster alias is shown in the **{{ ui-key.yacloud.mdb.cluster.hosts.section_cname-alias }}** field.


{% endlist %}

## Create a cluster alias {#create-alias}

To create an alias, you need the [managed-postgresql.editor](../security/index.md#managed-postgresql-editor) role or higher for the folder.

{% include [dns-time-warn](../../_includes/mdb/note-alias-dns-time.md) %}

{% list tabs group=instructions %}

- Management console {#console}

  1. [Navigate]({{ link-console-main }}/link/managed-postgresql) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Click the name of the cluster you need, then in the **{{ ui-key.yacloud.mdb.cluster.hosts.section_cname-alias }}** section, click ![image-link](../../_assets/console-icons/link.svg).
  1. In the window that opens, specify the cluster alias name. You can use lowercase Latin letters, digits, and hyphens. The alias can be up to 63 characters long.
  1. Click **{{ ui-key.yacloud.mdb.cluster.hosts.action_create-alias }}**.


{% endlist %}

## Move an alias between clusters {#move-alias}

You can only move an alias between clusters within the same folder. To move an alias, you need the [managed-postgresql.editor](../security/index.md#managed-postgresql-editor) role or higher for the folder.

{% include [dns-time-warn](../../_includes/mdb/note-alias-dns-time.md) %}

{% list tabs group=instructions %}

- Management console {#console}

  1. [Navigate]({{ link-console-main }}/link/managed-postgresql) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. You can move an alias in one of two ways:

     * From the settings of the cluster that has the alias.

        1. Click the name of the cluster whose alias you want to move to another cluster in your folder, then in the **{{ ui-key.yacloud.mdb.cluster.hosts.section_cname-alias }}** section, click ![image-shuffle](../../_assets/console-icons/shuffle.svg).
        1. In the window that opens, select the cluster to link the alias to.

     * From the settings of the cluster the alias is being moved to.

        1. Click the name of the cluster you want to move another cluster's alias to, then in the **{{ ui-key.yacloud.mdb.cluster.hosts.section_cname-alias }}** section, click ![image-shuffle](../../_assets/console-icons/shuffle.svg).
        1. In the window that opens, select the cluster the alias is currently linked to.

  1. Confirm the move and click **{{ ui-key.yacloud.mdb.cluster.hosts.action_move-cluster-alias }}**.


{% endlist %}

## Delete an alias {#delete-alias}

To delete an alias, you need the [managed-postgresql.editor](../security/index.md#managed-postgresql-editor) role or higher for the folder.

{% list tabs group=instructions %}

- Management console {#console}

  1. [Navigate]({{ link-console-main }}/link/managed-postgresql) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Click the name of the cluster you need, then in the **{{ ui-key.yacloud.mdb.cluster.hosts.section_cname-alias }}** section, click ![image-link](../../_assets/console-icons/link-slash.svg).
  1. In the window that opens, confirm that you want to delete the alias.


{% endlist %}
