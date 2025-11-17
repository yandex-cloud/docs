
* **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_type.title }}** — выберите вариант подключения к кластеру:

  * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_plain.title }}** — позволяет задать настройки подключения вручную.

    Выберите тип инсталляции **Кластер Managed Service for Apache Kafka** и задайте настройки:

    * {% include [Field Managed Kafka cluster](../../fields/kafka/ui/managed-kafka.md) %}
    * {% include [Field Authentication](../../fields/kafka/ui/authentication.md) %}

  * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_connman.title }}** — позволяет подключиться к кластеру через [{{ connection-manager-full-name }}](../../../../metadata-hub/quickstart/connection-manager.md):

    * Выберите каталог, в котором находится кластер {{ mkf-name }}.
    * Выберите тип инсталляции **Кластер управляемой БД** и задайте настройки:

      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.ConnmanConnection.mdb_cluster_id.title }}** — выберите кластер, к которому необходимо подключиться.
      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.ConnmanConnection.connection_id.title }}** — выберите подключение в {{ connection-manager-name }} или создайте его.

    {% include [connection-manager-access](../../notes/connection-manager-access.md) %}

* {% include [Field Topic Target](../../fields/kafka/ui/topic-target.md) %}
* {% include [Security groups](../../fields/kafka/ui/security-groups.md) %}
* {% include [Field Serialization](../../fields/kafka/ui/serialization.md) %}
* {% include [Field Extra Settings Target](../../fields/kafka/ui/extra-settings-target.md) %}

