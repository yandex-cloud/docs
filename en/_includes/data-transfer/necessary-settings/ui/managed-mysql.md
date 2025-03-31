
* **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_type.title }}**: Select a database connection option:

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_plain.title }}**: Allows you to specify connection settings manually.

        Select **Managed Service for MySQL cluster** as the installation type and configure the following settings:

        * {% include [cluster-id](../../fields/mysql/ui/cluster-id.md) %}
        * {% include [database](../../fields/mysql/ui/database.md) %}
        * {% include [user](../../fields/mysql/ui/user.md) %}
        * {% include [password](../../fields/mysql/ui/password.md) %}

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_connman.title }}**: Enables using a managed database connection using [{{ connection-manager-full-name }}](../../../../metadata-hub/quickstart/connection-manager.md):

        * Select the folder with the {{ mmy-name }} cluster.
        * Select **Managed DB cluster** as the installation type and configure the following settings:

            * {% include [cluster-id](../../fields/mysql/ui/cluster-id.md) %}
            * {% include [connection](../../fields/mysql/ui/connection.md) %}
            * {% include [database](../../fields/mysql/ui/database.md) %}

        {% include [connection-manager-access](../../notes/connection-manager-access.md) %}

* {% include [security-groups](../../fields/mysql/ui/security-groups.md) %}

