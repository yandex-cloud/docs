---
title: "Назначение привилегий и ролей пользователям PostgreSQL"
description: "Атомарные полномочия в PostgreSQL называются привилегиями, группы полномочий — ролями. Подробнее об организации прав доступа читайте в документации PostgreSQL. Пользователь, создаваемый вместе с кластером {{ mpg-name }}, является владельцем первой базы данных в кластере. Вы можете создавать других пользователей и настраивать их права по своему усмотрению."
---

# Назначение привилегий и ролей пользователям {{ PG }}

Атомарные полномочия в **{{ PG }}** называются _привилегиями_, группы полномочий — _ролями_. Подробнее об организации прав доступа читайте в [документации {{ PG }}](https://www.postgresql.org/docs/current/user-manag.html).

Пользователь, создаваемый вместе с кластером **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**, является владельцем первой базы данных в кластере. Вы можете [создавать других пользователей](cluster-users.md#adduser) и настраивать их права по своему усмотрению:

- [Изменить список ролей пользователя](#grant-role).
- [Выдать привилегию пользователю](#grant-privilege).
- [Отозвать привилегию у пользователя](#revoke-privilege).

{% include [public-privilege](../../_includes/mdb/mpg/public-privilege.md) %}

## Изменить список ролей пользователя {#grant-role}

Для назначения роли пользователю используйте интерфейсы {{ yandex-cloud }}: назначение роли запросом `GRANT` отменится при следующей операции с базой.

Сервис {{ mpg-name }} не дает доступа к [предопределенным ролям](https://www.postgresql.org/docs/current/predefined-roles.html), в том числе к роли суперпользователя. Назначить пользователю можно только специальные роли:

* `mdb_admin`
* `mdb_monitor`
* `mdb_replication`

Максимальные привилегии при работе с кластером имеет пользователь с [ролью](../concepts/roles.md#mdb-admin) `mdb_admin`. Подробнее см. в разделе [Назначение ролей](../concepts/roles.md).

{% note info %}

В {{ mpg-name }} не предусмотрено создание пользовательских ролей. Права пользователя определяются совокупностью назначенных ему привилегий.

{% endnote %}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на страницу каталога и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.postgresql.cluster.switch_users }}**.
  1. В строке с именем нужного пользователя нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) и выберите пункт **{{ ui-key.yacloud.mdb.cluster.users.button_action-update }}**.
  1. Разверните список **{{ ui-key.yacloud.mdb.dialogs.button_advanced-settings }}** и в поле **Grants** выберите роли, которые хотите назначить пользователю.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.dialogs.popup_button_save }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  Чтобы назначить роли пользователю кластера, передайте список нужных ролей в параметре `--grants`. Имеющиеся роли будут полностью перезаписаны: если вы хотите дополнить или уменьшить имеющийся список, сначала запросите текущие роли с информацией о пользователе командой `{{ yc-mdb-pg }} user get`.

  Чтобы назначить роли, выполните команду:

  ```bash
  {{ yc-mdb-pg }} user update <имя_пользователя> \
         --grants=<роль1,роль2> \
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
  
        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}
  
    1. Подтвердите изменение ресурсов.
  
        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Чтобы проверить список текущих ролей, воспользуйтесь методом [User.get](../api-ref/User/get.md) и выполните запрос, например, с помощью {{ api-examples.rest.tool }}:

     ```bash
     curl \
       --request GET \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/<идентификатор_кластера>/users/<имя_пользователя>'
     ```

     Идентификатор кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), а имя пользователя — со [списком пользователей в кластере](cluster-users.md#list-users).

     Список текущих ролей указан в параметре `grants` в выводе команды.

  1. Чтобы изменить список ролей пользователя, воспользуйтесь методом [User.update](../api-ref/User/update.md) и выполните запрос:

     {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

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

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/User/update.md#responses).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Чтобы проверить список текущих ролей, воспользуйтесь вызовом [UserService/Get](../api-ref/grpc/user_service.md#Get) и выполните запрос, например, с помощью {{ api-examples.grpc.tool }}:

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

  1. Чтобы изменить список ролей пользователя, воспользуйтесь вызовом [UserService/Update](../api-ref/grpc/user_service.md#Update) и выполните запрос:

     {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

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

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/user_service.md#Operation1).

{% endlist %}

## Выдать привилегию пользователю {#grant-privilege}

{% list tabs group=instructions %}

- SQL

    1. [Подключитесь](connect.md) к базе данных с помощью учетной записи владельца базы данных.
    1. Выполните команду `GRANT`. Подробное описание синтаксиса команды смотрите в [документации {{ PG }}](https://www.postgresql.org/docs/current/sql-grant.html).

- {{ TF }} {#tf}

    Выдать привилегию пользователю через {{ TF }} можно только в кластере с хостами в публичном доступе.

    Вы можете выдавать привилегии пользователям через {{ TF }}, используя сторонний провайдер — [Terraform Provider for PostgreSQL](https://github.com/cyrilgdn/terraform-provider-postgresql).

    {% include [pg-provider-disclaimer](../../_includes/mdb/mpg/terraform/pg-provider-disclaimer.md) %}

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

        {% include [see-fqdn](../../_includes/mdb/mpg/fqdn-host.md) %}

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
  
        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}
  
    1. Подтвердите изменение ресурсов.
  
        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

{% endlist %}

## Отозвать привилегию у пользователя {#revoke-privilege}

{% list tabs group=instructions %}

- SQL

    1. [Подключитесь](connect.md) к базе данных с помощью учетной записи владельца базы данных.
    1. Выполните команду `REVOKE`. Подробное описание синтаксиса команды смотрите в [документации {{ PG }}](https://www.postgresql.org/docs/current/sql-revoke.html).

- {{ TF }} {#tf}

    Если вы ранее выдали привилегию с использованием {{ TF }}:

    1. Откройте конфигурационный файл {{ TF }} с планом инфраструктуры.
    1. В блоке `postgresql_grant` удалите привилегию, которую хотите отозвать, из параметра `privileges`.

        Чтобы отозвать все привилегии, оставьте массив `privileges` пустым или удалите ресурс `postgresql_grant` целиком.

    1. Проверьте корректность настроек.
  
        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}
  
    1. Подтвердите изменение ресурсов.
  
        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

{% endlist %}

{% include [user-ro](../../_includes/mdb/mpg-user-examples.md) %}
