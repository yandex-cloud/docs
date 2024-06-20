# Storages

Storages are listed in the `storages` section, while storage references are added to the `pipe` section. The number of storages is unlimited; however, you can make only one reference to a storage.

## Description of storages in the storages section {#storages_section}

The storage description consists of the following elements:

- `name`: Name of the storage that can be referenced from the pipe.
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
      name: main # required, storage name defined in the storages section

      # Configuration of the session infrastructure.
      flow_control:
        new_sessions_rate_limit: null # optional, not set by default
```

## fs storage plugin {#fs_storage}

Only the `fs` (file storage) plugin is supported. Messages are saved in partitions. Partitions are the directories that contain the segment files with message data and the files with metadata.

{% note warning %}

We do not recommend using the file storage with the `nobarrier` file system mount option. Data integrity in case of power failure is not guaranteed, so manual intervention might be needed.

{% endnote %}

Parameter descriptions:

```yaml
storages: # optional

  # Storage name. You can use this name to reference the storage from pipes using storage_ref.
  # You can only reference storages once.
name: main # required
  # Plugin name. For now, only the fs plugin for binary storages in the file system is supported.
  plugin: fs # required

  config:
    # Directory with the storage data.
    # Subdirectories for partitions are created here.
    directory: ./data/storage # required

    # Maximum partition size.
    # By default, a storage has just one partition named default.
    # A new partition is only created if the user explicitly requested this by specifying the partition name in the _partition key of the session metadata.
    # In the core use cases, there is only one partition. This parameter can therefore be considered a limit imposed on the total storage size.
    max_partition_size: 10mb # required

    # Directory that stores auxiliary information for the storage.
    # The default value is .state inside the directory
    state_directory: {directory} / .state # optional, the default value is .state inside the directory

    # Maximum size of a segment (one file) within a partition.
    # The default value is one-tenth of the partition size.
    max_segment_size: {max_partition_size} / 10 # optional, the default value is one-tenth of max_partition_size

    # Block size for writing.
    # To reduce the overhead for system calls, messages are grouped into a block before calling write.
    # write is called if the block exceeds the specified size.
    block_flush_size: 1mb # optional, the default value is 1 MB

    # The block's lifetime for writing.
    # write will be called if more than the specified time has passed since the first message was received in the block.
    block_flush_period: 10ms # optional, the default value is 10 ms

    # The buffer size for calling syscall read.
    # Equals block_flush_size by default.
    read_buffer_size: {block_flush_size} # optional, equal to block_flush_size by default

    # Time to store the session information.
    # As soon as the incoming session is closed, the storage stops storing information about the session.
    # The mapping sessionid->last_seq_no and the session metadata are deleted.
    # The session is only deleted if all its data is written to the outputs.
    session_retention_time: 1h # optional, the default value is 1h

    # Partition data storage time.
    # The partition is deleted after the specified time if:
    # * All its data is written to outputs and confirmation is received.
    # * There are no active sessions that write data to this partition.
    partition_retention_time: 1h # optional, the default value is 1h

    # Check frequency for session_retention_time and partition_retention_time.
    retention_check_period: 1m # optional, default value is 1m

    # The fsync execution frequency.
    # The more often you run fsync, the less data you need to check on failure recovery, and the faster the agent starts.
    checkpoint_period: 1s # optional, not set by default

    # This parameter describes the conditions for saving data segments after receiving confirmation from the output.
    # If none of the conditions are met, the segments are deleted in the sequence from the old ones to the new ones.
    # The meaning of "old segment" here is opposite from the one currently written to.
    #
    # The conditions are checked:
    # * When receiving confirmation from the output.
    # * When receiving new data.
    # * Periodically, based on retention_check_period.
    #
    # The TrailingMessageAgeMs and TrailingSegmentAgeMs counters are supported at the partition level.
    # TrailingMessageAgeMs is determined by the timestamp of the first message of the oldest segment.
    # This counter approximately evaluates (without accounting for possible timestamp nonmonotonicity) the period of time for which the partition has data.
    # TrailingSegmentAgeMs is determined in a similar manner based on the segment that follows it.
    # This counter shows when the last segment will be deleted (when the value of the by_age property is reached).
    # The values of both counters are measured in milliseconds.
    # If there is no segment in the partition, both counters equal zero.
    # If there is only one segment in the partition, TrailingSegmentAgeMs equals zero.
    #
    # This parameter is not set by default, i.e., the oldest segment is deleted when confirmation for the last message of this segment is received from the output.
    data_retention: # optional
      # The segment is not deleted as there are more recent messages.
      # The relevance of messages can be figured out from the timestamp field value of the first message in the penultimate segment.
      # The partition stores data for approximately the specified period.
      by_age: 10d # optional, not set by default

      # The segment is not deleted as long as the partition's data size, less the segment's own size, remains short of the specified size.
      # That means the partition size will be maintained equal to or greater than the one specified.
      # If you specify by_size: max, the data will be deleted only when the partition size limit is reached.
      by_size: 500mb # optional, not set by default

    # The logging level to use when deleting unconfirmed data.
    # The agent's monitoring usually tracks the value of the Errors counter: the total number of events inside the agent logged with the ERROR level.
    # If storage overflow is a possible scenario (e.g., the data is being written to the agent at a higher rate than set in the new_sessions_rate_limit parameter of the flow_control section), you can use this parameter to disable alert firing.
    # Acceptable values: EMERG, ALERT, CRITICAL_INFO, ERROR, WARNING, NOTICE, INFO, DEBUG, RESOURCES.
    unacknowledged_eviction_log_priority: ERROR # optional, default value is ERROR
```
