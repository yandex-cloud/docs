#### Quotas {#ydb-quotas}

**Dedicated instance mode**

| Limits | Value |
| ----- | ----- |
| Total number of processor cores for all the database hosts in a cloud | 64 |
| Total virtual memory amount for all database hosts in a cloud | 256 GB |
| Maximum number of hosts per cloud | 8 |
| Maximum number of databases per cloud | 4 |
| Maximum number of storage groups per cloud | 8 |

**Serverless mode**

| Limits | Value |
| ----- | ----- |
| Maximum number of databases | 4 |
| Maximum number of serverless requests per second per cloud | 1000 RU |
| Maximum number of schema operations^*^ per day per serverless database | 1000 |
| Maximum number of schema operations^*^ per minute per serverless database | 30 |

^*^Transactions for which there is a quota: creating, updating, and deleting table schemas, getting a table description, getting a list of tables, and creating and deleting directories.

**Things to note about applying quotas for the number of serverless requests per second**

If the quota for the number of serverless requests is exceeded, a query is not accepted for execution and the `Throughput limit exceeded` error is returned. This error means that you can safely retry your query later. We recommend that you use the methods supplied as part of the {{ ydb-short-name }} SDK when re-sending. The proposed methods implement repetition algorithms that use different repetition strategies depending on error type and code: zero delay, exponential backoff, fast or slow repetition, and others.

The restriction is triggered with some delay, so the `Throughput limit exceeded` error is returned for a subsequent query rather than the specific query that resulted in exceeding the quota. After the restriction is triggered, requests will not be accepted for execution for a period approximately equal to the ratio of the requests over quota to the quota itself. If you use 1000 RU, for instance, in the execution of a single query while your quota is 100 RU, new requests will not be accepted for 10 seconds.

To reduce the risk of rejection under uneven load, {{ ydb-short-name }} flexibly applies restrictions using a bandwidth reservation mechanism (`burst capacity`). As long as you use fewer RU processing requests than specified in the restriction, the unused bandwidth is reserved. During peak usage, more bandwidth than specified in the restriction may be temporarily available from the accumulated reserve.

{{ ydb-short-name }} reserves about 5 minutes of bandwidth. The reserve enables you to run a single query with a cost of about `5 min × 60 s × quota RU/s` without subsequent requests being rejected. The `burst capacity` availability policy may be changed.

The quota for the number of serverless requests is also a tool to protect from paying for resource overruns resulting from application faults or attacks on the service. The `burst capacity` mechanism enables you to set the quota to the lowest value at which your application works without getting any `Throughput limit exceeded` errors and to keep some margin against an unexpected increase in load.

