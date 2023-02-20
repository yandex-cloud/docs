# Service Level of {{ mkf-full-name }}

This document defines Service Level of {{ mkf-full-name }} and is an integral part of Nebius Services Agreement ("Agreement") and SLA available at: <https://nebius.com/il/docs/legal/sla>. Capitalized terms used herein but not defined herein shall have the meanings set forth in Agreement and Linked Documents.

Service Level

| Kafka® Apache Cluster — reading | 99.99% |
| --- | --- |
| Kafka® Apache Cluster — writing | 99.95% |

Compensation Amount:

Availability of a Kafka® Apache Cluster — reading

| Uptime Percentage in the Reporting Period | Compensation, % of the cost of the Service used |
| --- | --- |
| < 99.99%-99.00% | 10.0% |
| < 99.00%-90.00% | 15.0% |
| less than 90.00% | 30.0% |

Availability of a Kafka® Apache Cluster — writing

| Uptime Percentage in the Reporting Period | Compensation, % of the cost of the Service used |
| --- | --- |
| < 99.95%-99.00% | 10.0% |
| < 99.00%-90.00% | 15.0% |
| less than 90.00% | 30.0% |

Definition of Unavailability for the Service:

Topic unavailability to read or write with replication factor equal or more than two, provided that its replicated Topic Partitions are in the availability other than with Leader Replicas.

The Service Level Agreement does not apply to unavailability arising from circumstances beyond the control of Nebius, such as failures in external networks or the Customer's failure to comply with the Instructions, or overload of one or more Brokers resulting in Unavailability, insufficient free disk space, use of an excessively large number of Partitions, etc.

## Definitions {#definitions}

Topic Partition — a separate Topic segment with data independent of data in other segments. Topic Partitions can be assigned on different Brokers.

Leader Replicas — Broker of selected Topic Partition, to which data is written only for this selected Topic Partition.

________________________________________

**Nebius Israel Ltd**

Web address: <https://nebius.com/il/docs/legal/sla-levels/managed-kafka>

Publication date: 20.02.2023

*Previous version of the document: <https://nebius.com/il/docs/legal/archive/sla-levels/managed-kafka-20221110>*