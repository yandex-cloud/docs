# Service Level for {{ managed-k8s-full-name }}

This document defines Service Level of {{ managed-k8s-full-name }} ("Service") and is an integral part of CloudIL Services Agreement ("Agreement") and SLA available at: <https://cloudil.co.il/docs/legal/sla>. Capitalized terms used herein but not defined herein shall have the meanings set forth in Agreement and Linked Documents.

| Service Level | 99.90% |
| --- | --- |

## Compensation Amount {#compensation-amount}

Service Availability

| Uptime Percentage in the Reporting Period | Compensation, % of Service Fee of Service used in Accrual Period |
| --- | --- |
| < 99.90%-95.00% | 10.0% |
| less than 95.00% | 25.0% |

## Definition of Service Unavailability {#unavailability}

No Customer access to the Master both within or from outside of the Platform for at least 5 minutes when the Customer uses the Regional Master Configuration.

The Service Level does not apply to the following cases:

* no access to the Master due to circumstances beyond the control of CloudIL;
* the Customer uses other Master configurations, except for the Regional Master Configuration;
* the Service unavailability resulted from the user settings of firewall and routing rules;
* the Service unavailability resulted from its integration by the Customer with an external application or installation by the Customer of an application, which disabled the Kubernetes® Cluster.

## Definitions {#definitions}

Regional Master Configuration means a Master with fault tolerance settings in at least two different availability zones.

________________________________________

**Cloud.IL Systems LTD**

Web address: <https://cloudil.co.il/docs/legal/sla-levels/managed-kubernetes>

Publication date: 10.11.2022
