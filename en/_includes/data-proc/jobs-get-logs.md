{% include [get-logs-info](note-info-get-logs.md) %}

{% list tabs %}

- Management console

   1. Go to the folder page and select **{{ dataproc-name }}**.
   1. Click on the name of the cluster and open the **Jobs** tab.
   1. Click on the name of the job.

- CLI

   {% include [cli-install](../cli-install.md) %}

   {% include [default-catalogue](../default-catalogue.md) %}

   To get job execution logs, run the command:

   ```bash
   {{ yc-dp }} job log \
      --cluster-name <cluster name> \
      --name <job name>
   ```

   You can find out the cluster ID and name in a [list of clusters in the folder](../../data-proc/operations/cluster-list.md#list).

- API

   Use the API [listLog](../../data-proc/api-ref/Job/listLog) method and pass in in the call:

   * The cluster ID in the `clusterId` parameter. You can retrieve it with a [list of folder clusters](../../data-proc/operations/cluster-list.md#list).
   * The job ID in the `jobId` parameter. You can retrieve it with the [list of cluster jobs](#list).

{% endlist %}
