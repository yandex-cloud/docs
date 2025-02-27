
* **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_type.title }}** — выберите вариант подключения к базе данных:

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_plain.title }}** — позволяет задать настройки подключения вручную.

        Выберите тип инсталляции **Кластер Managed Service for MySQL** и задайте настройки:

        * {% include [cluster-id](../../fields/mysql/ui/cluster-id.md) %}
        * {% include [database](../../fields/mysql/ui/database.md) %}
        * {% include [user](../../fields/mysql/ui/user.md) %}
        * {% include [password](../../fields/mysql/ui/password.md) %}

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_connman.title }}** — позволяет использовать управляемое подключение к базе данных через [{{ connection-manager-full-name }}](../../../../metadata-hub/quickstart/connection-manager.md):

        * Выберите каталог, в котором находится кластер {{ mmy-name }}.
        * Выберите тип инсталляции **Кластер управляемой БД** и задайте настройки:

            * {% include [cluster-id](../../fields/mysql/ui/cluster-id.md) %}
            * {% include [connection](../../fields/mysql/ui/connection.md) %}
            * {% include [database](../../fields/mysql/ui/database.md) %}

        {% include [connection-manager-access](../../notes/connection-manager-access.md) %}

* {% include [security-groups](../../fields/mysql/ui/security-groups.md) %}

