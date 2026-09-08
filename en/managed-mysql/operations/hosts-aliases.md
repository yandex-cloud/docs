# Managing host aliases

You can assign each {{ mmy-name }} cluster host an _alias_, which is a custom network name. An alias is mapped to a specific DNS record which always points to the host associated with the alias. This allows you to access the cluster using a human-readable name without the host’s internal FQDN. An alias must be unique within a folder. You can assign only one alias per host.

Alias format:

```
h-<alias_name>-my-<folder_ID>.rw.{{ dns-zone }}
```

{% note info %}

When creating an alias, you only need to specify its name.

{% endnote %}


## Getting a list of aliases {#list-aliases}

To get a list of aliases, you need the [managed-mysql.viewer](../security/index.md#managed-mysql-viewer) role or higher for the folder.


### Getting a list of aliases in a cluster {#list-aliases-in-cluster}

{% list tabs group=instructions %}

- Management console {#console}

  1. [Navigate]({{ link-console-main }}/link/managed-mysql) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Click the name of your cluster and select the **{{ ui-key.yacloud.mysql.cluster.switch_hosts }}** tab.

      In the list of hosts, the **{{ ui-key.yacloud.mdb.cluster.hosts.field_host_alias }}** column shows all host aliases created in the cluster.


{% endlist %}


## Getting the host alias {#get-host-alias}

To view the alias, you need the [managed-mysql.viewer](../security/index.md#managed-mysql-viewer) role or higher for the folder.

{% list tabs group=instructions %}

- Management console {#console}

  1. [Navigate]({{ link-console-main }}/link/managed-mysql) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Click the name of your cluster and select the **{{ ui-key.yacloud.mysql.cluster.switch_hosts }}** tab. In the list of hosts, locate the one you need. The host alias is displayed in the **{{ ui-key.yacloud.mdb.cluster.hosts.field_host_alias }}** column.


{% endlist %}

## Creating a host alias {#create-alias}

To create an alias, you need the [managed-mysql.editor](../security/index.md#managed-mysql-editor) role or higher for the folder.

{% include [dns-time-warn](../../_includes/mdb/note-alias-dns-time.md) %}

{% list tabs group=instructions %}

- Management console {#console}

  1. [Navigate]({{ link-console-main }}/link/managed-mysql) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Click the name of your cluster and select the **{{ ui-key.yacloud.mysql.cluster.switch_hosts }}** tab.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) in the host row and select **{{ ui-key.yacloud.mdb.cluster.hosts.action_create-alias }}**.
  1. In the window that opens, enter an alias and click **{{ ui-key.yacloud.mdb.cluster.hosts.action_create-alias }}**.

      Alias names can only contain lowercase Latin letters, digits, and hyphens. The alias may be up to 63 characters long.


{% endlist %}

## Deleting an alias {#delete-alias}

To delete an alias, you need the [managed-mysql.editor](../security/index.md#managed-mysql-editor) role or higher for the folder.

{% list tabs group=instructions %}

- Management console {#console}

  1. [Navigate]({{ link-console-main }}/link/managed-mysql) to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mysql }}**.
  1. Click the name of your cluster and select the **{{ ui-key.yacloud.mysql.cluster.switch_hosts }}** tab.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) in the host row and select **{{ ui-key.yacloud.mdb.cluster.hosts.action_delete-alias }}**.
  1. In the window that opens, click **Delete**.


{% endlist %}
