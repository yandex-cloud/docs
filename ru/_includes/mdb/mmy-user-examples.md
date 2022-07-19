## Примеры {#examples}

### Создать пользователя с правами только на чтение {#user-read-only}

Чтобы в существующем кластере `cluster1` создать нового пользователя `user2` с паролем `SecretPassword` и доступом к базе данных `db1` только для чтения:

{% list tabs %}

- Консоль управления

  [Создайте пользователя](../../managed-mysql/operations/cluster-users.md#adduser) с именем `user2`. При создании пользователя:

  1. Добавьте базу `db1` в список баз данных.
  1. Добавьте роль `SELECT` для базы `db1`.

- CLI

  1. Создайте пользователя `user2`:

      ```bash
      yc managed-mysql user create "user2" \
        --cluster-name "cluster1" \
        --password "SecretPassword"
      ```

  1. Добавьте роль `SELECT` для базы `db1`:

      ```bash
      yc managed-mysql users grant-permission "user2" \
        --cluster-name "cluster1" \
        --database "db1" \
        --permissions "SELECT"
      ```

- {{ TF }}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

      О том, как создать такой файл, см. в разделе [{#T}](../../managed-mysql/operations/cluster-create.md).

  1. Добавьте в описание кластера `cluster1` блок `user`:

      ```hcl
      resource "yandex_mdb_mysql_cluster" "cluster1" {
        ...
        user {
          name     = "user2"
          password = "SecretPassword"
          permission {
            database_name = "db1"
            roles         = ["SELECT"]
          }
        }
        ...
      }
      ```
  1. Проверьте корректность настроек.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  Подробнее см. в [документации провайдера {{ TF }}]({{ tf-provider-mmy }}).

{% endlist %}
