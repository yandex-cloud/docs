* **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_type.title }}** — выберите вариант подключения к базе данных:

  * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_plain.title }}** — позволяет задать настройки подключения вручную.

    Выберите тип инсталляции **Кластер Managed Service for ClickHouse** и задайте настройки:

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseManaged.mdb_cluster_id.title }}** — выберите кластер, к которому необходимо подключиться.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseConnection.shard_group.title }}** — укажите группу шардов, в которую будут передаваться данные. Если значение не указано, данные передаются во все шарды.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseConnection.database.title }}** — укажите имя базы данных в выбранном кластере.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseCredentials.user.title }}** — укажите имя пользователя, под которым сервис {{ data-transfer-name }} будет подключаться к базе данных.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseCredentials.password.title }}** — укажите пароль пользователя для доступа к базе данных.

  * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.Connection.authorization_connman.title }}** — позволяет подключиться к кластеру через [{{ connection-manager-full-name }}](../../../../metadata-hub/quickstart/connection-manager.md):

    * Выберите каталог, в котором находится кластер {{ mch-name }}.
    * Выберите тип инсталляции **Кластер управляемой БД** и задайте настройки:

      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.ConnmanConnection.mdb_cluster_id.title }}** — выберите кластер, к которому необходимо подключиться.
      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.common.console.form.common.ConnmanConnection.connection_id.title }}** — выберите подключение в {{ connection-manager-name }} или создайте его.

      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseConnection.database.title }}** — укажите имя базы данных в выбранном кластере.

      * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseConnection.shard_group.title }}** — укажите группу шардов, в которую будут передаваться данные. Если значение не указано, данные передаются во все шарды.

    {% include [connection-manager-access](../../notes/connection-manager-access.md) %}

    
* **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseConnection.security_groups.title }}** — выберите облачную сеть для размещения эндпоинта и группы безопасности для сетевого трафика. Это позволит применить указанные правила групп безопасности к ВМ и кластерам в выбранной сети без изменения их настроек. Подробнее см. в разделе [{#T}](../../../../data-transfer/concepts/network.md).

  Убедитесь, что выбранные группы безопасности [настроены](../../../../managed-clickhouse/operations/connect/index.md#configuring-security-groups).
