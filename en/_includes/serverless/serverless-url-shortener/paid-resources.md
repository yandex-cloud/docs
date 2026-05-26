The infrastructure support cost for the URL shortener includes:
* Fee for data storage (see [{{ objstorage-full-name }} pricing](../../../storage/pricing.md)).
* Fee for [YDB database](../../../ydb/concepts/resources.md#database) operations and data storage (see [{{ ydb-name }} pricing](../../../ydb/pricing/serverless.md)).
* Fee for the number of [function](../../../functions/concepts/function.md) calls, computing resources allocated to run the function, and outgoing traffic (see [{{ sf-name }} pricing](../../../functions/pricing.md)).
* Fee for the number of requests to the [API gateway](../../../api-gateway/concepts/index.md) and outgoing traffic (see [{{ api-gw-name }} pricing](../../../api-gateway/pricing.md)).