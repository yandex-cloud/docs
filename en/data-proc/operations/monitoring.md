# Monitoring the state of clusters and hosts in {{ dataproc-name }}

Using monitoring tools in the management console, you can track the status of a {{ dataproc-name }} cluster and its individual hosts. These tools display diagnostic information in the form of charts.

{% include [monitoring-source](../../_includes/mdb/monitoring-provides.md) %}

{% include [monitoring-frequency](../../_includes/mdb/monitoring-freq.md) %}

{% include [monitoring-units](../../_includes/mdb/note-monitoring-auto-units.md) %}

## Monitoring cluster status {#monitoring-cluster}

To view detailed information about the {{ dataproc-name }} cluster status:

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ dataproc-name }}**.
   1. Click on the name of the cluster and open the **Monitoring** tab.

   The tab displays the following charts:

   * **Active nodes**: The number of running hosts (except control hosts).
   * **Apps failed**: The number of applications with runtime errors.
   * **Available RAM**: The amount of free RAM (in bytes) available in YARN for hosts in `DATANODE` and `COMPUTENODE` subclusters.
   * **Available virtual cores**: The number of cores available in YARN.
   * **Containers pending**: The number of containers waiting to be launched by the YARN Resource Manager.
   * **Decommissioned nodes**: The number of hosts that have been [decommissioned](../concepts/decommission.md).

{% endlist %}

## Monitoring the state of hosts {#monitoring-hosts}

To view detailed information about the status of individual {{ dataproc-name }} hosts:

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ dataproc-name }}**.
   1. Click on the name of the cluster you want and select the **Hosts** tab.
   1. Open the VM of the desired host and select the **Monitoring** tab.

   The tab displays charts with information on VM resource usage:

   * **CPU Utilization**: Processor core workload.
   * **Connections quota utilization**: Percentage of the available host connections utilized.
   * **Disk bytes**: Storage read and write speed (bytes per second).
   * **Disk operations**: Disk activity (ops per second).
   * **Network Bytes**: The speed of data exchange over the network (bytes per second).
   * **Network Packets**: The number of packets exchanged over the network per second.

{% endlist %}
