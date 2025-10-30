---
sourcePath: en/monitoring_includes/concepts/data-collection/unified-agent/storage.md
---
# Storages

Storages are listed in the `storages` section, while storage references are added to the `pipe` section. The number of storages is unlimited; however, you can make only one reference to a storage.

## Description of storages in the storages section {#storages_section}

The storage description consists of the following elements:

- `name`: Storage name to use for reference from the pipe.
- `plugin`: [Storage plugin](#storages).
- `config`: Input configuration.

Example of the `storages` section:

```yaml
storages:
- name: main
  plugin: fs
  config:
    directory: ./data/storage/main
    max_partition_size: 500mb
- name: secondary
  plugin: fs
  config:
    directory: ./data/storage/secondary
    max_partition_size: 100mb
```

## Adding a storage to the pipe section {#pipe_section_storage}

To make a reference to a storage, you can use the `storage_ref` directive with the following parameters:

- `name`: Name of the storage defined in `storages`.
- `flow_control`: Settings for the [session creation mechanism](#flow_control).

Here is an example of a pipe with a storage reference:

```yaml
pipe:
  - storage_ref:
      name: main  # Required; name of the storage defined in `storages`

      # Configuration for the session infrastructure.
      flow_control:
        new_sessions_rate_limit: null  # optional, not set by default
```

## fs storage plugin {#fs_storage}

Only the `fs` (file storage) plugin is supported. Messages are saved in partitions. Partitions are the directories that contain the segment files with message data and the files with metadata.

{% note warning %}

We do not recommend using the file storage with the `nobarrier` file system mount option. Data integrity in case of power failure is not guaranteed, so manual intervention might be needed.

{% endnote %}

Parameter descriptions:

```yaml
storages:  # optional
  
  # Storage name. You can use this name to reference the storage from pipes using storage_ref.
  # You can only reference a storage once.
- name: main  # required
  # Plugin name. For now, only the fs plugin for binary storages in the file system is supported.
  plugin: fs  # required

  config:
    # Directory with the storage data.
    # Subdirectories for partitions are created here.
    directory: ./data/storage  # required

    # The maximum partition size.
    # By default, a storage only has one partition named `default`.
    # A new partition is only created if the user explicitly requested this by specifying the partition name in the `_partition` key of the session metadata.
    # In the core use cases, there is only one partition. This parameter can therefore be considered a limit imposed on the total storage size.
    max_partition_size: 10mb  # required

    # The directory that stores auxiliary information for the storage.
    # By default, this is `.state` inside `directory`.
    state_directory: {directory} / .state  # Optional, by default, this is `.state` inside `directory`.

    # The maximum size of a segment (single file) within a partition.
    # The default value is one-tenth of the partition size.
    max_segment_size: {max_partition_size} / 10  # Optional, the default value is one-tenth of `max_partition_size`.

    # Block size for writing.
    # To reduce the overhead for system calls, messages are grouped into a block before a `write` call.
    # `write` is called if the block exceeds the specified size.
    block_flush_size: 1mb  # Optional, the default value is `1mb`.

    # Lifetime of the block for writing.
    # `write` will be called if the time since the first message in the block exceeds the specified value.
    block_flush_period: 10ms  # Optional, the default value is `10ms`.

    # The buffer size for calling `syscall read`.
    # By default, it equals `block_flush_size`.
    read_buffer_size: {block_flush_size}  # Optional, equals `block_flush_size` by default.

    # Time to store the session information.
    # As soon as the incoming session is closed, the storage no longer retains information about the session.
    # The `sessionId->last_seq_no` mapping and session metadata will be deleted.
    # The session is only deleted if all its data has been written to the outputs.
    session_retention_time: 1h  # Optional, the default value is 1h.

    # Partition data storage time.
    # The partition will be deleted after the specified time if:
    # * All its data is written to outputs and confirmation is received.
    # * There are no active sessions that write data to this partition.
    partition_retention_time: 1h  # Optional, the default value is 1h.

    # Frequency of checks for `session_retention_time` and `partition_retention_time`.
    retention_check_period: 1m  # Optional, the default value is `1m`.

    # The `fsync` execution frequency.
    # The more often you run `fsync`, the less data you need to check on failure recovery, and the faster the agent starts.
    checkpoint_period: 1s  # Optional, not set by default.

    # This parameter describes the conditions for saving data segments after receiving confirmation from the output.
    # If none of the conditions are met, the segments are deleted starting with the older ones.
    # By an _old segment_ here we mean a segment opposite to the one where writing is in progress.
    #
    # The conditions are checked:
    # * When receiving confirmation from the output.
    # * When receiving new data.
    # * Regularly, at an interval of `retention_check_period`.
    #
    # The `TrailingMessageAgeMs` and `TrailingSegmentAgeMs` counters are supported at the partition level.
    # `TrailingMessageAgeMs` is determined by the `timestamp` of the first message in the oldest segment.
    # This counter approximately evaluates (without accounting for possible `timestamp` nonmonotonicity) the period of time for which the partition has data.
    # `TrailingSegmentAgeMs` is determined in a similar manner based on the segment that follows it.
    # This counter shows when the last segment will be deleted (when the value of the `by_age` property is reached).
    # The values of both counters are measured in milliseconds.
    # If there is no segment in the partition, both counters equal zero.
    # If there is only one segment in the partition, `TrailingSegmentAgeMs` equals zero.
    #
    # This parameter is not set by default. In other words, the oldest segment is deleted when confirmation for the last message of this segment is received from the output.
    data_retention:  # optional
      # The segment is not deleted while it contains more recent messages.
      # The relevance of messages is determined by the `timestamp` field value of the first message in the second-to-last segment.
      # The partition stores data for approximately the specified period.
      by_age: 10d  # Optional, not set by default.

      # The segment is not deleted as long as the partition's data size without the segment's own size remains less than the specified size.
      # This means the partition size will be maintained to not drop below the specified value.
      # If you specify `by_size: max`, the data will be deleted only when the partition size limit is reached.
      by_size: 500mb  # Optional, not set by default.

    # The logging level to use when deleting unconfirmed data.
    # The agent's monitoring usually tracks the value of the `Errors` counter, which is the total number of events inside the agent logged with the `ERROR` level.
    # If storage overflow is possible (e.g., the data is being written to the agent at a higher rate than set in the `new_sessions_rate_limit` parameter of the `flow_control` section), you can use this parameter to disable alert firing.
    # The possible values are: EMERG, ALERT, CRITICAL_INFO, ERROR, WARNING, NOTICE, INFO, DEBUG, RESOURCES.
    unacknowledged_eviction_log_priority: ERROR  # Optional, the default value is `ERROR`.
```
