# Managing hosts in a cluster

You can get a list of hosts (masters and segments) in a {{ mgp-name }} cluster.

## Getting a list of cluster hosts {#list}

{% list tabs %}

- Management console

    1. Go to the folder page and select **{{ mgp-name }}**.
    1. Click on the name of the cluster you need and select the **Hosts** tab.

{% endlist %}

In the list of hosts, the **Role** column shows the role of each host:

* `MASTER`: A primary master host. Receives user connections.
* `REPLICA`: A standby master host. Replicates data of the primary master host.
* `SEGMENT`: A segment host. Stores some of the cluster data.

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
