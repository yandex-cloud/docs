> 128 RUs × 1,024 × 10 = 1,310,720 RUs

Where:

* 128: Cost of request for 1 MB of data.
* 1,024 × 10: Amount of copied data, in MB.

The number of spent RUs (1,310,720) [exceeds 1,000,000](#prices), so the cost of creating a backup will be {{ sku|USD|ydb.v1.serverless.requests|pricingRate.1|string }} for 1,000,000 RUs.

> (1,310,720 RUs - 1,000,000 RUs) / 1,000,000 × {{ sku|USD|ydb.v1.serverless.requests|pricingRate.1|string }} = {% calc [currency=USD] (1310720 - 1000000) / 1000000 × {{ sku|USD|ydb.v1.serverless.requests|pricingRate.1|number }} %}
>
> Total: {% calc [currency=USD] (1310720 - 1000000) / 1000000 × {{ sku|USD|ydb.v1.serverless.requests|pricingRate.1|number }} %}, cost of creating a 10 GB backup.

Where:

* 1,310,720 RUs: Actual (on-demand) consumption of RUs per month.
* {{ sku|USD|ydb.v1.serverless.requests|pricingRate.1|string }}: Price per 1 million RUs.