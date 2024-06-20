# Service sections

## status section {#status}

This section contains the {{ unified-agent-short-name }} status viewing configuration.

```yaml
status: # optional
  # You can disable status viewing by specifying the false value.
  enabled: true # optional, true by default

  # Host for viewing the status, null/empty string/:: — on all interfaces.
  # For security reasons, the status service is only available locally by default.
  host: localhost # optional

  # Port for viewing the status.
  port: 16301 # required
```

## main_thread_pool section {#main_thread_pool}
This section contains a configuration for execution threads.

Parameter descriptions:

```yaml
main_thread_pool: # optional
  # Number of threads.
  threads: 1 # optional, default value is 1
```

## agent_log section {#agent_log}
This section contains the agent log settings. You can override the setting using command line parameters.

Parameter descriptions:

```yaml
agent_log: # optional
  # Logging level.
  # Acceptable values: EMERG, ALERT, CRITICAL_INFO, ERROR, WARNING, NOTICE, INFO, DEBUG, RESOURCES.
  priority: NOTICE # optional, the default value is NOTICE

  # Write logs to the specified file.
  file: cerr # optional, the default value is cerr (standard error stream)

  # Limit the log write rate to the specified value.
  # Write attempts exceeding this rate are discarded. The number of bytes discarded this way is reflected in the DroppedBytes counter in the "agent-log" group.
  rate_limit_bytes: null # optional, not set by default
```

## system section {#system}
Miscellaneous system settings.

Parameter descriptions:

```yaml
system: # optional
  # Prevents the agent's executable code from being paged from RAM to the swap area by using the mlock system call.
  # This can help you reduce delays, since there will be no major page faults due to swapping code from the disk.
  lock_executable_in_memory: false # optional, default value is false

  # Set a limit on RAM taken up using the setrlimit system call.
  memory_limit: null # optional, not set by default
```

## flow_control section {#flow_control}
This section contains a configuration for session control. The settings allow you to configure various session limits and their behavior upon reaching the limits.

You can use the `flow_control` section for inputs and storage references (`storage_ref`).

Parameter descriptions:

```yaml
flow_control: # optional
  # Session buffer settings.
  # The limit can be expressed as a number of bytes or message count.
  # Exceeding any of the limits triggers the logic specified in the action attribute.
  # The message count limit can be helpful when the input receives many small messages, each triggering a large output message.
  inflight:
    # Buffer size in bytes.
    limit: 10mb # optional, default value is 10 MB

    # Buffer size expressed as message count.
    limit_messages: null # optional, not set by default

    # Behavior when the buffer is full:
    #  * backpressure: Pause receiving new messages until the buffer is released.
    #  * drop: Drop new messages if they exceed the buffer.
    action: backpressure # optional, default value is backpressure

  # Limit on the frequency of creating new sessions, in number of new sessions per second.
  # If the limit is exceeded, the StartSession method returns TStartSessionResult::Throttled in the Status field.
  # There's no default value for storages.
  # For inputs, the default value is 5.
  new_sessions_rate_limit: 5 # optional, the default value is 5 for inputs, not supported for storage_ref
```
