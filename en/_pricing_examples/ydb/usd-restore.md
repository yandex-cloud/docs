> 0,5 RU × 1 024 × 1 024 × 10 = 5 242 880 RU

Where:

* 0.5: Cost of request for 1 KB of data.
* 1,024 × 1,024 × 10: Amount of data recovered, in KB.

The number of RUs spent (5,242,880) [exceeds 1,000,000](#prices), so the cost of recovery from a backup will be $0.171040 for 1,000,000 RUs.

> (5,242,880 RUs - 1,000,000 RUs)/ 1,000,000 × $0.171040 = $0.7257021952
>
> Total: $0.725702: Cost of recovery from a backup of 10 GB of data.

Where:

* 5,242,880 RUs: Actual (on-demand) consumption of RUs per month.
* $0.171040: Price per 1 million RUs.