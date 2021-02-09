## Примеры {#examples}

### Добавить пользователя с правами только на чтение {#user-read-only}

Чтобы добавить в существующий кластер нового пользователя `user2` с доступом только на чтение к базе данных `db1`:

1. [Создайте пользователя](../../managed-mysql/operations/cluster-users.md#adduser) с именем `user2`. При этом выберите базы данных, к которым должен иметь доступ пользователь.
1. [Подключитесь](../../managed-mysql/operations/connect.md#connection-string) к базе данных `db1` с помощью учетной записи владельца БД.
1. Чтобы выдать права доступа только к таблице `Products` в базе данных `db1`, выполните команду:

   ```sql
   GRANT SELECT ON Products TO user2;
   ```

1. Чтобы выдать права доступа к базе данных `db1`, выполните команду:
   
   ```sql
   GRANT SELECT ON db1.* TO user2;
   ```

Для отзыва выданных привилегий выполните команды:

```sql
REVOKE SELECT ON Products FROM user2;

REVOKE SELECT ON db1.* FROM user2;
```
