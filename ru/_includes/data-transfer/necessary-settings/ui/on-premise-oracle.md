* **{{ ui-key.yc-data-transfer.data-transfer.console.form.oracle.console.form.oracle.OracleConnection.connection_type.title }}** — выберите [тип подключения](https://docs.oracle.com/cd/E11882_01/network.112/e41945/concepts.htm#NETAG002) к кластеру Oracle.

* Для подключения типа **{{ ui-key.yc-data-transfer.data-transfer.console.form.oracle.console.form.oracle.OracleConnectionType.instance.title }}**:

    * {% include [Field Host](../../fields/oracle/ui/database-host.md) %}
    * **{{ ui-key.yc-data-transfer.data-transfer.console.form.oracle.console.form.oracle.OracleInstance.port.title }}** — укажите номер порта, который сервис {{ data-transfer-name }} будет использовать для подключения.
    
    * {% include [Field Type](../../fields/oracle/ui/type.md) %}

* Для подключения типа **{{ ui-key.yc-data-transfer.data-transfer.console.form.oracle.console.form.oracle.OracleConnectionType.tns.title }}** укажите строку подключения к Oracle RDBMS в соответствующем поле ниже.

* **{{ ui-key.yc-data-transfer.data-transfer.console.form.oracle.console.form.oracle.OracleConnection.user.title }}** — укажите имя пользователя, под которым сервис {{ data-transfer-name }} будет подключаться к базе данных.

* **{{ ui-key.yc-data-transfer.data-transfer.console.form.oracle.console.form.oracle.OracleConnection.password.title }}** — укажите пароль пользователя для доступа к базе данных.

* {% include [PDB Container](../../fields/oracle/ui/pdb-container.md) %}
* {% include [Field Included Tables](../../fields/oracle/ui/included-tables.md) %}
* {% include [Field Excluded Tables](../../fields/oracle/ui/excluded-tables.md) %}

  Списки включают имя [схемы]({{oracle.docs}}/admqs/managing-schema-objects.html) (описание содержания, структуры и ограничений целостности базы данных) и имя таблицы. Для обоих списков поддерживаются выражения вида:

    * `<имя_схемы>.<имя_таблицы>` — полное имя таблицы;
    * `<имя_схемы>.*` — все таблицы в указанной схеме;
    * `<имя_таблицы>` — таблица в схеме по умолчанию.

* {% include [Convert NUMBER to INT64](../../fields/oracle/ui/convert-number-to-int64.md) %}
