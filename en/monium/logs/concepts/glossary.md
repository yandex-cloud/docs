# Basic terms

### Log line {#log-row}

A _log line_ is the smallest data processing unit in the system. It represents a system event, its description, its timestamp in the user’s system, and labels that identify it.

### Log line size {#log-row-size}

The log line size is measured in bytes and equals the sum of all top-level field values, as well as the sum of lengths of all keys and values from `labels` and `meta`.

### Event lag {#event-lag}

Event lag is the latency between when the event was generated in the user system and when it was delivered to the centralized logging system (upstream of the collector).

### Observed lag {#observed-lag}

Observed lag is the latency between when the event was first processed by the agent (the very first one in the chain, if any) and when it was delivered to the centralized logging system (upstream of the collector).