#### What is {{ mch-short-name }}? {#what-is}

{{ mch-short-name }} is a solution that helps you create, operate, and scale {{ CH }} databases in the cloud.

With {{ mch-short-name }}, you can:
- Create a database with performance tailored to your needs.
- Scale computing power and dedicated storage capacity for your databases as needed.
- Get database logs.

{{ mch-short-name }} takes over time-consuming administrative tasks in {{ CH }}:
- Monitors your resource consumption.
- Automatically backs up your databases.
- Ensures [high availability](../../managed-clickhouse/concepts/high-availability.md) through automatic failover to standby replicas.
- Keeps your DBMS software up to date.

You work with a {{ mch-short-name }} database cluster just like with your regular local database. Thus, you can manage internal database settings to meet your application requirements.

#### What is {{ CH }} used for? Which DBMS should I select? {#why-ch}

{{ CH }} is designed primarily for analytics (OLAP) and only supports adding and reading data. You can update data but with [certain limitations](https://stackoverflow.com/questions/37901642/updating-data-in-clickhouse). For other purposes, you might want to use another DBMS.

#### What is the role of {{ mch-short-name }} in database management and maintenance? {#services}

When you create clusters, {{ mch-short-name }} allocates resources, installs the DBMS, and creates databases.

For all created and running databases, {{ mch-short-name }} automatically creates backups as well as applies DBMS patches and updates.

Furthermore, {{ mch-short-name }} ensures data replication across database hosts, both within and across [availability zones](../../overview/concepts/geo-scope.md), with automatic failover to a standby replica if a failure occurs.

{% include [responsibilities-link](../../_includes/mdb/responsibilities-link.md) %}

#### Not sure whether to use {{ mch-short-name }} or VMs with databases? {#mdb-advantage}

{{ yandex-cloud }} offers two ways to work with databases:

- With {{ mch-short-name }}, you can use template databases, with no administrative effort required.
- With {{ compute-full-name }} virtual machines, you can create and customize your own databases. This approach allows you to use any database management system, connect to databases over SSH, and many more.

#### What is a database host and database cluster? {#what-is-cluster}

A _database host_ is a cloud-based isolated database environment with dedicated computing resources and reserved storage capacity.

A _database cluster_ consists of one or more database hosts with configurable replication across them.

#### How do I get started with {{ mch-short-name }}? {#quickstart}

{{ mch-short-name }} is available to all registered {{ yandex-cloud }} users.

Before creating a database cluster in {{ mch-short-name }}, you need to decide on its configuration:

- [Host class](../../managed-clickhouse/concepts/instance-types.md) that will determine your computing power, i.e., vCPUs, RAM, and more.
- Storage size (fully reserved when creating the cluster).
- Network for your cluster.
- Number of hosts in your cluster and availability zone for each host.

For more information, see [Getting started](../../managed-clickhouse/quickstart.md).

#### How many database hosts can be in a cluster? {#how-many-hosts}


The minimum number of hosts in a cluster depends on the following:
    
  * [Storage type](../../managed-clickhouse/concepts/storage.md):

    * At least three hosts for non-replicated SSDs (`network-ssd-nonreplicated`).

    * At least two hosts for local SSDs (`local-ssd`).

    * At least one host for the following disk types:

      * Network HDDs (`network-hdd`)
      * Network SSDs (`network-ssd`)
      * Ultra high-speed network SSDs with three replicas (`network-ssd-io-m3`)

  * Cluster sharding. When sharding is enabled, you need to multiply the minimum number of hosts for the selected disk type by the number of shards.

    For more information on the features and limitations of sharding in {{ CH }}, see [this article](../../managed-clickhouse/concepts/sharding.md).


The maximum number of hosts per cluster cannot exceed the set limits.

For more information, see [Quotas and limits](../../managed-clickhouse/concepts/limits.md).

#### How can I access a running database host? {#db-access}

You can connect to {{ mch-short-name }} databases using conventional DBMS methods.

Learn more about connecting to clusters in [this guide](../../managed-clickhouse/operations/connect/index.md).

#### How many clusters can I create within a single cloud? {#db-limit}

To learn more about MDB technical and organizational limitations, see [Quotas and limits](../../managed-clickhouse/concepts/limits.md).

#### How are database clusters maintained? {#service-window}

Maintenance in {{ mch-short-name }} includes:

- Automatic installation of DBMS updates and patches for all hosts, even disabled ones.
- Changes in the host class and storage size.
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

Owners of affected database clusters are notified of an expected maintenance period and database availability in advance. 

#### What happens when a DBMS version becomes deprecated? {#dbms-deprecated}

When a DBMS version becomes deprecated, {{ mch-short-name }} automatically sends email notifications to the owners of database clusters created with this version.

New hosts can no longer be created using deprecated DBMS versions. Clusters running a deprecated {{ CH }} version are updated according to the [versioning policy](../../managed-clickhouse/concepts/update-policy.md).

Owners of affected database clusters are notified of an expected maintenance period and database availability in advance.

#### How do you calculate usage cost for a database host? {#db-cost}

In {{ mch-short-name }}, the usage cost is calculated based on the following:

- Selected host class.
- Reserved storage capacity for the database host.
- Size of database cluster backups. You are not charged for storing backups up to your storage size. Additional backup storage is charged according to our [pricing policy](../../managed-clickhouse/pricing.md).
- Database host uptime in hours. Partial hours are rounded to the nearest whole hour. For the cost per hour of operation for each host class, see our [pricing policy](../../managed-clickhouse/pricing.md).

#### How much does it cost to use my cluster? {#cluster-cost}

In the [management console]({{ link-console-main }}), navigate to the folder dashboard, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}**, and click the cluster you need. On the right side of the screen, you will see the cluster usage cost per month. For more information, see our [pricing policy](../../managed-clickhouse/pricing.md).

#### How can I change the computing resources and storage size for a database cluster? {#resources-change}

You can scale your computing resources and storage size directly in the management console by selecting a different host class for your cluster.

The cluster settings will update within 30 minutes. This window may also be used for other maintenance activities, such as installing updates.

#### How can I fix the no permission error when attaching a service account to a cluster? {#attach-service-account}

{% include notitle [attach-sa](../../_qa/attach-sa.md) %}

{% include [fz-152.md](../../_qa/fz-152.md) %}

{% include [logs](../logs.md) %}
