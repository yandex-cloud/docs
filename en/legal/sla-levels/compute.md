# Service Level for {{ compute-full-name }}

This document defines Service Level of {{ compute-full-name }} ("Service") and is an integral part of Nebius Services Agreement ("Agreement") and SLA available at: <https://nebius.com/il/docs/legal/sla>. Capitalized terms used herein but not defined herein shall have the meanings set forth in Agreement and Linked Documents.

| Service Level | 99.95% |
| --- | --- |

## Compensation Amount {#compensation-amount}

Availability of a single Virtual Machine:

| Service Uptime Percentage in Accrual Period | Compensation, % of Service Fee for Service in Accrual Period |
| --- | --- |
| < 99.95%-99.00% | 10.0% |
| < 99.00%-95.00% | 15.0% |
| less than 95.00% | 30.0% |

## Definition of a single Virtual Machine Unavailability {#unavailability-single-vm}

Loss of external connectiveness or a boot disk of a Virtual Machine. SLA does not apply to cases of loss of external connectiveness due to circumstances beyond Nebius' control, including cases of DoS or DDoS attacks on Customer's Virtual Machine.

Availability of a group of non-replicated Disk's:

| Basis for Compensation calculating in Accrual Period | Compensation, % of Service Fee for Service in Accrual Period |
| --- | --- |
| Every fact that a non-replicated Disk placement group is Unavailable | 10.0% |

## Definition of a group of non-replicated Disk's Unavailability {#unavailability-nrd}

The transition of two or more Disks from the same placement group to a faulty state in an 8-hour time interval (when after the transition of the first Disk to a faulty state within 8 hours, another Disk from the same group became faulty).

A failed Disk state means that the Disk goes to the "ERROR" state (the disk state is displayed in the Console or via the <https://nebius.com/il/docs/cli/quickstart>).

________________________________________

Publication date: 20.02.2023

*Previous version of the document: <https://nebius.com/il/docs/legal/archive/sla-levels/compute-20221110>*