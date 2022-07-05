* **Подключение** — выберите [тип подключения](https://docs.oracle.com/cd/E11882_01/network.112/e41945/concepts.htm#NETAG002) к кластеру Oracle.

* Для подключения типа **Инстанс**:

    * {% include [Field Host](../../fields/oracle/ui/database-host.md) %}
    * {% include [Field Port](../../fields/common/ui/database-port.md) %}
    * {% include [Field Type](../../fields/oracle/ui/type.md) %}

* Для подключения типа **TNS connect string** укажите строку подключения к Oracle RDBMS в соответствующем поле ниже.

* {% include [Field Username](../../fields/common/ui/username.md) %}
* {% include [Field Password](../../fields/common/ui/password.md) %}
* {% include [PDB Container](../../fields/oracle/ui/pdb-container.md) %}
* {% include [Field Included Tables](../../fields/oracle/ui/included-tables.md) %}
* {% include [Field Excluded Tables](../../fields/oracle/ui/excluded-tables.md) %}

    Для обоих списков поддерживаются выражения вида:

    * `<имя схемы>.<имя таблицы>` — полное имя таблицы;
    * `<имя схемы>.*` — все таблицы в указанной схеме;
    * `<имя таблицы>` — таблица в схеме по умолчанию.

* {% include [Convert NUMBER to INT64](../../fields/oracle/ui/convert-number-to-int64.md) %}
