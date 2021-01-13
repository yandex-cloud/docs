## Примеры {#examples}

### Создание пользователя с настройкой «только чтение» {#user-readonly}

Допустим, нужно добавить в существующий кластер нового пользователя `user2`, причем:

* пользователь должен иметь доступ к базе данных db1 кластера, в том числе:
   - к таблице `Products` в схеме по умолчанию `public`;
   - ко всем таблицам схемы `myschema`;
* доступ должен осуществляться в режиме «только чтение» (readonly), без возможности изменения настроек.

Для этого выполните следующие действия:

1. [Создайте пользователя](../../managed-postgresql/operations/cluster-users.md#adduser) с именем `user2`. При этом выберите базы данных, к которым должен иметь доступ пользователь.
1. Подключитесь к базе данных db1 с помощью учетной записи владельца БД.
1. Выполните команды:

    ```postgresql
    GRANT SELECT ON public.Products TO user2;

    GRANT SELECT ON ALL TABLES IN SCHEMA myschema TO user2;
    GRANT USAGE ON SCHEMA myschema TO user2;
    ```
1. Для отзыва выданных привилегий выполните команды:

    ```postgresql
    REVOKE SELECT ON public.Products FROM user2;

    REVOKE SELECT ON ALL TABLES IN SCHEMA myschema FROM user2;
    REVOKE USAGE ON SCHEMA myschema FROM user2;
    ```
