## Примеры {#examples}

### Добавить пользователя с правами только на чтение {#user-read-only}

Чтобы добавить в существующий кластер нового пользователя `user2` с доступом только на чтение к базе данных `db1`:

1. [Создайте пользователя](../../managed-sqlserver/operations/cluster-users.md#adduser) с именем `user2`. При этом выберите базы данных, к которым должен иметь доступ пользователь.
1. [Подключитесь](../../managed-sqlserver/operations/connect.md#connection-string) к базе данных `db1` с помощью учетной записи владельца БД.
1. Чтобы выдать права доступа только к таблице `Products` в схеме по умолчанию `dbo`, выполните команду:

   ```sql
   GRANT SELECT ON dbo.Products TO user2;
   GO
   ```
   
1. Чтобы выдать права доступа ко всем таблицам схемы `myschema`, выполните команду:
      
   ```sql
   GRANT SELECT, INSERT, UPDATE, DELETE ON SCHEMA::myschema TO user2;
   GO
   ```

Для отзыва выданных привилегий выполните команды:

```sql
REVOKE SELECT ON dbo.Products FROM user2;
REVOKE SELECT, INSERT, UPDATE, DELETE ON SCHEMA::myschema FROM user2;
GO
```
