


Example of calculating the cost of a function that has:
* **Memory specified when creating the version:** 512 MB
* **Number of function calls:** 10,000,000
* **Execution time of each call:** 800 ms

Function cost calculation:

> 0.043760 × ((512 / 1,024) × (800 / 3,600 / 1,000) × 10,000,000 – 10) + 0.128000 × ((10,000,000 – 1,000,000) / 1,000,000)
>
> Total: $49.336622

Where:
* 0.043760 is the price for 1 GB×hour.
* 512 / 1,024 converts MB to GB, as execution time is calculated in GB×hour.
* 800 / 3,600 / 1,000 converts milliseconds to hours, as execution time is calculated in GB×hour.
* 10,000,000 is the number of function calls.
* 10 is subtracted because the first 10 GB×hour are free.
* 0.128000 is the price per 1 million function calls.
* 10,000,000 is the number of function calls.
* 1,000,000 is subtracted because the first million invocations are free of charge.
* 1,000,000 is the divisor used to calculate the number of millions of function calls.
