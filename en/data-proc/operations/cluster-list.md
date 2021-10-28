# Information about existing clusters

You can request detailed information about each {{ dataproc-name }} cluster you created.

## Getting a list of clusters in a folder {#list}

{% list tabs %}

* Management console

    Go to the folder page and select **{{ dataproc-name }}**.

* CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To request a list of {{ dataproc-name }} clusters in the default folder, run the command:

    ```bash
    yc dataproc cluster list
    ```

* API

    To get a list of cluster, use the [list](../api-ref/Cluster/list.md) method.

{% endlist %}

## Getting detailed information about a cluster {#detail}

{% list tabs %}

* Management console
    1. Go to the folder page and select **{{ dataproc-name }}**.
    1. Click on the name of the cluster you need.

* CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To get {{ dataproc-name }} cluster details, run the command:

    ```bash
    yc dataproc cluster get <cluster name or ID>
    ```

    The cluster name and ID can be requested with a [list of clusters in the folder](#list).

* API

    To get cluster details, use the [get](../api-ref/Cluster/get.md) method.

{% endlist %}

## Viewing a list of operations in a cluster {#operations}

{% list tabs %}

* Management console
    1. Go to the folder page and select **{{ dataproc-name }}**.
    1. Click on the name of the cluster and open the **Operations** tab.

* CLI

    {% include [cli-install](../../_includes/cli-install.md) %}

    {% include [default-catalogue](../../_includes/default-catalogue.md) %}

    To get a list of operations, run the command:

    ```bash
    yc dataproc cluster list-operations <cluster name or ID>
    ```

    The cluster name and ID can be requested with a [list of clusters in the folder](#list).

* API

    To get a list of cluster operations, use the [listOperations](../api-ref/Cluster/listOperations.md) method.

{% endlist %}

