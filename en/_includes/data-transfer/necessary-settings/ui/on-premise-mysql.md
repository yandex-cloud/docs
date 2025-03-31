
* **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_type.title }}**: Select a database connection option:

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_plain.title }}**: Allows you to specify connection settings manually.

        Select **Custom installation** as the installation type and configure the following settings:

        * {% include [Field Host IP or FQDN](../../fields/mysql/ui/host.md) %}
        * {% include [port](../../fields/mysql/ui/port.md) %}
        * {% include [database-on-premise](../../fields/mysql/ui/database-on-premise.md) %}
        * {% include [user](../../fields/mysql/ui/user.md) %}
        * {% include [password](../../fields/mysql/ui/password.md) %}
        * {% include [Field CA certificate](../../fields/mysql/ui/ca-certificate.md) %}
        * {% include [subnet-id](../../fields/mysql/ui/subnet-id.md) %}

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_connman.title }}**: Enables using a managed database connection using [{{ connection-manager-full-name }}](../../../../metadata-hub/quickstart/connection-manager.md):

        * Select the folder where the {{ connection-manager-name }} managed connection was created.
        * Select **Custom installation** as the installation type and configure the following settings:

            * {% include [connection](../../fields/mysql/ui/connection.md) %}
            * {% include [database-on-premise](../../fields/mysql/ui/database-on-premise.md) %}
            * {% include [subnet-id](../../fields/mysql/ui/subnet-id.md) %}

        {% include [connection-manager-access](../../notes/connection-manager-access.md) %}

* {% include [security-groups](../../fields/mysql/ui/security-groups.md) %}

