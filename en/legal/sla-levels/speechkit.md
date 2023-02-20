# Service Level for {{ speechkit-full-name }}

This document defines Service Level of {{ speechkit-full-name }} ("Service") and is an integral part of Nebius Services Agreement ("Agreement") and SLA available at: <https://nebius.com/il/docs/legal/sla>. Capitalized terms used herein but not defined herein shall have the meanings set forth in Agreement and Linked Documents.

| Service Level | 99.90% |
| --- | --- |

**Compensation Amount:**

Availability

| Service Uptime Percentage in Accrual Period | Compensation, % of Service Fee of Service used in Accrual |
| --- | --- |
| < 99.90%-99.00% | 10.0% |
| < 99.00%-95.00% | 15.0% |
| less than 95.00% | 30.0% |

**Definition of Service Unavailability:**

"Service Unavailability" is recorded when the server-side Error Rate exceeds 5%.

"Error Rate" is calculated as follows: the number of Valid Queries that return HTTP Status 500 with the error code "INTERNAL_SERVER_ERROR" or gRPC Status 13 with error code "INTERNAL", divided by the total number of Valid Queries per minute.

"Service Unavailability Period" shall mean the number of full minutes, during which Service Unavailability was recorded.

"Valid Query" shall mean a query that conforms with Service documentation and returns HTTP Status 200 (OK) or gRPC Status 0 (OK), if Service functions properly.

________________________________________

Publication date: 20.02.2023

*Previous version of the document: <https://nebius.com/il/docs/legal/archive/sla-levels/speechkit-20221110>*