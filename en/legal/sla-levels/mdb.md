# Service Level for Managed Databases

This document defines Service Levels for Managed Service for PostgreSQL, Managed Service for ClickHouse, Managed Service for MySQL, Managed Service for Redis, Managed Service for OpenSearch (collectively, "Service") and is an integral part of Nebius Services Agreement ("Agreement") and SLA available at: <https://nebius.com/il/docs/legal/sla>. Capitalized terms used herein but not defined herein shall have the meanings set forth in Agreement and Linked Documents.

Service Level:

| DB Cluster, read | 99.99% |
| --- | --- |
| DB Cluster, write | 99.95% |

**Compensation Amount:**

Availability of DB Cluster — read:

| Service Uptime Percentage in Reporting Period | Compensation, % of Service Fee for Service in Reporting Period |
| --- | --- |
| < 99.99%-99.00% | 10.0% |
| < 99.00%-90.00% | 15.0% |
| less than 90.00% | 30.0% |

Availability of DB Cluster — write:

| Service Uptime Percentage in Reporting Period | Compensation, % of Service Fee for Service in Reporting Period |
| --- | --- |
| < 99.95%-99.00% | 10.0% |
| < 99.00%-90.00% | 15.0% |
| less than 90.00% | 30.0% |

**Definition of Service Unavailability:**

Unavailability of Managed Service for PostgreSQL and Managed Service for MySQL shall be defined as two or more DB Hosts placed in different Availability Zones for reading or writing via supported clients.

Unavailability of Managed Service for ClickHouse shall be defined as follows:

* two or more DB Hosts placed in different Availability Zones for reading or writing via supported clients, and/or
* unavailability of Shard placed in two or more DB Hosts which are located in different Availability Zones for reading or writing via supported clients while using Shard.

Unavailability of Managed Service for Redis shall be defined as:

* unavailability DB Cluster which consists of three and more DB Hosts placed in different Availability Zones for reading or writing via supported clients, and/or
* unavailability of Shard placed in three or more DB Hosts which are located in different Availability Zones for reading or writing via supported clients while using Shard.

Unavailability of Managed Service for OpenSearch shall be defined as unavailability of DB Cluster which consists of three or more DB Hosts with MANAGER role placed in different Availability Zones, and two or more DB Hosts with DATA role placed in different Availability Zones, for reading and writing via supported clients, when replication is enabled for indexes.

The list of supported clients for a specific type of DBMS can be found in technical documents of Service posted on Site.

## Definitions {#definitions}

Shard — the part of DB Cluster placed in one or several DB Hosts for load balancing. The process of forming a Shard is called sharding.

________________________________________

**Nebius Israel Ltd**

Web address: <https://nebius.com/il/docs/legal/sla-levels/mdb>

Publication date: 07.07.2023

*Previous version of the document: <https://nebius.com/il/docs/legal/archive/sla-levels/mdb-20230403>*

*Previous version of the document: <https://nebius.com/il/docs/legal/archive/sla-levels/mdb-20230306>*

*Previous version of the document: <https://nebius.com/il/docs/legal/archive/sla-levels/mdb-20230220>*

*Previous version of the document: <https://nebius.com/il/docs/legal/archive/sla-levels/mdb-20221110>*
