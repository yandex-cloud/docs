---
title: Updating {{ OS }} cluster settings
description: After creating a {{ OS }} cluster, you can edit its service settings.
keywords:
  - OpenSearch settings
  - OpenSearch cluster settings
  - OpenSearch
---

# Updating {{ OS }} cluster settings

After creating a cluster, you can change:

* [Service account](#change-service-account).
* `admin` [user password](#change-admin-password).
* [{{ OS }} settings](#change-opensearch-config).
* [Additional cluster settings](#change-additional-settings).
* [Security groups](#change-sg-set).

You can also:

* [Update the {{ OS }}](cluster-version-update.md) version.
* [Change the host group configuration](host-groups.md#update-host-group).
* [Move host groups to a different availability zone](host-migration.md).


## Changing a service account {#change-service-account}


To link your service account to a {{ mos-name }} cluster, [assign](../../iam/operations/roles/grant.md) the [iam.serviceAccounts.user](../../iam/security/index.md#iam-serviceAccounts-user) role or higher to your {{ yandex-cloud }} account.


{% include [mdb-service-account-update](../../_includes/mdb/service-account-update.md) %}

For more information about setting up a service account, see [Configuring access to {{ objstorage-name }}](s3-access.md).

{% list tabs group=instructions %}

- Management console {#console}

    To change a service account linked to a {{ mos-name }} cluster:

    1. In the [management console]({{ link-console-main }}), navigate to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
    1. Select a cluster and click ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}** in the top panel.
    1. In the **{{ ui-key.yacloud.mdb.forms.base_field_service-account }}** field, select the account you need from the list or [create a new one](../../iam/operations/sa/create.md). For more information about setting up a service account, see [Configuring access to {{ objstorage-name }}](s3-access.md).
    1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To change a service account linked to a {{ mos-name }} cluster, run the command:

    ```bash
    {{ yc-mdb-os }} cluster update <cluster_name_or_ID> \
       --service-account-name <service_account_name>
    ```

    You can request the cluster name and ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    For more information about setting up a service account, see [Configuring access to {{ objstorage-name }}](s3-access.md).

- {{ TF }} {#tf}

    To change a service account linked to a {{ mos-name }} cluster:

    1. Open the current {{ TF }} configuration file that defines your infrastructure.

        For a complete list of available {{ mos-name }} cluster configuration fields, see the [{{ TF }} provider documentation]({{ tf-provider-mos }}).

    1. In the `service_account_id` field, specify the service account ID:

        ```hcl
        resource "yandex_mdb_opensearch_cluster" "<cluster_name>" {
            ...
            service_account_id = "<service_account_ID>"
        }
        ```

        For more information about setting up a service account, see [Configuring access to {{ objstorage-name }}](s3-access.md).

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm updating the resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Use the [Cluster.Update](../api-ref/Cluster/update.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

        {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-opensearch/v1/clusters/<cluster_ID>' \
            --data '{
                        "updateMask": "serviceAccountId",
                        "serviceAccountId": "<service_account_ID>"
                    }'
        ```

        Where:

        * `updateMask`: List of parameters to update as a single string, separated by commas.

            Only one parameter is provided in this case.

        * `serviceAccountId`: ID of the service account used for cluster operations.

        You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation) to make sure the request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
    1. Use the [ClusterService.Update](../api-ref/grpc/Cluster/update.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

        {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/opensearch/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                    "cluster_id": "<cluster_ID>",
                    "update_mask": {
                        "paths": [
                            "service_account_id"
                        ]
                    },
                    "service_account_id": "<service_account_ID>"
                }' \
        {{ api-host-mdb }}:{{ port-https }} \
        yandex.cloud.mdb.opensearch.v1.ClusterService.Update
        ```

        Where:

        * `update_mask`: List of parameters to update as an array of `paths[]` strings.

            Only one parameter is provided in this case.

        * `service_account_id`: ID of the service account used for cluster operations.

        You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}


## Changing the admin password {#change-admin-password}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), navigate to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
    1. Select a cluster and click ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}** in the top panel.
    1. In the **{{ ui-key.yacloud.mdb.forms.database_field_admin-password }}** field, enter a new password.
    1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To change the `admin` password for a cluster, enter a new password using one of these methods:

    * Entering a password as plain text (less secure method).

        ```bash
        {{ yc-mdb-os }} cluster update <cluster_name_or_ID> \
           --admin-password <new_password>
        ```

    * Generating a password automatically. The generated password will be output to the console.

        ```bash
        {{ yc-mdb-os }} cluster update <cluster_name_or_ID> \
           --generate-admin-password
        ```

    You can request the cluster name and ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file that defines your infrastructure.

        For a complete list of available {{ mos-name }} cluster configuration fields, see the [{{ TF }} provider documentation]({{ tf-provider-mos }}).

    1. In the `config` section, change the `admin_password` field value:

        ```hcl
        resource "yandex_mdb_opensearch_cluster" "<cluster_name>" {
            ...
            config {
                admin_password = "<new_admin_user_password>"
            }
        }
        ```

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm updating the resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Use the [Cluster.Update](../api-ref/Cluster/update.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

        {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-opensearch/v1/clusters/<cluster_ID>' \
            --data '{
                        "updateMask": "configSpec.adminPassword",
                        "configSpec": {
                            "adminPassword": "<new_password>"
                        }
                    }'
        ```

        Where:

        * `updateMask`: List of parameters to update as a single string, separated by commas.

            Only one parameter is provided in this case.

        * `configSpec.adminPassword`: New password for the `admin` user.

        You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation) to make sure the request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
    1. Use the [ClusterService.Update](../api-ref/grpc/Cluster/update.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

        {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/opensearch/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                    "cluster_id": "<cluster_ID>",
                    "update_mask": {
                        "paths": [
                            "config_spec.admin_password"
                        ]
                    },
                    "config_spec": {
                        "admin_password": "<new_password>"
                    }
                }' \
        {{ api-host-mdb }}:{{ port-https }} \
        yandex.cloud.mdb.opensearch.v1.ClusterService.Update
        ```

        Where:

        * `update_mask`: List of parameters to update as an array of `paths[]` strings.

            Only one parameter is provided in this case.

        * `config_spec.admin_password`: New password for the `admin` user.

        You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}

## Changing {{ OS }} settings {#change-opensearch-config}

{% list tabs group=instructions %}

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Run the following command with a list of settings to change:

    ```bash
    {{ yc-mdb-os }} cluster update <cluster_name_or_ID> \
       --max-clause-count <number_of_Boolean_clauses> \
       --fielddata-cache-size <JVM_heap_size> \
       --reindex-remote-whitelist <host_address>:<port>
    ```

    You can request the cluster name and ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    Command settings:

    * `--max-clause-count`: Maximum allowed number of boolean clauses per query. For more information, see the relevant [{{ OS }}]({{ os.docs }}/query-dsl/compound/bool/) documentation.
    * `--fielddata-cache-size`: JVM heap size allocated for the `fielddata` data structure. You can specify either an absolute value or percentage, e.g., `512mb` or `50%`. For more information, see the relevant [{{ OS }}]({{ os.docs }}/install-and-configure/configuring-opensearch/index-settings/#cluster-level-index-settings) documentation.
    * `--reindex-remote-whitelist`: List of remote hosts whose indexes contain documents to copy for reindexing. Specify the parameter value in `<host_address>:<port>` format. If you need to specify more than one host, list values separated by commas. For more information, see the relevant [{{ OS }}]({{ os.docs }}/im-plugin/reindex-data/#reindex-from-a-remote-cluster) documentation.

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Use the [Cluster.Update](../api-ref/Cluster/update.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

        {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-opensearch/v1/clusters/<cluster_ID>' \
            --data '{
                        "updateMask": "configSpec.opensearchSpec.opensearchConfig_2.maxClauseCount,configSpec.opensearchSpec.opensearchConfig_2.fielddataCacheSize,configSpec.opensearchSpec.opensearchConfig_2.reindexRemoteWhitelist",
                        "configSpec": {
                            "opensearchSpec": {
                                "opensearchConfig_2": {
                                    "maxClauseCount": "<number_of_Boolean_clauses>",
                                    "fielddataCacheSize": "<JVM_heap_size>",
                                    "reindexRemoteWhitelist": "<host_address>:9200"
                                }
                            }
                        }
                    }'
        ```

        Where:

        * `updateMask`: List of parameters to update as a single string, separated by commas.
        * `configSpec.opensearchSpec.opensearchConfig_2`: {{ OS }} settings:

            * `maxClauseCount`: New maximum allowed number of boolean clauses. For more information, see the relevant [{{ OS }}]({{ os.docs }}/query-dsl/compound/bool/) documentation.

            * `fielddataCacheSize`: New JVM heap size allocated for the `fielddata` data structure. You can specify either an absolute value or percentage, e.g., `512mb` or `50%`. For more information, see the relevant [{{ OS }}]({{ os.docs }}/install-and-configure/configuring-opensearch/) documentation.

            * `reindexRemoteWhitelist`: New list of remote hosts whose indexes contain documents to copy for reindexing. Specify [host FQDN](connect.md#fqdn) and port 9200, separated by a colon. To specify multiple hosts, list them separated by commas after the port. For more information, see the relevant [{{ OS }}]({{ os.docs }}/im-plugin/reindex-data/#reindex-from-a-remote-cluster) documentation.

        You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation) to make sure the request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
    1. Use the [ClusterService.Update](../api-ref/grpc/Cluster/update.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

        {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/opensearch/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                    "cluster_id": "<cluster_ID>",
                    "update_mask": {
                        "paths": [
                            "config_spec.opensearch_spec.opensearch_config_2.max_clause_count",
                            "config_spec.opensearch_spec.opensearch_config_2.fielddata_cache_size",
                            "config_spec.opensearch_spec.opensearch_config_2.reindex_remote_whitelist"
                        ]
                    },
                    "config_spec": {
                        "opensearch_spec": {
                            "opensearch_config_2": {
                                "max_clause_count": "<number_of_Boolean_clauses>",
                                "fielddata_cache_size": "<JVM_heap_size>",
                                "reindex_remote_whitelist": "<host_address>:9200"
                            }
                        }
                    }
                }' \
        {{ api-host-mdb }}:{{ port-https }} \
        yandex.cloud.mdb.opensearch.v1.ClusterService.Update
        ```

        Where:

        * `update_mask`: List of parameters to update as an array of `paths[]` strings.

            Only one parameter is provided in this case.

        * `config_spec.opensearch_spec.opensearch_config_2`: {{ OS }} settings:

            * `max_clause_count`: New maximum allowed number of boolean clauses. For more information, see the relevant [{{ OS }}]({{ os.docs }}/query-dsl/compound/bool/) documentation.

            * `fielddata_cache_size`: New JVM heap size allocated for the `fielddata` data structure. You can specify either an absolute value or percentage, e.g., `512mb` or `50%`. For more information, see the relevant [{{ OS }}]({{ os.docs }}/install-and-configure/configuring-opensearch/) documentation.

            * `reindex_remote_whitelist`: New list of remote hosts whose indexes contain documents to copy for reindexing. Specify [host FQDN](connect.md#fqdn) and port 9200, separated by a colon. To specify multiple hosts, list them separated by commas after the port. For more information, see the relevant [{{ OS }}]({{ os.docs }}/im-plugin/reindex-data/#reindex-from-a-remote-cluster) documentation.

        You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}

## Changing additional cluster settings {#change-additional-settings}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), navigate to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
    1. Select a cluster and click ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}** in the top panel.
    1. Change additional cluster settings:

        * **{{ ui-key.yacloud.mdb.forms.maintenance-window-type }}**: [Maintenance window](../concepts/maintenance.md) settings:

            {% include [Maintenance window](../../_includes/mdb/console/maintenance-window-description.md) %}


        * {% include [Deletion protection](../../_includes/mdb/console/deletion-protection.md) %}

            Even with cluster deletion protection enabled, one can still delete a user or connect to the cluster manually and delete the data.

    1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    Run the following command with a list of settings to change:

    ```bash
    {{ yc-mdb-os }} cluster update <cluster_name_or_ID> \
       --maintenance schedule=<maintenance_type>,`
                    `weekday=<day_of_week>,`
                    `hour=<hour> \
       --delete-protection \
       --data-transfer-access=<true_or_false> \
       --serverless-access=<true_or_false>
    ```

    You can request the cluster name and ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    Command settings:

    * `--maintenance`: [Maintenance window](../concepts/maintenance.md) settings (including for disabled clusters):

        * To allow maintenance at any time, specify `--maintenance schedule=anytime`.
        * To specify the preferred maintenance start time, specify `--maintenance schedule=weekly,weekday=<day_of_week>,hour=<hour_in_UTC>`. In this case, maintenance will take place every week on a specified day at a specified time.

            Possible `weekday` values: `mon`, `tue`, `wed`, `thu`, `fry`, `sat`, `sun`. In the `hour` parameter, specify the maintenance completion time. For example, if you set `14`, maintenance will take place from 13:00 until 14:00 UTC.

    * {% include [Deletion protection](../../_includes/mdb/cli/deletion-protection.md) %}

        Even with cluster deletion protection enabled, one can still delete a user or connect to the cluster manually and delete the data.


    * `--serverless-access`: Access from [{{ serverless-containers-full-name }}](../../serverless-containers/index.yaml), `true` or `false`.

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file that defines your infrastructure.

        For a complete list of available {{ mos-name }} cluster configuration fields, see the [{{ TF }} provider documentation]({{ tf-provider-mos }}).

    1. To change the [maintenance](../concepts/maintenance.md) time (including for disabled clusters), specify the following settings in the `maintenance_window` parameter:

        ```hcl
        resource "yandex_mdb_opensearch_cluster" "<cluster_name>" {
            ...
            maintenance_window {
                type = "<maintenance_frequency>"
                hour = <hour>
                day = "<day_of_week>"
            }
        }
        ```

        Specify the following in the parameters:

        * `type`: `ANYTIME` to allow maintenance at any time or `WEEKLY` to perform maintenance every week.
        * `hour`: Maintenance completion hour, UTC. For example, if you set `14`, maintenance will take place from 13:00 until 14:00 UTC.
        * `day`: Day of week for maintenance. Possible values: `MON`, `TUE`, `WED`, `THU`, `FRI`, `SAT`, `SUN`.

    1. To enable cluster protection against accidental deletion by a user of your cloud, add the `deletion_protection` field set to `true` to your cluster description:

        ```hcl
        resource "yandex_mdb_opensearch_cluster" "<cluster_name>" {
            ...
            deletion_protection = <true_or_false>
        }
        ```

        Where `deletion_protection` is the protection against accidental cluster deletion.

        Even with cluster deletion protection enabled, one can still delete a user or connect to the cluster manually and delete the data.

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm updating the resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Use the [Cluster.Update](../api-ref/Cluster/update.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

        {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

        
        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-opensearch/v1/clusters/<cluster_ID>' \
            --data '{
                        "updateMask": "configSpec.access,deletionProtection,maintenanceWindow",
                        "configSpec": {
                            "access": {
                                "dataTransfer": <access_from_Data_Transfer:_true_or_false>,
                                "serverless": <access_from_Serverless_Containers:_true_or_false>
                            }
                        },
                        "deletionProtection": <cluster_deletion_protection:_true_or_false>,
                        "maintenanceWindow": {
                            "weeklyMaintenanceWindow": {
                                "day": "<day_of_week>",
                                "hour": "<hour>"
                            }
                        }
                    }'
        ```


        Where:

        * `updateMask`: List of parameters to update as a single string, separated by commas.

        
        * `access`: Cluster settings for access to the following {{ yandex-cloud }} services:

            * `dataTransfer`: [{{ data-transfer-full-name }}](../../data-transfer/index.yaml)
            * `serverless`: [{{ serverless-containers-full-name }}](../../serverless-containers/index.yaml)


        * `deletionProtection`: Cluster protection from accidental deletion.

            Even with cluster deletion protection enabled, one can still delete a user or connect to the cluster manually and delete the data.

        * `maintenanceWindow.weeklyMaintenanceWindow`: Maintenance window schedule:

            * `day`: Day of week, in `DDD` format, for scheduled maintenance.
            * `hour`: Hour, in `HH` format, for scheduled maintenance. The possible values range from `1` to `24`. Use the UTC time zone.

        You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation) to make sure the request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
    1. Use the [ClusterService.Update](../api-ref/grpc/Cluster/update.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

        {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

        
        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/opensearch/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                    "cluster_id": "<cluster_ID>",
                    "update_mask": {
                        "paths": [
                            "config_spec.access",
                            "deletion_protection",
                            "maintenance_window"
                        ]
                    },
                    "config_spec": {
                        "access": {
                            "data_transfer": <access_from_Data_Transfer:_true_or_false>,
                            "serverless": <access_from_Serverless_Containers:_true_or_false>
                        }
                    },
                    "deletion_protection": <cluster_deletion_protection:_true_or_false>,
                    "maintenance_window": {
                        "weekly_maintenance_window": {
                            "day": "<day_of_week>",
                            "hour": "<hour>"
                        }
                    }
                }' \
        {{ api-host-mdb }}:{{ port-https }} \
        yandex.cloud.mdb.opensearch.v1.ClusterService.Update
        ```


        Where:

        * `update_mask`: List of parameters to update as an array of `paths[]` strings.

            Only one parameter is provided in this case.

        
        * `access`: Cluster settings for access to the following {{ yandex-cloud }} services:

            * `data_transfer`: [{{ data-transfer-full-name }}](../../data-transfer/index.yaml)
            * `serverless`: [{{ serverless-containers-full-name }}](../../serverless-containers/index.yaml)


        * `deletion_protection`: Cluster protection from accidental deletion.

            Even with cluster deletion protection enabled, one can still delete a user or connect to the cluster manually and delete the data.

        * `maintenance_window.weekly_maintenance_window`: Maintenance window schedule:

            * `day`: Day of week, in `DDD` format, for scheduled maintenance.
            * `hour`: Hour, in `HH` format, for scheduled maintenance. The possible values range from `1` to `24`. Use the UTC time zone.

        You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}


## Changing security groups {#change-sg-set}

After you assign other [security groups](../concepts/network.md#security-groups), you may need to [additionally set them up](connect.md#security-groups) to connect to the cluster.

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), navigate to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-opensearch }}**.
    1. Select a cluster and click ![image](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.mdb.cluster.overview.button_action-edit }}** in the top panel.
    1. Under **{{ ui-key.yacloud.mdb.forms.section_network-settings }}**, select security groups for cluster network traffic.
    1. Click **{{ ui-key.yacloud.common.save }}**.

- CLI {#cli}

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To edit the list of security groups for a cluster, specify the security groups you need in the command:

    ```bash
    {{ yc-mdb-os }} cluster update <cluster_name_or_ID> \
       --security-group-ids <list_of_security_group_IDs>
    ```

    If you need to specify more than one group, list them separated by commas.

    You can request the cluster name and ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

    1. Open the current {{ TF }} configuration file that defines your infrastructure.

        For a complete list of available {{ mos-name }} cluster configuration fields, see the [{{ TF }} provider documentation]({{ tf-provider-mos }}).

    1. In the `security_group_ids` field, list the security group IDs separated by commas:

        ```hcl
        resource "yandex_mdb_opensearch_cluster" "<cluster_name>" {
            ...
            security_group_ids = [ "<security_groups>" ]
        }
        ```

    1. Make sure the settings are correct.

        {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

    1. Confirm updating the resources.

        {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Use the [Cluster.Update](../api-ref/Cluster/update.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

        {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

        ```bash
        curl \
            --request PATCH \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-opensearch/v1/clusters/<cluster_ID>' \
            --data '{
                        "updateMask": "securityGroupIds",
                        "securityGroupIds": [
                            "<security_group_1_ID>",
                            "<security_group_2_ID>",
                            ...
                            "<security_group_N_ID>"
                        ]
                    }'
        ```

        Where:

        * `updateMask`: List of parameters to update as a single string, separated by commas.

            Only one parameter is provided in this case.

        * `securityGroupIds`: Security group IDs.

        You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/Cluster/update.md#yandex.cloud.operation.Operation) to make sure the request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
    1. Use the [ClusterService.Update](../api-ref/grpc/Cluster/update.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

        {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/opensearch/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                    "cluster_id": "<cluster_ID>",
                    "update_mask": {
                        "paths": [
                            "security_group_ids"
                        ]
                    },
                    "security_group_ids": [
                        "<security_group_1_ID>",
                        "<security_group_2_ID>",
                        ...
                        "<security_group_N_ID>"
                    ]
                }' \
        {{ api-host-mdb }}:{{ port-https }} \
        yandex.cloud.mdb.opensearch.v1.ClusterService.Update
        ```

        Where:

        * `update_mask`: List of parameters to update as an array of `paths[]` strings.

            Only one parameter is provided in this case.

        * `security_group_ids`: Security group IDs.

        You can request the cluster ID with the [list of clusters in the folder](cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/grpc/Cluster/update.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}

