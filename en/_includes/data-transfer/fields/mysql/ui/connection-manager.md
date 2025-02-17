**{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_connman.title }}**: Enables using a database conection via [{{ connection-manager-full-name }}](../../../../../metadata-hub/quickstart/connection-manager.md):

* **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.ConnmanConnection.connection_id.title }}**: Specify a connection ID from {{ connection-manager-name }}.

* {% include [database](../../../fields/mysql/ui/database.md) %}

{% note warning %}

To use a connection from {{ connection-manager-name }}, the user must have [access permissions](../../../../../metadata-hub/operations/connection-access.md) of `connection-manager.user` or higher for this connection.

{% endnote %}
