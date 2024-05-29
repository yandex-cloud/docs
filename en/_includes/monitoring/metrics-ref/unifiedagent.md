The metric name is written in the `name` label.

All {{ unified-agent-short-name }} metrics share the `service=custom` label.

## Native {{ unified-agent-short-name }} metrics {#ua-metrics}

| Metric name<br>Type, unit | Description |
| --- | --- |
| `ua.backlog`<br>`DGAUGE`, number | Number of incoming messages for which no outgoing messages have been sent yet. Includes messages from the storage and all incoming but unsent messages. You can safely delete {{ unified-agent-short-name }} along with directories on the disk, if this metric equals zero and is not incrementing. |
| `ua.bytes_lost`<br>`RATE`, bytes | Amount of data lost in transit. |
| `ua.errors`<br>`RATE`, number | Number of {{ unified-agent-short-name }} events with `ERROR` level. For example, data loss due to a corrupted file on disk or exceeded limits, plugin errors while creating a session, or unavailable external services. |
| `ua.messages_lost`<br>`RATE`, number | Number of messages lost in transit. |
| `ua.metrics_lost`<br>`RATE`, number | Number of metrics lost in transit. |

## Memory metrics {#sys-memory-metrics}

These metrics are collected from the `/proc/meminfo` file.

| Metric name | Type |
| --- | --- |
| `sys.memory.Active` | `DGAUGE` |
| `sys.memory.ActiveAnon` | `DGAUGE` |
| `sys.memory.ActiveFile` | `DGAUGE` |
| `sys.memory.AnonHugePages` | `DGAUGE` |
| `sys.memory.AnonPages` | `DGAUGE` |
| `sys.memory.Buffers` | `DGAUGE` |
| `sys.memory.Cached` | `DGAUGE` |
| `sys.memory.CommitLimit` | `DGAUGE` |
| `sys.memory.Committed_AS` | `DGAUGE` |
| `sys.memory.Dirty` | `DGAUGE` |
| `sys.memory.Inactive` | `DGAUGE` |
| `sys.memory.InactiveAnon` | `DGAUGE` |
| `sys.memory.InactiveFile` | `DGAUGE` |
| `sys.memory.MajorPageFaults` | `RATE` |
| `sys.memory.Mapped` | `DGAUGE` |
| `sys.memory.MemAvailable` | `DGAUGE` |
| `sys.memory.MemFree` | `DGAUGE` |
| `sys.memory.MemTotal` | `DGAUGE` |
| `sys.memory.Mlocked` | `DGAUGE` |
| `sys.memory.PageTables` | `DGAUGE` |
| `sys.memory.SReclaimable` | `DGAUGE` |
| `sys.memory.SUnreclaim` | `DGAUGE` |
| `sys.memory.Shmem` | `DGAUGE` |
| `sys.memory.Slab` | `DGAUGE` |
| `sys.memory.SwapCached` | `DGAUGE` |
| `sys.memory.SwapFree` | `DGAUGE` |
| `sys.memory.SwapTotal` | `DGAUGE` |
| `sys.memory.Unevictable` | `DGAUGE` |
| `sys.memory.Writeback` | `DGAUGE` |


## CPU metrics {#sys-cpu-metrics}

These metrics are collected from the `/proc/cpuinfo` file.

| Metric name | Type |
| --- | --- |
| `sys.cpu.CpuCores` | `DGAUGE` |
| `sys.cpu.PhysicalCpuFrequency.Avg` | `DGAUGE` |
| `sys.cpu.PhysicalCpuFrequency.Max` | `DGAUGE` |
| `sys.cpu.PhysicalCpuFrequency.Min` | `DGAUGE` |


## File system metrics {#sys-filesystem-metrics}

| Metric name | Type |
| --- | --- |
| `sys.filesystem.FreeB` | `DGAUGE` |
| `sys.filesystem.INodeFree` | `DGAUGE` |
| `sys.filesystem.INodeTotal` | `DGAUGE` |
| `sys.filesystem.INodeUsed` | `DGAUGE` |
| `sys.filesystem.SizeB` | `DGAUGE` |
| `sys.filesystem.UsedB` | `DGAUGE` |


## Core metrics {#sys-proc-metrics}

These metrics are collected from the `/proc/loadavg` and `/proc/stat` files.

| Metric name | Type |
| --- | --- |
| `sys.proc.La` | `DGAUGE` |
| `sys.proc.LoadAverage15min` | `DGAUGE` |
| `sys.proc.LoadAverage1min` | `DGAUGE` |
| `sys.proc.LoadAverage5min` | `DGAUGE` |
| `sys.proc.ProcsBlocked` | `DGAUGE` |
| `sys.proc.ProcsRunning` | `DGAUGE` |
| `sys.proc.Threads` | `DGAUGE` |

## Disk metrics {#sys-disk-metrics}

| Metric name | Type |
| --- | --- |
| `sys.io.Disks.IOMillisec` | `RATE` |
| `sys.io.Disks.IOServiceTime` | `DGAUGE` |
| `sys.io.Disks.IOsInProgress` | `DGAUGE` |
| `sys.io.Disks.ReadBytes` | `RATE` |
| `sys.io.Disks.ReadWaitMillisec` | `RATE` |
| `sys.io.Disks.ReadWaitMillisecAvg` | `DGAUGE` |
| `sys.io.Disks.Reads` | `RATE` |
| `sys.io.Disks.TimeInQueueMillisec` | `RATE` |
| `sys.io.Disks.WriteBytes` | `RATE` |
| `sys.io.Disks.WriteWaitMillisec` | `RATE` |
| `sys.io.Disks.WriteWaitMillisecAvg` | `DGAUGE` |
| `sys.io.Disks.Writes` | `RATE` |

## Network metrics {#sys-net-metrics}

These metrics are collected from the `/proc/net/dev` structure.

| Metric name | Type |
| --- | --- |
| `sys.net.Ifs.RxBytes` | `RATE` |
| `sys.net.Ifs.RxDrop` | `RATE` |
| `sys.net.Ifs.RxErrs` | `RATE` |
| `sys.net.Ifs.RxPackets` | `RATE` |
| `sys.net.Ifs.TxBytes` | `RATE` |
| `sys.net.Ifs.TxDrop` | `RATE` |
| `sys.net.Ifs.TxErrs` | `RATE` |
| `sys.net.Ifs.TxPackets` | `RATE` |


## System metrics {#sys-system-metrics}

| Metric name | Type |
| --- | --- |
| `sys.system.GuestNiceTime` | `RATE` |
| `sys.system.GuestTime` | `RATE` |
| `sys.system.IdleTime` | `RATE` |
| `sys.system.IoWaitTime` | `RATE` |
| `sys.system.IrqTime` | `RATE` |
| `sys.system.NiceTime` | `RATE` |
| `sys.system.StealTime` | `RATE` |
| `sys.system.SystemTime` | `RATE` |
| `sys.system.UpTime` | `RATE` |
| `sys.system.UpTimeRaw` | `DGAUGE` |
| `sys.system.UserTime` | `RATE` |
| `sys.system.CpuUsagePercent` | `DGAUGE` |

See the description of Linux system metrics in the documentation, e.g., [Linux manual page](https://man7.org/linux/man-pages/man5/proc.5.html).