---
title: '{{ GP }} Command Center parameters'
description: In this article, you will learn what session and query details {{ GP }} Command Center provides.
---

# {{ GP }} Command Center parameters

This section describes the session and query parameters available in [{{ GP }} Command Center](command-center.md).

## Session {#cc-session}

**{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_section_resources }}**:

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-cpu-time }}**: Time used by CPU resources to process queries.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-peak-memory }}**: Maximum memory used to process queries.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-spill-total-bytes }}**: Total size of the files generated and spilled to disk while executing the query.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-read-bytes }}**: Number of bytes read from disk while executing the query.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-write-bytes }}**: Number of bytes written to disk while executing the query.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-net-recv-chunks }}**: Number of packets received via `interconnect`.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-net-sent-chunks }}**: Number of packets sent via `interconnect`.

**{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_section_session-info }}**:

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-user }}**: Username.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-database }}**: DB name.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-state-changed }}**: Date and time of the most recent status change.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-backend-start }}**: Session start date and time.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-application }}**: Connected client’s app name.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-session-client-hostname }}**: Connected client’s host name.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-session-pid }}**: Current session ID.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-session-client-addr }}**: Connected client’s IP address.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-session-client-port }}**: Number of the port the client uses for the connection.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-session-xact-start }}**: Current transaction’s start date and time.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-session-waiting }}**: This parameter defines whether the session waits for blocking events to complete.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-session-backend-xmin }}**: Earliest transaction ID.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-session-rsgid }}**: [Resource group](../../managed-greenplum/concepts/resource-groups.md) object ID.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-session-rsgname }}**: Current resource group name.

**{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_section_session-queries }}**:

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-running-query-key }}**: [Query key](../../managed-greenplum/concepts/command-center.md#statement-key).

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-query-text }}**: Text of the query being executed.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-backend-start }}**: Date and time when the query started executing.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-query-status }}**: Status of the query being executed.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-plan-id }}**: Query execution plan ID.

**{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_section_other-resources }}**:

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-total-system_stat-user_time_seconds }}**: Time used by CPU resources to run program instructions.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-total-system_stat-kernel_time_seconds }}**: Time used by CPU resources to process system calls.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-total-system_stat-rss }}**: Memory used to execute session queries, in bytes.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-total-system_stat-vsize }}**: Memory allocated to the session.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-total-system_stat-rchar }}**: Number of read characters.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-total-system_stat-wchar }}**: Number of written characters.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-total-system_stat-syscr }}**: Number of read operations.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-total-system_stat-syscw }}**: Number of write operations.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-total-system_stat-cancelled_write_bytes }}**: Size of data dropped due to a canceled write.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-net-sent-chunks }}**: Number of packets sent via `interconnect`.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-net-recv-chunks }}**: Number of packets received via `interconnect`.

**{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_section_optimizations }}**:

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-total-instrumentation-nloops }}**: Number of plan node calls.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-total-instrumentation-firsttuple }}**: Time spent processing the first row, in seconds.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-total-instrumentation-startup }}**: Time spent starting the operator, in seconds.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-total-instrumentation-total }}**: Total time spent processing rows.

**{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_section_counters }}**:

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-total-instrumentation-shared_blks_hit }}**: Number of shared memory blocks fetched from the buffer.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-total-instrumentation-shared_blks_read }}**: Number of shared memory blocks read from disk as they were missing in the buffer.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-total-instrumentation-shared_blks_dirtied }}**: Number of shared memory blocks that were modified and now require writing to disk.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-total-instrumentation-shared_blks_written }}**: Number of shared memory blocks written to disk.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-total-instrumentation-local_blks_hit }}**: Number of local blocks fetched from the buffer.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-total-instrumentation-local_blks_read }}**: Number of local blocks read from disk as they were missing in the buffer.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-total-instrumentation-local_blks_written }}**: Number of local blocks written to disk.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-total-instrumentation-temp_blks_read }}**: Number of temporary file blocks read from disk.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-total-instrumentation-temp_blks_written }}**: Number of temporary file blocks written to disk.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-total-instrumentation-blk_read_time }}**: Time spent reading blocks.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-total-instrumentation-blk_write_time }}**: Time spent writing blocks.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-total-spill-file_count }}**: Number of spill files.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-instrumentation-startup-time }}**: Time spent waiting for resources and planning.

## Query {#cc-query}

**{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_section_resources }}**:

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-cpu-time }}**: Time used by CPU resources to process queries.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-peak-memory }}**: Maximum memory used to process queries.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-spill-total-bytes }}**: Total size of the files generated and spilled to disk while executing the query.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-read-bytes }}**: Number of bytes read from disk while executing the query.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-write-bytes }}**: Number of bytes written to disk while executing the query.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-net-recv-chunks }}**: Number of packets received via `interconnect`.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-net-sent-chunks }}**: Number of packets sent via `interconnect`.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-skew }}**: Data skew (non-uniform distribution across segments).

