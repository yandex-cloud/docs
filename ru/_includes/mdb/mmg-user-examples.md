## Примеры {#examples}

### Добавить пользователя с правами только на чтение {#user-read-only}

Чтобы добавить в существующий кластер нового пользователя `user2` с доступом только на чтение к базе данных `db1`:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку ![image](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.mongodb.cluster.switch_users }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.users.button_add }}**.
  1. Введите имя пользователя `user2` и пароль (от 8 до 128 символов).
  1. Выберите базу данных `db1` из выпадающего списка **{{ ui-key.yacloud.mdb.dialogs.button_add-database }}**.
  1. Выберите роль `read` из выпадающего списка напротив базы данных `db1`.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.cluster.users.popup-add_button_add }}**.

- CLI {#cli}

  Выполните следующую команду:

  ```
  yc managed-mongodb user create user2 \
    --cluster-name <имя_кластера> \
    --password <пароль_пользователя> \
    --permission database=db1,role=read
  ```

{% endlist %}

### Изменить права пользователя {#update-user-read-only}

Чтобы добавить существующему пользователю `user1` кластера `cluster1` доступ только на чтение к базе данных `db2`:

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. Перейдите на [страницу каталога]({{ link-console-main }}) и выберите сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-mongodb }}**.
  1. Нажмите на имя кластера `cluster1` и выберите вкладку ![image](../../_assets/console-icons/persons.svg) **{{ ui-key.yacloud.mongodb.cluster.switch_users }}**.
  1. Нажмите значок ![image](../../_assets/console-icons/ellipsis.svg) в строке пользователя `user1` и выберите пункт **{{ ui-key.yacloud.mdb.cluster.users.button_action-update }}**.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.dialogs.button_add-database }}** и выберите базу данных `db2`.
  1. Нажмите ![image](../../_assets/console-icons/plus.svg) и выберите роль `read` из выпадающего списка напротив базы данных `db2`.
  1. Нажмите кнопку **{{ ui-key.yacloud.mdb.dialogs.popup_button_save }}**.

- CLI {#cli}

  Выполните следующую команду:

  ```
  {{ yc-mdb-mg }} user grant-permission user1 \
    --cluster-name cluster1 \
    --database db2 \
    --role read
  ```

- {{ TF }} {#tf}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

      О том, как создать такой файл, см. в разделе [{#T}](../../managed-mongodb/operations/cluster-create.md).

  1. Найдите в описании кластера {{ mmg-name }} блок `user` для пользователя `user1`.
  1. Добавьте блок `permission`:

      ```hcl
      resource "yandex_mdb_mongodb_cluster" "cluster1" {
        ...
        user {
          name     = "user1"
          password = "<пароль>"
          ...
          permission {
            database_name = "db2"
            roles         = [ "read" ]
          }
        }
      }
      ```

      1. Проверьте корректность настроек.

          {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

      1. Подтвердите изменение ресурсов.

          {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

    Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-mmg }}).

{% endlist %}
