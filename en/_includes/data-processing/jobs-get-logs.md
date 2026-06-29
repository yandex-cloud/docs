{% include [get-logs-info](note-info-get-logs.md) %}

{% list tabs group=instructions %}

- Management console {#console}

    1. Open the [folder dashboard]({{ link-console-main }}).
    1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_data-proc }}**.
    1. Click the name of your cluster and select the **{{ ui-key.yacloud.mdb.cluster.switch_jobs }}** tab.
    1. Click the job name.

- CLI {#cli}

    {% include [cli-install](../cli-install.md) %}

    {% include [default-catalogue](../default-catalogue.md) %}

    To get the job execution logs, run the following command:

    ```bash
    {{ yc-dp }} job log \
       --cluster-name=<cluster_name> \
       --name=<job_name>
    ```

    You can get the cluster ID and name with the [list of clusters in the folder](../../data-proc/operations/cluster-list.md#list).

- API {#api}

    Call the API [listLog](../../data-proc/api-ref/Job/listLog) method and provide the following in the request:

    * Cluster ID in the `clusterId` parameter. You can get it with the [list of clusters in the folder](../../data-proc/operations/cluster-list.md#list).
    * Job ID in the `jobId` parameter. You can get it with the [list of cluster jobs](#list).

{% endlist %}
