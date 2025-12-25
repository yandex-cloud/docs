---
title: Managing {{ PG }} cluster hosts
description: In this tutorial, you will learn how to manage {{ PG }} cluster hosts. You can add and remove cluster hosts, as well as manage their settings via the management console, CLI, and API.
---

# Managing {{ PG }} cluster hosts

You can add and remove cluster hosts, as well as manage their settings. For instructions on migrating cluster hosts to a different [availability zone](../../overview/concepts/geo-scope.md), see [this guide](host-migration.md).

## Getting a list of cluster hosts {#list}

{% list tabs group=instructions %}

- Management console {#console}

  1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Click the name of your cluster and open the **{{ ui-key.yacloud.postgresql.cluster.switch_hosts }}** tab.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To get a list of cluster hosts, run this command:

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


  You can get the cluster name from the [folder’s cluster list](cluster-list.md#list-clusters).

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [Cluster.ListHosts](../api-ref/Cluster/listHosts.md) method, for instance, via the following {{ api-examples.rest.tool }} request:

     ```bash
     curl \
       --request GET \
       --header "Authorization: Bearer $IAM_TOKEN" \
       --url 'https://{{ api-host-mdb }}/managed-postgresql/v1/clusters/<cluster_ID>/hosts'
     ```

     You can get the cluster ID from the [folder’s cluster list](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/Cluster/listHosts.md#yandex.cloud.mdb.postgresql.v1.ListClusterHostsResponse) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Call the [ClusterService.ListHosts](../api-ref/grpc/Cluster/listHosts.md) method, for instance, via the following {{ api-examples.grpc.tool }} request:

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

     You can get the cluster ID from the [folder’s cluster list](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/grpc/Cluster/listHosts.md#yandex.cloud.mdb.postgresql.v1.ListClusterHostsResponse) to make sure your request was successful.

{% endlist %}

## Creating a host {#add}

The number of hosts in {{ mpg-short-name }} clusters is limited by the CPU and RAM quotas allocated to database clusters in your cloud. To review your resource usage, open the [{{ ui-key.yacloud.iam.cloud.switch_quotas }}]({{ link-console-quotas }}) page and find the **{{ ui-key.yacloud.iam.folder.dashboard.label_mdb }}** section.

{% list tabs group=instructions %}

- Management console {#console}

  To create a host:
  1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Click the name of your cluster and open the **{{ ui-key.yacloud.postgresql.cluster.switch_hosts }}** tab.
  1. Click **{{ ui-key.yacloud.mdb.cluster.hosts.action_add-host }}**.

  
  1. Specify your host parameters:
     * Availability zone.
     * Subnet (select a subnet from the list or [create a new subnet](../../vpc/operations/subnet-create.md)).
     * Replication source (if you use [cascading replication](../concepts/replication.md#replication-manual)).
     * If needed, select **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}** to enable external access to the host from outside {{ yandex-cloud }}.


- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To create a host:

  
  1. To choose a subnet for your new host, first get the list of all cluster subnets:

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

     If the required subnet is not on the list, [create it](../../vpc/operations/subnet-create.md).


  1. See the description of the CLI command for adding a host:

     ```bash
     {{ yc-mdb-pg }} host add --help
     ```

  1. Run the command for adding a host:

     
     ```bash
     {{ yc-mdb-pg }} host add \
       --cluster-name <cluster_name> \
       --host zone-id=<availability_zone>,subnet-id=<subnet_ID>
     ```


     
     If your availability zone contains multiple subnets, make sure to specify the subnet ID; otherwise, {{ mpg-short-name }} will select the subnet automatically. You can get the cluster name from the [folder’s cluster list](cluster-list.md#list-clusters).


     You can specify extra options in the `--host` argument to manage public access to the host and cluster replication:
     * Use the host’s `replication-source` option for [manual replication stream management](../concepts/replication.md#replication-manual).
     * Use the `assign-public-ip` option to make the host accessible from outside {{ yandex-cloud }}:
       * `true`: Public access enabled.
       * `false`: Public access disabled.

  {{ mpg-short-name }} will start the host addition process.

- {{ TF }} {#tf}

  To create a host:
  1. Open the current {{ TF }} configuration file describing your infrastructure.

     To learn how to create this file, see [Creating clusters](cluster-create.md).

     For a complete list of configurable {{ mpg-name }} cluster fields, refer to the [{{ TF }} provider guides]({{ tf-provider-mpg }}).
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
     * `replication_source_name`: Replication source, i.e., the `name` attribute of the relevant `host` section.
     * `assign_public_ip`: [Public access to the host](../concepts/network.md#public-access-to-a-host), `true` or `false`.

  1. Validate your configuration.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm resource changes.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

     {% include [Terraform timeouts](../../_includes/mdb/mpg/terraform/timeouts.md) %}

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [Cluster.AddHosts](../api-ref/Cluster/addHosts.md) method, for instance, via the following {{ api-examples.rest.tool }} request:

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
                     "assignPublicIp": <allow_public_access_to_host>,
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

     Where `hostSpecs` is an array of new hosts. Each array element contains the configuration for a single host and has the following structure:

     * `zoneId`: Availability zone.
     * `subnetId`: Subnet ID.
     * `assignPublicIp`: Internet access to the host via a public IP address, `true` or `false`.
     * `replicationSource`: Host’s replication source for [manual replication stream management](../concepts/replication.md#replication-manual). Specify the [FQDN of the host](connect.md#special-fqdns) that will be used as the replication source.
     * `priority`: Host priority relative to all other hosts.
     * `configSpec.postgresqlConfig_<{{ PG }}_version>`: {{ PG }} settings. Specify each setting on a separate line, separated by commas.

       See the [method description](../api-ref/Cluster/addHosts.md#yandex.cloud.mdb.postgresql.v1.AddClusterHostsRequest) for the list of {{ PG }} versions supporting this option. See [{#T}](../concepts/settings-list.md) for descriptions and possible values of the settings.

     You can get the cluster ID from the [folder’s cluster list](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/Cluster/addHosts.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Call the [ClusterService.AddHosts](../api-ref/grpc/Cluster/addHosts.md) method, for instance, via the following {{ api-examples.grpc.tool }} request:

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
                 "assign_public_ip": <allow_public_access_to_host>,
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

     Where `host_specs` is an array of new hosts. Each array element contains the configuration for a single host and has the following structure:

     * `zone_id`: Availability zone.
     * `subnet_id`: Subnet ID.
     * `assign_public_ip`: Internet access to the host via a public IP address, `true` or `false`.
     * `replication_source`: Host’s replication source for [manual replication stream management](../concepts/replication.md#replication-manual). Specify the [FQDN of the host](connect.md#special-fqdns) that will be used as the replication source.
     * `priority`: Host priority relative to all other hosts.
     * `config_spec.postgresql_config_<{{ PG }}_version>`: {{ PG }} settings. Enter each setting on a new line, separated by commas.

       See the [method description](../api-ref/grpc/Cluster/create.md#yandex.cloud.mdb.postgresql.v1.ConfigHostSpec) for the list of {{ PG }} versions supporting this option. See [{#T}](../concepts/settings-list.md) for descriptions and possible values of the settings.

     You can get the cluster ID from the [folder’s cluster list](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/grpc/Cluster/addHosts.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}


{% note warning %}

If you cannot [connect](connect.md) to the host you added, check that the cluster [security group](../concepts/network.md#security-groups) is properly configured for the subnet containing your host.

{% endnote %}


## Updating a host {#update}

In a {{ mpg-short-name }} cluster, you can configure the [replication](../concepts/replication.md) source and [public access](../concepts/network.md#public-access-to-a-host) for each host.

{% list tabs group=instructions %}

- Management console {#console}

  To change the cluster host settings:
  1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Click the name of your cluster and open the **{{ ui-key.yacloud.postgresql.cluster.switch_hosts }}** tab.
  1. Find the host you need in the list, click ![image](../../_assets/console-icons/ellipsis.svg) in its row, then select **{{ ui-key.yacloud.common.edit }}**.
  1. Specify new host settings:
     1. Select the host’s replication source for [manual replication stream management](../concepts/replication.md#replication-manual).

     
     1. If needed, check **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}** to enable external access to the host from outside {{ yandex-cloud }}.


  1. Click **{{ ui-key.yacloud.postgresql.hosts.dialog.button_choose }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To update the cluster host’s settings, run the following command:

  ```bash
  {{ yc-mdb-pg }} host update <host_name> \
    --cluster-name <cluster_name> \
    --replication-source <source_host_name> \
    --assign-public-ip=<public_access_to_host>
  ```

  Where:

  * `cluster-name`: Cluster name.
  * `replication-source`: Replication source host name.
  * `assign-public-ip`: [Public access to the host](../concepts/network.md#public-access-to-a-host), `true` or `false`.

  You can get the host name from the [cluster’s host list](#list), and the cluster name from the [folder’s cluster list](cluster-list.md#list-clusters).

  For [manual replication stream management](../concepts/replication.md#replication-manual) within your cluster, change the value of the host's `--replication-source` argument.

- {{ TF }} {#tf}

  To change the cluster host settings:
  1. Open the current {{ TF }} configuration file describing your infrastructure.

     To learn how to create this file, see [Creating clusters](cluster-create.md).

     For a complete list of configurable {{ mpg-name }} cluster fields, refer to the [{{ TF }} provider guides]({{ tf-provider-mpg }}).
  1. In the {{ mpg-name }} cluster description, change the attributes of the `host` block referring to the host you want to update.

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

  * `replication_source_name`: Replication source, i.e., the `name` attribute of the relevant `host` section.
  * `assign_public_ip`: [Public access to the host](../concepts/network.md#public-access-to-a-host), `true` or `false`.

  1. Validate your configuration.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm resource changes.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

     {% include [Terraform timeouts](../../_includes/mdb/mpg/terraform/timeouts.md) %}

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [Cluster.UpdateHosts](../api-ref/Cluster/updateHosts.md) method, for instance, via the following {{ api-examples.rest.tool }} request:

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
                     "updateMask": "assignPublicIp,replicationSource,priority,configSpec.postgresqlConfig_<{{ PG }}_version>",
                     "hostName": "<host_FQDN>",
                     "assignPublicIp": <allow_public_access_to_host>,
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

     Where `updateHostSpecs` is an array of hosts you want to update. Each array element contains the configuration for a single host and has the following structure:

     * `updateMask`: Comma-separated list of settings you want to update.
     * `hostName`: [Target host FQDN](connect.md#fqdn).
     * `assignPublicIp`: Internet access to the host via a public IP address, `true` or `false`.
     * `replicationSource`: Host’s replication source for [manual replication stream management](../concepts/replication.md#replication-manual). Specify the FQDN of the host that will be used as the replication source.
     * `priority`: Host priority relative to all other hosts.
     * `configSpec.postgresqlConfig_<{{ PG }}_version>`: {{ PG }} settings. Specify each setting on a separate line, separated by commas.

       See the [method description](../api-ref/Cluster/updateHosts.md#yandex.cloud.mdb.postgresql.v1.UpdateClusterHostsRequest) for the list of {{ PG }} versions supporting this option. See [{#T}](../concepts/settings-list.md) for descriptions and possible values of the settings.

     You can get the cluster ID from the [folder’s cluster list](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/Cluster/updateHosts.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Call the [ClusterService.UpdateHosts](../api-ref/grpc/Cluster/updateHosts.md) method, for instance, via the following {{ api-examples.grpc.tool }} request:

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
                 "assign_public_ip": <allow_public_access_to_host>,
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

     Where `update_host_specs` is an array of hosts you want to update. Each array element contains the configuration for a single host and has the following structure:

     * `update_mask`: List of settings you want to update as an array of strings (`paths[]`).
     * `host_name`: [Target host FQDN](connect.md#fqdn).
     * `assign_public_ip`: Internet access to the host via a public IP address, `true` or `false`.
     * `replication_source`: Host’s replication source for [manual replication stream management](../concepts/replication.md#replication-manual). Specify the FQDN of the host that will be used as the replication source.
     * `priority`: Host priority relative to all other hosts.
     * `config_spec.postgresql_config_<{{ PG }}_version>`: {{ PG }} settings. Specify each setting on a separate line, separated by commas.

       See the [method description](../api-ref/grpc/Cluster/create.md#yandex.cloud.mdb.postgresql.v1.ConfigHostSpec) for the list of {{ PG }} versions supporting this option. See [{#T}](../concepts/settings-list.md) for descriptions and possible values of the settings.

     You can get the cluster ID from the [folder’s cluster list](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/grpc/Cluster/updateHosts.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}


{% note warning %}

If you cannot [connect](connect.md) to the host after the update, check that the cluster [security group](../concepts/network.md#security-groups) is properly configured for the subnet containing your host.

{% endnote %}


## Deleting a host {#remove}

You can delete a host from a {{ PG }} cluster as long as it is not the only host in the cluster. In order to replace a sole host, you must first create a new host and then delete the old one.

If you delete the master host, {{ mpg-short-name }} will automatically promote the highest priority replica to master.

{% list tabs group=instructions %}

- Management console {#console}

  To delete a host from a cluster:
  1. [Go to](../../console/operations/select-service.md#select-service) **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-postgresql }}**.
  1. Click the name of your cluster and open the **{{ ui-key.yacloud.postgresql.cluster.switch_hosts }}** tab.
  1. Find the host you need in the list, click ![image](../../_assets/console-icons/ellipsis.svg) in its row, select **{{ ui-key.yacloud.common.delete }}**, and confirm the deletion.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To delete a host from the cluster, run this command:

  ```bash
  {{ yc-mdb-pg }} host delete <host_name> \
    --cluster-name <cluster_name>
  ```

  You can get the host name from the [list of cluster hosts](#list), and the cluster name from the [folder’s cluster list](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

  To delete a host from a cluster:
  1. Open the current {{ TF }} configuration file describing your infrastructure.

     To learn how to create this file, see [Creating clusters](cluster-create.md).

     For a complete list of configurable {{ mpg-name }} cluster fields, refer to the [{{ TF }} provider guides]({{ tf-provider-mpg }}).
  1. Delete the `host` section referring to the host you want to delete from the {{ mpg-name }} cluster description.
  1. Validate your configuration.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Type `yes` and press **Enter**.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

     {% include [Terraform timeouts](../../_includes/mdb/mpg/terraform/timeouts.md) %}

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. Call the [Cluster.DeleteHosts](../api-ref/Cluster/deleteHosts.md) method, for instance, via the following {{ api-examples.rest.tool }} request:

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

     Where `hostNames` is an array of strings, each containing an [FQDN of the host targeted for deletion](connect.md#fqdn).

     You can get the cluster ID from the [folder’s cluster list](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/Cluster/deleteHosts.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and place it in an environment variable:

     {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  1. Call the [ClusterService.DeleteHosts](../api-ref/grpc/Cluster/deleteHosts.md) method, for instance, via the following {{ api-examples.grpc.tool }} request:

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

     Where `host_names` is an array of strings, each containing an [FQDN of the host targeted for deletion](connect.md#fqdn).

     You can get the cluster ID from the [folder’s cluster list](cluster-list.md#list-clusters).

  1. Check the [server response](../api-ref/grpc/Cluster/deleteHosts.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}