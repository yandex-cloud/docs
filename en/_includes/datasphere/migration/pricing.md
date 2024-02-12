### Pricing unit {#unit}

A pricing unit means a single billing unit. The number of billing units spent on calculations depends on:
* Capacity of the computing resources being used.
* Time spent on calculations.

   The calculation time is rounded up to an integer number of seconds.

One billing unit equals the cost of using one CPU core for one second. The number of units depends on the computing resource configuration.


[Background operation costs](#async) are calculated separately.

#### Examples of cost calculation {#price-example}

##### In {{ ds }} mode {#price-example-ds}

Cost of using {{ ml-platform-name }} with the following parameters:

* **Computing resources:** g1.1 configuration with 8 CPUs and 1 GPU.
* **Operation execution time:** 1400 ms (rounded up to an integer number of seconds).

The cost is calculated as follows:

> 72 × 2 = 144 units per computation
> 144 × 0.0000096 = $0.0013824
>
> Total: $0.0013824 is the cost of using {{ ml-platform-name }}.

Where:
* 72: Number of units per g1.1 configuration.
* 2: 1400 ms rounded up to the nearest second.
* $0.0000096: Cost per unit.

##### In {{ dd }} mode {#price-example-dd}

Cost of using {{ ml-platform-name }} with the following parameters:

* **Computing resources:** g1.1 configuration with 8 CPUs and 1 GPU.
* **VM usage time:** 10 minutes.

The cost is calculated as follows:

> 72 × 600 = 43,200 units for VM usage
> 43,200 × 0.0000096 = $0.4147200
>
> Total: $0.4147200 is the cost of using {{ ml-platform-name }}.

Where:
* 72: Number of units per g1.1 configuration.
* 600: VM usage time in seconds.
* $0.0000096: Cost per unit.

##### When using models {#price-example-node}

Cost of using {{ ml-platform-name }} with the following parameters:

* **Number of instances per node:** 2.
* **Instance configuration:** g1.1 with 8 CPUs and 1 GPU.
* **Node runtime:** 2 days 3 hours 36 minutes.

Converting node runtime into seconds:

> 2 × (24 × 60 × 60) + 3 × (60 × 60) + 36 × 60 =172,800 + 10,800 + 2,160= 185,760

Where:
* (24 × 60 × 60): Number of seconds in 24 hours.
* (60 × 60): Number of seconds in 1 hour.
* 60: Number of seconds in 1 minute.

The cost is calculated as follows:

> 72 × 185,760 × 2 = 26,749,440 units for running a node
> 26,749,440 × 0.0000096 = $256.7946240
>
> Total cost of using {{ ml-platform-name }}: $256.7946240.

Where:
* 72: Number of units per g1.1 configuration.
* 185,760 : Node runtime in seconds.
* 2: Number of instances per node.
* $0.0000096: Cost per unit.
