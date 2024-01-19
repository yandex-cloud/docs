{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_data-proc }}**.
   1. Click the cluster name and open the **{{ ui-key.yacloud.mdb.cluster.switch_jobs }}** tab.
   1. Click the job name.

- CLI

   {% include [cli-install](../cli-install.md) %}

   {% include [default-catalogue](../default-catalogue.md) %}

   To get general information about the job, run the command:

   ```bash
   {{ yc-dp }} job get \
      --cluster-name=<cluster_name> \
      --name=<job_name>
   ```

   You can get the cluster ID and name with a [list of clusters in the folder](../../data-proc/operations/cluster-list.md#list).

- API

   Use the [get](../../data-proc/api-ref/Job/get) API method and include the following in the request:

   * Cluster ID in the `clusterId` parameter. You can get it together with a [list of clusters in the folder](../../data-proc/operations/cluster-list.md#list).
   * Job ID in the `jobId` parameter. You can get it with the [list of cluster jobs](#list).

{% endlist %}
