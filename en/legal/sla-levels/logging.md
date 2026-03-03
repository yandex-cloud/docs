# Service Level for Cloud Logging

This document defines Service Level of Cloud Logging ("Service") and is an integral part of Nebius Services Agreement ("Agreement") and SLA available at: <https://nebius.com/il/docs/legal/sla>. Capitalized terms used herein but not defined herein shall have the meanings set forth in Agreement and Linked Documents.

| Service Level |	99.9% |
| --- | --- |


## Compensation Amount {#compensation-amount}

Availability

| Service Uptime Percentage in Reporting Period	| Compensation, % of Service Fee of Service used in Reporting Period |
| --- | --- |
| < 99,9%-95,00% |	10,0% |
| less than 95,00% |	30,0% |


## Definition of Service Unavailability {#unavailability}

"Service Unavailability" is recorded when the Nebius server-side Error Rate exceeds 5%.

"Error Rate" is calculated as follows: the number of Valid Queries that return HTTP Status 500-599 (in case of using of the HTTP protocol) or code 13, 14 (in case of using of the GRPC protocol), divided by the total number of Valid Queries per minute.

"Valid Query" shall mean a query that conforms with Service documentation and returns HTTP Status 200-499 or GRPC Status 0,1,3-12,16.

"Service Unavailability Period" shall mean the number of full minutes, during which Service Unavailability was recorded.

________________________________________

**Nebius Israel Ltd**

Web address: <https://nebius.com/il/docs/legal/sla-levels/logging>

Publication date: 15.05.2023