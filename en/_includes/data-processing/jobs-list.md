{% list tabs group=instructions %}

- Management console {#console}

    1. Open the [folder dashboard]({{ link-console-main }}).
    1. [Go](../../console/operations/select-service.md#select-service) to **{{ ui-key.yacloud.iam.folder.dashboard.label_data-proc }}**.
    1. Click the name of your cluster and select the **{{ ui-key.yacloud.mdb.cluster.switch_jobs }}** tab.

- CLI {#cli}

    {% include [cli-install](../cli-install.md) %}

    {% include [default-catalogue](../default-catalogue.md) %}

    To get a list of jobs, run the following command:

    ```bash
    {{ yc-dp }} job list --cluster-name=<cluster_name>
    ```

    You can get the cluster ID and name with the [list of clusters in the folder](../../data-proc/operations/cluster-list.md#list).

- API {#api}

    Use the [list](../../data-proc/api-ref/Job/list) API method and provide the cluster ID in the `clusterId` request parameter.

    You can get the cluster ID with the [list of clusters in the folder](../../data-proc/operations/cluster-list.md#list).

{% endlist %}
