# Cluster and hosts {{ mgp-short-name }}

#### What is a database host and database cluster? {#what-is-cluster}

_A database host_ is an isolated database environment in the cloud infrastructure with dedicated computing resources and reserved data storage.

_A database cluster_ is one or more database hosts between which replication can be configured.

#### How many DB hosts can a cluster contain? {#how-many-hosts}

The {{ mgp-short-name }} cluster consists of at least 4 hosts:

* 2 master hosts.
* 2 segment hosts.

The number of segment hosts can be increased up to 32.

For more information, see [{#T}](../../managed-greenplum/concepts/limits.md).

#### How many clusters can I create within a single cloud? {#db-limit}

MDB technical and organizational limits are given in [{#T}](../../managed-greenplum/concepts/limits.md).

#### How do I maintain database clusters? {#service-window}

Maintenance in {{ mgp-short-name }} implies:

* Automatic installation of DBMS updates and fixes for your database hosts.
* Changes to the host class and storage size.
* Other {{ mgp-short-name }} maintenance activities.

For more information, see [{#T}](../../managed-greenplum/concepts/maintenance.md).


#### How is the cost of usage calculated for a database host? {#db-cost}

In {{ mgp-short-name }}, the usage cost is calculated based on the following parameters:

* Selected host class.
* Size of the storage reserved for the database host.
* Size of the database cluster backups. Backup space in the amount of the reserved storage is free of charge. Backup storage that exceeds this size is charged at special [rates](../../managed-greenplum/pricing/index.md).
* Number of hours of database host operation. Partial hours are rounded to an integer value. The cost per hour of operation for each host class is given in [{#T}](../../managed-greenplum/pricing/index.md).

