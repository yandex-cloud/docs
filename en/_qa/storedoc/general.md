#### What is {{ mmg-short-name }}? {#what-is}

{{ mmg-short-name }} is a service that helps you create, operate, and scale {{ SD }} databases in the cloud.

With {{ mmg-short-name }}, you can:
- Create databases that meet your performance requirements.
- Scale computing power and dedicated storage capacity for your databases.
- Retrieve database logs.

{{ mmg-short-name }} handles the heavy lifting of {{ SD }} infrastructure management:
- Monitors your resource consumption.
- Performs automated database backups.
- Ensures fault tolerance through automatic failover to standby replicas.
- Keeps your database software up-to-date.

You can work with a {{ mmg-short-name }} database cluster the same way as with your regular local database. For instance, it allows you to manage the database’s internal settings to meet your application’s requirements.


#### What is the role of {{ mmg-short-name }} in database management and maintenance? {#services}

During cluster creation, {{ mmg-short-name }} allocates resources, installs the database software, and creates databases.

{{ mmg-short-name }} performs automated backups of your databases and applies database software patches and updates.

Additionally, {{ mmg-short-name }} ensures replication across database hosts (both within and between availability zones) and automatically redirects traffic to a standby replica during an outage.

{% include [responsibilities-link](../../_includes/mdb/responsibilities-link.md) %}

#### When should I use {{ mmg-short-name }} and when database-hosting VMs? {#mdb-advantage}

{{ yandex-cloud }} offers two approaches for working with databases:

- With {{ mmg-short-name }}, you can run pre-configured databases without the administrative overhead.
- Using {{ compute-full-name }} virtual machines, you can create and configure your own custom databases. This approach allows you to use any database management system, access databases over SSH, and much more.


#### What is a database host and what is a database cluster? {#what-is-cluster}

A _database host_ is a cloud-based isolated database environment with dedicated computing resources and reserved storage capacity.

A _database cluster_ consists of one or more database hosts with configurable replication between them.


#### How do I get started with {{ mmg-short-name }}? {#quickstart}

{{ mmg-short-name }} is available to all registered {{ yandex-cloud }} users.

Before you create a database cluster in {{ mmg-short-name }}, you need to decide on its specifications:

- [Host class](../../storedoc/concepts/instance-types.md) that will determine your host performance by specifying its resources, such as the number of vCPUs, RAM size, etc.
- [Disk type](../../storedoc/concepts/storage.md) and size. Its storage capacity is fully reserved when the cluster is created.
- Your cluster network.
- Number of hosts in the cluster and their respective availability zones.

For more details, see [{#T}](../../storedoc/quickstart.md).


#### How many database hosts can a cluster contain? {#how-many-hosts}

The minimum cluster size depends on the following:
* Your chosen [platform and host class](../../storedoc/concepts/instance-types.md).
* Selected [disk type](../../storedoc/concepts/storage.md).

The maximum cluster size is limited only by its allocated computing and storage resources.

For more details, see [Quotas and limits](../../storedoc/concepts/limits.md).


#### How can I access a running database host? {#db-access}

You can connect to {{ mmg-short-name }} databases using native DBMS connection methods.

To learn more about connecting to clusters see [this guide](../../storedoc/operations/connect/index.md).


#### How many clusters can I create within a single cloud? {#db-limit}

To learn more about technical and organizational limitations of MDB, see [Quotas and limits](../../storedoc/concepts/limits.md).


#### How are database clusters maintained? {#service-window}

Maintenance in {{ mmg-short-name }} includes:

- Automatic installation of database management system updates and patches for hosts in both running and stopped clusters.
- Host class and storage size scaling.
- Other {{ mmg-short-name }} maintenance tasks.

For more details, see [Maintenance](../../storedoc/concepts/maintenance.md).

#### Which {{ SD }} version does {{ mmg-short-name }} use? {#dbms-version}

{{ mmg-short-name }} supports {{ SD }} versions {{ versions.console.str }}.


#### What happens when a new DBMS version is released? {#new-version}

When new minor versions are released, the cluster software is updated after a short testing period. Affected database cluster owners receive advance notice of the maintenance schedule and database availability.


#### What happens when a DBMS version becomes deprecated? {#dbms-deprecated}

Following a one-month grace period after the end of support for a DBMS version, the relevant database cluster owners receive email notifications.

From that point on, you can no longer create new hosts with unsupported DBMS versions. Following a post-notification grace period of seven days for minor versions and one month for major versions, database clusters are automatically updated to the next supported release. We update unsupported major versions even when you have automatic updates turned off.


#### How do you calculate usage cost for a database host? {#db-cost}

In {{ mmg-short-name }}, the usage cost is calculated based on the following:

- Selected host class.
- Reserved storage capacity for the database host.
- Size of database cluster backups. You are not charged for backup storage up to the size of your provisioned storage. Backup storage exceeding this limit is charged according to our [pricing policy](../../storedoc/pricing.md).
- Database host uptime in hours. Partial hours are rounded to the nearest whole hour. The hourly cost for each host class is provided in our [pricing policy](../../storedoc/pricing.md).

#### How can I change the computing resources and storage size for a database cluster? {#resources-change}

You can scale your computing resources and storage size by selecting a different host class for your cluster in the [management console]({{ link-console-main }}).

Cluster modifications are applied within 30 minutes. This window may also be used for other maintenance tasks, such as installing updates.


#### Are database host backups enabled by default? {#default-backup}

Yes, backups are enabled by default. For {{ SD }}, a full backup is performed once a day, allowing you to restore from any saved backup point.

Backups are retained for seven days by default.

#### What is the backup schedule? Can I access my database cluster during backup? {#backup-window}

The backup window, i.e., the scheduled time for the full daily backup of a database cluster, is from 01:00 to 05:00 (UTC+3).

Clusters remain fully accessible throughout the backup window.

#### Can I change the retention period for automatic backups? {#backup-retain-days}

You can set the retention period for automatic backups when [creating](../../storedoc/operations/cluster-create.md) or [updating](../../storedoc/operations/update.md#change-additional-settings) a cluster.

#### What metrics and processes can be monitored? {#monitoring}

For all DBMS types, you can monitor:

- CPU, memory, network, and disk utilization, in absolute terms.
- Memory, network, and disk utilization as a percentage of the set limits for the cluster’s host class.
- Total cluster data size and available storage space remaining.

All database hosts support monitoring metrics specific to their DBMS type. For example, for {{ SD }} you can monitor:
- Number of queries per second.
- Disk space usage.
- Number of connections, and more.

You can monitor metrics with a five-second minimum granularity.

#### How can I configure an alert for when disk usage reaches a certain percentage? {#disk-space-percentage}

[Create an alert](../../storedoc/operations/monitoring.md#monitoring-integration) for the `disk.used_bytes` metric in {{ monitoring-full-name }}. This metric shows the disk space usage in the {{ mmg-name }} cluster.

For the `disk.used_bytes` metric, you can use notification thresholds with the following recommended values:

* `{{ ui-key.yacloud_monitoring.alert.status_alarm }}`: 90% of disk space.
* `{{ ui-key.yacloud_monitoring.alert.status_warn }}`: 70% of disk space.

Thresholds can only be set in bytes. For example, the recommended values for a 100 GB disk are as follows:

* `{{ ui-key.yacloud_monitoring.alert.status_alarm }}`: `96636764160` bytes (90%)
* `{{ ui-key.yacloud_monitoring.alert.status_warn }}`: `75161927680` bytes (70%)
