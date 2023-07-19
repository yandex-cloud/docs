# Управление базами данных в {{ mmy-name }}

Вы можете добавлять и удалять базы данных, просматривать информацию о них, а также управлять некоторыми настройками баз данных с помощью интерфейсов {{ mmy-name }}.

{% include [db-sql](../../_includes/mdb/mmy-db-sql-limits.md) %}

## Получить список баз данных в кластере {#list-db}

{% list tabs %}

- Консоль управления

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ mmy-name }}**.
  1. Нажмите на имя нужного кластера, затем выберите вкладку **Базы данных**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы получить список баз данных в кластере, выполните команду:

  ```bash
    {{ yc-mdb-my }} database list \
       --cluster-name=<имя кластера>
  ```

  Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md).

- API

  Чтобы получить список баз данных в кластере, воспользуйтесь методом REST API [list](../api-ref/Database/list.md) для ресурса [Database](../api-ref/Database/index.md) или вызовом gRPC API [DatabaseService/List](../api-ref/grpc/database_service.md#List) и передайте в запросе идентификатор кластера в параметре `clusterId`.

  {% include [Получение идентификатора кластера](../../_includes/mdb/mmy/note-api-get-cluster-id.md) %}

{% endlist %}

## Создать базу данных {#add-db}

{% include [1000 DBs limit](../../_includes/mdb/1000dbnote.md) %}

{% list tabs %}

- Консоль управления

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ mmy-name }}**.
  1. Нажмите на имя нужного кластера.
  1. Если владельцем новой базы данных должен стать еще не существующий пользователь, [создайте его](cluster-users.md#adduser).
  1. Выберите вкладку **Базы данных**.
  1. Нажмите кнопку **Добавить**.
  1. Введите имя для базы данных и нажмите кнопку **Добавить**.

      {% include [db-name-limits](../../_includes/mdb/mmy/note-info-db-name-limits.md) %}

  1. [Выдайте привилегии](grant.md#grant-privilege) на доступ к созданной базе данных нужным пользователям кластера.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы создать базу данных в кластере:

  1. Посмотрите описание команды CLI для создания БД:

     ```bash
      {{ yc-mdb-my }} database create --help
     ```

  1. Выполните команду создания БД:

      ```bash
      {{ yc-mdb-my }} database create <имя базы данных> --cluster-name=<имя кластера>
      ```

      {% include [db-name-limits](../../_includes/mdb/mmy/note-info-db-name-limits.md) %}

      Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md).

      {{ mmy-short-name }} запустит операцию создания базы данных.

- {{ TF }}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

      О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).

  1. Добавьте ресурс `yandex_mdb_mysql_database`:

      ```hcl
      resource "yandex_mdb_mysql_database" "<имя базы данных>" {
        cluster_id = "<идентификатор кластера>"
        name       = "<имя базы данных>"
      }
      ```

      {% include [db-name-limits](../../_includes/mdb/mmy/note-info-db-name-limits.md) %}

  1. Проверьте корректность настроек.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_mysql_database).

- API

  Чтобы создать базу данных, воспользуйтесь методом REST API [create](../api-ref/Database/create.md) для ресурса [Database](../api-ref/Database/index.md) или вызовом gRPC API [DatabaseService/Create](../api-ref/grpc/database_service.md#Create) и передайте в запросе:

  * Идентификатор кластера, в котором вы хотите создать базу данных, в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).

  * Имя базы данных в параметре `databaseSpec.name`.

      {% include [database-name-limits](../../_includes/mdb/mmy/note-info-db-name-limits.md) %}

{% endlist %}

## Удалить базу данных {#remove-db}

{% list tabs %}

- Консоль управления

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ mmy-name }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **Базы данных**.
  1. Нажмите значок ![image](../../_assets/horizontal-ellipsis.svg) в строке нужной БД и выберите пункт **Удалить**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы удалить базу данных, выполните команду:

  ```bash
   {{ yc-mdb-my }} database delete <имя базы данных> --cluster-name=<имя кластера>
  ```

  Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md).

- {{ TF }}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

      О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).

  1. Удалите ресурс `yandex_mdb_mysql_database` с именем удаляемой базы данных.

  1. Проверьте корректность настроек.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_mysql_database).

