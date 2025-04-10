## Примеры {#examples}

### Добавить пользователя с правами только на чтение {#user-readonly}

{% list tabs group=instructions %}

- SQL {#sql}

    {% note alert %}

    Не используйте этот пример, если пользователь создан с помощью {{ TF }}: последующие изменения, сделанные через {{ TF }}, могут отменить привилегии пользователя, сделанные через SQL.

    {% endnote %}

    Чтобы добавить в существующий кластер нового пользователя `user2` с доступом только на чтение к базе данных `db1`:

    1. [Создайте пользователя](../../managed-postgresql/operations/cluster-users.md#adduser) с именем `user2`. При этом выберите базы данных, к которым должен иметь доступ пользователь.
    1. [Подключитесь](../../managed-postgresql/operations/connect.md#connection-string) к базе данных `db1` с помощью учетной записи владельца БД.
    1. Выдайте пользователю `user2` нужные права доступа.

        Примеры:

        * Разрешить доступ только к таблице `Products` в схеме по умолчанию `public`:

            ```sql
            GRANT SELECT ON public.Products TO user2;
            ```

        * Разрешить доступ к объектам схемы `myschema`:

            ```sql
            GRANT USAGE ON SCHEMA myschema TO user2;
            ```

        * Разрешить доступ ко всем таблицам и последовательностям схемы `myschema`:

            ```sql
            GRANT SELECT ON ALL TABLES IN SCHEMA myschema TO user2;
            GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA myschema to user2;
            ```

        * Разрешить вызов функции `my_function` в схеме `myschema`:

            ```sql
            GRANT EXECUTE ON FUNCTION myschema.my_function TO user2;
            ```

        * Изменить привилегии по умолчанию для таблиц и последовательностей схемы `myschema`:

            ```sql
            ALTER DEFAULT PRIVILEGES IN SCHEMA myschema GRANT SELECT ON TABLES TO user2;
            ALTER DEFAULT PRIVILEGES IN SCHEMA myschema GRANT USAGE, SELECT ON SEQUENCES TO user2;
            ```

            Команды `ALTER DEFAULT PRIVILEGES` позволяют изменить права доступа к объектам (в данном случае — к таблицам и последовательностям схемы `myschema`), которые будут созданы в будущем, но не затрагивают права, назначенные уже существующим объектам.

            Чтобы изменить привилегии существующих объектов, используйте команды `GRANT` и `REVOKE`.

- {{ TF }} {#tf}

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

{% endlist %}

### Отозвать права доступа {#revoke-access}

{% list tabs group=instructions %}

- SQL {#sql}

    1. [Подключитесь](../../managed-postgresql/operations/connect.md#connection-string) к базе данных `db1` с помощью учетной записи владельца БД.
    1. Отзовите у пользователя `user2` нужные права доступа.

        Примеры:

        1. Отозвать все привилегии для таблиц схемы `myschema`:

            ```sql
            REVOKE ALL PRIVILEGES ON ALL TABLES IN SCHEMA myschema FROM user2;
            ```

        1. Отозвать доступ к таблице `Products` в схеме по умолчанию `public`:

            ```sql
            REVOKE SELECT ON public.Products FROM user2;
            ```

        1. Отозвать доступ ко всем таблицам схемы `myschema`:

            ```sql
            REVOKE SELECT ON ALL TABLES IN SCHEMA myschema FROM user2;
            ```

        1. Отозвать доступ к объектам схемы `myschema`:

            ```sql
            REVOKE USAGE ON SCHEMA myschema FROM user2;
            ```

- {{ TF }} {#tf}

    1. Откройте конфигурационный файл {{ TF }}, с помощью которого [назначались привилегии](#user-readonly).

    1. В блоке `postgresql_grant` удалите привилегию, которую хотите отозвать, из параметра `privileges`.

        Чтобы отозвать все привилегии, оставьте массив `privileges` пустым или удалите ресурс `postgresql_grant` целиком.

        ```hcl
        resource "postgresql_grant" "readonly_tables" {
          database          = yandex_mdb_postgresql_database.db1.name
          role              = yandex_mdb_postgresql_user.user2.name
          object_type       = "table"
          privileges        = []
          schema            = "public"
        }
        ```

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

{% endlist %}
