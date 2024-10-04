> 128 RUs × 1,024 × 10 = 1,310,720 RUs

Where:

* 128: Cost of request for 1 MB of data.
* 1,024 × 10: Amount of copied data, in MB.

The number of spent RUs (1,310,720) [exceeds 1,000,000](#prices), so the cost of creating a backup will be $0.171040 for 1,000,000 RUs.

> (1,310,720 RUs - 1,000,000 RUs) / 1,000,000 × $0.171040 = $0.0531455488
>
> Total: $0.053146, the cost of creating a 10 GB backup.

Where:

* 1,310,720 RUs: Actual (on-demand) consumption of RUs per month.
* $0.171040: Price per 1 million RUs.