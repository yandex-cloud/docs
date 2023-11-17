---
title: "Управление пользователями MongoDB"
description: "Из статьи вы узнаете, как добавлять и удалять пользователей, а также управлять их индивидуальными настройками в сервисе по управлению базами данных MongoDB."
---

# Управление пользователями {{ MG }}

Вы можете добавлять и удалять пользователей, а также управлять их индивидуальными настройками и правами доступа к базам данных.

## Получить список пользователей {#list-users}

{% list tabs %}

- Консоль управления
  
  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
  1. Нажмите на имя нужного кластера, затем выберите вкладку ![image](../../_assets/mdb/user.svg) **{{ ui-key.yacloud.mongodb.cluster.switch_users }}**.
  
- CLI
  
  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  Чтобы получить список пользователей кластера, выполните команду:
  
  ```
  {{ yc-mdb-mg }} user list \
    --cluster-name <имя_кластера>
  ```
  
  Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).
  
- API
  
  Чтобы получить список пользователей, воспользуйтесь методом REST API [list](../api-ref/User/list.md) для ресурса [User](../api-ref/User/index.md) или вызовом gRPC API [UserService/List](../api-ref/grpc/user_service.md#List) и передайте в запросе идентификатор кластера в параметре `clusterId`.

  Идентификатор кластера можно получить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

{% endlist %}

## Добавить пользователя {#adduser}

{% list tabs %}

- Консоль управления
  
  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.

  1. Нажмите на имя нужного кластера и выберите вкладку ![image](../../_assets/mdb/user.svg) **{{ ui-key.yacloud.mongodb.cluster.switch_users }}**.

  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.users.button_add }}**.

  1. Введите имя пользователя БД и пароль.

      {% include [user-name-and-password-limits](../../_includes/mdb/mmg/note-info-user-name-and-pass-limits.md) %}

  1. Настройте [роли](../concepts/users-and-roles.md) пользователя:

     1. Нажмите кнопку **{{ ui-key.yacloud.mdb.dialogs.button_add-database }}** и выберите БД, в которой вы хотите выдать роль.
     1. Добавьте роли с помощью кнопки ![image](../../_assets/plus-sign.svg).

     Вы можете выдать пользователю несколько ролей в разных базах данных.

  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.users.popup-add_button_add }}**.

- CLI
  
  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  Чтобы создать пользователя в кластере:
  
  1. Посмотрите описание команды CLI для создания пользователя:
  
     ```
     {{ yc-mdb-mg }} user create --help
     ```
  
  1. Укажите свойства пользователя в команде создания:
     ```
     {{ yc-mdb-mg }} user create <имя_пользователя> \
       --cluster-name <имя_кластера> \
       --password <пароль_для_пользователя> \
       --permission database=<имя_БД>,role=<роль>,role=<другая_роль>,... \
       --permission database=<имя_другой_БД>,role=<роль>,...
     ```
  
     {% include [user-name-and-password-limits](../../_includes/mdb/mmg/note-info-user-name-and-pass-limits.md) %}

     Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- {{ TF }}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.
  
        О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).
  
    1. Добавьте к описанию кластера {{ mmg-name }} блок `user`:
  
        ```hcl
        resource "yandex_mdb_mongodb_cluster" "<имя_кластера>" {
          ...
          user {
            name     = "<имя_пользователя>"
            password = "<пароль>"
            permission {
              database_name = "<имя_БД>"
              roles         = [ "<список_ролей_пользователя>" ]
            }
          }
        }
        ```

        Где `database_name` — имя БД, к которой предоставляется доступ.

        {% include [user-name-and-password-limits](../../_includes/mdb/mmg/note-info-user-name-and-pass-limits.md) %}

    1. Проверьте корректность настроек.
  
        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}
  
    1. Подтвердите изменение ресурсов.
  
        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}
  
  Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_mongodb_cluster).

  {% include [Terraform timeouts](../../_includes/mdb/mmg/terraform/timeouts.md) %}

