# Managing backup policies in {{ mpg-name }}

[Backup](../concepts/backup.md) policies give you flexible control over how cluster backups are created and stored. You can configure a schedule for creating full backups and set their retention period.

## Creating a backup policy {#create-policy}

{% list tabs group=instructions %}

- Management console {#console}

  1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Click the name of your cluster and select the **{{ ui-key.yacloud.postgresql.cluster.switch_backups }}** tab.
  1. On the **{{ ui-key.yacloud.mdb.cluster.backups.label_title }}** page, select the **{{ ui-key.yacloud.postgresql.cluster.switch_backup-policies }}** tab.
  1. Click **Create policy**.
  1. Specify the parameters of the new policy:

      1. Enter a name and description.
      1. Select one of the backup start options:

          * **Every day**.
          * **Every week**. For this option, additionally select one or more days of the week.
          * **By month**. For this option, additionally select one or more months and one or more days of the month.

          The backup start time is specified in the [cluster settings](update.md#change-additional-settings).

      1. Configure backup storage. You can store backups for 7 to 1,095 days (up to three years).

    1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for creating a policy:

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

      * `--cluster-id`: Cluster ID. You can get it with the [list of clusters](cluster-list.md#list-clusters).

      {% include [backup-policy-create-settings](../../_includes/mdb/cli/backup-policy-create-settings.md) %}

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [BackupRetentionPolicy.Create](../api-ref/BackupRetentionPolicy/create.md) method, for instance, via the following {{ api-examples.rest.tool }} request:

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

     * `<cluster_ID>`: Cluster ID which you can get with the [list of clusters](cluster-list.md#list-clusters).

     {% include [backup-policy-create-settings](../../_includes/mdb/api/backup-policy-create-settings-rest.md) %}

  1. Check the [server response](../api-ref/BackupRetentionPolicy/create.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

  1. To create a policy:

     1. Call the [BackupRetentionPolicyService.Create](../api-ref/grpc/BackupRetentionPolicy/create.md) method, for instance, via the following {{ api-examples.grpc.tool }} request:

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

        * `cluster_id`: Cluster ID. You can get it with the [list of clusters](cluster-list.md#list-clusters).

        {% include [backup-policy-create-settings](../../_includes/mdb/api/backup-policy-create-settings-grpc.md) %}

      1. Check the [server response](../api-ref/grpc/BackupRetentionPolicy/create.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

## Getting a list of backup policies {#list-policies}

{% list tabs group=instructions %}

- Management console {#console}

  1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Click the name of your cluster and select the **{{ ui-key.yacloud.postgresql.cluster.switch_backups }}** tab.
  1. On the **{{ ui-key.yacloud.mdb.cluster.backups.label_title }}** page, select the **{{ ui-key.yacloud.postgresql.cluster.switch_backup-policies }}** tab.


- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for getting a list of policies:

      ```bash
      {{ yc-mdb-pg }} backup-retention-policy list --help
      ```

  1. Get a list of policies for the {{ mpg-name }} cluster:

      ```bash
      {{ yc-mdb-pg }} backup-retention-policy list \
         --cluster-id <cluster_ID>
      ```

      You can get the cluster ID from the [cluster list](cluster-list.md#list-clusters).

      {% include [backup-policy-list](../../_includes/mdb/cli/backup-policy-list.md) %}

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [BackupRetentionPolicy.List](../api-ref/BackupRetentionPolicy/list.md) method, for instance, via the following {{ api-examples.rest.tool }} request:

      ```bash
      curl \
        --request GET \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/<cluster_ID>/retention_policies?pageSize=<number_of_results>'
      ```

      Where:

      * `<cluster_ID>`: Cluster ID which you can get with the [list of clusters](cluster-list.md#list-clusters).
      * `pageSize`: Number of query results per page. Specify a number greater than zero.

  1. Check the [server response](../api-ref/BackupRetentionPolicy/list.md#yandex.cloud.mdb.postgresql.v1.ListBackupRetentionPoliciesResponse) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

  1. To get a list of policies for a cluster:

     1. Call the [BackupRetentionPolicyService.List](../api-ref/grpc/BackupRetentionPolicy/list.md) method, for instance, via the following {{ api-examples.grpc.tool }} request:

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

        Where:

        * `cluster_id`: Cluster ID. You can get it with the [list of clusters](cluster-list.md#list-clusters).
        * `page_size`: Number of query results per page. Specify a number greater than zero.

     1. Check the [server response](../api-ref/grpc/BackupRetentionPolicy/list.md#yandex.cloud.mdb.postgresql.v1.ListBackupRetentionPoliciesResponse) to make sure your request was successful.      

{% endlist %}

## Deleting a backup policy {#delete-policy}

{% list tabs group=instructions %}

- Management console {#console}

  1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Click the name of your cluster and select the **{{ ui-key.yacloud.postgresql.cluster.switch_backups }}** tab.
  1. On the **{{ ui-key.yacloud.mdb.cluster.backups.label_title }}** page, select the **{{ ui-key.yacloud.postgresql.cluster.switch_backup-policies }}** tab.

  1. Click ![image](../../_assets/console-icons/ellipsis.svg) in the row of the policy you want to delete.
  1. Select **{{ ui-key.yacloud.common.delete }}**.
  1. Confirm deletion and click **Delete**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  1. See the description of the CLI command for deleting a policy:

      ```bash
      {{ yc-mdb-pg }} backup-retention-policy delete --help
      ```

  1. Delete a policy:

      ```bash
      {{ yc-mdb-pg }} backup-retention-policy delete <policy_ID> \
         --cluster-id <cluster_ID>
      ```

      You can get the cluster ID from the [list of clusters](cluster-list.md#list-clusters), and the policy ID from the [list of policies](#list-policies).

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [BackupRetentionPolicy.Delete](../api-ref/BackupRetentionPolicy/delete.md) method, for instance, via the following {{ api-examples.rest.tool }} request:

      ```bash
      curl \
        --request DELETE \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/<cluster_ID>/retention_policies/<policy_ID>'
      ```

     You can get the cluster ID from the [list of clusters](cluster-list.md#list-clusters), and the policy ID from the [list of policies](#list-policies).

  1. Check the [server response](../api-ref/BackupRetentionPolicy/delete.md#yandex.cloud.operation.Operation) to make sure your request was successful.


- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

  1. To delete a policy:

     1. Call the [BackupRetentionPolicyService.Delete](../api-ref/grpc/BackupRetentionPolicy/delete.md) method, for instance, via the following {{ api-examples.grpc.tool }} request:

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

        You can get the cluster ID from the [list of clusters](cluster-list.md#list-clusters), and the policy ID from the [list of policies](#list-policies).

     1. Check the [server response](../api-ref/grpc/BackupRetentionPolicy/delete.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}
