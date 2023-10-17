{% note info %}

To write logs to the target bucket with an [access policy](../../storage/concepts/policy.md) configured, [add](../../storage/operations/buckets/policy.md#apply-policy) there a rule to allow any account to perform the `PutObject` action, and specify the log object [key prefix](../../storage/concepts/server-logs.md#key-prefix), e.g., `logs/`, as a resource.

{% endnote %}