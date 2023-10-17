{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_data-proc }}**.
   1. Click the cluster name and open the **{{ ui-key.yacloud.mdb.cluster.switch_jobs }}** tab.

- CLI

   {% include [cli-install](../cli-install.md) %}

   {% include [default-catalogue](../default-catalogue.md) %}

   To get a list of jobs, run the following command:

   ```bash
   {{ yc-dp }} job list --cluster-name=<cluster name>
   ```

   You can find out the cluster ID and name in a [list of clusters in the folder](../../data-proc/operations/cluster-list.md#list).

- API

   Use the [list](../../data-proc/api-ref/Job/list) API method and provide the cluster ID in the `clusterId` request parameter.

   You can get the cluster ID with a [list of clusters in the folder](../../data-proc/operations/cluster-list.md#list).

{% endlist %}
