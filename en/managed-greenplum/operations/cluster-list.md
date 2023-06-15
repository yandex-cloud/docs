# Information about existing {{ GP }} clusters

You can request detailed information about each {{ mgp-name }} cluster you created.

## Getting a list of clusters in a folder {#list-clusters}

{% list tabs %}

- Management console

   Go to the [folder page]({{ link-console-main }}) and select **{{ mgp-name }}**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To request a list of {{ GP }} clusters in a folder, run the following command:

   ```bash
   {{ yc-mdb-gp }} cluster list
   ```

- API

   To get a list of DB clusters in a folder, use the [list](../api-ref/Cluster/list.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/List](../api-ref/grpc/cluster_service.md#List) gRPC API call.

{% endlist %}

## Getting detailed information about a cluster {#get-cluster}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mgp-name }}**.
   1. Click the name of the cluster you need.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get information about a {{ GP }} cluster, run the following command:

   ```bash
   {{ yc-mdb-gp }} cluster get <cluster ID or name>
   ```

   You can query the cluster ID and name with a [list of clusters in the folder](#list-clusters).

- API

   To get cluster details, use the [get](../api-ref/Cluster/get.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/Get](../api-ref/grpc/cluster_service.md#Get) gRPC API call and provide the cluster ID in the `clusterId` request parameter.

   You can get the cluster ID with a [list of clusters in the folder](#list-clusters).

{% endlist %}

## Viewing a list of operations in a cluster {#list-operations}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mgp-name }}**.
   1. Click the name of the desired cluster and select the ![operations.svg](../../_assets/mdb/operations.svg) **Operations** tab.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get a list of operations, run the following command:

   ```bash
   {{ yc-mdb-gp }} cluster list-operations <cluster ID or name>
   ```

   You can query the cluster ID and name with a [list of clusters in the folder](#list-clusters).

- API

   To get a list of operations, use the [listOperations](../api-ref/Cluster/listOperations.md) REST API method for the [Cluster](../api-ref/Cluster/index.md) resource or the [ClusterService/ListOperations](../api-ref/grpc/cluster_service.md#ListOperations) gRPC API call and provide the cluster ID in the `clusterId` request parameter.

   You can get the cluster ID with a [list of clusters in the folder](#list-clusters).

{% endlist %}

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
