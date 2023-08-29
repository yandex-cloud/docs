### Pricing unit {#unit}

A pricing unit means a single billing unit. The number of billing units spent on calculations depends on:
* Capacity of the computing resources being used.
* Time spent on calculations.

   The calculation time is rounded up to an integer number of seconds.

The cost of one billing unit means the cost of using one CPU core for one second. The number of units depends on computing resource configurations.


[Background operation costs](#async) are calculated separately.

#### Examples of cost calculation {#price-example}

##### In {{ ds }} mode {#price-example-ds}

Cost of using {{ ml-platform-name }} with the following parameters:

* **Computing resources:** g1.1 configuration with 8 CPUs and 1 GPU.
* **Operation execution time:** 1400 ms (rounded up to an integer number of seconds).

Cost calculation:

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

Cost calculation:

> 72 × 600 = 43.200 units for VM usage
> 43.200 × 0.0000096 = $0.4147200
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
* **Node operating time:** 10 minutes.

Cost calculation:

> 72 × 600 × 2 = 86.400 units for node operation
> 86.400 × 0.0000096 = $0.8294400
>
> Total: $0.8294400 is the cost of using {{ ml-platform-name }}.

Where:
* 72: Number of units per g1.1 configuration.
* 600: Node operating time in seconds.
* 2: Number of instances per node.
* $0.0000096: Cost per unit.
