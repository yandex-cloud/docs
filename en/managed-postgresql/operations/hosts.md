---
title: Managing {{ PG }} cluster hosts
description: In this tutorial, you will learn how to manage {{ PG }} cluster hosts. You can add and delete cluster hosts and manage their settings via the management console, CLI, and API.
---

# Managing {{ PG }} cluster hosts

You can add and remove cluster hosts and manage their settings. For information about moving cluster hosts to a different [availability zone](../../overview/concepts/geo-scope.md), see [this guide](host-migration.md).

## Getting a list of cluster hosts {#list}

{% list tabs group=instructions %}

- Management console {#console}

  1. Go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Click the name of the cluster you need and select the **{{ ui-key.yacloud.postgresql.cluster.switch_hosts }}** tab.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get a list of cluster hosts, run the command:

  ```bash
  {{ yc-mdb-pg }} host list \
    --cluster-name <cluster_name>
  ```

  Result:


  ```text
  +----------------------------+----------------------+---------+--------+--------------------+
  |            NAME            |      CLUSTER ID      |  ROLE   | HEALTH |      ZONE ID       |
  +----------------------------+----------------------+---------+--------+--------------------+
  | rc1b***{{ dns-zone }} | c9qp71dk1dfg******** | MASTER  | ALIVE  | {{ region-id }}-b      |
  | rc1a***{{ dns-zone }} | c9qp71dk1dfg******** | REPLICA | ALIVE  | {{ region-id }}-a      |
  +----------------------------+----------------------+---------+--------+--------------------+
  ```


  You can request the cluster name with the [list of clusters in the folder](cluster-list.md#list-clusters).

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Use the [Cluster.listHosts](../api-ref/Cluster/listHosts.md) method and make a request, e.g., via {{ api-examples.rest.tool }}:

     ```bash
     curl \
       --request GET \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/<cluster_ID>/hosts'
     ```

     You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/Cluster/listHosts.md#responses) to make sure the request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Use the [ClusterService/ListHosts](../api-ref/grpc/Cluster/listHosts.md) call and make a request, e.g., via {{ api-examples.grpc.tool }}:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<cluster_ID>"
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.postgresql.v1.ClusterService.ListHosts
     ```

     You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/grpc/Cluster/listHosts.md#yandex.cloud.mdb.postgresql.v1.ListClusterHostsResponse) to make sure the request was successful.

{% endlist %}

## Creating a host {#add}

The number of hosts in {{ mpg-short-name }} clusters is limited by the CPU and RAM quotas available to DB clusters in your cloud. To check the resources in use, open the [{{ ui-key.yacloud.iam.cloud.switch_quotas }}]({{ link-console-quotas }}) page and find the **{{ ui-key.yacloud.iam.folder.dashboard.label_mdb }}** section.

{% list tabs group=instructions %}

- Management console {#console}

  To create a host:
  1. Go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Click the cluster name and go to the **{{ ui-key.yacloud.postgresql.cluster.switch_hosts }}** tab.
  1. Click **{{ ui-key.yacloud.mdb.cluster.hosts.action_add-host }}**.


  1. Specify the host parameters:
     * Availability zone.
     * Subnet (if the required subnet is not on the list, [create it](../../vpc/operations/subnet-create.md)).
     * Replication source (if you use [cascading replication](../concepts/replication.md#replication-manual)).
     * Select **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}** if the host must be accessible from outside {{ yandex-cloud }}.


- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To create a host:


  1. Request a list of cluster subnets to select one for the new host:

     ```bash
     yc vpc subnet list
     ```

     Result:

     ```text
     +----------------------+-----------+----------------------+---------------+-------------------+
     |          ID          |   NAME    |      NETWORK ID      |      ZONE     |      RANGE        |
     +----------------------+-----------+----------------------+---------------+-------------------+
     | b0cl69q1w2e3******** | default-d | enp6rq71w2e3******** | {{ region-id }}-d | [172.16.**.**/20] |
     | e2lkj9q1w2e3******** | default-b | enp6rq71w2e3******** | {{ region-id }}-b | [10.10.**.**/16]  |
     | e9b0phq1w2e3******** | a-2       | enp6rq71w2e3******** | {{ region-id }}-a | [172.16.**.**/20] |
     | e9b9v2q1w2e3******** | default-a | enp6rq71w2e3******** | {{ region-id }}-a | [172.16.**.**/20] |
     +----------------------+-----------+----------------------+---------------+-------------------+
     ```

     If the required subnet is not in the list, [create it](../../vpc/operations/subnet-create.md).


  1. View a description of the CLI command for adding a host:

     ```bash
     {{ yc-mdb-pg }} host add --help
     ```

  1. Run the add host command:


     ```bash
     {{ yc-mdb-pg }} host add
       --cluster-name <cluster_name>
       --host zone-id=<availability_zone>,subnet-id=<subnet_ID>
     ```



     The subnet ID should be specified if the availability zone contains multiple subnets; otherwise, {{ mpg-short-name }} will automatically select a single subnet. You can request the cluster name with the [list of clusters in the folder](cluster-list.md#list-clusters).


     You can also specify several additional options in the `--host` parameter to manage public access to a host and replication in a cluster:
     * Replication source for the host in the `replication-source` option to [manually manage replication threads](../concepts/replication.md#replication-manual).
     * Host availability from outside {{ yandex-cloud }} in the `assign-public-ip` option:
       * `true`: Public access enabled.
       * `false`: Public access disabled.

  {{ mpg-short-name }} will run the add host operation.

- {{ TF }} {#tf}

  To create a host:
  1. Open the current {{ TF }} configuration file with an infrastructure plan.

     For more information about creating this file, see [Creating clusters](cluster-create.md).

     For a complete list of available {{ mpg-name }} cluster configuration fields, see the [{{ TF }} provider documentation]({{ tf-provider-mpg }}).
  1. Add a `host` section to the {{ mpg-name }} cluster description:

     ```hcl
     resource "yandex_mdb_postgresql_cluster" "<cluster_name>" {
       ...
       host {
         name                    = "<host_name>"
         zone                    = "<availability_zone>"
         subnet_id               = "<subnet_ID>"
         replication_source_name = "<replication_source>"
         assign_public_ip        = <public_access_to_host>
       }
     }
     ```

     Where:

     * `name`: Host name.
     * `zone`: Availability zone.
     * `subnet_id`: Subnet ID.
     * `replication_source_name`: Replication source, i.e., the `name` attribute of the corresponding `host` section.
     * `assign_public_ip`: [Public access to the host](../concepts/network.md#public-access-to-a-host), `true` or `false`.

  1. Make sure the settings are correct.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

     {% include [Terraform timeouts](../../_includes/mdb/mpg/terraform/timeouts.md) %}

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Use the [Cluster.addHosts](../api-ref/Cluster/addHosts.md) method and make a request, e.g., via {{ api-examples.rest.tool }}:

     ```bash
     curl \
       --request POST \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/<cluster_ID>/hosts:batchCreate' \
       --data '{
                 "hostSpecs": [
                   {
                     "zoneId": "<availability_zone>",
                     "subnetId": "<subnet_ID>",
                     "assignPublicIp": <public_host_address:_true_or_false>,
                     "replicationSource": "<host_FQDN>",
                     "priority": "<host_priority>",
                     "configSpec": {
                       "postgresqlConfig_<{{ PG }}_version>": {
                         <{{ PG }}_settings>
                       }
                     }
                   },
                   { <similar_settings_for_new_host_2> },
                   { ... },
                   { <similar_settings_for_new_host_N> }
                 ]
               }'
     ```

     Where `hostSpecs` is an array of new hosts. One array element contains settings for a single host and has the following structure:

     * `zoneId`: Availability zone.
     * `subnetId`: Subnet ID.
     * `assignPublicIp`: Internet access to the host via a public IP address.
     * `replicationSource`: Replication source for the host to [manually manage replication threads](../concepts/replication.md#replication-manual). In the parameter, specify the [FQDN of the host](connect.md#special-fqdns) to be used as a replication source.
     * `priority`: Host priority among all hosts.
     * `configSpec.postgresqlConfig_<{{ PG }}_version>`: {{ PG }} settings. Use a separate line for each setting; separate them by commas.

       See the [method description](../api-ref/Cluster/addHosts.md#body_params) for the list of {{ PG }} versions available for the parameter. See [{#T}](../concepts/settings-list.md) for a description and possible values for each setting.

     You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/Cluster/addHosts.md#responses) to make sure the request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Use the [ClusterService/AddHosts](../api-ref/grpc/Cluster/addHosts.md) call and make a request, e.g., via {{ api-examples.grpc.tool }}:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<cluster_ID>",
             "host_specs": [
               {
                 "zone_id": "<availability_zone>",
                 "subnet_id": "<subnet_ID>",
                 "assign_public_ip": <public_host_address:_true_or_false>,
                 "replication_source": "<host_FQDN>",
                 "priority": "<host_priority>",
                 "config_spec": {
                   "postgresql_config_<{{ PG }}_version>": {
                     <{{ PG }}_settings>
                   }
                 }
               },
               { <similar_settings_for_new_host_2> },
               { ... },
               { <similar_settings_for_new_host_N> }
             ]
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.postgresql.v1.ClusterService.AddHosts
     ```

     Where `host_specs` is an array of new hosts. One array element contains settings for a single host and has the following structure:

     * `zone_id`: Availability zone.
     * `subnet_id`: Subnet ID.
     * `assign_public_ip`: Internet access to the host via a public IP address.
     * `replication_source`: Replication source for the host to [manually manage replication threads](../concepts/replication.md#replication-manual). In the parameter, specify the [FQDN of the host](connect.md#special-fqdns) to be used as a replication source.
     * `priority`: Host priority among all hosts.
     * `config_spec.postgresql_config_<{{ PG }}_version>`: {{ PG }} settings. Use a separate line for each setting; separate them by commas.

       See the [method description](../api-ref/grpc/Cluster/create.md#yandex.cloud.mdb.postgresql.v1.ConfigHostSpec) for the list of {{ PG }} versions available for the parameter. See [{#T}](../concepts/settings-list.md) for a description and possible values for each setting.

     You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}


{% note warning %}

If you cannot [connect](connect.md) to the host you added, check that the cluster [security group](../concepts/network.md#security-groups) is configured correctly for the host's subnet.

{% endnote %}


## Changing a host {#update}

For each host in a {{ mpg-short-name }} cluster, you can specify the [replication](../concepts/replication.md) source and manage host [public access](../concepts/network.md#public-access-to-a-host).

{% list tabs group=instructions %}

- Management console {#console}

  To change the parameters of the cluster host:
  1. Go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Click the cluster name and open the **{{ ui-key.yacloud.postgresql.cluster.switch_hosts }}** tab.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) in the host's row and select **{{ ui-key.yacloud.common.edit }}**.
  1. Set new settings for the host:
     1. Select the replication source for the host to [manually manage replication threads](../concepts/replication.md#replication-manual).
     1. Enable **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}** if the host must be accessible from outside {{ yandex-cloud }}.
  1. Click **{{ ui-key.yacloud.postgresql.hosts.dialog.button_choose }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To change the parameters of a host in a cluster, run the command below:

  ```bash
  {{ yc-mdb-pg }} host update <host_name>
    --cluster-name <cluster_name>
    --replication-source <source_host_name>
    --assign-public-ip=<public_access_to_host>
  ```

  Where:

  * `cluster-name`: Cluster name.
  * `replication-source`: Source host name.
  * `assign-public-ip`: [Public access to the host](../concepts/network.md#public-access-to-a-host), `true` or `false`.

  You can request the host name with a [list of cluster hosts](#list), and the cluster name, with a [list of clusters in the folder](cluster-list.md#list-clusters).

  To [manually manage replication threads](../concepts/replication.md#replication-manual) in the cluster, change the host's replication source in the `--replication-source` parameter.

- {{ TF }} {#tf}

  To change the parameters of the cluster host:
  1. Open the current {{ TF }} configuration file with an infrastructure plan.

     For more information about creating this file, see [Creating clusters](cluster-create.md).

     For a complete list of available {{ mpg-name }} cluster configuration fields, see the [{{ TF }} provider documentation]({{ tf-provider-mpg }}).
  1. In the {{ mpg-name }} cluster description, change the attributes of the `host` block corresponding to the host you are updating.

     ```hcl
     resource "yandex_mdb_postgresql_cluster" "<cluster_name>" {
       ...
       host {
         replication_source_name = "<replication_source>"
         assign_public_ip        = <public_access_to_host>
       }
     }
     ```

  Where:

  * `replication_source_name`: Replication source, i.e., the `name` attribute of the corresponding `host` section.
  * `assign_public_ip`: [Public access to the host](../concepts/network.md#public-access-to-a-host), `true` or `false`.

  1. Make sure the settings are correct.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

     {% include [Terraform timeouts](../../_includes/mdb/mpg/terraform/timeouts.md) %}

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Use the [Cluster.updateHosts](../api-ref/Cluster/updateHosts.md) method and make a request, e.g., via {{ api-examples.rest.tool }}:

     {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

     ```bash
     curl \
       --request POST \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/<cluster_ID>/hosts:batchUpdate' \
       --data '{
                 "updateHostSpecs": [
                   {
                     "updateMask": "assignPublicIp,replicationSource,priority,configSpec.postgresqlConfig_<{{ PG }}>_version",
                     "hostName": "<host_FQDN>",
                     "assignPublicIp": <public_host_address:_true_or_false>,
                     "replicationSource": "<host_FQDN>",
                     "priority": "<host_priority>",
                     "configSpec": {
                       "postgresqlConfig_<{{ PG }}_version>": {
                         <{{ PG }}_settings>
                       }
                     }
                   },
                   { <similar_settings_for_host_2_being_changed> },
                   { ... },
                   { <similar_settings_for_host_N_being_changed> }
                 ]
               }'
     ```

     Where `updateHostSpecs` is an array of hosts being changed. One array element contains settings for a single host and has the following structure:

     * `updateMask`: List of parameters to update as a single string, separated by commas.
     * `hostName`: [FQDN of a host being changed](connect.md#fqdn).
     * `assignPublicIp`: Internet access to the host via a public IP address, `true` or `false`.
     * `replicationSource`: Replication source for the host to [manually manage replication threads](../concepts/replication.md#replication-manual). In the parameter, specify the FQDN of the host to be used as a replication source.
     * `priority`: Host priority among all hosts.
     * `configSpec.postgresqlConfig_<{{ PG }}_version>`: {{ PG }} settings. Use a separate line for each setting; separate them by commas.

       See the [method description](../api-ref/Cluster/updateHosts.md#body_params) for the list of {{ PG }} versions available for the parameter. See [{#T}](../concepts/settings-list.md) for a description and possible values for each setting.

     You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/Cluster/updateHosts.md#responses) to make sure the request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Use the [ClusterService/UpdateHosts](../api-ref/grpc/Cluster/updateHosts.md) call and make a request, e.g., via {{ api-examples.grpc.tool }}:

     {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<cluster_ID>",
             "update_host_specs": [
               {
                 "update_mask": {
                     "paths": [
                       "assign_public_ip",
                       "replication_source",
                       "priority",
                       "config_spec.postgresql_config_16"
                     ]
                 },
                 "host_name": "<host_FQDN>",
                 "assign_public_ip": <public_host_address:_true_or_false>,
                 "replication_source": "<host_FQDN>",
                 "priority": "<host_priority>",
                 "config_spec": {
                   "postgresql_config_<{{ PG }}_version>": {
                     <{{ PG }}_settings>
                   }
                 }
               }
             ]
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.postgresql.v1.ClusterService.UpdateHosts
     ```

     Where `update_host_specs` is an array of hosts being changed. One array element contains settings for a single host and has the following structure:

     * `update_mask`: List of parameters to update as an array of `paths[]` strings.
     * `host_name`: [FQDN of a host being changed](connect.md#fqdn).
     * `assign_public_ip`: Internet access to the host via a public IP address, `true` or `false`.
     * `replication_source`: Replication source for the host to [manually manage replication threads](../concepts/replication.md#replication-manual). In the parameter, specify the FQDN of the host to be used as a replication source.
     * `priority`: Host priority among all hosts.
     * `config_spec.postgresql_config_<{{ PG }}_version>`: {{ PG }} settings. Use a separate line for each setting; separate them by commas.

       See the [method description](../api-ref/grpc/Cluster/create.md#yandex.cloud.mdb.postgresql.v1.ConfigHostSpec) for the list of {{ PG }} versions available for the parameter. See [{#T}](../concepts/settings-list.md) for a description and possible values for each setting.

     You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}


{% note warning %}

If you cannot [connect](connect.md) to the host after you changed it, check that the cluster [security group](../concepts/network.md#security-groups) is configured correctly for the host's subnet.

{% endnote %}


## Removing a host {#remove}

You can remove a host from a {{ PG }} cluster if it is not the only host in it. To replace a single host, first create a new host and then remove the old one.

If the host is the master at the time of deletion, {{ mpg-short-name }} will automatically assign the next highest priority replica as the master.

{% list tabs group=instructions %}

- Management console {#console}

  To remove a host from a cluster:
  1. Go to the folder page and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Click the cluster name and open the **{{ ui-key.yacloud.postgresql.cluster.switch_hosts }}** tab.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) in the host's row, select **{{ ui-key.yacloud.common.delete }}**, and confirm the deletion.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To remove a host from the cluster, run:

  ```bash
  {{ yc-mdb-pg }} host delete <host_name>
    --cluster-name <cluster_name>
  ```

  You can request the host name with a [list of cluster hosts](#list), and the cluster name, with a [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

  To remove a host from a cluster:
  1. Open the current {{ TF }} configuration file with an infrastructure plan.

     For more information about creating this file, see [Creating clusters](cluster-create.md).

     For a complete list of available {{ mpg-name }} cluster configuration fields, see the [{{ TF }} provider documentation]({{ tf-provider-mpg }}).
  1. Delete the corresponding `host` block from the {{ mpg-name }} cluster description.
  1. Make sure the settings are correct.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Type `yes` and press **Enter**.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

     {% include [Terraform timeouts](../../_includes/mdb/mpg/terraform/timeouts.md) %}

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Use the [Cluster.deleteHosts](../api-ref/Cluster/deleteHosts.md) method and make a request, e.g., via {{ api-examples.rest.tool }}:

     ```bash
     curl \
       --request POST \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --header "Content-Type: application/json" \
       --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/<cluster_ID>/hosts:batchDelete' \
       --data '{
                 "hostNames": [
                   "<host_FQDN>"
                 ]
               }'
     ```

     Where `hostNames` is an array of strings, each containing the [FQDN of the host being deleted](connect.md#fqdn).

     You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/Cluster/deleteHosts.md#responses) to make sure the request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it into the environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Use the [ClusterService/DeleteHosts](../api-ref/grpc/Cluster/deleteHosts.md) call and make a request, e.g., via {{ api-examples.grpc.tool }}:

     ```bash
     grpcurl \
       -format json \
       -import-path ~/cloudapi/ \
       -import-path ~/cloudapi/third_party/googleapis/ \
       -proto ~/cloudapi/yandex/cloud/mdb/postgresql/v1/cluster_service.proto \
       -rpc-header "Authorization: Bearer $IAM_TOKEN" \
       -d '{
             "cluster_id": "<cluster_ID>",
             "host_names": [
               "<host_FQDN>"
             ]
           }' \
       {{ api-host-mdb }}:{{ port-https }} \
       yandex.cloud.mdb.postgresql.v1.ClusterService.DeleteHosts
     ```

     Where `host_names` is an array of strings, each containing the [FQDN of the host being deleted](connect.md#fqdn).

     You can get the cluster ID with a [list of clusters in the folder](cluster-list.md#list-clusters).

  1. View the [server response](../api-ref/grpc/Cluster/create.md#yandex.cloud.operation.Operation) to make sure the request was successful.

{% endlist %}