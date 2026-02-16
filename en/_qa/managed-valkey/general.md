#### What is {{ mrd-short-name }}? {#what-is}

{{ mrd-short-name }} is a solution that helps you create, operate, and scale {{ VLK }} databases in the cloud.

With {{ mrd-short-name }}, you can:
- Create a database with performance tailored to your needs.
- Scale computing power and storage size allocated to your databases as needed.
- Get database logs.

{{ mrd-short-name }} handles the heavy lifting of {{ VLK }} infrastructure management:
- Monitors your resource consumption.
- Performs automated database backups.
- Ensures fault tolerance through automatic failover to standby replicas.
- Keeps your DBMS software up to date.

You can work with a {{ mrd-short-name }} database cluster the same way as with your regular local database. This allows you to manage internal database settings to meet your app requirements.


#### What is the role of {{ mrd-short-name }} in database management and maintenance? {#services}

When you create clusters, {{ mrd-short-name }} allocates resources, installs the DBMS, and creates databases.

For all created and running databases, {{ mrd-short-name }} automatically creates backups as well as applies DBMS fixes and updates.

Furthermore, {{ mrd-short-name }} ensures data replication across database hosts, both within and across [availability zones](../../overview/concepts/geo-scope.md), with automatic failover to a standby replica if a failure occurs.

{% include [responsibilities-link](../../_includes/mdb/responsibilities-link.md) %}

#### Not sure whether to use {{ mrd-short-name }} or VMs with databases? {#mdb-advantage}

{{ yandex-cloud }} offers two ways to work with databases:

- With {{ mrd-short-name }}, you can use template databases, with no administrative effort required.
- With {{ compute-full-name }} virtual machines, you can create and customize your own databases. This approach allows you to use any database management system, connect to databases over SSH, and many more.


#### What is a database host and database cluster? {#what-is-cluster}

A _database host_ is a cloud-based isolated database environment with dedicated computing resources and reserved storage capacity.

A _database cluster_ consists of one or more database hosts with configurable replication across them.


#### How do I get started with {{ mrd-short-name }}? {#quickstart}

{{ mrd-short-name }} is available to all registered {{ yandex-cloud }} users.

Before you create a database cluster in {{ mrd-short-name }}, you need to decide on its specifications:

- [Host class](../../managed-valkey/concepts/instance-types.md) that will determine your host performance by specifying its resources, such as the number of vCPUs, RAM size, etc.
- [Disk type](../../managed-valkey/concepts/storage.md) and size (fully reserved when creating the cluster).
- Your cluster network.
- Number of hosts in your cluster and availability zone for each host.

For more information, see [Getting started](../../managed-valkey/quickstart.md).

#### How many database hosts can there be in a cluster? {#how-many-hosts}

The minimum cluster size depends on the following:
* Your chosen [platform and host class](../../managed-valkey/concepts/instance-types.md).
* Selected [disk type](../../managed-valkey/concepts/storage.md).
* Whether you enabled [sharding](../../managed-valkey/concepts/sharding.md) when [creating](../../managed-valkey/operations/cluster-create.md) a cluster.

The maximum number of hosts in a cluster is only limited by the computing resources you request and the size of storage allocated to the cluster.

For more information, see [Quotas and limits](../../managed-valkey/concepts/limits.md).

#### How can I access a running database host? {#db-access}

You can connect to {{ mrd-short-name }} databases using conventional DBMS methods. However, note that {{ mrd-short-name }} hosts can only be accessed from {{ yandex-cloud }} VMs in the same network.


#### How many clusters can I create within a single cloud? {#db-limit}

To learn more about technical and organizational limitations of MDB, see [Quotas and limits](../../managed-valkey/concepts/limits.md).


#### How are database clusters maintained? {#service-window}

Maintenance in {{ mrd-short-name }} includes:

- Automatic installation of DBMS updates and patches for database hosts (including for stopped clusters).
- Changes in the host class and storage size.
- Other {{ mrd-short-name }} maintenance tasks.

For more information, see [Maintenance](../../managed-valkey/concepts/maintenance.md).

#### Which {{ VLK }} version does {{ mrd-short-name }} use? {#dbms-version}

{{ mrd-short-name }} supports {{ VLK }} {{ versions.console.str }}.

#### What happens when a new DBMS version is released? {#new-version}

The database software is updated whenever new minor versions are released. Owners of affected database clusters get advance notice of the upcoming maintenance schedule and database availability.


#### What happens when a DBMS version becomes deprecated? {#dbms-deprecated}

One month after a DBMS version becomes deprecated, {{ mrd-short-name }} automatically sends email notifications to the owners of database clusters created with that version.

For clusters with a deprecated DBMS version, there is no option to create new hosts or restore from backups. Database clusters are automatically upgraded to the next supported version seven days after notification for minor versions and one month after notification for major versions. Deprecated major versions will be upgraded even if you disabled automatic updates.


#### How do you calculate usage cost for a database host? {#db-cost}

In {{ mrd-short-name }}, the usage cost is calculated based on the following:

