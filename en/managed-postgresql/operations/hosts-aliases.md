# Managing host aliases

You can assign an alias, a custom network name, to each host of a {{ mpg-name }} cluster. The alias corresponds to a separate DNS record that always points to the host the alias is linked to. This lets you access the host by a stable, human-readable name regardless of the host's internal FQDN. The alias must be unique within the folder. You can assign only one alias per host.

Alias format:

```
h-<alias_name>-pg-<folder_ID>.rw.{{ dns-zone }}
```

{% note info %}

When you create an alias, you only specify its name.

{% endnote %}

## Get a list of aliases {#list-aliases}

To get a list of aliases, you need the [managed-postgresql.viewer](../security/index.md#managed-postgresql-viewer) role or higher for the folder.


### Get a list of aliases in a cluster {#list-aliases-in-cluster}

{% list tabs group=instructions %}

- Management console {#console}

  1. [Navigate]({{ link-console-main }}/link/managed-postgresql) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Click the name of the cluster you need, then select the **{{ ui-key.yacloud.postgresql.cluster.switch_hosts }}** tab.

      All host aliases created in the cluster are listed in the host list, in the **{{ ui-key.yacloud.mdb.cluster.hosts.field_host_alias }}** column.


{% endlist %}


## Get a host alias {#get-host-alias}

To view an alias, you need the [managed-postgresql.viewer](../security/index.md#managed-postgresql-viewer) role or higher for the folder.

{% list tabs group=instructions %}

- Management console {#console}

  1. [Navigate]({{ link-console-main }}/link/managed-postgresql) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Click the name of the cluster you need, then select the **{{ ui-key.yacloud.postgresql.cluster.switch_hosts }}** tab and find the host you need in the host list. The host alias is shown in the **{{ ui-key.yacloud.mdb.cluster.hosts.field_host_alias }}** column.


{% endlist %}


## Create a host alias {#create-alias}

To create an alias, you need the [managed-postgresql.editor](../security/index.md#managed-postgresql-editor) role or higher for the folder.

{% include [dns-time-warn](../../_includes/mdb/note-alias-dns-time.md) %}

{% list tabs group=instructions %}

- Management console {#console}

  1. [Navigate]({{ link-console-main }}/link/managed-postgresql) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Click the name of the cluster you need, then select the **{{ ui-key.yacloud.postgresql.cluster.switch_hosts }}** tab.
  1. Click the ![image](../../_assets/console-icons/ellipsis.svg) icon in the row of the host you need and select **{{ ui-key.yacloud.mdb.cluster.hosts.action_create-alias }}**.
  1. In the window that opens, enter the alias and click **{{ ui-key.yacloud.mdb.cluster.hosts.action_create-alias }}**.

      The alias name can contain lowercase Latin letters, digits, and hyphens. The alias can be up to 63 characters long.


{% endlist %}

## Delete an alias {#delete-alias}

To delete an alias, you need the [managed-postgresql.editor](../security/index.md#managed-postgresql-editor) role or higher for the folder.

{% list tabs group=instructions %}

- Management console {#console}

  1. [Navigate]({{ link-console-main }}/link/managed-postgresql) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Click the name of the cluster you need, then select the **{{ ui-key.yacloud.postgresql.cluster.switch_hosts }}** tab.
  1. Click the ![image](../../_assets/console-icons/ellipsis.svg) icon in the row of the host you need and select **{{ ui-key.yacloud.mdb.cluster.hosts.action_delete-alias }}**.
  1. In the window that opens, click **Delete**.


{% endlist %}
