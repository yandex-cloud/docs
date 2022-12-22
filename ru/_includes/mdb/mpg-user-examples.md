## Примеры {#examples}

### Добавить пользователя с правами только на чтение {#user-readonly}

Чтобы добавить в существующий кластер нового пользователя `user2` с доступом только на чтение к базе данных `db1`:

1. [Создайте пользователя](../../managed-postgresql/operations/cluster-users.md#adduser) с именем `user2`. При этом выберите базы данных, к которым должен иметь доступ пользователь.
1. [Подключитесь](../../managed-postgresql/operations/connect.md#connection-string) к базе данных `db1` с помощью учетной записи владельца БД.
1. Чтобы выдать права доступа только к таблице `Products` в схеме по умолчанию `public`, выполните команду:

    ```sql
    GRANT SELECT ON public.Products TO user2;
    ```

1. Чтобы выдать доступ ко всем таблицам схемы `myschema`, выполните команду:

    ```sql
    GRANT SELECT ON ALL TABLES IN SCHEMA myschema TO user2;
    GRANT USAGE ON SCHEMA myschema TO user2;
    ```

Для отзыва выданных привилегий выполните команды:

```sql
REVOKE SELECT ON public.Products FROM user2;

REVOKE SELECT ON ALL TABLES IN SCHEMA myschema FROM user2;
REVOKE USAGE ON SCHEMA myschema FROM user2;
```
