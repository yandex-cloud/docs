# Information about existing {{ dataproc-name }} clusters

You can get detailed information about each {{ dataproc-name }} cluster.

## Getting a list of clusters in a folder {#list}

{% list tabs group=instructions %}

- Management console {#console}

   Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_data-proc }}**.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To request a list of {{ dataproc-name }} clusters in the default folder, run the command:

   ```bash
   {{ yc-dp }} cluster list
   ```

- API {#api}

   Use the [list](../api-ref/Cluster/list.md) API method.

{% endlist %}

## Getting detailed information about a cluster {#detail}

{% list tabs group=instructions %}

- Management console {#console}

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_data-proc }}**.
   1. Click the cluster name.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get {{ dataproc-name }} cluster details, run the command:

   ```bash
   {{ yc-dp }} cluster get <cluster_name_or_ID>
   ```

   You can get the cluster ID and name with a [list of clusters in the folder](#list).

- API {#api}

   Use the [get](../api-ref/Cluster/get.md) API method and include the cluster ID in the `clusterId` request parameter.

   You can get the cluster ID with a [list of clusters in the folder](#list).

{% endlist %}

## Viewing a list of operations in a cluster {#operations}

{% list tabs group=instructions %}

- Management console {#console}

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_data-proc }}**.
   1. Click the cluster name and open the **{{ ui-key.yacloud.dataproc.switch_operations }}** tab.

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   To get a list of operations, run the following command:

   ```bash
   {{ yc-dp }} cluster list-operations <cluster_name_or_ID>
   ```

   You can get the cluster ID and name with a [list of clusters in the folder](#list).

- API {#api}

   Use the [listOperations](../api-ref/Cluster/listOperations.md) API method and provide the cluster ID in the `clusterId` request parameter.

   You can get the cluster ID with a [list of clusters in the folder](#list).

{% endlist %}
