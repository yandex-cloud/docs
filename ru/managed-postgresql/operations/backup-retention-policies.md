# Управление политиками резервного копирования в {{ mpg-name }}

Политики [резервного копирования](../concepts/backup.md) позволяют гибко управлять созданием и хранением резервных копий кластера. Вы можете настроить расписание, по которому будут создаваться полные резервные копии, и задать срок их хранения.

## Создать политику резервного копирования {#create-policy}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Перейдите]({{ link-console-main }}/link/managed-postgresql) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.postgresql.cluster.switch_backups }}**.
  1. На странице **{{ ui-key.yacloud.mdb.cluster.backups.label_title }}** выберите вкладку **{{ ui-key.yacloud.postgresql.cluster.switch_backup-policies }}**.
  1. Нажмите кнопку **Создать политику**.
  1. Укажите параметры новой политики:

      1. Введите имя и описание.
      1. Выберите один из вариантов запуска резервного копирования:

          * **Каждый день**.
          * **Каждую неделю**. Для этого варианта дополнительно выберите один или несколько дней недели.
          * **По месяцам**. Для этого варианта дополнительно выберите один или несколько месяцев и один или несколько дней месяца.

          Время начала резервного копирования указывается в [настройках кластера](update.md#change-additional-settings).

      1. Укажите параметры хранения резервных копий. Вы можете хранить копии от 7 до 1095 дней (до трех лет).

    1. Нажмите кнопку **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для создания политики:

      ```bash
      {{ yc-mdb-pg }} backup-retention-policy create --help
      ```

  1. Создайте политику:

      ```bash
      {{ yc-mdb-pg }} backup-retention-policy create \
         --cluster-id <идентификатор_кластера> \
         --policy-name <название_политики> \
         --day-of-month <день_месяца> \
         --month <месяц> \
         --day-of-week <день_недели> \
         --retain-for-days <срок_хранения_копии_в_днях> \
         --description <описание_политики>
      ```

      Где:

      * `--cluster-id` — идентификатор кластера. Его можно получить со [списком кластеров](cluster-list.md#list-clusters).

      {% include [backup-policy-create-settings](../../_includes/mdb/cli/backup-policy-create-settings.md) %}

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [BackupRetentionPolicy.Create](../api-ref/BackupRetentionPolicy/create.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

     ```bash
     curl \
       --request POST \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/<идентификатор_кластера>/retention_policies' \
       --data '{
                  "cron": {
                    "dayOfMonth": "<день_месяца>",
                    "month": "<месяц>",
                    "dayOfWeek": "<день_недели>"
                  },
                  "retainForDays": "<срок_хранения_в_днях>",
                  "description": "<описание_политики>",
                  "policyName": "<название_политики>"
              }'
     ```

     Где:

     * `<идентификатор_кластера>` — идентификатор кластера, который можно получить со [списком кластеров](cluster-list.md#list-clusters).

     {% include [backup-policy-create-settings](../../_includes/mdb/api/backup-policy-create-settings-rest.md) %}

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/BackupRetentionPolicy/create.md#yandex.cloud.operation.Operation).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

  1. Чтобы создать политику:

     1. Воспользуйтесь вызовом [BackupRetentionPolicyService.Create](../api-ref/grpc/BackupRetentionPolicy/create.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/backup_retention_policy_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<идентификатор_кластера>",
                  "cron": {
                     "day_of_month": "<день_месяца>",
                     "month": "<месяц>",
                     "day_of_week": "<день_недели>"
                  },
                  "retain_for_days": "<срок_хранения_копии_в_днях>",
                  "description": "<описание_политики>",
                  "policy_name": "<название_политики>"
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.postgresql.v1.BackupRetentionPolicyService.Create
        ```     

        Где:

        * `cluster_id` — идентификатор кластера. Его можно получить со [списком кластеров](cluster-list.md#list-clusters).

        {% include [backup-policy-create-settings](../../_includes/mdb/api/backup-policy-create-settings-grpc.md) %}

      1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/BackupRetentionPolicy/create.md#yandex.cloud.operation.Operation).

{% endlist %}

## Получить список политик резервного копирования {#list-policies}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Перейдите]({{ link-console-main }}/link/managed-postgresql) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.postgresql.cluster.switch_backups }}**.
  1. На странице **{{ ui-key.yacloud.mdb.cluster.backups.label_title }}** выберите вкладку **{{ ui-key.yacloud.postgresql.cluster.switch_backup-policies }}**.


- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для получения списка политик:

      ```bash
      {{ yc-mdb-pg }} backup-retention-policy list --help
      ```

  1. Получите список политик для кластера {{ mpg-name }}:

      ```bash
      {{ yc-mdb-pg }} backup-retention-policy list \
         --cluster-id <идентификатор_кластера>
      ```

      Идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters).

      {% include [backup-policy-list](../../_includes/mdb/cli/backup-policy-list.md) %}

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [BackupRetentionPolicy.List](../api-ref/BackupRetentionPolicy/list.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

      ```bash
      curl \
        --request GET \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/<идентификатор_кластера>/retention_policies?pageSize=<количество_результатов>'
      ```

      Где:

      * `<идентификатор_кластера>` — идентификатор кластера, который можно получить со [списком кластеров](cluster-list.md#list-clusters).
      * `pageSize` — количество результатов запроса, которые возвращаются на одной странице. Укажите число больше нуля.

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/BackupRetentionPolicy/list.md#yandex.cloud.mdb.postgresql.v1.ListBackupRetentionPoliciesResponse).

- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

  1. Чтобы получить список политик для кластера:

     1. Воспользуйтесь вызовом [BackupRetentionPolicyService.List](../api-ref/grpc/BackupRetentionPolicy/list.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/backup_retention_policy_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "cluster_id": "<идентификатор_кластера>",
                "page_size": "<количество_результатов>"
              }' \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.postgresql.v1.BackupRetentionPolicyService.List
        ```

        Где:

        * `cluster_id` — идентификатор кластера. Его можно получить со [списком кластеров](cluster-list.md#list-clusters).
        * `page_size` — количество результатов запроса, которые возвращаются на одной странице. Укажите число больше нуля.

     1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/BackupRetentionPolicy/list.md#yandex.cloud.mdb.postgresql.v1.ListBackupRetentionPoliciesResponse).      

{% endlist %}

## Удалить политику резервного копирования {#delete-policy}

{% list tabs group=instructions %}

- Консоль управления {#console}

  1. [Перейдите]({{ link-console-main }}/link/managed-postgresql) в сервис **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Нажмите на имя нужного кластера и выберите вкладку **{{ ui-key.yacloud.postgresql.cluster.switch_backups }}**.
  1. На странице **{{ ui-key.yacloud.mdb.cluster.backups.label_title }}** выберите вкладку **{{ ui-key.yacloud.postgresql.cluster.switch_backup-policies }}**.

  1. Нажмите на значок ![image](../../_assets/console-icons/ellipsis.svg) в строке политики, которую вы хотите удалить.
  1. Выберите пункт **{{ ui-key.yacloud.common.delete }}**.
  1. Подтвердите удаление и нажмите кнопку **Удалить**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. Посмотрите описание команды CLI для удаления политики:

      ```bash
      {{ yc-mdb-pg }} backup-retention-policy delete --help
      ```

  1. Удалите политику:

      ```bash
      {{ yc-mdb-pg }} backup-retention-policy delete <идентификатор_политики> \
         --cluster-id <идентификатор_кластера>
      ```

      Идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters), а идентификатор политики — со [списком политик](#list-policies).

- REST API {#api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Воспользуйтесь методом [BackupRetentionPolicy.Delete](../api-ref/BackupRetentionPolicy/delete.md) и выполните запрос, например с помощью {{ api-examples.rest.tool }}:

      ```bash
      curl \
        --request DELETE \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/<идентификатор_кластера>/retention_policies/<идентификатор_политики>'
      ```

     Идентификатор кластера можно запросить со [списком кластеров](cluster-list.md#list-clusters), а идентификатор политики — со [списком политик](#list-policies).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/BackupRetentionPolicy/delete.md#yandex.cloud.operation.Operation).


- gRPC API {#grpc-api}

  1. [Получите IAM-токен для аутентификации в API](../api-ref/authentication.md) и поместите токен в переменную среды окружения:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

  1. Чтобы удалить политику:

     1. Воспользуйтесь вызовом [BackupRetentionPolicyService.Delete](../api-ref/grpc/BackupRetentionPolicy/delete.md) и выполните запрос, например с помощью {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/backup_retention_policy_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "policy_id": "<идентификатор_политики>",
                "cluster_id": "<идентификатор_кластера>"
              }' \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.postgresql.v1.BackupRetentionPolicyService.Delete
        ```

        Идентификатор кластера можно запросить со [списком кластеров](cluster-list.md#list-clusters), а идентификатор политики — со [списком политик](#list-policies).

     1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/BackupRetentionPolicy/delete.md#yandex.cloud.operation.Operation).

{% endlist %}