- API

  Чтобы удалить базу данных, воспользуйтесь методом REST API [delete](../api-ref/Database/delete.md) для ресурса [Database](../api-ref/Database/index.md) или вызовом gRPC API [DatabaseService/Delete](../api-ref/grpc/database_service.md#Delete) и передайте в запросе:

  * Идентификатор кластера, в котором находится база данных, в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
  * Имя базы данных в параметре `databaseName`. Чтобы узнать имя базы данных, [получите список баз данных в кластере](#list-db).

{% endlist %}

{% note warning %}

Прежде чем создать новую базу с тем же именем, дождитесь завершения операции удаления, иначе будет восстановлена удаляемая база. Статус операции можно получить вместе со [списком операций в кластере](cluster-list.md#list-operations).

{% endnote %}

## Установить режим SQL {#sql-mode}

Вы можете задать или изменить значение настройки [sql_mode](../concepts/settings-list.md#setting-sql-mode), которая определяет режим SQL для базы данных. Эта операция вызовет перезапуск хостов кластера.

{% list tabs %}

- Консоль управления

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ mmy-name }}**.
  1. Выберите кластер и нажмите кнопку **Изменить кластер** на панели сверху.
  1. В блоке **Настройки СУБД** нажмите кнопку **Настроить**.
  1. В списке настроек найдите параметр **sql_mode**.
  1. Задайте набор режимов SQL с помощью выпадающего списка. Чтобы вернуть настройки по умолчанию, нажмите кнопку **Сбросить**.
  1. Нажмите кнопку **Сохранить** в диалоговом окне настроек СУБД.
  1. Нажмите кнопку **Сохранить изменения**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Задайте нужные режимы SQL в значении параметра `--set`, например:

  ```bash
  {{ yc-mdb-my }} cluster update-config \
    --name <имя кластера> \
    --set '"sql_mode=NO_KEY_OPTIONS,NO_TABLE_OPTIONS"'
  ```

  Обратите внимание на кавычки: значением параметра должна стать вся строка, включая часть `sql_mode=`.

  Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md).

- {{ TF }}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [{#T}](./cluster-create.md).

    1. Задайте нужные режимы SQL в значении параметра `sql_mode` блока `mysql_config`, например:

        ```hcl
        resource "yandex_mdb_mysql_cluster" "<имя кластера>" {
          ...
          mysql_config = {
            sql_mode = "<список режимов SQL>"
            ...
          }
        }
        ```

    1. Проверьте корректность настроек.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Подтвердите изменение ресурсов.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_mysql_cluster#mysql-config).

    {% include [Terraform timeouts](../../_includes/mdb/mmy/terraform/timeouts.md) %}

- API

    Чтобы задать нужные режимы SQL, воспользуйтесь методом REST API [update](../api-ref/Cluster/update.md) для ресурса [Cluster](../api-ref/Cluster/index.md) или вызовом gRPC API [ClusterService/Update](../api-ref/grpc/cluster_service.md#Update) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md).
    * Массив с новой конфигурацией {{ MY }} в параметре:
        * `configSpec.mysqlConfig_5_7.sqlMode` для {{ MY }} версии 5.7.
        * `configSpec.mysqlConfig_8_0.sqlMode` для {{ MY }} версии 8.0.

    * Список настроек, которые необходимо изменить, в параметре `updateMask`.

    {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Изменить набор символов и правила их сравнения {#charset-collate}

Чтобы установить настройки символов (`CHARACTER SET`, `COLLATE`) для базы данных:

1. [Подключитесь](connect.md) к базе данных с помощью учетной записи ее владельца или пользователя с привилегией `ALTER` для этой базы данных.
1. Выполните запрос [ALTER DATABASE](https://dev.mysql.com/doc/refman/5.7/en/charset-database.html):

   ```sql
   ALTER DATABASE <имя БД> CHARACTER SET = 'utf8mb4' COLLATE = 'utf8mb4_unicode_ci';
   ```

1. Чтобы настройки изменились не только для самой базы данных, но и для таблиц в ней, сконвертируйте таблицы с теми же настройками:

   ```sql
   ALTER TABLE <имя БД>.<имя таблицы> CONVERT TO CHARACTER SET 'utf8mb4' COLLATE 'utf8mb4_unicode_ci';
   ```
