Чтобы включить [управление пользователями через SQL](../../../../managed-clickhouse/concepts/user-access-rights.md#sql-user-management), добавьте к описанию кластера поле `sql_user_management` со значением `true` и поле `admin_password` с паролем пользователя `admin`:

```hcl
resource "yandex_mdb_clickhouse_cluster_v2" "<имя_кластера>" {
  name                = "<имя_кластера>"
  ...
  admin_password      = "<пароль_пользователя_admin>"
  sql_user_management = true
  ...
}
```
