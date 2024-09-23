## System messages {#router-loggin}

When processing each function call, the system also logs `START`, `END`, and `REPORT` system messages:

```text
START RequestID: <request_ID> Version: <function_version_ID>
END RequestID: <request_ID>
REPORT RequestID: <request_ID>
    Duration: 236.606 ms
    Billed Duration: 300 ms
    Memory Size: 128 MB
    Max Memory Used: 22 MB
    Queuing Duration: 0.027 ms
    Function Init Duration: 225.298 ms
```

All lines contain the ID of the request (`RequestID`), which is generated automatically when the function is invoked.

The `REPORT` line provides a report on the function run. It contains additional information about the resources consumed:
* `Duration`: Time spent invoking the function. It includes the `Queuing Duration` and `Function Init Duration` parameters.
* `Billed Duration`: Time billed based on the [pricing policy](../../functions/pricing.md).
* `Memory Size`: Amount of memory specified at version creation, MB.
* `Max Memory Used`: Memory used when the request starts running.
* `Queuing Duration`: Time spent by the request in the internal queue. If this time increases, it may indicate a lack of function instances. The maximum number of instances is determined by the [quotas](../../functions/concepts/limits.md).
* `Function Init Duration`: Time spent initializing the runtime and loading the function code.
