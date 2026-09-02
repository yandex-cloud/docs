## Примеры {#examples}

### Создать пользователя с правами только на чтение {#user-read-only}

Чтобы в существующем кластере `cluster1` создать нового пользователя `user2` с паролем `SecretPassword`, защитой от удаления и доступом к базе данных `db1` только для чтения:

{% list tabs group=instructions %}

- Консоль управления {#console}

  [Создайте пользователя](../../managed-mysql/operations/cluster-users.md#adduser) с именем `user2`. При создании пользователя:

  1. Добавьте базу `db1` в список баз данных.
  1. Добавьте роль `SELECT` для базы `db1`.
  1. Включите защиту от удаления.

- CLI {#cli}

  Создайте пользователя `user2` с нужными привилегиями:

  ```bash
  {{ yc-mdb-my }} user create "user2" \
    --cluster-name "cluster1" \
    --password "SecretPassword" \
    --permissions database=db1,role=SELECT \
    --deletion-protection enabled
  ```

- {{ TF }} {#tf}

  1. Откройте актуальный конфигурационный файл {{ TF }} с планом инфраструктуры.

      Как создать такой файл, описано в разделе [{#T}](../../managed-mysql/operations/cluster-create.md).

  1. Добавьте ресурс `yandex_mdb_mysql_user_v2`:

      ```hcl
      resource "yandex_mdb_mysql_user_v2" "user2" {
        cluster_id               = yandex_mdb_mysql_cluster.cluster1.id
        name                     = "user2"
        password                 = "SecretPassword"
        deletion_protection_mode = "DELETION_PROTECTION_MODE_ENABLED"
        permission {
          database_name = "db1"
          roles         = ["SELECT"]
        ...
        }
      }
      ```

  1. Проверьте корректность настроек.

      {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Подтвердите изменение ресурсов.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  Подробнее в [документации провайдера {{ TF }}]({{ tf-provider-resources-link }}/mdb_mysql_user).

{% endlist %}
