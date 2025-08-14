#### What is {{ mrd-short-name }}? {#what-is}

{{ mrd-short-name }} is a service that helps you create, operate, and scale {{ VLK }} databases in a cloud infrastructure.

With {{ mrd-short-name }}, you can:
- Create a database with the required performance characteristics.
- Scale your processing power and storage size allocated to your databases as needed.
- Get database logs.

{{ mrd-short-name }} takes on time-consuming {{ VLK }} infrastructure administration tasks:
- Monitors resource usage.
- Automatically creates DB backups.
- Provides fault tolerance through automatic failover to backup replicas.
- Keeps database software updated.

You interact with database clusters in {{ mrd-short-name }} the same way you interact with regular databases in your local infrastructure. This allows you to manage internal database settings to meet your app requirements.


#### What part of database management and maintenance is {{ mrd-short-name }} responsible for? {#services}

When you create clusters, {{ mrd-short-name }} allocates resources, installs the DBMS, and creates databases.

For the created and running databases, {{ mrd-short-name }} automatically creates backups and applies fixes and updates to the DBMS.

{{ mrd-short-name }} also allows you to replicate data between database hosts (both within and across [availability zones](../../overview/concepts/geo-scope.md)) and automatically routes the load to a backup replica in the event of a failure.

#### Which tasks are best addressed using {{ mrd-short-name }}, and which using VMs with databases? {#mdb-advantage}

{{ yandex-cloud }} offers two ways to work with databases:

- {{ mrd-short-name }} allows you to operate template databases with no need to worry about administration.
- {{ compute-full-name }} virtual machines allow you to create and configure your own databases. This approach allows you to use any database management systems, access databases via SSH, etc.


#### What is a database host and database cluster? {#what-is-cluster}

A _database host_ is an isolated database environment in the cloud infrastructure with dedicated computing resources and reserved data storage.

A _database cluster_ is one or more database hosts between which you can configure replication.


#### How do I get started with {{ mrd-short-name }}? {#quickstart}

{{ mrd-short-name }} is available to any registered {{ yandex-cloud }} user.

To create a database cluster in {{ mrd-short-name }}, you need to define its parameters:

- [Host class](../../managed-redis/concepts/instance-types.md) (performance characteristics, such as CPUs, RAM, etc.).
- [Disk type](../../managed-redis/concepts/storage.md) and size (reserved in full when creating a cluster).
- Network your cluster will be connected to.
- Number of hosts for the cluster and the availability zone for each host.

For more information, see [Getting started](../../managed-redis/quickstart.md).

#### How many database hosts can there be in one cluster? {#how-many-hosts}

The minimum number of hosts per cluster depends on the following:
* Selected [platform and host class](../../managed-redis/concepts/instance-types.md).
* Selected [disk type](../../managed-redis/concepts/storage.md).
* Whether you enabled [sharding](../../managed-redis/concepts/sharding.md) when [creating](../../managed-redis/operations/cluster-create.md) a cluster.

The maximum number of hosts in a cluster is only limited by the requested computing resources and the size of the storage for the cluster.

For more information, see [Quotas and limits](../../managed-redis/concepts/limits.md).

#### How can I access a running DB host? {#db-access}

You can connect to {{ mrd-short-name }} databases using standard DBMS methods. However, there is one exception: {{ mrd-short-name }} hosts can only be accessed from {{ yandex-cloud }} VMs connected to the same network.


#### How many clusters can I create within a single cloud? {#db-limit}

For more information on MDB technical and organizational limitations, see [Quotas and limits](../../managed-redis/concepts/limits.md).


#### How are DB clusters maintained? {#service-window}

In {{ mrd-short-name }}, maintenance implies:

- Automatic installation of DBMS updates and revisions for DB hosts (including disabled clusters).
- Changes to the host class and storage size.
- Other {{ mrd-short-name }} maintenance activities.

For more information, see [Maintenance](../../managed-redis/concepts/maintenance.md).

#### Which {{ VLK }} version does {{ mrd-short-name }} use? {#dbms-version}

{{ mrd-short-name }} supports {{ VLK }} versions {{ versions.console.str }}.

#### What happens when a new DBMS version is released? {#new-version}

The database software is updated when new minor versions are released. Owners of the affected DB clusters are notified of expected work times and DB availability in advance.


#### What happens when a DBMS version becomes deprecated? {#dbms-deprecated}

One month after the database version becomes deprecated, {{ mrd-short-name }} automatically sends email notifications to the owners of DB clusters created with this version.

New hosts can no longer be created using deprecated DBMS versions. Database clusters are automatically upgraded to the next supported version seven days after notification for minor versions and one month after notification for major versions. Deprecated major versions are going to be upgraded even if you have disabled automatic updates.


#### How do you calculate usage cost for a database host? {#db-cost}

In {{ mrd-short-name }}, the usage cost is calculated based on the following parameters:

- Selected host class.
- Size of the storage reserved for the database host.
- Size of the database cluster backups. Backup size equal to the storage size is free of charge. Backup storage that exceeds this size is charged at [special rates](../../managed-redis/pricing.md).
- Number of hours of database host operation. Partial hours are rounded to an integer value. You can find the cost per hour data for each host class in the [Pricing policy](../../managed-redis/pricing.md) section.

