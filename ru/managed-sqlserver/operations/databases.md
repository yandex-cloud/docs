# Управление базами данных

* [Получить список БД в кластере](#list-db).
* [Создать БД](#add-db).
* [Изменить параметры сортировки БД](#collation).
* [Удалить БД](#remove-db).

{% include [db-sql](../../_includes/mdb/mms/db-sql-limits.md) %}

## Получить список баз данных в кластере {#list-db}

{% list tabs %}

- Консоль управления

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ mms-name }}**.
  1. Нажмите на имя нужного кластера, затем выберите вкладку **Базы данных**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы получить список БД в кластере, выполните команду:

  ```bash
  {{ yc-mdb-ms }} database list \
    --cluster-name=<имя кластера>
  ```

  Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- API

  Воспользуйтесь методом API [list](../api-ref/Database/list.md): передайте значение идентификатора требуемого кластера в параметре `clusterId` запроса.

  Чтобы узнать идентификатор кластера, [получите список кластеров в каталоге](cluster-list.md#list-clusters).

{% endlist %}

## Создать базу данных {#add-db}

{% include [1000 DBs limit](../../_includes/mdb/1000dbnote.md) %}

{% list tabs %}

- Консоль управления

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ mms-name }}**.
  1. Нажмите на имя нужного кластера.
  1. Если владельцем новой БД должен стать еще не существующий пользователь, [создайте его](cluster-users.md#adduser).
  1. Выберите вкладку **Базы данных**.
  1. Нажмите кнопку **Добавить**.
  1. Введите имя БД и нажмите кнопку **Создать**.

     {% include [database-name-limits](../../_includes/mdb/mms/note-info-db-name-limits.md) %}

  1. [Выдайте роль `DB_OWNER`](grant.md) пользователю, который должен стать владельцем новой БД.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы создать БД в кластере:
  1. Посмотрите описание команды CLI для создания БД:

     ```bash
     {{ yc-mdb-ms }} database create --help
     ```

  1. Выполните команду создания БД:

     ```bash
     {{ yc-mdb-ms }} database create <имя БД> \
       --cluster-name=<имя кластера>
     ```

     {% include [db-name-limits](../../_includes/mdb/mms/note-info-db-name-limits.md) %}

     Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

     {{ mms-name }} запустит операцию создания БД.

  Чтобы предоставить пользователям доступ к созданной БД, [следуйте инструкции](cluster-users.md#update-settings).

- {{ TF }}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

     О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).
  1. Добавьте к описанию кластера {{ mms-name }} блок `database`.

     ```hcl
     resource "yandex_mdb_sqlserver_cluster" "<имя кластера>" {
       ...
       database {
         name = "<имя БД>"
       }
     }
     ```

     {% include [database-name-limits](../../_includes/mdb/mms/note-info-db-name-limits.md) %}

  1. Добавьте блок `permission` к описанию пользователя, который должен стать владельцем новой БД:

     ```hcl
     resource "yandex_mdb_sqlserver_cluster" "<имя кластера>" {
       ...
       user {
         ...
         permission {
           database_name = "<имя БД>"
           roles         = ["OWNER"]
         }
         ...
       }
     }
     ```

  1. Проверьте корректность настроек.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-mms }}).

  {% include [Terraform timeouts](../../_includes/mdb/mms/terraform/timeouts.md) %}

- API

  Воспользуйтесь методом API [create](../api-ref/Database/create.md) и передайте в запросе:
  * Идентификатор кластера, в котором вы хотите создать БД в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
  * Имя БД в параметре `databaseSpec.name`.

    {% include [database-name-limits](../../_includes/mdb/mms/note-info-db-name-limits.md) %}

{% endlist %}

## Изменить параметры сортировки базы данных {#collation}

1. [Подключитесь](connect.md) к БД с помощью учетной записи ее владельца.
1. Выполните запрос `ALTER DATABASE` и укажите имя новых параметров сортировки.

{% note info %}

Запрос изменит параметры сортировки только для новых объектов БД. О том, как изменить параметры сортировки для существующих БД, читайте в [документации {{ MS }}]({{ ms.docs }}/sql/relational-databases/collations/set-or-change-the-database-collation).

{% endnote %}

Подробнее см. в [документации {{ MS }}]({{ ms.docs }}/sql/relational-databases/collations/set-or-change-the-database-collation).

## Удалить базу данных {#remove-db}

{% list tabs %}

- Консоль управления

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ mms-name }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **Базы данных**.
  1. Нажмите значок ![image](../../_assets/horizontal-ellipsis.svg) в строке нужной БД и выберите пункт **Удалить**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы удалить БД, выполните команду:

  ```bash
  {{ yc-mdb-ms }} database delete <имя БД> \
    --cluster-name=<имя кластера>
  ```

  Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- {{ TF }}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

     О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).
  1. Удалите из описания кластера {{ mms-name }} блок `database` с описанием БД.
  1. Удалите из описания пользователей блоки `permission` с полем `database_name`, указывающим на удаляемую БД.
  1. Проверьте корректность настроек.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Введите слово `yes` и нажмите **Enter**.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-mms }}).

  {% include [Terraform timeouts](../../_includes/mdb/mms/terraform/timeouts.md) %}

- API

  Воспользуйтесь методом API [delete](../api-ref/Database/delete.md) и передайте в запросе:
  * Идентификатор кластера, в котором находится БД в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
  * Имя БД в параметре `databaseName`. Чтобы узнать имя БД, [получите список БД в кластере](#list-db).

{% endlist %}

{% note warning %}

Прежде чем создать новую БД с тем же именем, дождитесь завершения операции удаления, иначе будет восстановлена удаляемая БД. Статус операции можно получить вместе со [списком операций в кластере](cluster-list.md#list-operations).

{% endnote %}