# Назначение привилегий и ролей пользователям {{ PG }}

{{ PG }} управляет правами доступа к базе данных с помощью _ролей_. Роли могут владеть объектами базы данных и иметь _привилегии_.

Пользователь в {{ PG }} — это роль, которая может авторизоваться в базе данных. Пользователь, создаваемый вместе с кластером {{ mpg-name }}, является владельцем первой базы данных в кластере. 

Вы можете [создавать других пользователей](cluster-users.md#adduser) и настраивать их права по своему усмотрению:

- [Изменить список ролей пользователя](#grant-role).
- [Выдать привилегию пользователю](#grant-privilege).
- [Отозвать привилегию у пользователя](#revoke-privilege).

{% note warning %}

Для новых пользователей привилегия на создание таблиц в схеме `public` зависит от версии {{ PG }}:

* 14 и ниже — привилегия выдается автоматически и отозвать ее нельзя.
* 15 и выше — привилегию необходимо предоставить пользователю [вручную](grant.md#user-readonly).

{% endnote %}

Подробнее о [создании пользователей](https://www.postgresql.org/docs/current/sql-createuser.html) и [организации прав доступа](https://www.postgresql.org/docs/current/user-manag.html) в документации {{ PG }}.

## Изменить список ролей пользователя {#grant-role}

Для назначения роли пользователю используйте интерфейсы {{ yandex-cloud }}: назначение роли запросом `GRANT` отменится при следующей операции с базой.

{% note info %}

В {{ PG }} роли могут включать в себя другие роли. Пользователь (то есть роль, которая может авторизоваться в базе данных) может быть членом одной или нескольких других ролей и получать их права. [Подробнее о членстве в ролях](https://www.postgresql.org/docs/current/sql-grant.html).

{% endnote %}

Сервис {{ mpg-name }} не дает доступа к [предопределенным ролям](https://www.postgresql.org/docs/current/predefined-roles.html), в том числе к роли суперпользователя. Назначить пользователю можно только специальные роли:

* `mdb_admin`
* `mdb_monitor`
* `mdb_replication`
* `mdb_superuser`

{% note info %}

В {{ mpg-name }} не предусмотрено создание пользовательских ролей. Права пользователя определяются совокупностью назначенных ему привилегий.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.postgresql.cluster.switch_users }}**.
  1. В строке с именем нужного пользователя нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) и выберите пункт **{{ ui-key.yacloud.mdb.cluster.users.button_action-update }}**.
  1. Разверните список **{{ ui-key.yacloud.mdb.dialogs.button_advanced-settings }}** и в поле **Grants** выберите роли, которые хотите назначить пользователю.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.dialogs.popup_button_save }}**.

- CLI {#cli}

  Если у вас еще нет интерфейса командной строки {{ yandex-cloud }} (CLI), [установите и инициализируйте его](../../cli/quickstart.md#install).

  По умолчанию используется каталог, указанный при [создании](../../cli/operations/profile/profile-create.md) профиля CLI. Чтобы изменить каталог по умолчанию, используйте команду `yc config set folder-id <идентификатор_каталога>`. Также для любой команды вы можете указать другой каталог с помощью параметров `--folder-name` или `--folder-id`. Если вы обращаетесь к ресурсу по имени, поиск будет выполнен в каталоге по умолчанию. Если вы обращаетесь к ресурсу по идентификатору, поиск будет выполнен глобально — во всех каталогах с учетом прав доступа.

  Чтобы назначить роли пользователю кластера, передайте список нужных ролей в параметре `--grants`. Имеющиеся роли будут полностью перезаписаны: если вы хотите дополнить или уменьшить имеющийся список, сначала запросите текущие роли с информацией о пользователе командой `{{ yc-mdb-pg }} user get`.

  Чтобы назначить роли, выполните команду:

  ```bash
  {{ yc-mdb-pg }} user update <имя_пользователя> \
         --grants=<роль1>,<роль2> \
         --cluster-id <идентификатор_кластера>
  ```

  Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md), имя пользователя — со [списком пользователей](cluster-users.md#list-users).

- {{ TF }} {#tf}

  Чтобы назначить роли пользователю кластера:
  
    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.
  
        О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

        Полный список доступных для изменения полей конфигурации пользователей кластера {{ mpg-name }} см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_postgresql_user).

    1. Найдите ресурс `yandex_mdb_postgresql_user` нужного пользователя.
    1. Добавьте атрибут `grants` со списком нужных ролей:
  
        ```hcl
        resource "yandex_mdb_postgresql_user" "<имя_пользователя>" {
          ...
          name   = "<имя_пользователя>"
          grants = [ "<роль1>","<роль2>" ]
          ...
        }
        ```

    1. Проверьте корректность настроек.
  
        1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы {{ TF }} с планом инфраструктуры.
        1. Выполните команду:
        
           ```bash
           terraform validate
           ```
        
           Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.
  
    1. Подтвердите изменение ресурсов.
  
        1. Выполните команду для просмотра планируемых изменений:
        
           ```bash
           terraform plan
           ```
        
           Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
        
        1. Если вас устраивают планируемые изменения, внесите их:
           1. Выполните команду:
        
              ```bash
              terraform apply
              ```
        
           1. Подтвердите изменение ресурсов.
           1. Дождитесь завершения операции.

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     ```bash
     export IAM_TOKEN="<IAM-токен>"
     ```

  1. Чтобы проверить список текущих ролей, воспользуйтесь методом [User.Get](../api-ref/User/get.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

     ```bash
     curl \
       --request GET \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/<идентификатор_кластера>/users/<имя_пользователя>'
     ```

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), а имя пользователя — со [списком пользователей в кластере](cluster-users.md#list-users).

     Список текущих ролей указан в параметре `grants` в выводе команды.

  1. Чтобы изменить список ролей пользователя, воспользуйтесь методом [User.Update](../api-ref/User/update.md) и выполните запрос:

     {% note warning %}
     
     Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `updateMask` (одной строкой через запятую).
     
     {% endnote %}

     ```bash
     curl \
       --request PATCH \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/<идентификатор_кластера>/users/<имя_пользователя>' \
       --data '{
                 "updateMask": "grants",
                 "grants": [
                   "роль_1", "роль_2", ..., "роль_N"
                 ]
               }'
     ```

     Где:

     * `updateMask` — перечень изменяемых параметров в одну строку через запятую.

       В данном случае передается только один параметр.

     * `grants` — массив строк с новыми ролями. Каждая строка соответствует отдельной роли. Возможные значения:

       * `mdb_admin`
       * `mdb_monitor`
       * `mdb_replication`
       * `mdb_superuser`

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/User/update.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     ```bash
     export IAM_TOKEN="<IAM-токен>"
     ```

  1. Клонируйте репозиторий [cloudapi](https://github.com/yandex-cloud/cloudapi):
     
     ```bash
     cd ~/ && git clone --depth=1 https://github.com/yandex-cloud/cloudapi
     ```
     
     Далее предполагается, что содержимое репозитория находится в директории `~/cloudapi/`.
  1. Чтобы проверить список текущих ролей, воспользуйтесь вызовом [UserService.Get](../api-ref/grpc/User/get.md) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/user_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<идентификатор_кластера>",
             "user_name": "<имя_пользователя>"
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.postgresql.v1.UserService.Get
     ```

     Список текущих ролей указан в параметре `grants` в выводе команды.

  1. Чтобы изменить список ролей пользователя, воспользуйтесь вызовом [UserService.Update](../api-ref/grpc/User/update.md) и выполните запрос:

     {% note warning %}
     
     Метод API переопределит все параметры изменяемого объекта, которые не были явно переданы в запросе, на значения по умолчанию. Чтобы избежать этого, перечислите настройки, которые вы хотите изменить, в параметре `update_mask` (в виде массива строк `paths[]`).
     
     {% cut "Формат перечисления настроек" %}
     
     ```yaml
     "update_mask": {
         "paths": [
             "<настройка_1>",
             "<настройка_2>",
             ...
             "<настройка_N>"
         ]
     }
     ```
     
     {% endcut %}
     
     {% endnote %}

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/user_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<идентификатор_кластера>",
             "user_name": "<имя_пользователя>",
             "update_mask": {
               "paths": [
                 "grants"
               ]
             },
             "grants": [
               "роль_1", "роль_2", ..., "роль_N"
             ]
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.postgresql.v1.UserService.Update
     ```

     Где:

     * `update_mask` — перечень изменяемых параметров в виде массива строк `paths[]`.

       В данном случае передается только один параметр.

     * `grants` — массив строк с новыми ролями. Каждая строка соответствует отдельной роли. Возможные значения:

       * `mdb_admin`
       * `mdb_monitor`
       * `mdb_replication`
       * `mdb_superuser`

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), а имя пользователя — со [списком пользователей в кластере](cluster-users.md#list-users).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/User/update.md#yandex.cloud.operation.Operation).

{% endlist %}

## Выдать привилегию пользователю {#grant-privilege}

{% list tabs group=instructions %}

- SQL

    1. [Подключитесь](connect/index.md) к базе данных с помощью учетной записи владельца базы данных.
    1. Выполните команду `GRANT`. Подробное описание синтаксиса команды смотрите в [документации {{ PG }}](https://www.postgresql.org/docs/current/sql-grant.html).

- {{ TF }} {#tf}

    {% note warning %}

    Выдать привилегию пользователю через {{ TF }} можно только в кластере с хостами в публичном доступе.

    {% endnote %}
  
    Вы можете выдавать привилегии пользователям через {{ TF }}, используя сторонний провайдер — [Terraform Provider for PostgreSQL](https://github.com/cyrilgdn/terraform-provider-postgresql).

    {% note info %}
    
    Terraform Provider for PostgreSQL не является частью сервиса {{ mpg-name }} и не сопровождается командой разработки и службой поддержки {{ yandex-cloud }}, а его использование не входит в [условия использования {{ mpg-full-name }}]({{ link-cloud-terms-of-use }}).
    
    {% endnote %}

    Чтобы выдать привилегию пользователю кластера:
  
    1. Добавьте провайдер `postgresql` в блок `required_providers` в файле с настройками провайдера:

        ```hcl
        terraform {
          required_providers {
            ...
            postgresql = {
              source = "cyrilgdn/postgresql"
            }
            ...
          }
        }
        ```

    1. Откройте конфигурационный файл {{ TF }} с планом инфраструктуры.
  
        О том, как создать такой файл, см. в разделе [Создание кластера](cluster-create.md).

    1. Добавьте провайдер `postgresql` и настройте для него доступ к интересующей базе данных от имени ее владельца:

        ```hcl
        provider "postgresql" {
          host            = <FQDN_хоста>
          port            = 6432
          database        = <имя_БД>
          username        = <имя_пользователя_владельца_БД> 
          password        = <пароль_пользователя>
        }
        ```

        О том, как получить FQDN хоста, см. [инструкцию](connect/fqdn.md).

        Полный список настроек см. в [документации провайдера](https://registry.terraform.io/providers/cyrilgdn/postgresql/latest/docs).

    1. Добавьте ресурс `postgresql_grant`:

        ```hcl
        resource "postgresql_grant" "<название_ресурса>" {
          database    = "<имя_БД>"
          role        = "<имя_пользователя>"
          object_type = "<тип_объекта>"
          privileges  = ["<список_привилегий>"]
          schema      = "<схема>"
          objects     = ["<список_объектов>"]
          columns     = ["<список_столбцов>"]
          with_grant_option = <разрешение_на_выдачу_привилегий>
        }
        ```

        Где:

        * `<название_ресурса>` — название {{ TF }}-ресурса с привилегиями. Должно быть уникальным в рамках манифеста {{ TF }}.
        * `database` — имя базы данных, на которую выдаются привилегии.
        * `role` — имя пользователя, которому выдаются привилегии.
        * `object_type` — тип {{ PG }}-объекта, на который выдаются привилегии. Возможные значения: `database`, `schema`, `table`, `sequence`, `function`, `procedure`, `routine`, `foreign_data_wrapper`, `foreign_server`, `column`.
        * `privileges` — массив выдаваемых привилегий. Возможные значения: `SELECT`, `INSERT`, `UPDATE`, `DELETE`, `TRUNCATE`, `REFERENCES`, `TRIGGER`, `CREATE`, `CONNECT`, `TEMPORARY`, `EXECUTE` и `USAGE`. Описание привилегий см. в [документации {{ PG }}](https://www.postgresql.org/docs/current/ddl-priv.html).
        * `schema` — схема, на которую выдаются привилегии. Нельзя задать, если выбран тип объекта `database`.
        * (Опционально) `objects` — массив объектов, на которые выдаются привилегии. Если параметр не задан, привилегии будут выданы на все объекты указанного типа. Нельзя задать, если выбран тип объекта `database` или `schema`. Если выбран тип объекта `column`, массив может содержать только одно значение.
        * `columns` — массив столбцов, на которые выдаются привилегии. Параметр обязателен, если выбран тип объекта `column`. Нельзя задать, если выбран любой другой тип объекта, кроме `column`.
        * (Опционально) `with_grant_option` — если `true`, то пользователь с выданными привилегиями сможет выдавать эти привилегии другим пользователям. По умолчанию `false`.

    1. Повторно инициализируйте {{ TF }}:

        ```bash
        terraform init
        ```

    1. Проверьте корректность настроек.
  
        1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы {{ TF }} с планом инфраструктуры.
        1. Выполните команду:
        
           ```bash
           terraform validate
           ```
        
           Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.
  
    1. Подтвердите изменение ресурсов.
  
        1. Выполните команду для просмотра планируемых изменений:
        
           ```bash
           terraform plan
           ```
        
           Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
        
        1. Если вас устраивают планируемые изменения, внесите их:
           1. Выполните команду:
        
              ```bash
              terraform apply
              ```
        
           1. Подтвердите изменение ресурсов.
           1. Дождитесь завершения операции.

{% endlist %}

## Отозвать привилегию у пользователя {#revoke-privilege}

{% list tabs group=instructions %}

- SQL

    1. [Подключитесь](connect/index.md) к базе данных с помощью учетной записи владельца базы данных.
    1. Выполните команду `REVOKE`. Подробное описание синтаксиса команды смотрите в [документации {{ PG }}](https://www.postgresql.org/docs/current/sql-revoke.html).

- {{ TF }} {#tf}

    Если вы ранее выдали привилегию с использованием {{ TF }}:

    1. Откройте конфигурационный файл {{ TF }} с планом инфраструктуры.
    1. В блоке `postgresql_grant` удалите привилегию, которую хотите отозвать, из параметра `privileges`.

        Чтобы отозвать все привилегии, оставьте массив `privileges` пустым или удалите ресурс `postgresql_grant` целиком.

    1. Проверьте корректность настроек.
  
        1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы {{ TF }} с планом инфраструктуры.
        1. Выполните команду:
        
           ```bash
           terraform validate
           ```
        
           Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.
  
    1. Подтвердите изменение ресурсов.
  
        1. Выполните команду для просмотра планируемых изменений:
        
           ```bash
           terraform plan
           ```
        
           Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
        
        1. Если вас устраивают планируемые изменения, внесите их:
           1. Выполните команду:
        
              ```bash
              terraform apply
              ```
        
           1. Подтвердите изменение ресурсов.
           1. Дождитесь завершения операции.

{% endlist %}

## Примеры {#examples}

### Добавить пользователя с правами только на чтение {#user-readonly}

{% list tabs group=instructions %}

- SQL {#sql}

    {% note alert %}

    Не используйте этот пример, если пользователь создан с помощью {{ TF }}: последующие изменения, сделанные через {{ TF }}, могут отменить привилегии пользователя, сделанные через SQL.

    {% endnote %}

    Чтобы добавить в существующий кластер нового пользователя `user2` с доступом только на чтение к базе данных `db1`:

    1. [Создайте пользователя](cluster-users.md#adduser) с именем `user2`. При этом выберите базы данных, к которым должен иметь доступ пользователь.
    1. [Подключитесь](connect/code-examples.md) к базе данных `db1` с помощью учетной записи владельца БД.
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

    {% note warning %}

    Выдать привилегию пользователю через {{ TF }} можно только в кластере с хостами в публичном доступе.

    {% endnote %}

    Для выдачи привилегий пользователям через {{ TF }} используется сторонний провайдер — [Terraform Provider for PostgreSQL](https://github.com/cyrilgdn/terraform-provider-postgresql).

    {% note info %}
    
    Terraform Provider for PostgreSQL не является частью сервиса {{ mpg-name }} и не сопровождается командой разработки и службой поддержки {{ yandex-cloud }}, а его использование не входит в [условия использования {{ mpg-full-name }}]({{ link-cloud-terms-of-use }}).
    
    {% endnote %}

    Подробнее о выдаче привилегий см. в разделе [{#T}](grant.md#grant-privilege).

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

        1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы {{ TF }} с планом инфраструктуры.
        1. Выполните команду:
        
           ```bash
           terraform validate
           ```
        
           Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Подтвердите изменение ресурсов.

        1. Выполните команду для просмотра планируемых изменений:
        
           ```bash
           terraform plan
           ```
        
           Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
        
        1. Если вас устраивают планируемые изменения, внесите их:
           1. Выполните команду:
        
              ```bash
              terraform apply
              ```
        
           1. Подтвердите изменение ресурсов.
           1. Дождитесь завершения операции.

{% endlist %}

### Отозвать права доступа {#revoke-access}

{% list tabs group=instructions %}

- SQL {#sql}

    1. [Подключитесь](connect/code-examples.md) к базе данных `db1` с помощью учетной записи владельца БД.
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

        1. В командной строке перейдите в каталог, в котором расположены актуальные конфигурационные файлы {{ TF }} с планом инфраструктуры.
        1. Выполните команду:
        
           ```bash
           terraform validate
           ```
        
           Если в файлах конфигурации есть ошибки, {{ TF }} на них укажет.

    1. Подтвердите изменение ресурсов.

        1. Выполните команду для просмотра планируемых изменений:
        
           ```bash
           terraform plan
           ```
        
           Если конфигурации ресурсов описаны верно, в терминале отобразится список изменяемых ресурсов и их параметров. Это проверочный этап: ресурсы не будут изменены.
        
        1. Если вас устраивают планируемые изменения, внесите их:
           1. Выполните команду:
        
              ```bash
              terraform apply
              ```
        
           1. Подтвердите изменение ресурсов.
           1. Дождитесь завершения операции.

{% endlist %}