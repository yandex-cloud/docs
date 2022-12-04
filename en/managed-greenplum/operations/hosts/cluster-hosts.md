# Managing {{ GP }} cluster hosts

You can get a list of hosts (masters and segments) in a {{ mgp-name }} cluster.

{% if audience == "draft" %}
You can add and remove cluster hosts and request a list of hosts in the selected cluster.
{% endif %}

## Getting a list of cluster hosts {#list-hosts}

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mgp-name }}**.
   1. Click the name of the desired cluster and select the ![hosts.svg](../../../_assets/mdb/hosts.svg) **Hosts** tab.

   In the list of hosts, the **Role** column shows the role of each host:

   * `MASTER`: A primary master host. Receives user connections.
   * `REPLICA`: A standby master host. Replicates data of the primary master host.
   * `SEGMENT`: A segment host. Stores some of the cluster data.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   To get a list of cluster master hosts, run the command:

   ```bash
   {{ yc-mdb-gp }} hosts list master \
      --cluster-name=<cluster name>
   ```

   To get a list of cluster segment hosts, run the command:

   ```bash
   {{ yc-mdb-gp }} hosts list segment \
      --cluster-name=<cluster name>
   ```

   The cluster name can be requested with a [list of clusters in the folder](../cluster-list.md#list-clusters).

- API

   Use the [listMasterHosts](../../api-ref/Cluster/listMasterHosts.md) and [listSegmentHosts](../../api-ref/Cluster/listSegmentHosts.md) API methods and pass the cluster ID in the `clusterId` request parameter.

   You can get the cluster ID with a [list of clusters in the folder](../cluster-list.md#list-clusters).

{% endlist %}

{% if audience == "draft" %}

## Change the number of hosts in the cluster {#change-hosts}

The number of hosts in {{ mgp-short-name }} clusters is limited by the CPU and RAM quotas available to clusters in your cloud. To check the resources in use, open the [Quotas]({{ link-console-quotas }}) page and find **{{ mgp-full-name }}**.

{% list tabs %}

* {{ TF }}

   To add a segment host to a cluster:

   1. Open the relevant {{ TF }} configuration file with the description of the cluster and its hosts.

      For more information about creating this file, see [{#T}](../cluster-create.md).

   1. Change the number of hosts in the description of the {{ mgp-name }} cluster:

      ```hcl
      resource "yandex_mdb_greenplum_cluster" "<cluster name>" {
        ...
        master_host_count  = <number of master hosts: 1 or 2>
        segment_host_count = <number of segment hosts>
      }
      ```

   1. Make sure the settings are correct.

      {% include [terraform-validate](../../../_includes/mdb/terraform/validate.md) %}

   1. Confirm the update of resources.

      {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

   For more information, see the [{{ TF }} provider documentation]({{ tf-provider-mgp }}).

{% endlist %}

{% endif %}

{% include [greenplum-trademark](../../../_includes/mdb/mgp/trademark.md) %}
