
* **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_type.title }}** — выберите вариант подключения к базе данных:

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_plain.title }}** — позволяет задать настройки подключения вручную.

        Выберите тип инсталляции **Пользовательская инсталляция** и задайте настройки:

        * {% include [Field Host IP or FQDN](../../fields/mysql/ui/host.md) %}
        * {% include [port](../../fields/mysql/ui/port.md) %}
        * {% include [database-on-premise](../../fields/mysql/ui/database-on-premise.md) %}
        * {% include [user](../../fields/mysql/ui/user.md) %}
        * {% include [password](../../fields/mysql/ui/password.md) %}
        * {% include [Field CA certificate](../../fields/mysql/ui/ca-certificate.md) %}
        * {% include [subnet-id](../../fields/mysql/ui/subnet-id.md) %}

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_connman.title }}** — позволяет использовать управляемое подключение к базе данных через [{{ connection-manager-full-name }}](../../../../metadata-hub/quickstart/connection-manager.md):

        * Выберите каталог, в котором создано управляемое подключение {{ connection-manager-name }}.
        * Выберите тип инсталляции **Пользовательская инсталляция** и задайте настройки:

            * {% include [connection](../../fields/mysql/ui/connection.md) %}
            * {% include [database-on-premise](../../fields/mysql/ui/database-on-premise.md) %}
            * {% include [subnet-id](../../fields/mysql/ui/subnet-id.md) %}

        {% include [connection-manager-access](../../notes/connection-manager-access.md) %}

* {% include [security-groups](../../fields/mysql/ui/security-groups.md) %}

