### Pricing unit {#unit}

A pricing unit means a single billing unit. The number of billing units spent on calculations depends on:
* Capacity of the computing resources being used.
* Time spent on calculations.

   The calculation time is rounded up to an integer number of seconds.

The cost of one billing unit means the cost of using one CPU core for one second. The number of units depends on computing resource configurations.


[Background operation costs](#async) are calculated separately.

#### Example of calculating cost for {{ ds }} mode {#price-example}

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
