---
title: Service sections
description: 'In this article, you will learn about the service sections: status, main_thread_pool, agent_log, system, and flow_control.'
---

# Service sections

## The status section {#status}

This section contains the {{ unified-agent-short-name }} status viewing configuration.

```yaml
status:  # optional
  # You can disable status viewing by setting the value to false.
  enabled: true  # optional, the default value is true

  # Host for viewing the status (null/empty string/::) on all interfaces.
  # For security reasons, the status service is only available locally by default.
  host: localhost  # optional

  # Port for viewing the status.
  port: 16301  # required
```

## The main_thread_pool section {#main_thread_pool}
This section contains a configuration for execution threads.

Parameter descriptions:

```yaml
main_thread_pool:  # optional
  # Number of threads.
  threads: 1  # optional, the default value is 1
```

## The agent_log section {#agent_log}
This section contains the agent log settings. You can override the setting using command line parameters.

Parameter descriptions:

```yaml
agent_log:  # optional
  # Logging level.
  # The possible values are: EMERG, ALERT, CRITICAL_INFO, ERROR, WARNING, NOTICE, INFO, DEBUG, RESOURCES.
  priority: NOTICE  # optional, the default value is NOTICE

  # Log to a specified file.
  file: cerr  # optional, the default value is cerr (standard error stream)

  # Limit logging speed to a specified value.
  # The excess will be dropped. Bytes dropped in this way will be counted by the DroppedBytes counter in the agent-log group.
  rate_limit_bytes: null  # optional, not set by default
```

## The system section {#system}
Miscellaneous system settings.

Parameter descriptions:

```yaml
system:  # optional
  # Prevent the agent's executable code from being paged from RAM to the swap area by using the *mlock* system call.
  # This may help reduce delays by eliminating major page faults for swapping code from the disk.
  lock_executable_in_memory: false  # optional, the default value is false

  # Limit RAM in use with the help of the setrlimit system call.
  memory_limit: null  # optional, not set by default
```

## The flow_control section {#flow_control}
This section contains a session control configuration. Use it to configure various session limits and behaviors triggered by them.

You can use the `flow_control` section for inputs and storage references (`storage_ref`).

Parameter descriptions:

```yaml
flow_control:  # optional
  # Session buffer settings.
  # A limit can be expressed as a byte or message count.
  # Exceeding any of the limits triggers the logic specified in the `action` attribute.
  # The message count limit can be of use when you have many small messages at the input, each resulting in a large output message.
  inflight:
    # Buffer size in bytes.
    limit: 10mb  # optional, the default value is 10mb

    # Buffer size expressed as a message count.
    limit_messages: null  # optional, not set by default

    # Behavior on full buffer:
    #   * backpressure: Pause receiving new messages until the buffer is freed up.
    #   * drop: Drop new messages if not fitting into the buffer.
    action: backpressure  # optional, the default value is backpressure

  # Limit on how often new sessions can be created, in new sessions per second.
  # If the limit is exceeded, the StartSession method returns TStartSessionResult::Throttled in the Status field.
  # There is no default value for storages.
  # For inputs, the default value is 5.
  new_sessions_rate_limit: 5 # optional, the default value is 5 for inputs; not supported for storage_ref
```
