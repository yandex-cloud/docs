## System messages {#router-loggin}

When handling each function call, the system logs `START`, `END`, and `REPORT` system messages:

```
START RequestID: <request ID> Version: <function version ID>
END RequestID: <request ID>
REPORT RequestID: <request ID>
    Duration: 236.606 ms
    Billed Duration: 300 ms
    Memory Size: 128 MB
    Max Memory Used: 22 MB
    Queuing Duration: 0.027 ms
    Function Init Duration: 225.298 ms
```

All lines contain the ID of the request (`RequestID`), which is generated automatically when the function is invoked.

The `REPORT` line provides a report on the function execution. It contains additional information about the resources consumed:

* `Duration`: The time spent invoking the function. It includes the `Queuing Duration` and `Function Init Duration` parameters.
* `Billed Duration`: The time you're billed for in accordance with the [pricing policy](../../functions/pricing.md).
* `Memory Size`: The amount of memory specified when creating the version, MB.
* `Max Memory Used`: The amount of memory used at the start of the request.
* `Queuing Duration`: The time spent by the function call request in the internal queue. If it increases, this may mean there aren't enough function instances. The maximum number of instances depends on the [quotas](../../functions/concepts/limits.md).
* `Function Init Duration`: The time spent initializing the runtime and loading the function code.

