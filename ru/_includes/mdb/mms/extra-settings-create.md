{% include [extra-settings](./extra-settings.md) %}

- **SQL Server Collation** — определяет правила, по которым сортируются и сравниваются данные. В {{ mms-name }} эта настройка задается на уровне всего кластера. Значение по умолчанию — `Cyrillic_General_CI_AS`.

   После создания кластера настройку нельзя изменить, но можно [задать параметры сортировки](../../../managed-sqlserver/operations/databases.md#collation) для отдельных баз данных.

   Подробнее о параметрах сортировки см. в [документации {{ MS }}](https://docs.microsoft.com/en-us/sql/relational-databases/collations/collation-and-unicode-support).
