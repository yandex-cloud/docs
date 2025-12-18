# Fixing error 503 `Service Unavailable`


## Issue description {#issue-description}

Database reads or writes end with this error:

```
message: "Service Unavailable",
requestId: "SOME_UUID",
status: 503
```

## Solution {#issue-resolution}

This error may occur if you exceed the quota. It happens when you perform a lot of concurrent operations with a database.

To resolve the error, we recommend requesting an increase for the **Number of requests per second** quota on [this page]({{ link-console-quotas }}). You can also view the current values for all your quotas there.