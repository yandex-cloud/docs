{% note info %}

You cannot cancel jobs with the status `ERROR`, `DONE`, or `CANCELLED`. To find out a job's status, retrieve a [list of jobs](#list) in the cluster.

{% endnote %}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_data-proc }}**.
   1. Click the cluster name and open the **{{ ui-key.yacloud.mdb.cluster.switch_jobs }}** tab.
   1. Click the job name.
   1. Click **{{ ui-key.yacloud.common.cancel }}** in the top-right corner of the page.
   1. In the window that opens, select **{{ ui-key.yacloud.mdb.dialogs.popup_button_cancel }}**.

- CLI

   {% include [cli-install](../cli-install.md) %}

   {% include [default-catalogue](../default-catalogue.md) %}

   To cancel a job, run the command below:

   ```bash
   {{ yc-dp }} job cancel <job_name_or_ID> \
     --cluster-name=<cluster_name>
   ```

   You can get the job name or ID with the [list of cluster jobs](#list), and the cluster name, with the [list of folder clusters](../../data-proc/operations/cluster-list.md#list).

- API

   Use the API [cancel](../../data-proc/api-ref/Job/cancel) method and include the following in the request:
   * Cluster ID in the `clusterId` parameter
   * Job ID in the `jobId` parameter

   You can get the cluster ID with the [list of folder clusters](../../data-proc/operations/cluster-list.md#list), and the job ID, with the [list of cluster jobs](#list).

{% endlist %}