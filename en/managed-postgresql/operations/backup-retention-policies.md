# Managing backup policies in {{ mpg-name }}

[Backup](../concepts/backup.md) policies allow you to flexibly manage the creation and storage of cluster backups. You can configure a schedule to create full backups and specify their retention period.

## Creating a backup policy {#create-policy}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command to create a policy:

      ```bash
      {{ yc-mdb-pg }} backup-retention-policy create --help
      ```

  1. Create a policy:

      ```bash
      {{ yc-mdb-pg }} backup-retention-policy create \
         --cluster-id <cluster_ID> \
         --policy-name <policy_name> \
         --day-of-month <day_of_month> \
         --month <month> \
         --day-of-week <day_of_week> \
         --retain-for-days <backup_retention_period_in_days> \
         --description <policy_description>
      ```

      Where:

      * `day-of-month`: Day of month. The possible value is `1–31`.
      * `month`: Month. The possible values are `1–12` or `JAN–DEC`.
      * `day-of-week`: Day of week. The possible values are `0–6` or `SUN–SAT`.
      * `retain-for-days`: Backup retention period in days. The minimum value is `7`.

        The `day-of-month`, `month`, and `day-of-week` parameters are used to schedule backups. The schedule is set as a cron expression, but hours and minutes are not specified.
        
        The cron expression also supports special characters:

        * `*`: Selecting all possible values. A backup will be taken on every possible opportunity (every day or month) provided there is no conflict with other parameters. This option is used by default if the parameter value is not specified.
        * `,`: Listing multiple values.
        * `–`: Specifying a range of values.
        * `/`: Specifying a range interval. For example, `*/3` for the `day-of-month` parameter means that a backup will be created every three days.

        If none of the schedule parameters is set, backups are taken based on the `* * *` cron expression, i.e., every day.

        Examples of cron expressions:

        * `1 */6 *`: Backup is created on the first day of month every six month.
        * `31 jan SUN`: Backup is created in January each Sunday and on January 31.
        * `* * WED`: Backup is created every Wednesday.

        You can test a cron expression in the [editor](https://crontab.guru).

      You can get the cluster ID with a [list of clusters](cluster-list.md#list-clusters).

      Result:

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

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Use the [BackupRetentionPolicy.Create](../api-ref/BackupRetentionPolicy/create.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

     ```bash
     curl \
       --request POST \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/<cluster_ID>/retention_policies' \
       --data '{
                  "cron": {
                    "dayOfMonth": "<day_of_month>",
                    "month": "<month>",
                    "dayOfWeek": "<day_of_week>"
                  },
                  "retainForDays": "<retention_period_in_days>",
                  "description": "<policy_description>",
                  "policyName": "<policy_name>"
              }'
     ```

      Where:
      * `dayOfMonth`: Day of month. The possible value is `1-31`.
      * `month`: Month. The possible values are `1-12` or `JAN-DEC`.
      * `dayOfWeek`: Day of week. The possible values are `0-6` or `SUN-SAT`.
      * `retainForDays`: Backup retention period in days. The minimum value is `7`.
        
        The `dayOfMonth`, `month`, and `dayOfWeek` parameters are used to schedule backups. The schedule is set as a cron expression, but hours and minutes are not specified.
        
        The cron expression also supports special characters:

        * `*`: Selecting all possible values. A backup will be taken on every possible opportunity (every day or month) provided there is no conflict with other parameters. This option is used by default if the parameter value is not specified.
        * `,`: Listing multiple values.
        * `–`: Specifying a range of values.
        * `/`: Specifying a range interval. For example, `*/3` for the `dayOfMonth` parameter means that a backup will be created every three days.

        If none of the schedule parameters is set, backups are taken based on the `* * *` cron expression, i.e., every day.

        Examples of cron expressions:

        * `1 */6 *`: Backup is created on the first day of month every six month.
        * `31 jan SUN`: Backup is created in January each Sunday and on January 31.
        * `* * WED`: Backup is created every Wednesday.

        You can test a cron expression in the [editor](https://crontab.guru).

     You can request the cluster ID with a [list of clusters](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/BackupRetentionPolicy/create.md#yandex.cloud.mdb.postgresql.v1.CreateBackupRetentionPolicyResponse) to make sure the request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

  1. To create a policy:

     1. Use the [BackupRetentionPolicyService.Create](../api-ref/grpc/BackupRetentionPolicy/create.md) method and send the following request, e.g., via {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/backup_retention_policy_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                  "cluster_id": "<cluster_ID>",
                  "cron": {
                     "day_of_month": "<day_of_month>",
                     "month": "<month>",
                     "day_of_week": "<day_of_week>"
                  },
                  "retain_for_days": "<backup_retention_period_in_days>",
                  "description": "<policy_description>",
                  "policy_name": "<policy_name>"
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.postgresql.v1.BackupRetentionPolicyService.Create
        ```     

        Where:

        * `day_of_month`: Day of month. The possible value is `1–31`.
        * `month`: Month. The possible values are `1–12` or `JAN–DEC`.
        * `day_of_week`: Day of week. The possible values are `0–6` or `SUN–SAT`.
        * `retain_for_days`: Backup retention period in days. The minimum value is `7`.

          The `day_of_month`, `month`, and `day_of_week` parameters are used to schedule backups. The schedule is set as a cron expression, but hours and minutes are not specified.
          
          The cron expression also supports special characters:

          * `*`: Selecting all possible values. A backup will be taken on every possible opportunity (every day or month) provided there is no conflict with other parameters. This option is used by default if the parameter value is not specified.
          * `,`: Listing multiple values.
          * `–`: Specifying a range of values.
          * `/`: Specifying a range interval. For example, `*/3` for the `day_of_month` parameter means that a backup will be created every three days.

          If none of the schedule parameters is set, backups are taken based on the `* * *` cron expression, i.e., every day.

          Examples of cron expressions:

          * `1 */6 *`: Backup is created on the first day of month every six month.
          * `31 jan SUN`: Backup is created in January each Sunday and on January 31.
          * `* * WED`: Backup is created every Wednesday.

          You can test a cron expression in the [editor](https://crontab.guru).

        You can get the cluster ID with a [list of clusters](cluster-list.md#list-clusters).

      1. View the [server response](../api-ref/grpc/BackupRetentionPolicy/create.md#yandex.cloud.mdb.postgresql.v1.CreateBackupRetentionPolicyResponse) to make sure the request was successful.

{% endlist %}

## Getting a list of backup policies {#list-policies}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command to get a list of policies:

      ```bash
      {{ yc-mdb-pg }} backup-retention-policy list --help
      ```

  1. Get a list of policies for a {{ mpg-name }} cluster:

      ```bash
      {{ yc-mdb-pg }} backup-retention-policy list \
         --cluster-id <cluster_ID>
      ```

      You can get the cluster ID with a [list of clusters](cluster-list.md#list-clusters).

      Result:

      ```text
      +----------------------+-------------+--------------------+------------+-------------------+
      |          ID          |     NAME    |     CLUSTER ID     |  CRONTAB   |  RETENTION PERIOD |
      +----------------------+-------------+--------------------+------------+-------------------+
      | mdbt553glp51******** | test-policy | c9q5le6h1a4******* | 31 JAN SUN |                50 |
      +----------------------+-------------+--------------------+------------+-------------------+
      ```

      Order of parameters in the `CRONTAB` column: `day_of_month`, `month`, `day_of_week`.

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Use the [BackupRetentionPolicy.List](../api-ref/BackupRetentionPolicy/list.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

      ```bash
      curl \
        --request GET \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/<cluster_ID>/retention_policies?pageSize=<number_of_results>'
      ```
      
      Where `page_size` is the number of request results returned per page. Specify a number larger than zero.

     You can request the cluster ID with a [list of clusters](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/BackupRetentionPolicy/list.md#yandex.cloud.mdb.postgresql.v1.ListBackupRetentionPoliciesResponse) to make sure the request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

  1. To get a list of policies for a cluster:

     1. Use the [BackupRetentionPolicyService.List](../api-ref/grpc/BackupRetentionPolicy/list.md) method and send the following request, e.g., via {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/backup_retention_policy_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "cluster_id": "<cluster_ID>",
                "page_size": "<number_of_results>"
              }' \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.postgresql.v1.BackupRetentionPolicyService.List
        ```

        Where `page_size` is the number of request results returned per page. Specify a number larger than zero.

        You can request the cluster ID with a [list of clusters](cluster-list.md#list-clusters).

     1. View the [server response](../api-ref/grpc/BackupRetentionPolicy/list.md#yandex.cloud.mdb.postgresql.v1.ListBackupRetentionPoliciesResponse) to make sure the request was successful.      

{% endlist %}

## Deleting a backup policy {#delete-policy}

{% list tabs group=instructions %}

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command to delete a policy:

      ```bash
      {{ yc-mdb-pg }} backup-retention-policy delete --help
      ```

  1. Delete a policy:

      ```bash
      {{ yc-mdb-pg }} backup-retention-policy delete <policy_ID> \
         --cluster-id <cluster_ID>
      ```

      You can get the cluster ID with the [list of clusters](cluster-list.md#list-clusters), and the policy ID, with the [list of policies](#list-policies).

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Use the [BackupRetentionPolicy.Delete](../api-ref/BackupRetentionPolicy/delete.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

      ```bash
      curl \
        --request DELETE \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/<cluster_ID>/retention_policies/<policy_ID>'
      ```

     You can request the cluster ID with the [list of clusters](cluster-list.md#list-clusters), and the policy ID, with the [list of policies](#list-policies).

  1. View the [server response](../api-ref/BackupRetentionPolicy/delete.md#yandex.cloud.mdb.postgresql.v1.DeleteBackupRetentionPolicyResponse) to make sure the request was successful.


- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

  1. To delete a policy:

     1. Use the [BackupRetentionPolicyService.Delete](../api-ref/grpc/BackupRetentionPolicy/delete.md) method and send the following request, e.g., via {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
          -format json \
          -import-path ~/cloudapi/ \
          -import-path ~/cloudapi/third_party/googleapis/ \
          -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/backup_retention_policy_service.proto \
          -rpc-header "Authorization: Bearer $IAM_TOKEN" \
          -d '{
                "policy_id": "<policy_ID>",
                "cluster_id": "<cluster_ID>"
              }' \
          {{ api-host-mdb }}:{{ port-https }} \
          yandex.cloud.mdb.postgresql.v1.BackupRetentionPolicyService.Delete
        ```

        You can request the cluster ID with the [list of clusters](cluster-list.md#list-clusters), and the policy ID, with the [list of policies](#list-policies).

     1. View the [server response](../api-ref/grpc/BackupRetentionPolicy/delete.md#yandex.cloud.mdb.postgresql.v1.DeleteBackupRetentionPolicyResponse) to make sure the request was successful.      

{% endlist %}
