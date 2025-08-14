#### What is {{ mch-short-name }}? {#what-is}

{{ mch-short-name }} is a service that helps you create, operate, and scale {{ CH }} databases in a cloud infrastructure.

With {{ mch-short-name }}, you can:
- Create a database with the required performance characteristics.
- Scale processing power and storage dedicated for your databases as needed.
- Get database logs.

{{ mch-short-name }} takes on time-consuming {{ CH }} infrastructure administration tasks:
- Monitors resource usage.
- Automatically creates DB backups.
- Provides fault tolerance through automatic failover to backup replicas.
- Keeps database software updated.

You interact with database clusters in {{ mch-short-name }} the same way you interact with regular databases in your local infrastructure. This allows you to manage internal database settings to meet your app requirements.

#### What is {{ CH }} used for? Which DBMS should I select? {#why-ch}

{{ CH }} is designed primarily for analytics (OLAP) and only supports adding and reading data. You can update data but with [limitations](https://stackoverflow.com/questions/37901642/updating-data-in-clickhouse). For other purposes, you might want to use other managed DB services.

#### What part of database management and maintenance is {{ mch-short-name }} responsible for? {#services}

When you create clusters, {{ mch-short-name }} allocates resources, installs the DBMS, and creates databases.

For the created and running databases, {{ mch-short-name }} automatically creates backups and applies fixes and updates to the DBMS.

{{ mch-short-name }} also allows you to replicate data between database hosts (both within and across [availability zones](../../overview/concepts/geo-scope.md)) and automatically routes the load to a backup replica in the event of a failure.

#### Which tasks are best addressed using {{ mch-short-name }}, and which using VMs with databases? {#mdb-advantage}

{{ yandex-cloud }} offers two ways to work with databases:

- {{ mch-short-name }} allows you to operate template databases with no need to worry about administration.
- {{ compute-full-name }} virtual machines allow you to create and configure your own databases. This approach allows you to use any database management systems, access databases via SSH, etc.

#### What is a database host and database cluster? {#what-is-cluster}

A _database host_ is an isolated database environment in the cloud infrastructure with dedicated computing resources and reserved data storage.

A _database cluster_ is one or more database hosts between which you can configure replication.

#### How do I get started with {{ mch-short-name }}? {#quickstart}

{{ mch-short-name }} is available to any registered {{ yandex-cloud }} user.

To create a database cluster in {{ mch-short-name }}, you need to define its parameters:

- [Host class](../../managed-clickhouse/concepts/instance-types.md) (performance characteristics, such as CPUs, RAM, etc.).
- Storage size (reserved to the full extent when you create a cluster).
- Network your cluster will be connected to.
- Number of hosts for the cluster and the availability zone for each host.

For more information, see [Getting started](../../managed-clickhouse/quickstart.md).

#### How many database hosts can there be in one cluster? {#how-many-hosts}


The minimum number of hosts in a cluster depends on the following:
    
  * [Storage type](../../managed-clickhouse/concepts/storage.md):

    * At least three hosts for non-replicated SSDs (`network-ssd-nonreplicated`).

    * At least two hosts for local SSDs (`local-ssd`).

    * At least one host for the following:

      * Network HDDs (`network-hdd`).
      * Network SSDs (`network-ssd`).
      * Ultra high-speed network SSDs with three replicas (`network-ssd-io-m3`).

  * Cluster sharding. When sharding is enabled, you need to multiply the minimum number of hosts for the selected disk type by the number of shards.

    For more information on the features and limitations of sharding in {{ CH }}, see [this section](../../managed-clickhouse/concepts/sharding.md).


The maximum number of hosts per cluster is subject to the limits in place.

For more information, see [Quotas and limits](../../managed-clickhouse/concepts/limits.md).

#### How can I access a running DB host? {#db-access}

You can connect to {{ mch-short-name }} databases using standard DBMS methods.

[Learn more about connecting to clusters](../../managed-clickhouse/operations/connect/index.md).

#### How many clusters can I create within a single cloud? {#db-limit}

For more information on MDB technical and organizational limitations, see [Quotas and limits](../../managed-clickhouse/concepts/limits.md).

#### How are DB clusters maintained? {#service-window}

In {{ mch-short-name }}, maintenance implies:

- Automatic installation of DBMS updates and revisions for DB hosts (including disabled clusters).
- Changes to the host class and storage size.
- Other {{ mch-short-name }} maintenance activities.

For more information, see [Maintenance](../../managed-clickhouse/concepts/maintenance.md).

#### How do I edit external dictionaries? {#external-dict}

To rename a dictionary, run the query:

```sql
RENAME DICTIONARY <dictionary_name> TO <new_name>
```

For other changes, use the [update](../../managed-clickhouse/api-ref/Cluster/update.md) API method.

#### Which {{ CH }} version does {{ mch-short-name }} use? {#dbms-version}

{{ mch-short-name }} uses some of the latest stable versions of {{ CH }}. For more information, see [{#T}](../../managed-clickhouse/concepts/update-policy.md).

#### Which {{ CH }} version should I choose? {#choose-version}

We recommend the latest available LTS version of {{ CH }}. For more information, see [{#T}](../../managed-clickhouse/concepts/update-policy.md).

#### What happens when a new DBMS version is released? {#new-version}

When new minor versions are released, the cluster software is automatically updated after a short testing period. 

Owners of the affected DB clusters are notified of expected work times and DB availability in advance. 

#### What happens when a DBMS version becomes deprecated? {#dbms-deprecated}

When a DBMS version becomes deprecated, {{ mch-short-name }} automatically sends email notifications to the owners of database clusters created with this version.

New hosts can no longer be created using deprecated DBMS versions. Clusters on a deprecated version of {{ CH }} are updated according to the [versioning policy](../../managed-clickhouse/concepts/update-policy.md).

Owners of the affected DB clusters are notified of expected work times and DB availability in advance.

#### How do you calculate usage cost for a database host? {#db-cost}

In {{ mch-short-name }}, the usage cost is calculated based on the following parameters:

- Selected host class.
- Size of the storage reserved for the database host.
- Size of the database cluster backups. Backup size equal to the storage size is free of charge. Backup storage that exceeds this size is charged at [special rates](../../managed-clickhouse/pricing.md).
- Number of hours of database host operation. Partial hours are rounded to an integer value. You can find the cost per hour for each host class in the [Pricing policy](../../managed-clickhouse/pricing.md) section.

#### How much does it cost to use my cluster? {#cluster-cost}

In the [management console]({{ link-console-main }}), go to the folder page, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**, and click the appropriate cluster. On the right side of the screen, you will see the cluster usage cost per month. For more information, see [Pricing policy](../../managed-clickhouse/pricing.md).

#### How can I change the computing resources and storage size for a database cluster? {#resources-change}

You can change computing resources and storage size in the management console. All you need to do is choose a different host class for the required cluster.

The cluster characteristics change within 30 minutes. During this period, other maintenance activities may also be enabled for the cluster, such as installing updates.

#### How can I fix the no permission error when connecting a service account to the cluster? {#attach-service-account}

{% include notitle [attach-sa](../../_qa/attach-sa.md) %}

{% include [fz-152.md](../../_qa/fz-152.md) %}

{% include [logs](../logs.md) %}
