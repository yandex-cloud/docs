---
title: Yandex Cloud and managed database service user zones of control
description: In this article you will learn what falls into the zone of control of managed database service users and what is under Yandex Cloud's responsibility.
---

# Zones of control between managed database (MDB) service users and {{ yandex-cloud }}

When using managed database (MDB) services, i.e., {{ mpg-short-name }}, {{ mch-short-name }}, {{ mgp-full-name }}, {{ mmg-full-name }}, {{ mrd-short-name }}, {{ mmy-short-name }}, {{ mos-short-name }}, and {{ mkf-short-name }}, it is important to bear in mind what is controlled by the [MDB service](#cloud-responsibilities), and what by the [{{ yandex-cloud }} customer](#customer-responsibilities). Understanding these control zones will help you use your cloud resources effectively and avoid potential database-related problems.

## {{ yandex-cloud }} control zone {#cloud-responsibilities}

* **MDB nodes**. Ensuring the declared MDB functionality; monitoring MDB nodes, maintaining current versions of the guest OS, core, DBMS, and cluster integrity component.

* **Backup and recovery**. Backup and recovery of the cluster and its individual parts. Recovery from a backup is not guaranteed if the problem is due to an error on the database provider's side or to data architecture. {{ yandex-cloud }} support will explain what has led to the error and how to avoid it in the future. They will also restore the cluster, if possible.

* **Cluster operations**. Facilitating MDB cluster operations available through the [management console](../../console/index.yaml), [API](../../api-design-guide/index.yaml), [CLI](../../cli/index.yaml), or [Terraform](../../terraform/index.yaml).

* **MDB tools**. Providing {{ yandex-cloud }} managed database tools (see the [MDB documentation](#mdb-docs) table), such as performance diagnostics, command center, cluster (host) and DBMS monitoring (monitoring agents, metrics, and dashboards), alerts, and log display.

* **Base-level cluster operation**. Providing access to the cluster and performing all functions specific to the DBMS selected by the client (including but not limited to master, replica, shard, and segment roles) during periods of zero {{ yandex-cloud }} infrastructure emergencies or incidents, provided the user load is aligned with the cluster configuration selected by the client.

* **[High availability cluster](../../architecture/fault-tolerance.md#mdb-ha) operation**. For clusters configured as per the high availability policy, the conditions applicable to base-level clusters must be met, including in the event of {{ yandex-cloud }} infrastructure emergencies or incidents, provided the user load is aligned with the cluster configuration selected by the client.

* **Setting up new clusters**. Applying optimal default settings in new clusters to improve {{ yandex-cloud }} cluster stability and data reliability in line with DBMS provider recommendations.

* **Cluster setup when upgrading the DBMS version**. Using optimal settings managed by the DBMS provider to improve {{ yandex-cloud }} cluster stability and data reliability in line with DBMS provider recommendations.

* **User documentation**. Developing and updating MDB documentation. DBMS documentation is under the responsibility of DBMS providers. For more information on various MDB aspects, see the following documentation sections:
  
 {% cut "MDB documentation" %} {#mdb-docs}
  | MDB | Documentation sections |
  | --- |----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
  | {{ mpg-short-name }} | [Operations with clusters](../../managed-postgresql/operations/index.md)</br>[Backups](../../managed-postgresql/concepts/backup.md)</br>[High cluster availability](../../managed-postgresql/concepts/high-availability.md)</br>[Maintenance](../../managed-postgresql/concepts/maintenance.md)</br>[Performance diagnostics](../../managed-postgresql/operations/performance-diagnostics.md)</br>[Cluster state monitoring](../../managed-postgresql/operations/monitoring.md)</br>[Viewing logs](../../managed-postgresql/operations/cluster-logs.md) |
  | {{ mch-short-name }} | [Operations with clusters](../../managed-clickhouse/operations/index.md)</br>[Backups](../../managed-clickhouse/concepts/backup.md)</br>[Versioning policy](../../managed-clickhouse/concepts/update-policy.md)</br>[Maintenance](../../managed-clickhouse/concepts/maintenance.md)</br>[Monitoring cluster state](../../managed-clickhouse/operations/monitoring.md)</br>[Viewing logs](../../managed-clickhouse/operations/cluster-logs.md) |
  | {{ mgp-full-name }} | [Operations with clusters](../../managed-greenplum/operations/index.md)</br>[Backups](../../managed-greenplum/concepts/backup.md)</br>[Command center](../../managed-greenplum/concepts/command-center.md)</br>[Maintenance](../../managed-greenplum/concepts/maintenance.md)</br>[Performance diagnostics](../../managed-greenplum/operations/performance-diagnostics.md)</br>[Monitoring cluster state](../../managed-greenplum/operations/monitoring.md)</br>[Viewing logs](../../managed-greenplum/operations/cluster-logs.md) |
  | {{ mmg-full-name }} | [Operations with clusters](../../storedoc/operations/index.md)</br>[Backups](../../storedoc/concepts/backup.md)</br>[Maintenance](../../storedoc/concepts/maintenance.md)</br>[Performance diagnostics](../../storedoc/operations/performance-diagnostics.md)</br>[Monitoring cluster state](../../storedoc/operations/monitoring.md)</br>[Viewing logs](../../storedoc/operations/cluster-logs.md) |
  | {{ mrd-short-name }} | [Operations with clusters](../../managed-valkey/operations/index.md)</br>[Backups](../../managed-valkey/concepts/backup.md)</br>[Maintenance](../../managed-valkey/concepts/maintenance.md)</br>[Monitoring cluster state](../../managed-valkey/operations/monitoring.md)</br>[Viewing logs](../../managed-valkey/operations/cluster-logs.md) |
  | {{ mmy-short-name }} | [Operations with clusters](../../managed-mysql/operations/index.md)</br>[Backups](../../managed-mysql/concepts/backup.md)</br>[High cluster availability](../../managed-mysql/concepts/high-availability.md)</br>[Maintenance](../../managed-mysql/concepts/maintenance.md)</br>[Performance diagnostics](../../managed-mysql/operations/performance-diagnostics.md)</br>[Monitoring cluster state](../../managed-mysql/operations/monitoring.md)</br>[Viewing logs](../../managed-mysql/operations/cluster-logs.md) |
  | {{ mos-short-name }} | [Operations with clusters](../../managed-opensearch/operations/index.md)</br>[Backups](../../managed-opensearch/concepts/backup.md)</br>[Maintenance](../../managed-opensearch/concepts/maintenance.md)</br>[Monitoring cluster state](../../managed-opensearch/operations/monitoring.md)</br>[Viewing logs](../../managed-opensearch/operations/cluster-logs.md)</br>[Versioning policy](../../managed-opensearch/concepts/update-policy.md) |
  | {{ mkf-short-name }} | [Operations with clusters](../../managed-kafka/operations/index.md)</br>[High cluster availability](../../managed-kafka/concepts/ha-cluster.md)</br>[Maintenance](../../managed-kafka/concepts/maintenance.md)</br>[Monitoring cluster state](../../managed-kafka/operations/monitoring.md)</br>[Viewing logs](../../managed-kafka/operations/cluster-logs.md)</br>[Versioning policy](../../managed-kafka/concepts/update-policy.md) |

  {% endcut %}

## {{ yandex-cloud }} customer control zone {#customer-responsibilities}

* **Operations with clusters**. Self-management of MDB clusters through available interfaces: [management console](../../console/index.yaml), [API](../../api-design-guide/index.yaml), [CLI](../../cli/index.yaml), or [Terraform](../../terraform/index.yaml).

* **Maintenance window**. Scheduling the maintenance window interval for a predictable operational timeline.

* **Cluster resources**. Keeping cluster resources (host class and number, cluster replicas and shards) aligned with DBMS user load and MDB operating load. The operating load includes collecting and sending metrics, logs, and performance diagnostics data, backups, cluster maintenance operations, and internal health checks.

* **Use of settings not recommended by default**. Use of settings capable of affecting cluster health, availability, security, and data processing speed that are different from the recommended defaults.

* **Load analysis**. Analyzing and managing the cluster load profile; implementing DBMS provider recommendations when generating the load profile.

* **DBMS queries**. Writing, operating, debugging, and optimizing DBMS queries; diagnosing query execution status; analyzing query results and execution speed, other DBMS administration functions.

* **Access management**. Managing user account privileges and permissions, assigning permissions for database objects in line with the limitations of MDB services.

* **Cluster performance analysis**. Cluster (host) monitoring data analysis and timely response to alerts.

* **Backup checks**. Regular data integrity and cluster health checks following a recovery from a backup.

* **Adhering to the documentation guidelines**. Operating the cluster in line with the MDB user and legal documentation and the official DBMS provider documentation.

* **Experimental settings**. Use of any settings and procedures capable of affecting MDB health that are not recommended by the DBMS provider or are experimental.

* **Self-managed software version upgrades**. Maintaining current DBMS versions as per {{ yandex-cloud }}'s upgrade schedule. Self-preparation ahead of DBMS version upgrades; analyzing the changes and whether the client software is ready for those changes. Troubleshooting cluster operation issues related to untimely DBMS version upgrades.

* **Preparation for migration**. Completing all recommended setup steps and prerequisites in the source and target DBMS clusters ahead of data transfer when migrating to {{ yandex-cloud }}. 

  {% note info %}

  The preparation for an upcoming migration may require updating the client software to work with the target DBMS cluster version.

  {% endnote %}

* **Third-party software**. Configuring and operating third-party client software to work with an MDB cluster.

* **Requirements related to [high availability clusters](../../architecture/fault-tolerance.md#mdb-ha)**. Unassisted setup of client software for correct operation with high availability clusters, e.g., reconnecting the software to a node if the old node fails or a new one is added.

{% note info %}

If a client lacks the expertise to independently perform actions within their control, they can contact their account manager.

{% endnote %}