- API
  
  Чтобы добавить пользователя, воспользуйтесь методом REST API [create](../api-ref/User/create.md) для ресурса [User](../api-ref/User/index.md) или вызовом gRPC API [UserService/Create](../api-ref/grpc/user_service.md#Create) и передайте в запросе:

  * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
  * Настройки пользователя в параметре `userSpec`:
    * Имя пользователя в параметре `name`.
    * Пароль пользователя в параметре `password`.
    * Права доступа к базам данных (один или несколько параметров `permissions`, по одному на каждую базу данных):
      * Имя базы данных в параметре `databaseName`. Чтобы узнать имя, [получите список баз данных в кластере](databases.md#list-db).
      * Права доступа к базе данных в параметре `roles`.

{% endlist %}

## Изменить пользователя {#updateuser}

{% list tabs %}

- Консоль управления

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.

  1. Нажмите на имя нужного кластера и выберите вкладку ![image](../../_assets/mdb/user.svg) **{{ ui-key.yacloud.mongodb.cluster.switch_users }}**.

  1. Чтобы изменить пароль пользователя, нажмите значок ![image](../../_assets/options.svg) в строке нужного пользователя и выберите пункт **{{ ui-key.yacloud.mdb.cluster.users.button_action-password }}**.

     {% include [password-limits](../../_includes/mdb/mch/note-info-password-limits.md) %}

  1. Чтобы изменить [роли](../concepts/users-and-roles.md) пользователя:

     1. Нажмите значок ![image](../../_assets/options.svg) в строке нужного пользователя и выберите пункт **{{ ui-key.yacloud.mdb.cluster.users.button_action-update }}**.
     1. Чтобы добавить роль, нажмите ![image](../../_assets/plus-sign.svg) напротив нужной БД и выберите роль.
     1. Чтобы удалить роль, нажмите на значок ![image](../../_assets/cross.svg) возле названия роли.

  1. Нажмите **{{ ui-key.yacloud.mdb.dialogs.popup_button_save }}**.

- CLI
  
  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  Чтобы изменить пароль или список ролей пользователя:
  
  1. Посмотрите описание команды CLI для изменения пользователя:
  
     ```
     {{ yc-mdb-mg }} user update --help
     ```
  
  1. Укажите свойства пользователя в команде изменения:
     ```
     {{ yc-mdb-mg }} user update <имя_пользователя> \
       --cluster-name <имя_кластера> \
       --password <пароль_для_пользователя> \
       --permission database=<имя_БД>,role=<роль>,role=<другая_роль>,... \
       --permission database=<имя_другой_БД>,role=<роль>,...
     ```
  
     {% include [password-limits](../../_includes/mdb/mch/note-info-password-limits.md) %}

  Чтобы добавить пользователю доступ к базе данных с определенным набором ролей:

  1. Посмотрите описание команды CLI для выдачи прав пользователю:
  
     ```
     {{ yc-mdb-mg }} user grant-permission --help
     ```
  
  1. Укажите свойства пользователя в команде выдачи прав:

     ```bash
     {{ yc-mdb-mg }} user grant-permission <имя_пользователя> \
       --cluster-name <имя_кластера> \
       --database <имя_БД> \
       --role <набор_ролей_через_запятую>
     ```

  Чтобы отозвать доступ у пользователя к базе данных:

  1. Посмотрите описание команды CLI для отзыва прав пользователя:
  
     ```
     {{ yc-mdb-mg }} user revoke-permission --help
     ```
  
  1. Укажите свойства пользователя в команде отзыва прав:

     ```bash
     {{ yc-mdb-mg }} user revoke-permission <имя_пользователя> \
       --cluster-name <имя_кластера> \
       --database <имя_БД>
     ```

      Эта команда полностью закрывает доступ пользователю к указанной базе данных.

  Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters), имя базы данных — со [списком баз данных в кластере](databases.md#list-db), имя пользователя — со [списком пользователей в кластере](cluster-users.md#list-users).

- {{ TF }}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.
  
        О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).
  
    1. Найдите в описании кластера {{ mmg-name }} блок `user` для нужного пользователя.
    1. Измените значение полей `password` и `permission`:
  
        ```hcl
        resource "yandex_mdb_mongodb_cluster" "<имя_кластера>" {
          ...
          user {
            name     = "<имя_пользователя>"
            password = "<новый_пароль>"
            permission {
              database_name = "<имя_БД>"
              roles         = [ "<новый_список_ролей_пользователя>" ]
            }
          }
        }
        ```

        {% include [password-limits](../../_includes/mdb/mch/note-info-password-limits.md) %}

    1. Проверьте корректность настроек.
  
        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}
  
    1. Подтвердите изменение ресурсов.
  
        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}
  
  Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_mongodb_cluster).

  {% include [Terraform timeouts](../../_includes/mdb/mmg/terraform/timeouts.md) %}

