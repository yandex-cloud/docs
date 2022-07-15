# Monitoring the state of clusters and hosts

{% include [monitoring-introduction](../../_includes/mdb/monitoring-introduction.md) %}

New data for charts is received every {{ graph-update }}.

{% include [note-monitoring-auto-units](../../_includes/mdb/note-monitoring-auto-units.md) %}

## Monitoring cluster status {#monitoring-cluster}

To view detailed information about the {{ mgp-name }} cluster status:

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{ mgp-name }}**.
   1. Click the name of the desired cluster and select the ![monitoring.svg](../../_assets/monitoring.svg) **Monitoring** tab.
   1. {% include [open-in-yandex-monitoring](../../_includes/mdb/open-in-yandex-monitoring.md) %}

   The page displays the following charts:

   * **Alive hosts**: cluster host functionality.

   * **Alive segments**: primary and backup master as well as primary and mirror segment functionality.

   * **Connections**: number of DB connections in each state:

      * **Active**: active.
      * **Waiting**: waiting.
      * **Idle**: idle.
      * **Idle in transaction**: idle in a transaction.
      * **Aborted**: terminated.

   * **Group resource cpu**: processor core workload by process group:

      * **admin_group**: in the administrative group.
      * **default_group**: in the default group.

   * **Group resource memory**: bytes of RAM used by process group:

      * **admin_group**: in the administrative group.
      * **default_group**: in the default group.

   * **Master**: definition of primary master host.

   * **Master replication lag**: master replication delay (in bytes).

   * **Master replication state**: master replication condition.

   * **Segment health**: number of segments with various levels of performance:

      * **total**: everything.
      * **not sync**: unsynced.
      * **down**: unavailable.
      * **not prefer role**: non-preferred.

   * **Spill files count**: number of temporary files.

   * **Spill files size**: total size of temporary files (in bytes).

   * **Xid wraparound**: utilization of the [ sequence of transaction IDs](https://docs.greenplum.org/6-16/admin_guide/managing/maintain.html) (as a percentage).

{% endlist %}

## Monitoring the state of hosts {#monitoring-hosts}

To view detailed information about the status of individual {{ mgp-name }} hosts:

{% list tabs %}

- Management console

   1. Go to the [folder page]({{ link-console-main }}) and select **{{mgp-name }}**.
   1. Click the name of the desired cluster and select ![hosts.svg](../../_assets/mdb/hosts.svg) **Hosts** → **Monitoring**.
   1. Select the host from the drop-down list.

   This page displays graphs showing the workload of an individual cluster host (master or segment):

   * **CPU**: The load on processor cores. As the load goes up, the `Idle` value goes down.
   * **Disk IOPS in progress**: number of pending disk operations.
   * **Disk io time**: duration of disk operations.
   * **Disk read and write**: amount of data (in bytes) in disk operations.
   * **Disk read and write time**: duration of disk reads and writes.
   * **Disk usage**: disk space usage (two graphs are displayed: bytes and percent).
   * **Memory usage**: The use of RAM in bytes. At high loads, the value of `Free` goes down while the other values go up.
   * **Network**: amount of network traffic (in bytes).

{% endlist %}

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
