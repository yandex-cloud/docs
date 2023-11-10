## Примеры {#examples}

### Добавить пользователя с правами только на чтение {#user-readonly}

{% list tabs %}

- SQL

    {% note alert %}

    Не используйте этот пример, если пользователь создан с помощью {{ TF }}: последующие изменения, сделанные через {{ TF }}, могут отменить привилегии пользователя, сделанные через SQL.

    {% endnote %}

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
        GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA myschema to user2;
        ```

    1. (Опционально) Чтобы изменить привилегии по умолчанию, выполните команду:

        ```sql
        ALTER DEFAULT PRIVILEGES IN SCHEMA myschema GRANT SELECT ON TABLES TO user2;
        ALTER DEFAULT PRIVILEGES IN SCHEMA myschema GRANT USAGE, SELECT ON SEQUENCES TO user2;
        ```

    Для отзыва выданных привилегий выполните команды:

    ```sql
    REVOKE SELECT ON public.Products FROM user2;

    REVOKE SELECT ON ALL TABLES IN SCHEMA myschema FROM user2;
    REVOKE USAGE ON SCHEMA myschema FROM user2;
    ```

- {{ TF }}

    Выдать привилегию пользователю через {{ TF }} можно только в кластере с хостами в публичном доступе.

    Для выдачи привилегий пользователям через {{ TF }} используется сторонний провайдер — [Terraform Provider for PostgreSQL](https://github.com/cyrilgdn/terraform-provider-postgresql).

    {% include [pg-provider-disclaimer](../../_includes/mdb/mpg/terraform/pg-provider-disclaimer.md) %}

    Подробнее о выдаче привилегий см. в разделе [{#T}](../../managed-postgresql/operations/grant.md#grant-privilege).

    Допустим, существует кластер `mypg` с пользователем `user1` в роли владельца. Чтобы добавить в него нового пользователя `user2` с доступом только на чтение из таблиц в схеме `public` базы данных `db1`:

    1. Добавьте провайдер `postgresql` в блок `required_providers` в файле с настройками провайдера:

        ```hcl
        terraform {
          required_providers {
            ...
            postgresql = {
              source   = "cyrilgdn/postgresql"
            }
            ...
          }
        }
        ```

    1. Откройте конфигурационный файл {{ TF }} с планом инфраструктуры.
    1. Добавьте ресурс `yandex_mdb_postgresql_user`:

        ```hcl
        resource "yandex_mdb_postgresql_user" "user2" {
          cluster_id      = yandex_mdb_postgresql_cluster.mypg.id
          name            = "user2"
          password        = "user2user2"
          permission {
            database_name = yandex_mdb_postgresql_database.db1.name
          }
        }
        ```

    1. Добавьте провайдер `postgresql` и настройте для него доступ к базе данных `db1`:

        ```hcl
        provider "postgresql" {
          host            = yandex_mdb_postgresql_cluster.mypg.host[0].fqdn
          port            = 6432
          database        = yandex_mdb_postgresql_database.db1.name
          username        = yandex_mdb_postgresql_user.user1.name
          password        = yandex_mdb_postgresql_user.user1.password
        }
        ```

    1. Добавьте ресурс `postgresql_grant` со следующими атрибутами:

        ```hcl
        resource "postgresql_grant" "readonly_tables" {
          database          = yandex_mdb_postgresql_database.db1.name
          role              = yandex_mdb_postgresql_user.user2.name
          object_type       = "table"
          privileges        = ["SELECT"]
          schema            = "public"
        }
        ```

    1. Повторно инициализируйте {{ TF }}:

        ```bash
        terraform init
        ```

    1. Проверьте корректность настроек.
  
        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}
  
    1. Подтвердите изменение ресурсов.
  
        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Чтобы отозвать выданную привилегию, удалите ее из списка `privileges` и подтвердите изменение ресурсов.

{% endlist %}
