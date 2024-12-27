> ($0.010545 + $0.000960) × 2 + ($0.002795 + $0.000240) × 16 + $0.000152 × 20 = $0.074610
>
> Total: $0.074610, cost of using the first subcluster per hour.

Where:

* $0.010545: Cost of using 100% vCPU per hour.
* $0.000960: {{ dataproc-name }} markup for using 100% vCPU.
* 2: Number of vCPUs per master host.
* $0.002795: Cost of using 1 GB of RAM per hour.
* $0.000240: {{ dataproc-name }} markup for using 1 GB of RAM.
* 16: Amount of RAM per master host (in GB).
* $0.000152: Cost of using 1 GB of `network-ssd` per hour.
* 20: Master host storage capacity (in GB).

> ($0.010545 + $0.000960) × 2 + ($0.002795 + $0.000240) × 8 + $0.000037 × 100 = $0.050990
>
> Total: $0.050990, cost of using the second subcluster per hour.

Where:

* $0.010545: Cost of using 100% vCPU per hour.
* $0.000960: {{ dataproc-name }} markup for using 100% vCPU.
* 2: Number of vCPUs per data storage host.
* $0.002795: Cost of using 1 GB of RAM per hour.
* $0.000240: {{ dataproc-name }} markup for using 1 GB of RAM.
* 8: Amount of RAM per data storage host (in GB).
* $0.000037: Cost of using 1 GB of `network-hdd` per hour.
* 100: Storage capacity per data storage host (in GB).

> $0.074610 + $0.050990 = $0.125600
>
> Total: $0.125600, cost of using a cluster of two subclusters per hour.

Where:

* $0.074610: Cost of using the first subcluster per hour.
* $0.050990: Cost of using the second subcluster per hour.