# Fixing the `Quota limit vpc.routeTables.count exceeded` error


## Issue description {#issue-description}

When creating a resource in {{ yandex-cloud }}, you get this error message:

```
message: Quota limit vpc.routeTables.count exceeded; 
status: 429; description: Quota limit vpc.routeTables.count exceeded; 
code: GATEWAY_REQUEST_ERROR;
```

## Solution {#issue-resolution}

This error means that you exhausted the **Number of route tables** [quota](../../../vpc/concepts/limits.md#vpc-quotas). To fix this issue, you can request the quota increase using [this form in the management console]({{ link-console-quotas }}) or redistribute route tables.