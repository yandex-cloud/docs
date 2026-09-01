{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select a folder.
    1. [Navigate]({{ link-console-main }}/link/data-proc) to **{{ ui-key.yacloud.iam.folder.dashboard.label_data-proc }}**.
    1. Select the cluster and open the **{{ ui-key.yacloud.mdb.cluster.switch_jobs }}** tab.

- CLI {#cli}

    {% include [cli-install](../cli-install.md) %}

    {% include [default-catalogue](../default-catalogue.md) %}

    To get a list of jobs, run the following command:

    ```bash
    {{ yc-dp }} job list --cluster-name=<cluster_name>
    ```

    You can get the cluster ID and name with the [list of clusters in the folder](../../data-proc/operations/cluster-list.md#list).

- API {#api}

    Call the [list](../../data-proc/api-ref/Job/list) API method, providing the cluster ID in the `clusterId` request parameter.

    You can get the cluster ID with the [list of clusters in the folder](../../data-proc/operations/cluster-list.md#list).

{% endlist %}