**{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_section_query-info }}**:

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-query-key }}**: Unique attribute assigned to the query during its execution.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-start-time }}**: Query execution start date and time.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-end-time }}**: Query execution end date and time.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-generator }}**: [Query optimizer](https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/7/greenplum-database/admin_guide-query-topics-optimizer-hints.html).

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-min-time }}**: Minimum query execution time.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-max-time }}**: Maximum query execution time.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-username }}**: Username.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-database }}**: DB name.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-query-id }}**: [Non-unique hash](../../managed-greenplum/concepts/command-center.md#statement-id) generated from the query text.

**{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_section_other-resources }}**:

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-user-time-seconds }}**: Time used by CPU resources to run program instructions.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-kernel-time-seconds }}**: Time used by CPU resources to process system calls.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-rss }}**: Memory used to execute the query, in bytes.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-vsize }}**: Memory allocated to execute the query.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-rchar }}**: Number of read characters.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-wchar }}**: Number of written characters.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-syscr }}**: Number of read operations.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-syscw }}**: Number of write operations.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-cancelled_write_bytes }}**: Size of data dropped due to a canceled write.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-net-sent-chunks }}**: Number of packets sent via `interconnect`.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-net-recv-chunks }}**: Number of packets received via `interconnect`.

**{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_section_optimizations }}**:

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-nloops }}**: Number of plan node calls.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-firsttuple }}**: Time spent processing the first row, in seconds.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-startup }}**: Time spent starting the operator, in seconds.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-total-time }}**: Total time spent processing rows.

**{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_section_counters }}**:

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-shared_blks_hit }}**: Number of shared memory blocks fetched from the buffer.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-shared-blks-read }}**: Number of shared memory blocks read from disk as they were missing in the buffer.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-shared-blks-dirtied }}**: Number of shared memory blocks that were modified and now require writing to disk.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-shared_blks_written }}**: Number of shared memory blocks written to disk.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-local_blks_hit }}**: Number of local blocks fetched from the buffer.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-local_blks_read }}**: Number of local blocks read from disk as they were missing in the buffer.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-local_blks_dirtied }}**: Number of local blocks that were modified and now require writing to disk.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-local_blks_written }}**: Number of local blocks written to disk.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-temp_blks_read }}**: Number of temporary file blocks read from disk.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-temp_blks_written }}**: Number of temporary file blocks written to disk.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-blk_read_time }}**: Time spent reading blocks.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_query-field-blk_write_time }}**: Time spent writing blocks.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-query-spill-file_count }}**: Number of spill files.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_field-instrumentation-startup-time }}**: Time spent waiting for resources and planning.

## Interconnect network metrics {#cc-interconnect}

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_interconnect-active-connections-num }}**: Maximum number of active outbound connections registered.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_interconnect-buffer-counting-time }}**: Monotonically increasing counter of buffer availability checks before sending packets. It increases with each successful outbound connection.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_interconnect-buffer-counting-time }}**: Monotonically increasing counter of outbound queue size checks. It increases with every processed connection.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_interconnect-crc-errors }}**: Monotonically increasing counter of packets that failed [checksum validation](https://en.wikipedia.org/wiki/Cyclic_redundancy_check). It applies if `gp_interconnect_full_crc` is enabled.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_interconnect-disordered-pkt-num }}**: Monotonically increasing counter of out-of-order packets. It increases if at least one of these conditions is met:

  * The sequence number of the inbound packet does not match the expected value.
  * The inbound packet queue overflowed and the packet was dropped.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_interconnect-duplicated-pkt-num }}**: Monotonically increasing counter of duplicate packets. It increases when the sequence number of the inbound packet is lower than the highest sequence number of processed packets.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_interconnect-mismatch-num }}**: Monotonically increasing counter of mismatched packets. These packets pertain to the previous query or the current one but are not yet ready for processing.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_interconnect-recv-ack-num }}**: Monotonically increasing counter of acknowledgments for inbound packets.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_interconnect-recv-pkt-num }}**: Monotonically increasing counter of processed inbound packets.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_interconnect-recv-queue-size-counting-time }}**: Monotonically increasing counter of inbound queue size checks. It increases with every processed connection.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_interconnect-retransmits }}**: Monotonically increasing counter of retransmitted packets. Retransmission applies to out-of-order and outdated packets.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_interconnect-snd-pkt-num }}**: Monotonically increasing counter of sent packets.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_interconnect-startup-cached-pkt-num }}**: Monotonically increasing counter of cached packets received but not yet ready for processing.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_interconnect-status-query-msg-num }}**: Monotonically increasing counter of transmitted status packets. These packets are used to check the connection health if no packet transmission acknowledgments are received for a while.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_interconnect-total-buffers }}**: Minimum number of available buffers registered before sending packets.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_interconnect-total-capacity }}**: Maximum size of the outbound queue, in packets.

* **{{ ui-key.yacloud.greenplum.cluster.perf-diag.label_interconnect-total-recv-queue-size }}**: Maximum size of the inbound queue, in packets.

Learn more about `interconnect` [here](https://techdocs.broadcom.com/us/en/vmware-tanzu/data-solutions/tanzu-greenplum/6/greenplum-database/admin_guide-intro-arch_overview.html#arch_interconnect).

{% include [greenplum-trademark](../../_includes/mdb/mgp/trademark.md) %}
