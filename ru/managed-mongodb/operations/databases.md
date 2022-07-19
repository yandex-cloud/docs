# Управление базами данных

Вы можете добавлять и удалять базы данных, а также просматривать информацию о них.

## Получить список баз данных в кластере {#list-db}

{% list tabs %}

- Консоль управления

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ mmg-name }}**.
  1. Нажмите на имя нужного кластера, затем выберите вкладку **Базы данных**.


- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы получить список баз данных в кластере, выполните команду:

  ```
  {{ yc-mdb-mg }} database list
       --cluster-name <имя кластера>
  ```

  Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).


- API

  Получить список баз данных кластера можно с помощью метода [list](../api-ref/Database/list.md).

{% endlist %}

## Создать базу данных {#add-db}

Количество баз данных в кластере неограниченно.

{% note info %}

Созданные базы данных по умолчанию недоступны пользователям кластера. Чтобы подключиться к новой базе, не забудьте выдать разрешение пользователю.

{% endnote %}

{% list tabs %}

- Консоль управления

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ mmg-name }}**.
  1. Нажмите на имя нужного кластера.
  1. Выберите вкладку **Базы данных**.
  1. Нажмите кнопку **Добавить**.
  1. Введите имя для базы данных и нажмите кнопку **Добавить**.
  1. Не забудьте [выдать разрешение](cluster-users.md#updateuser) на доступ к созданной базе данных нужному пользователю кластера (пока доступно только с помощью CLI и API).

  {% include [db-name-limits](../../_includes/mdb/mmg/note-info-db-name-limits.md) %}

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Выполните команду создания БД, задав имя новой базы:

  ```
  {{ yc-mdb-mg }} database create <имя базы данных>
      --cluster-name <имя кластера>
  ```

  {% include [db-name-limits](../../_includes/mdb/mmg/note-info-db-name-limits.md) %}

  {{ mmg-short-name }} запустит операцию создания базы данных.

  Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

  Не забудьте [выдать разрешение](cluster-users.md#updateuser) на доступ к созданной базе данных нужному пользователю кластера.

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
  
  Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-link }}/mdb_mongodb_cluster).

  {% include [Terraform timeouts](../../_includes/mdb/mmg/terraform/timeouts.md) %}

- API

  Создать новую базу данных в кластере можно с помощью метода [create](../api-ref/Database/create.md). Разрешить доступ к созданной базе — с помощью метода [update](../api-ref/User/update.md).

{% endlist %}

## Удалить базу данных {#remove-db}

{% list tabs %}

- Консоль управления

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ mmg-name }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **Базы данных**.
  1. Нажмите значок ![image](../../_assets/horizontal-ellipsis.svg) в строке нужной БД и выберите пункт **Удалить**.


- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы удалить базу данных, выполните команду:

  ```
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
  
    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-link }}/mdb_mongodb_cluster).

    {% include [Terraform timeouts](../../_includes/mdb/mmg/terraform/timeouts.md) %}

- API

  Воспользуйтесь методом [delete](../api-ref/Database/delete.md) и передайте в запросе:

    * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md).
    * Имя базы данных в параметре `databaseName`.

{% endlist %}

{% note warning %}

Прежде чем создать новую базу с тем же именем, дождитесь завершения операции удаления, иначе будет восстановлена удаляемая база. Статус операции можно получить вместе со [списком операций в кластере](cluster-list.md#list-operations).

{% endnote %}
