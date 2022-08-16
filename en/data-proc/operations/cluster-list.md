# Information about existing clusters

Detailed information about each {{ dataproc-name }} cluster created is available.

## Getting a list of clusters in a folder {#list}

{% list tabs %}

- Management console

    Go to the [folder page]({{ link-console-main }}) and select **{{ dataproc-name }}**.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To request a list of {{ dataproc-name }} clusters in the default folder, run the command:

    ```bash
   {{ yc-dp }} cluster list
    ```

- API

    Use the [list](../api-ref/Cluster/list.md) API method.

{% endlist %}

## Getting detailed information about a cluster {#detail}

{% list tabs %}

- Management console
    1. Go to the [folder page]({{ link-console-main }}) and select **{{ dataproc-name }}**.
    1. Click on the name of the cluster you need.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To get {{ dataproc-name }} cluster details, run the command:

    ```bash
    {{ yc-dp }} cluster get <cluster name or ID>
    ```

    You can get the cluster ID and name with a [list of clusters in the folder](#list).

- API

    Use the [get](../api-ref/Cluster/get.md) API method and pass the cluster ID in the `clusterId` parameter of the request.

    You can get the cluster ID with a [list of clusters in the folder](#list).

{% endlist %}

## Viewing a list of operations in a cluster {#operations}

{% list tabs %}

- Management console
    1. Go to the [folder page]({{ link-console-main }}) and select **{{ dataproc-name }}**.
    1. Click on the name of the cluster and open the **Operations** tab.

- CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To get a list of operations, run the command:

    ```bash
    {{ yc-dp }} cluster list-operations <cluster name or ID>
    ```

    You can get the cluster ID and name with a [list of clusters in the folder](#list).

- API

    Use the [listOperations](../api-ref/Cluster/listOperations.md) API method and pass the cluster ID in the `clusterId` parameter of the request.

    You can get the cluster ID with a [list of clusters in the folder](#list).

{% endlist %}

