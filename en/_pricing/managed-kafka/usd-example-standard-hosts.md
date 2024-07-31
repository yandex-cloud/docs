Cost calculation for {{ KF }} broker hosts:

> 3 × (2&nbsp;×&nbsp;$0.012080 + 8&nbsp;×&nbsp;$0.003200) = $0.149280
>
> Total: $0.149280 is the cost per hour of operation of {{ KF }} broker hosts.

Where:
* 3 is the number of {{ KF }} broker hosts.
* 2 is the number of vCPUs.
* $0.012080 is the cost per hour of 100% vCPU utilization.
* 8 is the amount of RAM per host (in GB).
* $0.00320 is the cost per hour of 1 GB RAM utilization on 100% vCPU.

Calculating the cost of storage for {{ KF }} broker hosts:

> 3 × 100 × $0.025600 = $7.680000
>
> Total: $7.680000 is the cost of storage for {{ KF }} broker hosts.

Where:
* 3 is the number of {{ KF }} broker hosts.
* 100: Amount of network HDD storage (in GB).
* $0.025600: Cost of using 1 GB of network HDD storage per month.

Cost calculation for {{ ZK }} hosts:

> 3 × (2&nbsp;×&nbsp;$0.005600 + 4&nbsp;×&nbsp;$0.002240) = $0.060480
>
> Total: $0.060480 is the cost per hour of {{ ZK }} host operation.

Where:
* 3 is the number of {{ ZK }} hosts.
* 2 is the number of vCPUs.
* $0.005600 is the cost per hour of 50% vCPU utilization.
* 4 is the amount of RAM per host (in GB).
* $0.002240 is the cost per hour of 1 GB RAM utilization on 50% vCPU.

Calculating the cost of storage for {{ ZK }} hosts:

> 3 × 10 × $0.104080 = $3.122400
>
> Total: $3.122400 is the cost of storage for {{ ZK }} hosts.

Where:
* 3 is the number of {{ ZK }} hosts.
* 10 is the amount of SSD network storage (in GB).
* $0.104080 is the cost of using 1 GB of network SSD storage per month.

Total cost calculation:

> 720 × ($0.149280 + $0.060480) + $7.680000 + $3.122400 = $161.829600
>
> Total: $161.829600 is the cost of using the cluster for 30 days.

Where:
* 720: Number of hours in 30 days.
* $0.149280 is the cost per hour of {{ KF }} broker host operation.
* $0.060480 is the cost per hour of {{ ZK }} host operation.
* $7.680000 is the cost of storage for {{ KF }} broker hosts.
* $3.122400 is the cost of storage for {{ ZK }} hosts.