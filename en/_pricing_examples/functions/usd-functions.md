> $0.043760 × ((512 / 1,024) × (800 / 3,600 / 1,000) × 10,000,000 – 10) + $0.128000 × ((10,000,000 – 1,000,000) / 1,000,000)
>
> Total: $49.336622

Where:
* $0.043760: Price per 1 GB×hour.
* 512 / 1,024 converts MB to GB, as execution time is calculated in GB×hour.
* 800 / 3,600 / 1,000 converts milliseconds to hours, as execution time is calculated in GB×hour.
* 10,000,000: Number of function calls.
* 10: Subtracted because the first 10 GB×hour are free of charge.
* $0.128000: Price per 1 million function calls.
* 10,000,000: Number of function calls.
* 1,000,000: Subtracted because the first million calls are free of charge.
* 1,000,000: Divisor to calculate the number of millions of function calls.