#### How can I change the computing resources and storage size for a database cluster? {#resources-change}

You can change computing resources and storage size in the management console. All you need to do is choose a different host class for the required cluster.

The cluster characteristics change within 30 minutes. During this period, other maintenance activities may also be enabled for the cluster, such as installing updates.

#### How do I fix the `Maximum number of hosts reached` error when adding a host to the cluster? {#error-when-adding-host}

This error occurs when adding a host to the {{ mrd-name }} cluster with the `b2.medium` or `b3-c1-m4` [host class](../../managed-redis/concepts/instance-types.md#available-flavors). In this case, [change the host class](../../managed-redis/operations/update.md#change-resource-preset). The cluster will become unavailable for about five to seven minutes. Then, add a host to the cluster.

Clusters with the `b2.medium` or `b3-c1-m4` host class may contain only one host per cluster or [shard](../../managed-redis/concepts/sharding.md). If you want to save a host class, after changing the class, you can add the host with the configuration you need and delete the previous host. Then, change the host class back to the initial one.

#### Is database host backup enabled by default? {#default-backup}

Yes, backup is enabled by default. For {{ VLK }}, a full backup takes place once a day and saves all DB cluster transaction logs. This allows you to restore the cluster state to any point in time during the backup storage period, except for the last 30 seconds.

By default, backups are stored for seven days.

#### When are backups performed? Is a database cluster available during backup? {#backup-window}

The backup window is an interval during which a full daily backup of the DB cluster is performed. The backup window is from 01:00 to 05:00 (UTC+3).

Clusters remain fully accessible during the backup window.

#### What metrics and processes can be tracked using monitoring? {#monitoring}

For all DBMS types, you can track:

- CPU, memory, network, or disk usage, in absolute terms.
- Memory, network, or disk usage as a percentage of the set limits for the corresponding cluster host class.
- Amount of data in the DB cluster and the remaining free space in the data storage.

For DB hosts, you can track metrics specific to the corresponding type of DBMS. For example, for {{ VLK }}, you can track:
- Average query execution time.
- Number of queries per second.
- Number of errors in logs, etc.

Monitoring can be performed with a minimum granularity of 5 seconds.

#### How do I set up an alert that triggers as soon as a certain percentage of disk space has been used up? {#disk-space-percentage}

[Create an alert](../../managed-redis/operations/monitoring.md#monitoring-integration) with the `disk.used_bytes` metric in {{ monitoring-full-name }}. This metric shows the disk space usage in the {{ mrd-name }} cluster.

For `disk.used_bytes`, use notification thresholds. The recommended values are as follows:

* `Alarm`: 90% of disk space
* `Warning`: 80% of disk space

Thresholds are set in bytes only. For example, the recommended values for a 100 GB disk are as follows:

* `Alarm`: `96636764160` bytes (90%).
* `Warning`: `85899345920` bytes (80%).

{% include [fz-152.md](../fz-152.md) %}

{% include [logs](../logs.md) %}

{% include [log-duration](../../_includes/mdb/log-duration-qa.md) %}

#### Why is the cluster slow even though the computing resources are not used fully? {#throttling}

Your storage may have insufficient maximum [IOPS and bandwidth](../../compute/concepts/storage-read-write.md) to process the current number of requests. In this case, [throttling](../../compute/concepts/storage-read-write.md#throttling) occurs, which degrades the entire cluster performance.

The maximum IOPS and bandwidth values increase by a fixed value when the storage size increases by a certain step. The step and increment values depend on the disk type:

| Disk type                  | Step, GB | Max IOPS increase (read/write) | Max bandwidth increase (read/write), MB/s |
|-----------------------------|---------|------------------------------------|-----------------------------------------------|
| `network-ssd`               | 32      | 1,000/1,000                          | 15/15                                         |
| `network-ssd-nonreplicated` | 93      | 28,000/5,600                         | 110/82                                        |

To increase the maximum IOPS and bandwidth values and make throttling less likely, increase the storage size when you [update your cluster](../../managed-redis/operations/update.md#change-disk-size).

Consider switching to a faster disk type by [restoring the cluster](../../managed-redis/operations/cluster-backups.md#restore) from a backup.

#### Can I connect to cluster hosts via SSH or get superuser permissions on hosts? {#connect-ssh}

{% include [connect-via-ssh](../../_includes/mdb/connect-via-ssh.md) %}

#### What should I do if I get the revocation check error when using PowerShell to obtain an SSL certificate? {#get-ssl-error}

Here is the full text of the error:

```text
curl: (35) schannel: next InitializeSecurityContext failed: Unknown error (0x80092012)
The revocation function was unable to check revocation for the certificate
```
This means, when connecting to the website, the service was unable to check whether or not its certificate was listed among revoked ones.

To fix this error:

* Make sure the corporate network settings do not block the check.
* Run the command with the `--ssl-no-revoke` parameter.

   ```powershell
   mkdir $HOME\.redis; curl.exe --ssl-no-revoke -o $HOME\.redis\{{ crt-local-file }} {{ crt-web-path }}
   ```