- Selected host class.
- Reserved storage capacity for the database host.
- Size of database cluster backups. You are not charged for backup storage up to the size of your provisioned storage. Backup storage exceeding this limit is charged according to our [pricing policy](../../managed-valkey/pricing.md).
- Database host uptime in hours. Partial hours are rounded to the nearest whole hour. For the hourly rates of each host class, see our [pricing policy](../../managed-valkey/pricing.md).

#### How can I change the computing resources and storage size for a database cluster? {#resources-change}

You can scale your computing resources and storage size directly in the management console by selecting a different host class for your cluster.

The cluster settings will update within 30 minutes. This window may also be used for other maintenance tasks, such as installing updates.

#### How do I fix the `Maximum number of hosts reached` error when adding a host to my cluster? {#error-when-adding-host}

This error occurs when adding a host to a {{ mrd-name }} cluster with the `b2.medium` or `b3-c1-m4` [host class](../../managed-valkey/concepts/instance-types.md#available-flavors). In this case, [change the host class](../../managed-valkey/operations/update.md#change-resource-preset). The cluster will become unavailable for about five to seven minutes. Then, add a host to the cluster.

Clusters with the `b2.medium` or `b3-c1-m4` host class may contain only one host per cluster or [shard](../../managed-valkey/concepts/sharding.md). If you want to keep the original host class, add a new host with the required configuration after changing the class and then delete the old one. Then, change the host class back to the original one.

#### Are database host backups enabled by default? {#default-backup}

Yes, backups are enabled by default. The {{ VLK }} backup policies provide full daily backups and continuous transaction log archiving. This enables you to restore your cluster to any point in time within the backup retention period, except for the last 30 seconds.

By default, backups are retained for seven days.

#### When does a backup run? Can I access my database cluster during backup? {#backup-window}

The backup window, i.e., the scheduled time for the full daily backup of a database cluster, is from 01:00 to 05:00 (UTC+3).

Clusters remain fully available during the backup window.

#### What metrics and processes can be monitored? {#monitoring}

For all DBMS types, you can monitor:

- CPU, memory, network, and disk utilization, in absolute terms.
- Memory, network, and disk utilization as a percentage of the set limits for the cluster’s host class.
- Total cluster data size and available storage space remaining.

For all database hosts, you can monitor metrics specific to their DBMS type. For example, for {{ VLK }}, you can monitor:
- Average query execution time.
- Number of queries per second.
- Number of errors in logs, and more.

You can monitor metrics with a minimum granularity of five seconds.

#### How can I configure an alert for when disk usage reaches a certain percentage? {#disk-space-percentage}

[Create an alert](../../managed-valkey/operations/monitoring.md#monitoring-integration) for the `disk.used_bytes` metric in {{ monitoring-full-name }}. This metric shows the disk space usage in the {{ mrd-name }} cluster.

For `disk.used_bytes`, use notification thresholds. Their recommended values are as follows:

* `Alarm`: 90% of disk space
* `Warning`: 80% of disk space

Thresholds are set in bytes only. For example, the recommended values for a 100 GB disk are as follows:

* `Alarm`: `96636764160` bytes (90%).
* `Warning`: `85899345920` bytes (80%).

{% include [fz-152.md](../fz-152.md) %}

{% include [logs](../logs.md) %}

{% include [log-duration](../../_includes/mdb/log-duration-qa.md) %}

#### Why is my cluster slow even though the computing resources are not fully utilized? {#throttling}

Most likely, [IOPS and bandwidth](../../compute/concepts/storage-read-write.md) limits of your storage are too low to handle the current command load. This leads to [throttling](../../compute/concepts/storage-read-write.md#throttling) which degrades the overall performance of the cluster.

Maximum IOPS and bandwidth increase by a fixed increment for each storage expansion step. The step and increment depend on the disk type:

| Disk type                  | Step, GB | Max IOPS increment (read/write) | Max bandwidth increment (read/write), MB/s |
|-----------------------------|---------|------------------------------------|-----------------------------------------------|
| `network-ssd`               | 32      | 1,000/1,000                          | 15/15                                         |
| `network-ssd-nonreplicated` | 93      | 28,000/5,600                         | 110/82                                        |

To increase the maximum IOPS and bandwidth values and make throttling less likely, expand the storage when [updating your cluster](../../managed-valkey/operations/update.md#change-disk-size).

Consider switching to a higher-speed disk type by [restoring the cluster](../../managed-valkey/operations/cluster-backups.md#restore) from a backup.

#### Can I connect to cluster hosts over SSH or get superuser privileges on hosts? {#connect-ssh}

{% include [connect-via-ssh](../../_includes/mdb/connect-via-ssh.md) %}

#### What should I do if I get a revocation check error when using PowerShell to obtain an SSL certificate? {#get-ssl-error}

Here is the full text of the error:

```text
curl: (35) schannel: next InitializeSecurityContext failed: Unknown error (0x80092012)
The revocation function was unable to check revocation for the certificate
```
This means that when connecting to the website, the service was unable to check whether or not its certificate was listed among revoked ones.

To fix this error:

* Make sure your corporate network policies are not blocking the check.
* Run the following command with the `--ssl-no-revoke` parameter:

   ```powershell
   mkdir $HOME\.redis; curl.exe --ssl-no-revoke -o $HOME\.redis\{{ crt-local-file }} {{ crt-web-path }}
   ```

