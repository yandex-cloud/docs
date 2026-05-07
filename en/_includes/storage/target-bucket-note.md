{% note info %}

To write logs to the target bucket with an [access policy](../../storage/concepts/policy.md) configured, [add](../../storage/operations/buckets/policy.md#apply-policy) a rule to this policy to allow any account to perform the `PutObject` action, and specify the name of the bucket with a [key prefix](../../storage/concepts/server-logs.md#key-prefix) for log objects, e.g., `<bucket_name>/logs/*`, as a resource.

{% endnote %}