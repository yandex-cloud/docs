> 0.5 RUs × 1,024 × 1,024 × 10 = 5,242,880 RUs

Where:

* 0.5: Cost of request for 1 KB of data.
* 1,024 × 1,024 × 10: Amount of data being recovered, in KB.

The number of spent RUs (5,242,880) [exceeds 1,000,000](#prices), so the cost of recovery from a backup will be {{ sku|USD|ydb.v1.serverless.requests|pricingRate.1|string }} for 1,000,000 RUs.

> (5,242,880 RUs - 1,000,000 RUs) / 1,000,000 × {{ sku|USD|ydb.v1.serverless.requests|pricingRate.1|string }} = {% calc [currency=USD] (5242880 - 1000000) / 1000000 × {{ sku|USD|ydb.v1.serverless.requests|pricingRate.1|number }} %}
>
> Total: {% calc [currency=USD] (5242880 - 1000000) / 1000000 × {{ sku|USD|ydb.v1.serverless.requests|pricingRate.1|number }} %}, the cost of recovery from a backup of 10 GB of data.

Where:

* 5,242,880 RUs: Actual (on-demand) consumption of RUs per month.
* {{ sku|USD|ydb.v1.serverless.requests|pricingRate.1|string }}: Price per 1 million RUs.