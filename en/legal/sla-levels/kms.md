# Service Level for {{ kms-full-name }}

This document defines Service Level of {{ kms-full-name }} ("Service") and is an integral part of Nebius Services Agreement ("Agreement") and SLA available at: <https://nebius.com/il/docs/legal/sla>. Capitalized terms used herein but not defined herein shall have the meanings set forth in Agreement and Linked Documents.

| Service Level | 99.95% |
| --- | --- |

## Compensation Amount {#compensation-amount}

Service Availability

| Uptime Percentage in the Reporting Period | Compensation, % of the Cost of the Service Used |
| --- | --- |
| < 99.95%-99.00% | 10.0% |
| < 99.00%-95.00% | 15.0% |
| < 95.00% | 30.0% |

## Definition of Service Unavailability {#unavailability}

Service Unavailability is spotted when the following occurs for at least 5 minutes:

* for more than 10% of Encrypt, Decrypt, ReEncrypt, and GenerateDataKey queries, at least one of the following conditions is present during the observation period:
  * 50x HTPP response codes;
  * INTERNAL/UNAVAILABLE gRPC response codes;
  * response time more than 10 seconds.
* network unavailability of endpoint dpl.kms.api.il.nebius.cloud due to a removed announcement or other issues on the part of Nebius.

Service Unavailability Period means the number of full minutes during which Service Unavailability was spotted.

The Service Level Agreement does not apply to unavailability arising from circumstances beyond the control of Nebius, such as failures in external networks or the Customer's failure to comply with the Instructions.

________________________________________

**Nebius Israel Ltd**

Web address: <https://nebius.com/il/docs/legal/sla-levels/kms>

Publication date: 20.02.2023

*Previous version of the document: <https://nebius.com/il/docs/legal/archive/sla-levels/kms-20221110>*