Cost calculation for standard hosts:

> 3 × (8&nbsp;×&nbsp;$0.017231 + 32&nbsp;×&nbsp;$0.004564) = $0.851688
>
> Total: $0.851688, per hour cost of standard hosts.

Where:

* 3: Number of standard hosts.
* 8: Number of vCPUs.
* $0.017231: Cost of using 100% vCPU per hour.
* 32: Amount of RAM per standard host (in GB).
* $0.004564: Cost of using 1 GB of RAM at 100% vCPU per hour.

Cost calculation for dedicated hosts:

> 3 × (8&nbsp;×&nbsp;$0.009595 + 32&nbsp;×&nbsp;$0.002538) = $0.473928
>
> Total: $0.473928, per hour cost of dedicated hosts.

Where:

* 3: Number of dedicated hosts.
* 8: Number of vCPUs.
* $0.009595: Cost of using 100% vCPU per hour.
* 32: Amount of RAM per dedicated host (in GB).
* $0.002538: Cost of using 1 GB of RAM at 100% vCPU per hour.

Calculation for the storage cost and total cost:

> (720 × $0.851688 + 100 × $0.104080) + (720 × $0.473928 + 50 × $0.104080) = $970.0555
>
> Total: $970.0555, cost of using the cluster for 30 days.

Where:

* 720: Number of hours in 30 days.
* $0.851688: Cost per hour of operation of standard hosts.
* 100: Amount of network HDD storage (in GB) for standard hosts.
* $0.104080: Cost of using 1 GB of network HDD storage per month.
* $0.473928: Per hour cost of dedicated hosts.
* 50: Amount of local SSD storage (in GB) for dedicated hosts.
* $0.104080: Cost of using 1 GB of local SSD storage per month.