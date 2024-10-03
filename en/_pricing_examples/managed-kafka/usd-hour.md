Cost calculation for {{ KF }} broker hosts:

> 3 × (2&nbsp;×&nbsp;$0.012080 + 8&nbsp;×&nbsp;$0.003200) = $0.149280
>
> Total: $0.149280, per hour cost of {{ KF }} broker hosts.

Where:
* 3: Number of {{ KF }} broker hosts.
* 2: Number of vCPUs.
* $0.012080: Cost of using 100% vCPU per hour.
* 8: Amount of RAM per host (in GB).
* $0.003200: Cost of using 1 GB of RAM at 100% vCPU per hour.

Calculating the cost of storage for {{ KF }} broker hosts:

> 3 × 100 × $0.025600 = $7.680000
>
> Total: $7.680000, cost of storage for {{ KF }} broker hosts.

Where:
* 3: Number of {{ KF }} broker hosts.
* 100: Amount of network HDD storage (in GB).
* $0.025600: Cost of using 1 GB of network HDD storage per month.

Cost calculation for {{ ZK }} hosts:

> 3 × (2 × $0.005600 + 4 × $0.002240) = $0.060480
>
> Total: $0.060480, per hour cost of {{ ZK }} hosts.

Where:
* 3: Number of {{ ZK }} hosts.
* 2: Number of vCPUs.
* $0.005600: Cost of using 50% vCPU per hour.
* 4: Amount of RAM per host (in GB).
* $0.002240: Cost of using 1 GB of RAM at 50% vCPU per hour.

Calculating the cost of storage for {{ ZK }} hosts:

> 3 × 10 × $0.104080 = $3.122400
>
> Total: $3.122400, cost of storage for {{ ZK }} hosts.

Where:
* 3: Number of {{ ZK }} hosts.
* 10: Amount of SSD network storage (in GB).
* $0.104080: Cost of using 1 GB of network SSD storage per month.

Total cost calculation:

> 720 × ($0.149280 + $0.060480) + $7.680000 + $3.122400 = $161.829600
>
> Total: $161.829600, cost of using the cluster for 30 days.

Where:
* 720: Number of hours in 30 days.
* $0.149280: Per hour cost of {{ KF }} broker hosts.
* $0.060480: Per hour cost of {{ ZK }} hosts.
* $7.680000: Cost of storage for {{ KF }} broker hosts.
* $3.122400: Cost of storage for {{ ZK }} hosts.