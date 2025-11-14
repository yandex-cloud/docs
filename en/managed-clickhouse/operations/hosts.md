---
title: Managing {{ CH }} hosts
description: 'Follow this guide to manage {{ CH }} cluster hosts: get the list of hosts in the cluster, create a host, change {{ CH }} settings for a host, restart a host, and delete a host.'
---

# Managing {{ CH }} hosts

You can do the following with {{ CH }} hosts:

* [Get the list of cluster hosts](#list-hosts).
* [Create a host](#add-host).
* [Update {{ CH }} host settings](#update).
* [Restart a host](#restart).
* [Delete a host](#remove-host).

For information about moving {{ CH }} hosts to a different [availability zone](../../overview/concepts/geo-scope.md), see [this guide](host-migration.md#clickhouse-hosts).

{% note warning %}

If you have created a cluster without [{{ CK }}](../concepts/replication.md#ck) support, then before adding new hosts to any of the [shards](../concepts/sharding.md), [add at least three {{ ZK }} hosts](zk-hosts.md#add-zk).

{% endnote %}

## Getting a list of cluster hosts {#list-hosts}

{% include notitle [get-hosts](../../_includes/mdb/mch/get-hosts.md) %}

## Creating a host {#add-host}

The number of hosts in {{ mch-name }} clusters is limited by the CPU and RAM quotas available to DB clusters in your cloud. To check the resources currently in use, open the [Quotas]({{ link-console-quotas }}) page and find **{{ ui-key.yacloud.iam.folder.dashboard.label_mdb }}**.

You can create several hosts in a cluster in one go.

{% list tabs group=instructions %}

- Management console {#console}

  1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Click the cluster name and navigate to the **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}** tab.
  1. Click **{{ ui-key.yacloud.clickhouse.hosts.dialog.action_add-clickhouse-hosts }}**.

  1. Specify these host parameters:

      
      * Availability zone.
      * Subnet (if the required subnet is not on the list, [create it](../../vpc/operations/subnet-create.md)).
      * Shard name.
      * Enable **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}** to make the host accessible from outside {{ yandex-cloud }}, if required.


  1. Optionally, click **{{ ui-key.yacloud.clickhouse.hosts.dialog.action_add-host-item }}** to add more hosts and specify their parameters.
     
  1. Under **{{ ui-key.yacloud.clickhouse.hosts.dialog.title_additional-settings }}**:
  
     * **{{ ui-key.yacloud.clickhouse.hosts.dialog.field_copy_schema }}**: If the data schema is the same on all replica hosts in the cluster, enable this option to copy the schema from a random replica to the new hosts.

  1. Click **{{ ui-key.yacloud.clickhouse.hosts.dialog.action_submit }}** to create one or more hosts.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To create one or more hosts:

  
  1. Request the list of cluster subnets to select one for the new host:

     ```bash
     yc vpc subnet list
     ```

     Result:

     ```text
     +-----------+-----------+------------+---------------+------------------+
     |     ID    |   NAME    | NETWORK ID |     ZONE      |      RANGE       |
     +-----------+-----------+------------+---------------+------------------+
     | b0cl69... | default-d | enp6rq7... | {{ region-id }}-d | [172.16.0.0/20]  |
     | e2lkj9... | default-b | enp6rq7... | {{ region-id }}-b | [10.10.0.0/16]   |
     | e9b0ph... | a-2       | enp6rq7... | {{ region-id }}-a | [172.16.32.0/20] |
     | e9b9v2... | default-a | enp6rq7... | {{ region-id }}-a | [172.16.16.0/20] |
     +-----------+-----------+------------+---------------+------------------+
     ```

     If the required subnet is not on the list, [create it](../../vpc/operations/subnet-create.md).


  1. See the description of the CLI command for creating hosts:

     ```bash
     {{ yc-mdb-ch }} hosts add --help
     ```

  1. Run the command to create hosts.

     Specify one or more `--host` parameters in the command, one for each new host.

     The command for creating a single host looks like this:

     
     ```bash
     {{ yc-mdb-ch }} hosts add \
       --cluster-name=<cluster_name> \
       --host zone-id=<availability_zone>,`
         `subnet-id=<subnet_ID>,`
         `assign-public-ip=<public_access_to_host>,`
         `shard-name=<shard_name>,`
         `type=clickhouse
     ```

     Where `assign-public-ip` is internet access to the host via a public IP address, `true` or `false`.


     To copy the data schema from a random replica to the new host, set the optional `--copy-schema` parameter.

     {{ mch-name }} will run start creating hosts.

     
     If your availability zone contains multiple subnets, make sure to specify the subnet ID; otherwise, {{ mch-name }} will automatically select the single subnet available. You can get the cluster name with the [list of clusters in the folder](cluster-list.md#list-clusters).


- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file describing your infrastructure.

     For information on how to create this file, see [Creating a cluster](cluster-create.md).
  1. Add one or more `host` sections to the {{ mch-name }} cluster description, one for each new host.

     A single `host` section looks like this:

     ```hcl
     resource "yandex_mdb_clickhouse_cluster" "<cluster_name>" {
       ...
       host {
         type             = "CLICKHOUSE"
         zone             = "<availability_zone>"
         subnet_id        = "<subnet_ID>"
         assign_public_ip = <public_access_to_host>
       }
     }
     ```

     Where `assign_public_ip` is internet access to the host via a public IP address, `true` or `false`.

  1. Validate your configuration.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  For more information, see [this {{ TF }} provider guide]({{ tf-provider-resources-link }}/mdb_clickhouse_cluster).

  {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and save it as an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Use the [Cluster.AddHosts](../api-ref/Cluster/addHosts.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

        ```bash
        curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<cluster_ID>/hosts:batchCreate' \
            --data '{
                      "hostSpecs": [
                        {
                          "type": "CLICKHOUSE",
                          "zoneId": "<availability_zone>",
                          "subnetId": "<subnet_ID>",
                          "shardName": "<shard_name>",
                          "assignPublicIp": <public_access_to_host>
                        },
                        { <similar_settings_for_new_host_2> },
                        { ... },
                        { <similar_settings_for_new_host_N> }
                      ],
                      "copySchema": <data_schema_copying>
                    }'
        ```

        Where:

        * `hostSpecs`: Array of settings for the new hosts. One array element contains settings for a single host and has the following structure:

            * `type`: Host type, which is always `CLICKHOUSE` for {{ CH }} hosts.
            * `zoneId`: Availability zone.
            * `subnetId`: Subnet ID.
            * `shardName`: Shard name.
            * `assignPublicIp`: Internet access to the host via a public IP address, `true` or `false`.

        * `copySchema`: Enables or disables copying the data schema from a random replica to the new hosts, `true` or `false`.

        You can get the cluster ID with the [list of clusters in the folder](./cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/Cluster/addHosts.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and save it as an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Use the [ClusterService.AddHosts](../api-ref/grpc/Cluster/addHosts.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                    "cluster_id": "<cluster_ID>",
                    "host_specs": [
                        {
                            "type": "CLICKHOUSE",
                            "zone_id": "<availability_zone>",
                            "subnet_id": "<subnet_ID>",
                            "shard_name": "<shard_name>",
                            "assign_public_ip": <public_access_to_host>
                        },
                        { <similar_settings_for_new_host_2> },
                        { ... },
                        { <similar_settings_for_new_host_N> }
                    ],
                    "copy_schema": <enabling_or_disabling_data_schema_copying>
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.clickhouse.v1.ClusterService.AddHosts
        ```

        Where:

        * `host_specs`: Array of settings for the new hosts. One array element contains settings for a single host and has the following structure:

            * `type`: Host type, which is always `CLICKHOUSE` for {{ CH }} hosts.
            * `zone_id`: Availability zone.
            * `subnet_id`: Subnet ID.
            * `shard_name`: Shard name.
            * `assign_public_ip`: Internet access to the host via a public IP address, `true` or `false`.

        * `copy_schema`: Enables or disables copying the data schema from a random replica to the new hosts, `true` or `false`.

        You can request the cluster ID with the [list of clusters in the folder](./cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/grpc/Cluster/addHosts.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

{% note warning %}


If you cannot [connect](connect/clients.md) to the host you created, check that the cluster [security group](../concepts/network.md#security-groups) is configured correctly for the host subnet.


Use the copy schema option only if the schema is the same across all replica hosts of the cluster.

{% endnote %}


## Updating a host {#update}

You can change public access settings for any host in a {{ mch-name }} cluster.

{% include [mch-public-access-sg](../../_includes/mdb/mch/note-public-access-sg-rule.md) %}

{% list tabs group=instructions %}

- Management console {#console}

  To change the parameters of a cluster host:
  1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Click the cluster name and navigate to the **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}** tab.
  1. Click ![image](../../_assets/console-icons/ellipsis.svg) next to the host in question and select **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}**.
  1. In the window that opens, enable **{{ ui-key.yacloud.mdb.hosts.dialog.field_public_ip }}** to make the host accessible from outside {{ yandex-cloud }}, if required.
  1. Click **{{ ui-key.yacloud.mdb.hosts.dialog.button_choose }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To change the host parameters, run this command:

  ```bash
  {{ yc-mdb-ch }} host update <host_name> \
    --cluster-name=<cluster_name> \
    --assign-public-ip=<public_access_to_host>
  ```

  Where `assign-public-ip` is internet access to the host via a public IP address, `true` or `false`.

  You can get the host name with the [list of cluster hosts](#list-hosts), and the cluster name, with the [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file describing your infrastructure.

     For information on how to create this file, see [Creating a cluster](cluster-create.md).

  1. Add or edit the `assign_public_ip` parameter in the relevant `host` section.

     ```hcl
     resource "yandex_mdb_clickhouse_cluster" "<cluster_name>" {
       ...
       host {
         ...
         assign_public_ip = <public_access_to_host>
       }
       ...
     }
     ```

     Where `assign_public_ip` is internet access to the host via a public IP address, `true` or `false`.

  1. Validate your configuration.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Confirm updating the resources.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  For more information, see [this {{ TF }} provider guide]({{ tf-provider-mch }}).

- REST API {#api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and save it as an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. Use the [Cluster.UpdateHosts](../api-ref/Cluster/updateHosts.md) method and send the following request, e.g., via {{ api-examples.rest.tool }}:

        {% include [note-updatemask](../../_includes/note-api-updatemask.md) %}

        ```bash
        curl \
            --request POST \
            --header "Authorization: Bearer $IAM_TOKEN" \
            --header "Content-Type: application/json" \
            --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<cluster_ID>/hosts:batchUpdate' \
            --data '{
                      "updateHostSpecs": [
                        {
                          "hostName": "<host_name>",
                          "updateMask": "assignPublicIp",
                          "assignPublicIp": <public_access_to_host>
                        }
                      ]
                    }'
        ```

        Where `updateHostSpecs[]` is the list of hosts and their parameters to update. Below is the structure of an individual element:

        * `hostName`: Host name which you can get with the [list of hosts in the cluster](#list-hosts).
        * `updateMask`: Comma-separated list of settings you want to update.

            Here, we only specified a single parameter, `assignPublicIp`.

        * `assignPublicIp`: Internet access to the host via a public IP address, `true` or `false`.

        You can get the cluster ID with the [list of clusters in the folder](./cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/Cluster/updateHosts.md#yandex.cloud.operation.Operation) to make sure your request was successful.

- gRPC API {#grpc-api}

    1. [Get an IAM token for API authentication](../api-ref/authentication.md) and save it as an environment variable:

        {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}

    1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}

    1. Use the [ClusterService.UpdateHosts](../api-ref/grpc/Cluster/updateHosts.md) call and send the following request, e.g., via {{ api-examples.grpc.tool }}:

        {% include [note-grpc-updatemask](../../_includes/note-grpc-api-updatemask.md) %}

        ```bash
        grpcurl \
            -format json \
            -import-path ~/cloudapi/ \
            -import-path ~/cloudapi/third_party/googleapis/ \
            -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
            -rpc-header "Authorization: Bearer $IAM_TOKEN" \
            -d '{
                    "cluster_id": "<cluster_ID>",
                    "update_host_specs": [
                    {
                        "host_name": "<host_name>",
                        "update_mask": {
                            "paths": [
                                "assign_public_ip"
                            ]
                        },
                        "assign_public_ip": <public_access_to_host>
                    }]
                }' \
            {{ api-host-mdb }}:{{ port-https }} \
            yandex.cloud.mdb.clickhouse.v1.ClusterService.UpdateHosts
        ```

        Where `update_host_specs[]` is the list of hosts and their parameters to update. Below is the structure of an individual element:

        * `host_name`: Host name which you can get with the [list of hosts in the cluster](#list-hosts).
        * `update_mask`: List of parameters to update as an array of `paths[]` strings.

            Here, we only specified a single parameter, `assign_public_ip`.

        * `assign_public_ip`: Internet access to the host via a public IP address, `true` or `false`.

        You can get the cluster ID with the [list of clusters in the folder](./cluster-list.md#list-clusters).

    1. View the [server response](../api-ref/grpc/Cluster/updateHosts.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}


{% note warning %}

If you cannot [connect](connect/clients.md) to the host you updated, check that the cluster [security group](../concepts/network.md#security-groups) is configured correctly for the host subnet.

{% endnote %}



## Restarting a host {#restart}

{% include notitle [restart-host](../../_includes/mdb/mch/restart-host.md) %}

## Deleting a host {#remove-host}

{% note warning %}

You cannot delete a host from a cluster or shard if the [relevant limit for the minimum number of hosts](../concepts/limits.md#mch-limits) was reached.

You cannot delete hosts running [{{ CK }}](../concepts/replication.md#ck) if you enabled this replication option when creating the cluster.

You cannot delete hosts of different types ({{ CH }} and {{ ZK }}) at the same time.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  To delete a single host:

    1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
    1. Click the cluster name and navigate to the **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}** tab.
    1. Click ![image](../../_assets/console-icons/ellipsis.svg) next to the host in question and select **{{ ui-key.yacloud.mdb.clusters.button_action-delete }}**.
    1. In the window that opens, check **Delete host** and click **{{ ui-key.yacloud.mdb.cluster.hosts.popup-confirm_button }}**.

  To delete several hosts in one go:

    1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
    1. Click the cluster name and navigate to the **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}** tab.
    1. Select the hosts you want to delete and click **{{ ui-key.yacloud.mdb.clusters.button_action-delete }}** at the bottom of the screen.
    1. In the window that opens, click **{{ ui-key.yacloud.mdb.cluster.hosts.action_delete-host }}**.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To delete one or more hosts from a cluster, run the command below, providing the names of the hosts you want to delete. Use the space character as a separator.

  The command for deleting a single host looks like this:

  ```bash
  {{ yc-mdb-ch }} hosts delete --cluster-name=<cluster_name> \
    <host_name>
  ```

  You can get the host names with the [list of cluster hosts](#list-hosts), and the cluster name, with the [list of clusters in the folder](cluster-list.md#list-clusters).

- {{ TF }} {#tf}

  1. Open the current {{ TF }} configuration file describing your infrastructure.

     For information on how to create this file, see [Creating a cluster](cluster-create.md).
  1. In the {{ mch-name }} cluster description, delete one or more `CLICKHOUSE`-type `host` sections.
  1. Validate your configuration.

     {% include [terraform-validate](../../_includes/mdb/terraform/validate.md) %}

  1. Type `yes` and press **Enter**.

     {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

  For more information, see [this {{ TF }} provider guide]({{ tf-provider-resources-link }}/mdb_clickhouse_cluster).

  {% include [Terraform timeouts](../../_includes/mdb/mch/terraform/timeouts.md) %}

- REST API {#api}

    {% include [zk-hosts-rest](../../_includes/mdb/mch/api/delete-zk-hosts-rest.md) %}

- gRPC API {#grpc-api}

    {% include [zk-hosts-grpc](../../_includes/mdb/mch/api/delete-zk-hosts-grpc.md) %}

{% endlist %}

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
