# Управление базами данных в {{ mpg-name }}

Вы можете добавлять и удалять базы данных, а также просматривать информацию о них.

{% include [db-sql](../../_includes/mdb/mdb-db-sql-limits.md) %}

## Получить список баз данных в кластере {#list-db}

{% list tabs %}

- Консоль управления

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ mpg-name }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **Базы данных**.


- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы получить список баз данных в кластере, выполните команду:

  ```bash
  {{ yc-mdb-pg }} database list --cluster-name=<имя кластера>
  ```

  Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).


- API

  Чтобы получить список баз данных в кластере, воспользуйтесь методом REST API [list](../api-ref/Database/list.md) для ресурса [Database](../api-ref/Database/index.md) или вызовом gRPC API [DatabaseService/List](../api-ref/grpc/database_service.md#List) и передайте в запросе идентификатор кластера в параметре `clusterId`.

  Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

{% endlist %}

## Создать базу данных {#add-db}

{% include [1000 DBs limit](../../_includes/mdb/1000dbnote.md) %}

{% list tabs %}

- Консоль управления

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ mpg-name }}**.
  1. Нажмите на имя нужного кластера.
  1. Если владельцем новой базы данных должен стать еще не существующий пользователь, [создайте его](cluster-users.md#adduser).
  1. Выберите вкладку **Базы данных**.
  1. Нажмите кнопку ![image](../../_assets/plus-sign.svg) **Добавить**.
  1. Укажите параметры базы данных:

      * Имя.

        {% include [db-name-limits](../../_includes/mdb/mpg/note-info-db-name-limits.md) %}

      * Владелец.

      * (Опционально) Шаблон — имя одной из существующих баз, с которой нужно будет скопировать схему данных. На время создания новой базы все подключения к базе-шаблону будут закрыты.

          Подробнее см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/sql-createdatabase.html).

      * Локали сортировки и набора символов.

          {% include [postgresql-locale](../../_includes/mdb/mpg-locale-settings.md) %}

  1. Нажмите кнопку **Добавить**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы создать базу данных в кластере:

  1. Посмотрите описание команды CLI для создания БД:

     ```bash
     {{ yc-mdb-pg }} database create --help
     ```

  1. Запросите список пользователей кластера, чтобы выбрать владельца новой базы данных:

     ```bash
     {{ yc-mdb-pg }} user list --cluster-name=<имя кластера>
     ```

     Если нужного пользователя в списке нет, [создайте его](cluster-users.md#adduser).

  1. Выполните команду создания БД. При необходимости укажите нужные локали сортировки и набора символов (по умолчанию задаются `LC_COLLATE=C` и `LC_CTYPE=C`) и шаблон:

     ```bash
     {{ yc-mdb-pg }} database create <имя базы данных> \
        --cluster-name=<имя кластера> \
        --owner=<имя пользователя-владельца> \
        --lc-collate=<локаль сортировки> \
        --lc-type=<локаль набора символов> \
        --template-db=<имя базы данных, используемой в качестве шаблона>
     ```

     {% include [db-name-limits](../../_includes/mdb/mpg/note-info-db-name-limits.md) %}

     Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

     {{ mpg-short-name }} запустит операцию создания базы данных.

- {{ TF }}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

        О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).

        Полный список доступных для изменения полей конфигурации базы данных кластера {{ mpg-name }} см. в [документации провайдера {{ TF }}]({{ tf-provider-link }}/mdb_postgresql_database).

    1. Добавьте ресурс `yandex_mdb_postgresql_database`. При необходимости укажите нужные локали сортировки и набора символов (по умолчанию задаются `LC_COLLATE=C` и `LC_CTYPE=C`) и шаблон:
  
        ```hcl
        resource "yandex_mdb_postgresql_database" "<имя базы данных>" {
          cluster_id  = "<идентификатор кластера>"
          name        = "<имя базы данных>"
          owner       = "<имя пользователя-владельца: должен быть задан в ресурсе yandex_mdb_postgresql_user>"
          lc_collate  = "<локаль сортировки>"
          lc_type     = "<локаль набора символов>"
          template_db = "<имя базы данных, используемой в качестве шаблона>"
        }
        ```
  
        {% include [db-name-limits](../../_includes/mdb/mpg/note-info-db-name-limits.md) %}

    1. Проверьте корректность настроек.
  
        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}
  
    1. Подтвердите изменение ресурсов.
  
        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- API

  Чтобы создать базу данных в кластере, воспользуйтесь методом REST API [create](../api-ref/Database/create.md) для ресурса [Database](../api-ref/Database/index.md) или вызовом gRPC API [DatabaseService/Create](../api-ref/grpc/database_service.md#Create) и передайте в запросе:

  * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
  * Настройки новой базы в параметре `databaseSpec`.

{% endlist %}

## Удалить базу данных {#remove-db}

{% list tabs %}

- Консоль управления

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ mpg-name }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **Базы данных**.
  1. Нажмите на значок ![image](../../_assets/options.svg) в строке нужной БД и выберите пункт **Удалить**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы удалить базу данных, выполните команду:

  ```bash
  {{ yc-mdb-pg }} database delete <имя базы данных> \
     --cluster-name <имя кластера>
  ```

  Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md).

- {{ TF }}
  
  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.
  
     О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).

     Полный список доступных для изменения полей конфигурации базы данных кластера {{ mpg-name }} см. в [документации провайдера {{ TF }}]({{ tf-provider-link }}/mdb_postgresql_database).

  1. Удалите ресурс `yandex_mdb_postgresql_database` с именем удаляемой базы данных.
  
  1. Проверьте корректность настроек.
  
      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}
  
  1. Подтвердите изменение ресурсов.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- API

  Чтобы удалить базу данных, воспользуйтесь методом REST API [delete](../api-ref/Database/delete.md) для ресурса [Database](../api-ref/Database/index.md) или вызовом gRPC API [DatabaseService/Delete](../api-ref/grpc/database_service.md#Delete) и передайте в запросе:
  
  * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
  * Имя удаляемой базы данных в параметре `databaseName`. Чтобы узнать имя базы данных, [получите список баз данных в кластере](#list-db).

{% endlist %}

{% note warning %}

Прежде чем создать новую базу с тем же именем, дождитесь завершения операции удаления, иначе будет восстановлена удаляемая база. Статус операции можно получить вместе со [списком операций в кластере](cluster-list.md#list-operations).

{% endnote %}
