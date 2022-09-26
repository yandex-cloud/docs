# Configuring a YDB source endpoint
{% if audience == "external" %}
When [creating](../index.md#create) or [editing](../index.md#update) an endpoint, you can define:

* The {{ ydb-full-name }} database and [service account](../../../../iam/concepts/users/service-accounts.md) to access it.
* The transfer path list (for tables and directories).

## Settings {#settings}

{% list tabs %}

- Management console

   * **Database**: Select a {{ ydb-name }} database from the list.
   * **Service account ID**: Select a service account with the `{{ roles-editor }}` role from the list to use to transfer data, or create new one.
   * **Transfer path list**: Add paths to the {{ ydb-name }} tables and directories to transfer. If no path is specified, all the tables will be transferred.

{% endlist %}
{% endif %}