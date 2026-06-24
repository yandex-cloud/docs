#### What is {{ mspqr-name }}? {#what-is-mspqr}

{{ mspqr-name }} ({{ SPQR }}) is a managed service for horizontal {{ PG }} scaling through automatic [sharding](../../managed-spqr/concepts/sharding.md). It functions as an intelligent proxy router that processes SQL queries and distributes them across shards based on defined rules called [sharding keys](../../managed-spqr/concepts/sharding-keys.md). In addition, {{ mspqr-name }}:

- Uses high-availability clusters as the foundation for sharding to maximize reliability.
- Maintains cluster availability during migrations from monolithic to sharded architectures.
- Optimized for OLTP queries with minimal overhead.

Key features

* Sharding by value range or by hash: the [router](../../managed-spqr/concepts/index.md#router) selects the target [shard](../../managed-spqr/concepts/index.md#shard) for each query.
* Compatibility with the {{ PG }} extended protocol enables out-of-the-box support for prepared statements and client libraries.
* Support for the session and transaction modes.
* Unlimited number of routers.
* [Rebalancing](../../managed-spqr/concepts/sharding-method.md#data-rebalancing), i.e., cross-shard data migration for even load distribution.
* Support for assigning multiple servers to a single shard, which enables the router to distribute read-only queries among replicas and automatically locate the master.

#### What are the benefits offered by {{ mspqr-name }}? {#mspqr-benefits}

With {{ mspqr-name }}, you get the following benefits:

* Managed service: Out-of-the-box support for automated updates, monitoring, and backups.
* High availability: Automatic failover to replicas in case of failures.
* Dynamic rebalancing: `REDISTRIBUTE KEY RANGE` command for data redistribution across shards.
* Transaction support: `SESSION` and `TRANSACTION` connection management modes.
* Resource monitoring, where the user retains control over load.
* Consulting services.

#### When should I use {{ mspqr-name }}? {#use-cases}

{{ mspqr-name }} is ideal for scenarios that meet one or more of these criteria:
* Your data size exceeds 1 TB with no remaining options for vertical scaling.
* Your workload exceeds 20,000 queries per second, causing visible performance degradation.
* Data cooling is required (archiving old data while keeping it accessible).
* You need to automate an existing sharded infrastructure.

We recommend implementing sharding if your cluster has more than four hosts, more than 40 CPU cores, or disk size exceeding 600 GB. Early migration to {{ mspqr-name }} removes the added complexity of handling multi-terabyte datasets.

#### When is {{ mspqr-name }} not a good fit? {#not-suitable-use-cases}

{{ mspqr-name }} is not suitable for:

* OLAP workloads (use [{{ mgp-name }} instead](../../managed-greenplum/index.yaml)).
* Complex queries involving data from multiple shards, e.g., cross-shard JOIN operations.

#### Are JSONB and large objects supported? {#jsonb-support}
Yes. {{ mspqr-name }} supports all native {{ PG }} data types, including JSONB. Note that large objects may affect network performance.

#### When should I choose {{ mspqr-name }} over {{ ydb-full-name }}? {#mspqr-vs-ydb}
{{ mspqr-name }} enables you to solve the {{ PG }} scaling problem without changing the DBMS type.

#### Can a multi-host {{ mpg-name }} cluster serve as a shard in {{ mspqr-name }}? {#multi-host-pg-cluster}
Yes. In {{ mspqr-name }}, a shard can be either a single-host or a multi-host {{ mpg-name }} cluster.

#### Does it make sense to migrate high-performance {{ PG }} instances (e.g., 96 vCPUs) to {{ SPQR }}? {#powerful-pg-instances}
Yes, if your application is ready for sharding. {{ SPQR }} replaces a single high-spec host with multiple smaller instances, allowing you to scale resources horizontally and balance the load.

#### How is {{ mspqr-name }} different from Neon? {#mspqr-vs-neon}

Neon decouples the compute and storage layers (similar to Amazon Aurora), but it is not a sharded solution and does not support horizontal scaling of clusters. {{ SPQR }} achieves true horizontal scalability through data and query sharding across independent {{ PG }} nodes.

#### How is {{ mspqr-name }} different from Citus/Vitess? {#mspqr-vs-citus-vs-vitess}

| **Feature** | **{{ mspqr-name }}** | **Citus** | **Vitess** |
|--------------|--------------------------------|-----------|------------|
| Performance compared to {{ PG }} | 10–30% lower | 15–40% lower | 20–50% lower |
| Protocol | Native {{ PG }} | {{ PG }} extensions | Proprietary |
| Rebalancing | Via `REDISTRIBUTE KEY RANGE`; cluster remains available for reads and writes | Requires downtime | Via VReplication |
| Management | Full integration with managed databases | Manual administration | End-to-end setup |
| Reading from replicas | Automated | Via master only | Via VTGate |
| License | Open {{ PG }} license | GNU AGPLv3 with limitations | Apache License 2.0 |

#### How do I get started with {{ mspqr-name }}? {#how-to-start}

Create your first {{ mspqr-name }} cluster. For step-by-step instructions, see [Getting started with {{ mspqr-name }}](../../managed-spqr/quickstart.md).

Before you begin, define your cluster specifications:
* [Sharding type](../../managed-spqr/concepts/sharding.md#shard-management).
* Your cluster [network](../../vpc/concepts/network.md#network).
* [Availability zone](../../overview/concepts/geo-scope.md) for your cluster hosts.
* Number and [class of hosts](../../managed-spqr/concepts/instance-types.md).
* [Storage](../../managed-spqr/concepts/storage.md) size (reserved in full during cluster creation).
