# Управление базами данных в {{ mmg-name }}

Вы можете добавлять и удалять базы данных, а также просматривать информацию о них.

## Получить список баз данных в кластере {#list-db}

{% list tabs %}

- Консоль управления

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
  1. Нажмите на имя нужного кластера, затем выберите вкладку **{{ ui-key.yacloud.mongodb.cluster.switch_databases }}**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы получить список баз данных в кластере, выполните команду:

  ```bash
  {{ yc-mdb-mg }} database list
     --cluster-name <имя кластера>
  ```

  Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- API

  Чтобы получить список баз данных кластера, воспользуйтесь методом REST API [list](../api-ref/Database/list.md) для ресурса [Database](../api-ref/Database/index.md) или вызовом gRPC API [DatabaseService/List](../api-ref/grpc/database_service.md#List) и передайте в запросе идентификатор кластера в параметре `clusterId`.

  Идентификатор кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

{% endlist %}

## Создать базу данных {#add-db}

{% include [1000 DBs limit](../../_includes/mdb/1000dbnote.md) %}

{% list tabs %}

- Консоль управления

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
  1. Нажмите на имя нужного кластера.
  1. Выберите вкладку **{{ ui-key.yacloud.mongodb.cluster.switch_databases }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.databases.button_add }}**.
  1. Введите имя для базы данных и нажмите кнопку **{{ ui-key.yacloud.mdb.dialogs.popup-add-db_button_add }}**.

      {% include [db-name-limits](../../_includes/mdb/mmg/note-info-db-name-limits.md) %}

  1. [Выдайте разрешение](cluster-users.md#updateuser) на доступ к созданной базе данных нужным пользователям кластера.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Выполните команду создания БД, задав имя новой базы:

  ```bash
  {{ yc-mdb-mg }} database create <имя базы данных>
    --cluster-name <имя кластера>
  ```

  {% include [db-name-limits](../../_includes/mdb/mmg/note-info-db-name-limits.md) %}

  Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  {{ mmg-short-name }} запустит операцию создания базы данных.

  [Выдайте разрешение](cluster-users.md#updateuser) на доступ к созданной базе данных нужным пользователям кластера.

- {{ TF }}
  
    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.
  
        О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).
  
    1. Добавьте к описанию кластера {{ mmg-name }} блок `database`:
  
        ```hcl
        resource "yandex_mdb_mongodb_cluster" "<имя кластера>" {
          ...
          database {
            name = "<имя базы данных>"
          }
        }
        ```

        {% include [db-name-limits](../../_includes/mdb/mmg/note-info-db-name-limits.md) %}
  
    1. Проверьте корректность настроек.
  
        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}
  
    1. Подтвердите изменение ресурсов.
  
        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}
  
  Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_mongodb_cluster).

  {% include [Terraform timeouts](../../_includes/mdb/mmg/terraform/timeouts.md) %}

- API

  Чтобы создать новую базу данных в кластере, воспользуйтесь методом REST API [create](../api-ref/Database/create.md) для ресурса [Database](../api-ref/Database/index.md) или вызовом gRPC API [DatabaseService/Create](../api-ref/grpc/database_service.md#Create)  и передайте в запросе:

  * Идентификатор кластера, в котором нужно создать базу данных, в параметре `clusterId`. Чтобы получить идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
  * Настройки базы данных в параметре `databaseSpec`.
  
  Чтобы разрешить доступ к созданной базе, воспользуйтесь методом REST API [update](../api-ref/User/update.md) для ресурса [User](../api-ref/User/index.md) или вызовом gRPC API [UserService/Update](../api-ref/grpc/user_service.md#Update).

{% endlist %}

## Удалить базу данных {#remove-db}

{% list tabs %}

- Консоль управления

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.mongodb.cluster.switch_databases }}**.
  1. Нажмите значок ![image](../../_assets/horizontal-ellipsis.svg) в строке нужной БД и выберите пункт **{{ ui-key.yacloud.mdb.cluster.databases.button_action-remove }}**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы удалить базу данных, выполните команду:

  ```bash
  {{ yc-mdb-mg }} database delete <имя базы данных>
     --cluster-name <имя кластера>
  ```

  Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- {{ TF }}
  
    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.
  
       О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).
  
    1. Удалите из описания кластера {{ mmg-name }} блок `database` с именем удаляемой базы данных.
  
    1. Проверьте корректность настроек.
  
        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}
  
    1. Подтвердите изменение ресурсов.
  
        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}
  
    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_mongodb_cluster).

    {% include [Terraform timeouts](../../_includes/mdb/mmg/terraform/timeouts.md) %}

- API

  Чтобы удалить базу данных, воспользуйтесь методом REST API [delete](../api-ref/Database/delete.md) для ресурса [Database](../api-ref/Database/index.md) или вызовом gRPC API [DatabaseService/Delete](../api-ref/grpc/database_service.md#Delete) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md).
    * Имя базы данных в параметре `databaseName`.

{% endlist %}

{% note warning %}

Прежде чем создать новую базу с тем же именем, дождитесь завершения операции удаления, иначе будет восстановлена удаляемая база. Статус операции можно получить вместе со [списком операций в кластере](cluster-list.md#list-operations).

{% endnote %}
