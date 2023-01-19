{% note info %}

You cannot cancel jobs with the status `ERROR`, `DONE`, or `CANCELLED`. To find out a job's status, retrieve a [list of jobs](#list) in the cluster.

{% endnote %}

{% list tabs %}

- Management console

   1. Go to the folder page and select **{{ dataproc-name }}**.
   1. Click on the name of the cluster and open the **Jobs** tab.
   1. Click on the name of the job.
   1. Click **Cancel** in the upper-right corner of the page.
   1. In the window that opens, click **Cancel**.

- CLI

   {% include [cli-install](../cli-install.md) %}

   {% include [default-catalogue](../default-catalogue.md) %}

   To cancel a job, run the command below:

   ```bash
   {{ yc-dp }} job cancel <job ID or name> \
     --cluster-name=<cluster name>
   ```

   You can retrieve a job name or ID in the [list of cluster jobs](#list), and a cluster name in the [list of folder clusters](../../data-proc/operations/cluster-list.md#list).

- API

   Use the API [cancel](../../data-proc/api-ref/Job/cancel) method and pass in the call:
   * The cluster ID in the `clusterId` parameter.
   * The job ID in the `jobId` parameter.

   You can retrieve a cluster ID in the [list of folder clusters](../../data-proc/operations/cluster-list.md#list), and a job ID in the [list of cluster jobs](#list).

{% endlist %}