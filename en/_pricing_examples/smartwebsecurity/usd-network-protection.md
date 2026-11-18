> Let’s calculate the cost of Network Protection for December (31 days, 744 hours) using the formula:
> 6.96721 × max(p95, average speed) × T / M, without VAT.

Where:

* 6.96721: Price per 1 Mbps of billable bandwidth, $.
* max(p95, average speed): Billable bandwidth, Mbps.
* T: Duration of the proxy server connection to protection in the billing month, including intervals without traffic.
* M: Duration of the full calendar month.

The examples bill cleaned incoming traffic passed by Network Protection, including traffic that was later blocked at L7.

##### No traffic {#np-example-no-traffic}

The proxy server is connected to protection all December, but there is no incoming traffic. p95 and average speed are zero.

**Cost:** 6.96721 × 0 × 31 / 31 = **{% calc [currency=USD] round((6.96721 × 0 × 31 / 31) × 100) / 100 %}**, without VAT.

##### Partial month {#np-example-partial-month}

The proxy server is created and connected to protection on December 16 at 12:00. Until the end of the month, it constantly receives 120 Mbps. The connection period is 15.5 days; p95 and average speed for this period are 120 Mbps.

**Cost:** 6.96721 × 120 × 15.5 / 31 = **{% calc [currency=USD] round((6.96721 × 120 × 15.5 / 31) × 100) / 100 %}**, without VAT.

##### Stop and restart {#np-example-stop-restart}

**Restarting the same proxy server.** The proxy server is connected to protection all December. From December 10 00:00 to December 20 00:00, it is stopped and receives no traffic. The rest of the time, the speed is constant at 120 Mbps.

The connection period is 31 days. p95 is 120 Mbps, and the average speed is `120 × 21 / 31 ≈ 81.29 Mbps`. Billing uses p95.

**Cost:** 6.96721 × 120 × 31 / 31 = **{% calc [currency=USD] round((6.96721 × 120 × 31 / 31) × 100) / 100 %}**, without VAT.

In this example, stopping and restarting does not reduce the total cost.

**Creating a new proxy server while keeping the old one.** The old proxy server receives 120 Mbps from the beginning of December. At 12:00 on December 16, it is stopped, and all traffic is moved to a new proxy server at the same speed. The old proxy server remains under protection until the end of the month, but it receives no more traffic.

For the old proxy server, half of the five-minute values are 120 Mbps, and the other half are zero. The average speed is 60 Mbps, but p95 remains 120 Mbps. The protection period is 31 days.

For the new proxy server, p95 and average speed are 120 Mbps; the protection period is 15.5 days.

* Old proxy server: 6.96721 × 120 × 31 / 31 = **{% calc [currency=USD] round((6.96721 × 120 × 31 / 31) × 100) / 100 %}**, without VAT.
* New proxy server: 6.96721 × 120 × 15.5 / 31 = **{% calc [currency=USD] round((6.96721 × 120 × 15.5 / 31) × 100) / 100 %}**, without VAT.

**Total cost:** 6.96721 × 120 × 31 / 31 + 6.96721 × 120 × 15.5 / 31 = **{% calc [currency=USD] round((6.96721 × 120 × 31 / 31 + 6.96721 × 120 × 15.5 / 31) × 100) / 100 %}**, without VAT.

**Deleting the old proxy server and creating a new one.** The conditions are the same, but at 12:00 on December 16, the old proxy server is deleted and a new one is created immediately. The protection period of each is 15.5 days; p95 and average speed of each are 120 Mbps.

**Total cost:** 6.96721 × 120 × 15.5 / 31 + 6.96721 × 120 × 15.5 / 31 = **{% calc [currency=USD] round((2 × 6.96721 × 120 × 15.5 / 31) × 100) / 100 %}**, without VAT.

##### Full month {#np-example-full-month}

**Constant traffic.** The proxy server is connected to protection all December and constantly receives 120 Mbps. p95 and average speed are 120 Mbps.

**Cost:** 6.96721 × 120 × 31 / 31 = **{% calc [currency=USD] round((6.96721 × 120 × 31 / 31) × 100) / 100 %}**, without VAT.

**Traffic with short spikes.** The proxy server is connected to protection all December. Out of 744 hours, it receives 120 Mbps for 714 hours and 300 Mbps for 30 hours. The speed change boundaries match the five-minute interval boundaries.

p95 remains 120 Mbps. The average speed is higher:

`(120 × 714 + 300 × 30) / 744 ≈ 127.2581 Mbps`.

Billing uses the average speed. The cost is calculated without rounding the average in advance:

**Cost:** 6.96721 × (120 × 714 + 300 × 30) / 744 = **{% calc [currency=USD] round((6.96721 × (120 × 714 + 300 × 30) / 744) × 100) / 100 %}**, without VAT.
