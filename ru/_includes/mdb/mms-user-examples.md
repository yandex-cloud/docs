## Примеры {#examples}

### Добавить пользователя с правами только на чтение {#user-read-only}

{% list tabs %}

- Консоль управления

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

- {{ TF }}

    Чтобы добавить в существующий кластер нового пользователя `user2` с доступом только на чтение к базе данных `db1`:

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [{#T}](../../managed-sqlserver/operations/cluster-create.md).

    1. Добавьте к описанию кластера блок `user`:

        ```hcl
        resource "yandex_mdb_sqlserver_cluster" "<имя кластера>" {

          user {
            name     = "user2"
            password = "<пароль>"

            permission {
              database_name = "db1"
              roles         = ["DATAREADER"]
            }
          }
        }
        ```

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-mms }}).

{% endlist %}
