{% list tabs %}

- Management console

   1. Go to the folder page and select **{{ dataproc-name }}**.
   1. Click on the name of the cluster and open the **Jobs** tab.

- CLI

   {% include [cli-install](../cli-install.md) %}

   {% include [default-catalogue](../default-catalogue.md) %}

   To get a list of jobs, run the command:

   ```bash
   {{ yc-dp }} job list --cluster-name=<cluster name>
   ```

   You can find out the cluster ID and name in a [list of clusters in the folder](../../data-proc/operations/cluster-list.md#list).

- API

   Use the [list](../../data-proc/api-ref/Job/list) API method and pass the cluster ID in the `clusterId` request parameter.

   You can get the cluster ID with a [list of clusters in the folder](../../data-proc/operations/cluster-list.md#list).

{% endlist %}
