> $0.0256 × (2 × (150 / 3,600,000) × 3,000,000 – 10) + $0.0384 × (1 × (150 / 3,600,000) × 3,000,000 – 5) + $0.1280 × ((3,000,000 – 1,000,000) / 1,000,000)
>
> Total: $11.0080

Where:

* $0.0256: Price per 1 GB×hour in excess of 10 GB×hour per month.
* 2: Amount of RAM.
* 150 / 3,600,000 converts milliseconds to hours, as RAM usage time is calculated in GB×hour.
* 3,000,000: Number of container invocations.
* 10: RAM usage time free of charge.
* $0.0384: Price per 1 hour of CPU usage in excess of 5 vCPUs × hour per month.
* 1 : Number of vCPU cores.
* 150 / 3,600,000 converts milliseconds to hours, as CPU usage time is calculated in GB×hour.
* 3,000,000: Number of container invocations.
* 5: CPU usage time free of charge.
* $0.1280: Price per 1 million container invocations in excess of 1 million per month.
* 3,000,000: Number of container invocations.
* 1,000,000: Subtracted because the first million calls are free of charge.
* 1,000,000: Divisor to calculate the number of millions of container invocations.