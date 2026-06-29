{% note info %}

You cannot cancel jobs with the `ERROR`, `DONE`, or `CANCELLED` status. To find out the job status, get the [list of jobs](#list) in the cluster.

{% endnote %}

{% list tabs group=instructions %}

- Management console {#console}

  1. Open the [folder dashboard]({{ link-console-main }}).
  1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_data-proc }}**.
  1. Click the name of your cluster and select the **{{ ui-key.yacloud.mdb.cluster.switch_jobs }}** tab.
  1. Click the job name.
  1. Click **{{ ui-key.yacloud.common.cancel }}** in the top-right corner of the page.
  1. In the window that opens, select **{{ ui-key.yacloud.mdb.dialogs.popup_button_cancel }}**.

- CLI {#cli}

  {% include [cli-install](../cli-install.md) %}

  {% include [default-catalogue](../default-catalogue.md) %}

  To cancel a job, run this command:

  ```bash
  {{ yc-dp }} job cancel <job_name_or_ID> \
    --cluster-name=<cluster_name>
  ```

  You can get the job ID and name with the [list of jobs in the cluster](#list), and the cluster name, with the [list of clusters in the folder](../../data-proc/operations/cluster-list.md#list).

- API {#api}

  Call the [cancel](../../data-proc/api-ref/Job/cancel) API method and provide the following in the request:
  * Cluster ID in the `clusterId` parameter.
  * Job ID in the `jobId` parameter.

  You can get the cluster ID with the [list of clusters in the folder](../../data-proc/operations/cluster-list.md#list), and the job ID, with the [list of cluster jobs](#list).

{% endlist %}