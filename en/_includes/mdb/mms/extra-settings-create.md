{% include [extra-settings](./extra-settings.md) %}

- **SQL Server Collation**: Defines the rules to store and compare data. In {{ mms-name }}, this setting is configured at the cluster level. The default value is `Cyrillic_General_CI_AS`.

   After creating a cluster, you can't change the setting, but you can [set the collation](../../../managed-sqlserver/operations/databases.md#collation) for individual databases.

   For more information about collation options, see the [{{ MS }} documentation](https://docs.microsoft.com/en-us/sql/relational-databases/collations/collation-and-unicode-support).

