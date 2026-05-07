### Log line (log record) {#log-row}

The smallest data processing unit in the system. It represents a system event, its description, timestamp, and labels that identify it.

### Log line size {#log-row-size}

Log line size in bytes represents the sum of all top-level field values, as well as the lengths of all keys and values from `labels` and `meta`.

### Event lag {#event-lag}

Event lag is the latency between when the event was generated in the user system and when it was delivered to the centralized logging system (upstream of the collector).

### Observed lag {#observed-lag}

Observed lag is the latency between when the event was first processed by the collection agent and when it was delivered to the centralized logging system (upstream of the collector).