- API

  Чтобы изменить пользователя, воспользуйтесь методом REST API [update](../api-ref/User/update.md) для ресурса [User](../api-ref/User/index.md) или вызовом gRPC API [UserService/Update](../api-ref/grpc/user_service.md#Update) и передайте в запросе:

  * Идентификатор кластера, в котором находится пользователь, в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
  * Имя пользователя в параметре `userName`. Чтобы узнать имя, [получите список пользователей в кластере](cluster-users.md#list-users).
  * Имя базы данных, для которой вы хотите изменить список ролей пользователя, в параметре `permissions.databaseName`. Чтобы узнать имя, [получите список баз данных в кластере](databases.md#list-db).
  * Массив нового списка ролей пользователя в параметре `permissions.roles`.
  * Список настроек пользователя, которые необходимо изменить, в параметре `updateMask`.

  {% include [Note API updateMask](../../_includes/note-api-updatemask.md) %}

{% endlist %}

## Удалить пользователя {#removeuser}

{% list tabs %}

- Консоль управления
  
  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку ![image](../../_assets/mdb/user.svg) **{{ ui-key.yacloud.mongodb.cluster.switch_users }}**.
  1. Нажмите значок ![image](../../_assets/options.svg) в строке нужного пользователя и выберите пункт **{{ ui-key.yacloud.mdb.cluster.users.button_remove }}**.
  
- CLI
  
  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  Чтобы удалить пользователя, выполните команду:
  
  ```
  {{ yc-mdb-mg }} user delete <имя_пользователя> \
    --cluster-name <имя_кластера>
  ```
  
  Имя кластера можно запросить со [списком кластеров в каталоге](cluster-list.md#list-clusters).

- {{ TF }}

    1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.
  
        О том, как создать такой файл, см. в разделе [{#T}](cluster-create.md).
  
    1. Удалите из описания кластера {{ mmg-name }} блок `user` с описанием нужного пользователя.
  
    1. Проверьте корректность настроек.
  
        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}
  
    1. Подтвердите изменение ресурсов.
  
        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}
  
  Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_mongodb_cluster).

  {% include [Terraform timeouts](../../_includes/mdb/mmg/terraform/timeouts.md) %}

- API
  
  Чтобы удалить пользователя, воспользуйтесь методом REST API [delete](../api-ref/User/delete.md) для ресурса [User](../api-ref/User/index.md) или вызовом gRPC API [UserService/Delete](../api-ref/grpc/user_service.md#Delete) и передайте в запросе:

  * Идентификатор кластера в параметре `clusterId`. Чтобы узнать идентификатор, [получите список кластеров в каталоге](cluster-list.md#list-clusters).
  * Имя пользователя, которого требуется удалить, в параметре `userName`. Чтобы узнать имя, [получите список пользователей в кластере](#list-users).

{% endlist %}

{% include [user-ro](../../_includes/mdb/mmg-user-examples.md) %}
