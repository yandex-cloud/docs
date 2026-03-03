# Service Level for Managed Service for Kubernetes


This document defines Service Level of Managed Service for Kubernetes ("Service") and is an integral part of Nebius Services Agreement ("Agreement") and SLA available at: <https://nebius.com/il/docs/legal/sla>. Capitalized terms used herein but not defined herein shall have the meanings set forth in Agreement and Linked Documents.

| Service Level | 99.90% |
| --- | --- |

## Compensation Amount {#compensation-amount}

Service Availability

| Uptime Percentage in the Reporting Period | Compensation, % of Service Fee of Service used in Reporting Period |
| --- | --- |
| < 99.90%-95.00% | 10.0% |
| less than 95.00% | 25.0% |

## Definition of Service Unavailability {#unavailability}

No Customer access to the Master both within or from outside of the Platform for at least 5 minutes when the Customer uses the Regional Master Configuration.

The Service Level does not apply to the following cases:

* no access to the Master due to circumstances beyond the control of Nebius;
* the Customer uses other Master configurations, except for the Regional Master Configuration;
* the Service unavailability resulted from the user settings of firewall and routing rules;
* the Service unavailability resulted from its integration by the Customer with an external application or installation by the Customer of an application, which disabled the Kubernetes® Cluster.

## Definitions {#definitions}

Regional Master Configuration means a Master with fault tolerance settings in at least two different availability zones.

________________________________________

**Nebius Israel Ltd**

Web address: <https://nebius.com/il/docs/legal/sla-levels/managed-kubernetes>

Publication date: 06.03.2023

*Previous version of the document: <https://nebius.com/il/docs/legal/archive/sla-levels/managed-kubernetes-20230220>*

*Previous version of the document: <https://nebius.com/il/docs/legal/archive/sla-levels/managed-kubernetes-20221110>*