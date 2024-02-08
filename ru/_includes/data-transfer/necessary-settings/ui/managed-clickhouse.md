* **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseManaged.mdb_cluster_id.title }}** — идентификатор кластера, к которому необходимо подключиться.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseCredentials.user.title }}** — укажите имя пользователя, под которым сервис {{ data-transfer-name }} будет подключаться к базе данных.

    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseCredentials.password.title }}** — укажите пароль пользователя для доступа к базе данных.

* **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseConnection.database.title }}** — укажите имя базы данных в выбранном кластере.

* **{{ ui-key.yc-data-transfer.data-transfer.console.form.clickhouse.console.form.clickhouse.ClickHouseConnection.security_groups.title }}** — выберите облачную сеть для размещения эндпоинта и группы безопасности для сетевого трафика. Это позволит применить указанные правила групп безопасности к ВМ и кластерам в выбранной сети без изменения их настроек. Подробнее см. в разделе [{#T}](../../../../data-transfer/concepts/network.md).

   Убедитесь, что выбранные группы безопасности [настроены](../../../../managed-clickhouse/operations/connect.md#configuring-security-groups).


