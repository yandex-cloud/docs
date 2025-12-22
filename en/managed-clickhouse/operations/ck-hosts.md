---
title: Managing {{ CK }} hosts
description: Follow this guide to manage {{ CK }} hosts.
---

# Managing {{ CK }} hosts

After creating a cluster with separate {{ CK }} hosts, you can:

* [Get a list of hosts](#list-hosts).
* [Create a host](#add-ck).
* [Change {{ CK }} settings](#update-keeper-settings).
* [Restart a host](#restart-host).
* [Convert non-replicated tables to replicated ones](#replicated-tables).
* [Delete a {{ CK }} host](#delete-host).

For more information about {{ CK }} hosts, see [{#T}](../concepts/replication.md#ck).

## Getting a list of cluster hosts {#list-hosts}

{% include notitle [get-hosts](../../_includes/mdb/mch/get-hosts.md) %}


## Creating a {{ CK }} host {#add-ck}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Click the cluster name and go to the **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}** tab.
  1. Click **{{ ui-key.yacloud.mdb.cluster.hosts.button_add-clickhouse-keeper }}** in the top-right corner of the page.
  1. Select the [availability zone](../../overview/concepts/geo-scope.md) and a subnet inside it.
  1. Click **{{ ui-key.yacloud.mdb.hosts.dialog.button_choose }}**.

{% endlist %}  

## Changing {{ CK }} settings {#update-keeper-settings}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), navigate to the folder dashboard and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Select the cluster and click **{{ ui-key.yacloud.mdb.clusters.button_action-edit }}** in the top panel.
  1. Under **{{ ui-key.yacloud.clickhouse.cluster.section_clickhouse-keeper-resource }}**, select the platform, VM type, and required {{ CK }} host class.
  1. Under **{{ ui-key.yacloud.clickhouse.cluster.section_clickhouse-keeper-disk }}**, specify the disk type and storage size, and set up [automatic storage size increase](../concepts/storage.md#autoscaling).
  1. Click **{{ ui-key.yacloud.mdb.forms.button_edit }}**.

{% endlist %}

## Restarting a host {#restart-host}

{% include notitle [restart-host](../../_includes/mdb/mch/restart-host.md) %}

## Converting non-replicated tables to replicated ones {#replicated-tables}

To automatically convert non-replicated [MergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/mergetree/) tables to [replicated](../concepts/replication.md#replicated-tables) [ReplicatedMergeTree]({{ ch.docs }}/engines/table-engines/mergetree-family/replication/) tables, enable the **{{ ui-key.yacloud.clickhouse.field_convert_tables_to_replicated }}** setting when [activating the coordination service](update.md#enable-coordination).

## Deleting a {{ CK }} host {#delete-host}

{% note warning %}

You can delete only one {{ CK }} host at a time. However, there must be at least three {{ CK }} hosts left in the cluster at all times.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**.
  1. Click the cluster name and go to the **{{ ui-key.yacloud.mdb.cluster.hosts.label_title }}** tab.
  1. In the host row, click ![image](../../_assets/console-icons/ellipsis.svg) and select **{{ ui-key.yacloud.mdb.clusters.button_action-delete }}**.
  1. Confirm the deletion.

- CLI {#cli}

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To delete a {{ CK }} host:

  1. See the description of the CLI command for deleting a host:
    
      ```bash
      {{ yc-mdb-ch }} hosts delete --help
      ```
      
  1. Delete the host by running this command:

      ```bash
      {{ yc-mdb-ch }} hosts delete <host_name> \ 
        --cluster-id=<cluster_ID>
      ```

      You can get the host name with the [list of hosts](#list-hosts) in the cluster.

      You can get the cluster ID with the [list of clusters](cluster-list.md#list-clusters) in the folder.

- REST API {#api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it in an environment variable:
  
      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}
  
  1. Call the [Cluster.DeleteHosts](../api-ref/Cluster/deleteHosts.md) method, e.g., via the following {{ api-examples.rest.tool }} request:
  
      ```bash
      curl \
        --request POST \
        --header "Authorization: Bearer $IAM_TOKEN" \
        --header "Content-Type: application/json" \
        --url 'https://{{ api-host-mdb }}/managed-clickhouse/v1/clusters/<cluster_ID>/hosts:batchDelete' \
        --data '{
          "hostNames": [
            <host_name>
          ]
        }'
      ```
  
      You can get the host name with the [list of hosts](#list-hosts) in the cluster.

      You can get the cluster ID with the [list of clusters](cluster-list.md#list-clusters) in the folder.
  
  1. Check the [server response](../api-ref/Cluster/deleteHosts.md#yandex.cloud.operation.Operation) to make sure your request was successful.
  
- gRPC API {#grpc-api}

  1. [Get an IAM token for API authentication](../api-ref/authentication.md) and put it in an environment variable:
  
      {% include [api-auth-token](../../_includes/mdb/api-auth-token.md) %}
  
  1. {% include [grpc-api-setup-repo](../../_includes/mdb/grpc-api-setup-repo.md) %}
  
  1. Call the [ClusterService.DeleteHosts](../api-ref/grpc/Cluster/deleteHosts.md) method, e.g., via the following {{ api-examples.grpc.tool }} request:
  
      ```bash
      grpcurl \
        -format json \
        -import-path ~/cloudapi/ \
        -import-path ~/cloudapi/third_party/googleapis/ \
        -proto ~/cloudapi/yandex/cloud/mdb/clickhouse/v1/cluster_service.proto \
        -rpc-header "Authorization: Bearer $IAM_TOKEN" \
        -d '{
          "cluster_id": "<cluster_ID>",
          "host_names": [
            <host_name>
          ]
        }' \
        {{ api-host-mdb }}:{{ port-https }} \
        yandex.cloud.mdb.clickhouse.v1.ClusterService.DeleteHosts
      ```
  
      You can get the host name with the [list of hosts](#list-hosts) in the cluster.

      You can get the cluster ID with the [list of clusters](cluster-list.md#list-clusters) in the folder.
  
  1. View the [server response](../api-ref/grpc/Cluster/deleteHosts.md#yandex.cloud.operation.Operation) to make sure your request was successful.

{% endlist %}

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}