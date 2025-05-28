# Управление политиками резервного копирования в {{ mpg-name }}

Политики [резервного копирования](../concepts/backup.md) позволяют гибко управлять созданием и хранением резервных копий кластера. Вы можете настроить расписание, по которому будут создаваться полные резервные копии, и задать срок их хранения.

## Создать политику резервного копирования {#create-policy}

{% list tabs group=instructions %}

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

      * `day-of-month` — день месяца. Возможные значения: `1–31`.
      * `month` — месяц. Возможные значения: `1–12` или `JAN–DEC`.
      * `day-of-week` — день недели. Возможные значения: `0–6` или `SUN–SAT`.
      * `retain-for-days` — срок хранения копии в днях. Минимальное значение — `7`.

        Параметры `day-of-month`, `month` и `day-of-week` составляют расписание, по которому создаются резервные копии. Расписание задается в виде cron-выражения, но часы и минуты не указываются.
        
        Сron-выражение также поддерживает специальные символы:

        * `*` — выбор всех возможных значений. Копия будет создаваться каждый раз (день или месяц), когда это возможно и не противоречит остальным параметрам. Используется по умолчанию, если значение параметра не указано.
        * `,` — перечисление нескольких значений.
        * `–` — указание диапазона значений.
        * `/` — указание шага диапазона. Например, `*/3` для параметра `day-of-month` означает, что копия будет создаваться раз в три дня.

        Если ни один параметр расписания не задан, резервные копии создаются по cron-выражению `* * *`, то есть каждый день.

        Примеры cron-выражений:

        * `1 */6 *` — копия создается в первый день месяца раз в полгода.
        * `31 jan SUN` — копия создается в январе по воскресеньям и тридцать первого января.
        * `* * WED` — копия создается каждую среду.

        Вы можете протестировать cron-выражение в [редакторе](https://crontab.guru).

      Идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters).

      Результат выполнения команды:

      ```text
      policy_id: mdbt553glp51********
      cluster_id: c9q5le6h1a4k********
      policy_name: test-policy
      created_at: "2025-03-25T15:55:50.393000450Z"
      cron:
        day_of_month: "25"
        month: mar
        day_of_week: TUE
      retain_for_days: "300"
      ```

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
      * `dayOfMonth` — день месяца. Возможные значения: `1-31`.
      * `month` — месяц. Возможные значения: `1-12` или `JAN-DEC`.
      * `dayOfWeek` — день недели. Возможные значения: `0-6` или `SUN-SAT`.
      * `retainForDays` — срок хранения копии в днях. Минимальное значение — `7`.
        
        Параметры `dayOfMonth`, `month` и `dayOfWeek` составляют расписание, по которому создаются резервные копии. Расписание задается в виде cron-выражения, но часы и минуты не указываются.
        
        Сron-выражение также поддерживает специальные символы:

        * `*` — выбор всех возможных значений. Копия будет создаваться каждый раз (день или месяц), когда это возможно и не противоречит остальным параметрам. Используется по умолчанию, если значение параметра не указано.
        * `,` — перечисление нескольких значений.
        * `–` — указание диапазона значений.
        * `/` — указание шага диапазона. Например, `*/3` для параметра `dayOfMonth` означает, что копия будет создаваться раз в три дня.

        Если ни один параметр расписания не задан, резервные копии создаются по cron-выражению `* * *`, то есть каждый день.

        Примеры cron-выражений:

        * `1 */6 *` — копия создается в первый день месяца раз в полгода.
        * `31 jan SUN` — копия создается в январе по воскресеньям и тридцать первого января.
        * `* * WED` — копия создается каждую среду.

        Вы можете протестировать cron-выражение в [редакторе](https://crontab.guru).

     Идентификатор кластера можно запросить со [списком кластеров](cluster-list.md#list-clusters).

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/BackupRetentionPolicy/create.md#yandex.cloud.mdb.postgresql.v1.CreateBackupRetentionPolicyResponse).

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

        * `day_of_month` — день месяца. Возможные значения: `1–31`.
        * `month` — месяц. Возможные значения: `1–12` или `JAN–DEC`.
        * `day_of_week` — день недели. Возможные значения: `0–6` или `SUN–SAT`.
        * `retain_for_days` — срок хранения копии в днях. Минимальное значение — `7`.

          Параметры `day_of_month`, `month` и `day_of_week` составляют расписание, по которому создаются резервные копии. Расписание задается в виде cron-выражения, но часы и минуты не указываются.
          
          Сron-выражение также поддерживает специальные символы:

          * `*` — выбор всех возможных значений. Копия будет создаваться каждый раз (день или месяц), когда это возможно и не противоречит остальным параметрам. Используется по умолчанию, если значение параметра не указано.
          * `,` — перечисление нескольких значений.
          * `–` — указание диапазона значений.
          * `/` — указание шага диапазона. Например, `*/3` для параметра `day_of_month` означает, что копия будет создаваться раз в три дня.

          Если ни один параметр расписания не задан, резервные копии создаются по cron-выражению `* * *`, то есть каждый день.

          Примеры cron-выражений:

          * `1 */6 *` — копия создается в первый день месяца раз в полгода.
          * `31 jan SUN` — копия создается в январе по воскресеньям и тридцать первого января.
          * `* * WED` — копия создается каждую среду.

          Вы можете протестировать cron-выражение в [редакторе](https://crontab.guru).

        Идентификатор кластера можно получить со [списком кластеров](cluster-list.md#list-clusters).

      1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/BackupRetentionPolicy/create.md#yandex.cloud.mdb.postgresql.v1.CreateBackupRetentionPolicyResponse).

{% endlist %}

## Получить список политик резервного копирования {#list-policies}

{% list tabs group=instructions %}

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

      Результат выполнения команды:

      ```text
      +----------------------+-------------+--------------------+------------+-------------------+
      |          ID          |     NAME    |     CLUSTER ID     |  CRONTAB   |  RETENTION PERIOD |
      +----------------------+-------------+--------------------+------------+-------------------+
      | mdbt553glp51******** | test-policy | c9q5le6h1a4******* | 31 JAN SUN |                50 |
      +----------------------+-------------+--------------------+------------+-------------------+
      ```

      Порядок параметров в столбце `CRONTAB`: `day_of_month` (день месяца), `month` (месяц), `day_of_week` (день недели).

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
      
      Где `pageSize` — количество результатов запроса, которые возвращаются на одной странице. Укажите число больше нуля.

     Идентификатор кластера можно запросить со [списком кластеров](cluster-list.md#list-clusters).

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

        Где `page_size` — количество результатов запроса, которые возвращаются на одной странице. Укажите число больше нуля.

        Идентификатор кластера можно запросить со [списком кластеров](cluster-list.md#list-clusters).

     1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/BackupRetentionPolicy/list.md#yandex.cloud.mdb.postgresql.v1.ListBackupRetentionPoliciesResponse).      

{% endlist %}

## Удалить политику резервного копирования {#delete-policy}

{% list tabs group=instructions %}

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

  1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/BackupRetentionPolicy/delete.md#yandex.cloud.mdb.postgresql.v1.DeleteBackupRetentionPolicyResponse).


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

     1. Убедитесь, что запрос был выполнен успешно, изучив [ответ сервера](../api-ref/grpc/BackupRetentionPolicy/delete.md#yandex.cloud.mdb.postgresql.v1.DeleteBackupRetentionPolicyResponse).      

{% endlist %}
