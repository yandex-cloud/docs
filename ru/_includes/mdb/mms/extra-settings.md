- **Начало резервного копирования (UTC)** — время по UTC в 24-часовом формате, в которое начинается [резервное копирование](../../../managed-sqlserver/operations/cluster-backups.md) кластера. Если время не задано, резервное копирование начнется в 22:00 UTC.

- **Доступ из {{ datalens-name }}** — опция разрешает анализировать данные из кластера в сервисе [{{ datalens-full-name }}](../../../datalens/concepts/index.md).

- **SQL Server Collation** — определяет правила, по которым сортируются и сравниваются данные. В {{ mms-name }} эта настройка задается на уровне всего кластера. Значение по умолчанию — `Cyrillic_General_CI_AS`.

   После создания кластера настройку нельзя изменить, но можно [задать параметры сортировки](../../../managed-sqlserver/operations/databases.md#collation) для отдельных баз данных.

   Подробнее о параметрах сортировки см. в [документации {{ MS }}](https://docs.microsoft.com/en-us/sql/relational-databases/collations/collation-and-unicode-support).
