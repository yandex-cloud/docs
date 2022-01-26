You can't disable materialization in the following cases:

* [Geographical functions](../../datalens/function-ref/geographical-functions.md) are used in your dataset.
* The dataset is used for a public chart or dashboard. For a public chart, a managed {{ CH }} database may be sufficient as a data source, without materialization.
