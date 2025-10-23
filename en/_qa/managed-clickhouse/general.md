#### What is {{ mch-short-name }}? {#what-is}

{{ mch-short-name }} is a solution that helps you create, operate, and scale {{ CH }} databases in the cloud.

With {{ mch-short-name }}, you can:
- Create a database with the performance parameters tailored to your needs.
- Scale computing power and dedicated storage capacity for your databases as needed.
- Get database logs.

{{ mch-short-name }} takes over time-consuming {{ CH }} infrastructure administration tasks:
- Monitors resource usage.
- Automatically creates DB backups.
- Provides fault tolerance through automatic failover to backup replicas.
- Keeps database software updated.

You work with a {{ mch-short-name }} database cluster as if it were a regular database in your local infrastructure This allows you to manage internal database settings to meet your app requirements.

#### What is {{ CH }} used for? Which DBMS should I select? {#why-ch}

{{ CH }} is designed primarily for analytics (OLAP) and only supports adding and reading data. You can update data but with [certain limitations](https://stackoverflow.com/questions/37901642/updating-data-in-clickhouse). For other purposes, you might want to use another DBMS.

#### What is {{ mch-short-name }}'s share of database management and maintenance work? {#services}

When you create clusters, {{ mch-short-name }} allocates resources, installs the DBMS, and creates databases.

For all created and running databases, {{ mch-short-name }} automatically creates backups and applies fixes and updates.

{{ mch-short-name }} also enables data replication between database hosts (both within and across [availability zones](../../overview/concepts/geo-scope.md)) and automatically fails over to a backup replica if a failure occurs.

{% include [responsibilities-link](../../_includes/mdb/responsibilities-link.md) %}

#### Not sure whether to use {{ mch-short-name }} or VMs running databases? {#mdb-advantage}

{{ yandex-cloud }} offers two ways to work with databases:

- {{ mch-short-name }}: Enables you to operate template databases without needing to manage their administration.
- {{ compute-full-name }} VM: Enables you to create and configure your own databases. With this approach, you can use any database management systems, access databases via SSH, and more.

#### What is a database host and database cluster? {#what-is-cluster}

A _database host_ is an isolated database environment in the cloud with dedicated computing resources and reserved storage capacity.

A _database cluster_ is one or more database hosts with the option to configure replication.

#### How do I get started with {{ mch-short-name }}? {#quickstart}

{{ mch-short-name }} is available to all registered {{ yandex-cloud }} users.

To create a database cluster in {{ mch-short-name }}, you need to define its settings:

- [Host class](../../managed-clickhouse/concepts/instance-types.md) (performance parameters, such as CPUs, RAM, etc.).
- Storage size (fully reserved when creating the cluster).
- Network your cluster will be connected to.
- Number of hosts for your cluster and availability zone for each host.

For more information, see [Getting started](../../managed-clickhouse/quickstart.md).

#### How many database hosts does a cluster support? {#how-many-hosts}


The minimum number of hosts in a cluster depends on the following:
    
  * [Storage type](../../managed-clickhouse/concepts/storage.md):

    * At least three hosts for non-replicated SSDs (`network-ssd-nonreplicated`).

    * At least two hosts for local SSDs (`local-ssd`).

    * At least one host for the following:

      * Network HDDs (`network-hdd`).
      * Network SSDs (`network-ssd`).
      * Ultra high-speed network SSDs with three replicas (`network-ssd-io-m3`).

  * Cluster sharding. When sharding is enabled, you need to multiply the minimum number of hosts for the selected disk type by the number of shards.

    For more information on the features and limitations of sharding in {{ CH }}, see [this article](../../managed-clickhouse/concepts/sharding.md).


The maximum number of hosts per cluster cannot exceed the set limits.

For more information, see [Quotas and limits](../../managed-clickhouse/concepts/limits.md).

#### How can I access a running DB host? {#db-access}

You can connect to {{ mch-short-name }} databases using standard DBMS methods.

Learn more about connecting to clusters [here](../../managed-clickhouse/operations/connect/index.md).

#### How many clusters can I create within a single cloud? {#db-limit}

For more information on MDB technical and organizational limitations, see [Quotas and limits](../../managed-clickhouse/concepts/limits.md).

#### How are DB clusters maintained? {#service-window}

In {{ mch-short-name }}, maintenance implies:

- Automatic installation of DBMS updates and fixes for DB hosts (including disabled clusters).
- Changes to the host class and storage size.
- Other {{ mch-short-name }} maintenance activities.

For more information, see [Maintenance](../../managed-clickhouse/concepts/maintenance.md).

#### How do I edit external dictionaries? {#external-dict}

To rename a dictionary, run this query:

```sql
RENAME DICTIONARY <dictionary_name> TO <new_name>
```

For other changes, use the [update](../../managed-clickhouse/api-ref/Cluster/update.md) API method.

#### Which {{ CH }} version does {{ mch-short-name }} use? {#dbms-version}

{{ mch-short-name }} uses multiple latest stable versions of {{ CH }}. For more information, see [{#T}](../../managed-clickhouse/concepts/update-policy.md).

#### Which {{ CH }} version should I choose? {#choose-version}

We recommend the latest available LTS version of {{ CH }}. For more information, see [{#T}](../../managed-clickhouse/concepts/update-policy.md).

#### What happens when a new DBMS version is released? {#new-version}

When new minor versions are released, the cluster software is automatically updated after a short testing period. 

Owners of the affected DB clusters are notified of an expected maintenance period and DB availability in advance. 

#### What happens when a DBMS version becomes deprecated? {#dbms-deprecated}

When a DBMS version becomes deprecated, {{ mch-short-name }} automatically sends email notifications to the owners of database clusters created with this version.

New hosts can no longer be created using deprecated DBMS versions. Clusters running a deprecated {{ CH }} version are updated according to the [versioning policy](../../managed-clickhouse/concepts/update-policy.md).

Owners of the affected DB clusters are notified of an expected maintenance period and DB availability in advance.

#### How do you calculate usage cost for a database host? {#db-cost}

In {{ mch-short-name }}, the usage cost is calculated based on the following:

- Selected host class.
- Size of the storage reserved for the database host.
- Size of the database cluster backups. Backup size equal to the storage size is free of charge. Backup storage that exceeds this size is charged based on the [pricing policy](../../managed-clickhouse/pricing.md).
- Database host uptime in hours. Partial hours are rounded up to the nearest whole hour. For the cost per hour of operation for each host class, see [Pricing policy](../../managed-clickhouse/pricing.md).

#### How much does it cost to use my cluster? {#cluster-cost}

In the [management console]({{ link-console-main }}), navigate to the folder dashboard, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**, and click the cluster you need. On the right side of the screen, you will see the cluster usage cost per month. For more information, see [Pricing policy](../../managed-clickhouse/pricing.md).

#### How can I change the computing resources and storage size for a database cluster? {#resources-change}

You can change computing resources and storage size in the management console. All you need to do is choose a different host class for the relevant cluster.

The cluster settings update within 30 minutes. This period may also include other cluster maintenance activities, such as installing updates.

#### How can I fix the no permission error when assigning a service account to a cluster? {#attach-service-account}

{% include notitle [attach-sa](../../_qa/attach-sa.md) %}

{% include [fz-152.md](../../_qa/fz-152.md) %}

{% include [logs](../logs.md) %}
