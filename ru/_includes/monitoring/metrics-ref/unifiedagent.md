Имя метрики пишется в метку `name`.

Все метрики {{ unified-agent-short-name }} имеют общую метку `service=custom`.

## Собственные метрики {{ unified-agent-short-name }} {#ua-metrics}

| Имя метрики<br>Тип, единицы измерения | Описание |
| --- | --- |
| `ua.backlog`<br>`DGAUGE`, штуки | Количество входящих сообщений, для которых еще не отправлены исходящие сообщения. Учитывает сообщения из хранилища и все входящие, но неотправленные сообщения. {{ unified-agent-short-name }} можно безопасно удалить вместе с директориями на диске, если эта метрика равна нулю и не увеличивается. |
| `ua.bytes_lost`<br>`RATE`, байты | Объем данных, потерянных при передаче. |
| `ua.errors`<br>`RATE`, штуки | Количество событий {{ unified-agent-short-name }} с уровнем `ERROR`. Например, потеря данных из-за повреждения файла на диске или превышения лимитов, ошибки плагинов при создании сессии, недоступность внешних сервисов. |
| `ua.messages_lost`<br>`RATE`, штуки | Количество сообщений, потерянных при передаче. |
| `ua.metrics_lost`<br>`RATE`, штуки | Количество метрик, потерянных при передаче. |

## Метрики памяти {#sys-memory-metrics}

Метрики собираются из файла `/proc/meminfo`.

| Имя метрики | Тип |
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


## Метрики СPU {#sys-cpu-metrics}

Метрики собираются из файла `/proc/cpuinfo`.

| Имя метрики | Тип |
| --- | --- |
| `sys.cpu.CpuCores` | `DGAUGE` |
| `sys.cpu.PhysicalCpuFrequency.Avg` | `DGAUGE` |
| `sys.cpu.PhysicalCpuFrequency.Max` | `DGAUGE` |
| `sys.cpu.PhysicalCpuFrequency.Min` | `DGAUGE` |


## Метрики файловой системы {#sys-filesystem-metrics}

| Имя метрики | Тип |
| --- | --- |
| `sys.filesystem.FreeB` | `DGAUGE` |
| `sys.filesystem.INodeFree` | `DGAUGE` |
| `sys.filesystem.INodeTotal` | `DGAUGE` |
| `sys.filesystem.INodeUsed` | `DGAUGE` |
| `sys.filesystem.SizeB` | `DGAUGE` |
| `sys.filesystem.UsedB` | `DGAUGE` |


## Метрики ядра {#sys-proc-metrics}

Метрики собираются из файлов `/proc/loadavg` и `/proc/stat`.

| Имя метрики | Тип |
| --- | --- |
| `sys.proc.La` | `DGAUGE` |
| `sys.proc.LoadAverage15min` | `DGAUGE` |
| `sys.proc.LoadAverage1min` | `DGAUGE` |
| `sys.proc.LoadAverage5min` | `DGAUGE` |
| `sys.proc.ProcsBlocked` | `DGAUGE` |
| `sys.proc.ProcsRunning` | `DGAUGE` |
| `sys.proc.Threads` | `DGAUGE` |

## Метрики диска {#sys-disk-metrics}

| Имя метрики | Тип |
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

## Метрики сети {#sys-net-metrics}

Метрики собираются из структуры `/proc/net/dev`.

| Имя метрики | Тип |
| --- | --- |
| `sys.net.Ifs.RxBytes` | `RATE` |
| `sys.net.Ifs.RxDrop` | `RATE` |
| `sys.net.Ifs.RxErrs` | `RATE` |
| `sys.net.Ifs.RxPackets` | `RATE` |
| `sys.net.Ifs.TxBytes` | `RATE` |
| `sys.net.Ifs.TxDrop` | `RATE` |
| `sys.net.Ifs.TxErrs` | `RATE` |
| `sys.net.Ifs.TxPackets` | `RATE` |


## Метрики системы {#sys-system-metrics}

| Имя метрики | Тип |
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

Описание системных метрик Linux смотрите в документации Linux, например [Linux manual page](https://man7.org/linux/man-pages/man5/proc.5.html).