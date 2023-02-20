# Service Level for Managed Databases

This document defines Service Levels for {{ mpg-full-name }}, Nebius {{ mch-full-name }}, Nebius {{ mmy-full-name }} (collectively, "Service") and is an integral part of Nebius Services Agreement ("Agreement") and SLA available at: <https://nebius.com/il/docs/legal/sla>. Capitalized terms used herein but not defined herein shall have the meanings set forth in Agreement and Linked Documents.

Service Level:

| DB Cluster, read | 99.99% |
| --- | --- |
| DB Cluster, write | 99.95% |

**Compensation Amount:**

Availability of DB Cluster — read:

| Service Uptime Percentage in Accrual Period | Compensation, % of Service Fee for Service in Accrual Period |
| --- | --- |
| < 99.99%-99.00% | 10.0% |
| < 99.00%-90.00% | 15.0% |
| less than 90.00% | 30.0% |

Availability of DB Cluster — write:

| Service Uptime Percentage in Accrual Period | Compensation, % of Service Fee for Service in Accrual Period |
| --- | --- |
| < 99.95%-99.00% | 10.0% |
| < 99.00%-90.00% | 15.0% |
| less than 90.00% | 30.0% |

**Definition of Service Unavailability:**

Unavailability of Nebius {{ mpg-full-name }} and Nebius {{ mmy-full-name }} shall be defined as two or more DB Hosts placed in different Availability Zones for reading or writing via supported clients.

Unavailability of Nebius {{ mch-full-name }} shall be defined as follows:

* two or more DB Hosts placed in different Availability Zones for reading or writing via supported clients, and/or
* unavailability of Shard placed in two or more DB Hosts which are located in different Availability Zones for reading or writing via supported clients while using Shard.

The list of supported clients for a specific type of DBMS can be found in technical documents of Service posted on Site.

## Definitions {#definitions}

Shard — the part of DB Cluster placed in one or several DB Hosts for load balancing. The process of forming a Shard is called sharding.

________________________________________

**Nebius Israel Ltd**

Web address: <https://nebius.com/il/docs/legal/sla-levels/mdb>

Publication date: 20.02.2023

*Previous version of the document: <https://nebius.com/il/docs/legal/archive/sla-levels/mdb-20221110>*