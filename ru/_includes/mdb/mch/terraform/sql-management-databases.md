Чтобы включить [режим управления базами данных через SQL](../../../../managed-clickhouse/operations/databases.md#sql-database-management), добавьте к описанию кластера поля `sql_user_management` и `sql_database_management` со значением `true`, а также поле `admin_password` с паролем пользователя `admin`:

```hcl
resource "yandex_mdb_clickhouse_cluster" "<имя кластера>" {
  name                    = "<имя кластера>"
  ...
  admin_password          = "<пароль пользователя admin>"
  sql_database_management = true
  sql_user_management     = true
  ...
}
```
