---
title: "{{ mch-name }}. Questions and answers"
description: "What is {{ mch-name }}? Which tasks should I use {{ mch-name }} for and for which are VMs with databases more appropriate? What part of database management and maintenance is {{ mch-name }} responsible for? Find the answers to these and other questions in this article."
---

# General questions about {{ mch-name }}

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

You interact with database clusters in {{ mch-short-name }} the same way you interact with regular databases in your local infrastructure. This allows you to manage internal database settings to meet your app's requirements.

#### What is {{ CH }} used for? Which database should I select? {#why-ch}

{{ CH }} is designed primarily for analytics (OLAP) and only supports adding and reading data. You can update data but with [limitations](https://stackoverflow.com/questions/37901642/updating-data-in-clickhouse). For other purposes, you might want to use other managed DB services.

#### What part of database management and maintenance is {{ mch-short-name }} responsible for? {#services}

When creating clusters, {{ mch-short-name }} allocates resources, installs the DBMS, and creates databases.

For the created and running databases, {{ mch-short-name }} automatically creates backups and applies fixes and updates to the DBMS.

{{ mch-short-name }} also provides data replication between database hosts (both inside and between availability zones) and automatically switches the load over to a backup replica in the event of a failure.

#### Which tasks should I use {{ mch-short-name }} for and for which VMs with databases? {#mdb-advantage}

{{ yandex-cloud }} offers two ways to work with databases:

- {{ mch-short-name }} allows you to operate template databases with no need to worry about administration.
- {{ compute-full-name }} virtual machines allow you to create and configure your own databases. This approach allows you to use any database management systems, access databases via SSH, etc.

#### What is a database host and database cluster? {#what-is-cluster}

A _database host_ is an isolated database environment in the cloud infrastructure with dedicated computing resources and reserved data storage.

A _database cluster_ is one or more database hosts between which replication can be configured.

#### How do I get started with {{ mch-short-name }}? {#quickstart}

{{ mch-short-name }} is available to any registered {{ yandex-cloud }} user.

To create a database cluster in {{ mch-short-name }}, you must define its characteristics:

- [Host class](../../managed-clickhouse/concepts/instance-types.md) (performance characteristics such as CPUs, memory, and so on).
- Storage size (reserved in full when you create the cluster).
- The network your cluster will be connected to.
- The number of hosts for the cluster and the availability zone for each host.

For detailed instructions, see [{#T}](../../managed-clickhouse/quickstart.md).

#### How many DB hosts can a cluster contain? {#how-many-hosts}

The minimum number of hosts depends on the selected type of [storage](../../managed-clickhouse/concepts/storage.md):

- If you use non-replicated SSD storage, the minimum number of hosts is 3.
- If you use local SSD storage, the minimum number of hosts is 2.
- If you use HDD network or SSD network storage, you can create single-host clusters.

The maximum number of hosts in a cluster is only limited by the requested computing resources and the size of the storage for the cluster.

For more information, see [{#T}](../../managed-clickhouse/concepts/limits.md).

#### How can I access a running DB host? {#db-access}

You can connect to {{ mch-short-name }} databases using standard DBMS methods.

[Learn more about connecting to clusters](../../managed-clickhouse/operations/connect.md).

#### How many clusters can I create within a single cloud? {#db-limit}

MDB technical and organizational limits are given in [{#T}](../../managed-clickhouse/concepts/limits.md).

#### How do I maintain database clusters? {#service-window}

Maintenance in {{ mch-short-name }} implies:

- Automatic installation of DBMS updates and revisions for DB hosts (including disabled clusters).
- Changes to the host class and storage size.
- Other {{ mch-short-name }} maintenance activities.

For more information, see [{#T}](../../managed-clickhouse/concepts/maintenance.md).

#### How do I edit external dictionaries? {#external-dict}

To rename a dictionary, run the query:

```sql
RENAME DICTIONARY <dictionary_name> TO <new_name>
```

For other changes, use the [update](../../managed-clickhouse/api-ref/Cluster/update.md) API method.

#### Which version of {{ CH }} does {{ mch-short-name }} use? {#dbms-version}

{{ mch-short-name }} uses some of the latest stable versions of {{ CH }}. For more information, see [{#T}](../../managed-clickhouse/concepts/update-policy.md).

#### Which {{ CH }} version should I choose? {#choose-version}

We recommend the latest available LTS version of {{ CH }}. For more information, see [{#T}](../../managed-clickhouse/concepts/update-policy.md).

#### What happens when a new DBMS version is released? {#new-version}

When new minor versions are released, the cluster software is automatically updated after a short testing period.

The owners of the affected DB clusters receive advanced notice of expected work times and DB availability.

#### What happens when a DBMS version becomes deprecated? {#dbms-deprecated}

When a DBMS version becomes deprecated, {{ mch-short-name }} automatically sends email notifications to the owners of database clusters created with this version.

New hosts can no longer be created using deprecated DBMS versions. Clusters on a deprecated version of {{ CH }} are updated according to the [versioning policy](../../managed-clickhouse/concepts/update-policy.md).

The owners of the affected DB clusters receive advanced notice of expected work times and DB availability.

#### How is the cost of usage calculated for a database host? {#db-cost}

In {{ mch-short-name }}, the usage cost is calculated based on the following parameters:

- Selected host class.
- Size of the storage reserved for the database host.
- Size of the database cluster backups. Backup space in the amount of the reserved storage is free of charge. Backup storage that exceeds this size is charged at [special rates](../../managed-clickhouse/pricing.md).
- Number of hours of database host operation. Partial hours are rounded to an integer value. The cost per hour of operation for each host class is given in [{#T}](../../managed-clickhouse/pricing.md).

#### How much does it cost to use my cluster? {#cluster-cost}

In the [management console]({{ link-console-main }}), go to the folder page, select **{{ ui-key.yacloud.iam.folder.dashboard.label_managed-clickhouse }}** and click the appropriate cluster. The cost of your cluster usage per month will be shown on the right side of the screen. For more information, see [{#T}](../../managed-clickhouse/pricing.md).

#### How can I change the computing resources and storage size for a database cluster? {#resources-change}

You can change computing resources and storage size in the management console. All you need to do is choose a different host class for the required cluster.

The cluster characteristics change within 30 minutes. During this period, other maintenance activities may also be enabled for the cluster, such as installing updates.


{% include [fz-152.md](../../_qa/fz-152.md) %}


{% include [logs](../logs.md) %}
