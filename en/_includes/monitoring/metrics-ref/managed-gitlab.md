The `name` label stores the metric name.

Labels shared by all {{ mgl-name }} metrics:

| Label     |   Value                                     |
|-----------|------------------------------------------------|
| service   | Service ID: `managed-gitlab`.         |
| host      | Instance name in the `.gitlab.yandexcloud.net` domain. |
| cloud_id  | [Cloud](../../../resource-manager/concepts/resources-hierarchy.md#cloud) ID.    |
| folder_id | [Folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) ID. |

## Disk metrics {#managed-gitlab-disc-metrics}

Common label for all disk metrics: `mountpoint`. The possible values are:

* `/`: System disk
* `/place/gitlab`: {{ GL }} disk

Disk metrics:

| Name                   | Type      | Description                                             |
|:-----------------------|:---------|:-----------------------------------------------------|
| `sys.filesystem.FreeB` | `DGAUGE` | Free space on all instance disks, in bytes. |
| `sys.filesystem.SizeB` | `DGAUGE` | Instance disk size, in bytes.                     |
| `sys.filesystem.UsedB` | `DGAUGE` | The amount of used instance disk space, in bytes.   |


## RAM metrics {#managed-gitlab-ram-metrics}

| Name                      | Type      | Description                                          |
|:--------------------------|:---------|:--------------------------------------------------|
| `sys.memory.MemAvailable` | `DGAUGE` | The available amount of RAM, in bytes.  |
| `sys.memory.MemFree`      | `DGAUGE` | Unused amount of RAM, in bytes.               |
| `sys.memory.MemTotal`     | `DGAUGE` | Total amount of RAM, in bytes.                        |

## Core metrics {#managed-gitlab-core-metrics}

| Name                        | Type      | Description   |
|:---------------------------|:---------|:-----------|
| `sys.proc.LoadAverage1min` | `DGAUGE` | Average number of running and pending processes per vCPU over the last minute. |
| `sys.proc.LoadAverage5min` | `DGAUGE` | Average number of running and pending processes per vCPU over the last five minutes. |
| `sys.proc.LoadAverage15min` | `DGAUGE` | Average number of running and pending processes per vCPU over the last 15 minutes. |

## System metrics {#managed-gitlab-system-metrics}

Common label for system metrics: `cpu` (vCPU sequence number starting from `0`).

System metrics:

| Name | Type | Description |
|:----|:----|:---------|
| `sys.system.GuestNiceTime` | `DGAUGE` | Time servicing a low-priority guest OS, as a percentage of total CPU time. |
| `sys.system.GuestTime` | `DGAUGE` | Time servicing a guest OS, as a percentage of total CPU time. |
| `sys.system.IdleTime` | `DGAUGE` | CPU idle time, as a percentage of total CPU time. |
| `sys.system.IoWaitTime` | `DGAUGE` | Wait time for I/O operations, as a percentage of total CPU time. |
| `sys.system.IrqTime` | `DGAUGE` | Hardware interrupt processing time, as a percentage of total CPU time. |
| `sys.system.NiceTime` | `DGAUGE` | Execution time of low-priority processes, as a percentage of total CPU time. |
| `sys.system.StealTime` | `DGAUGE` | Hypervisor steal time, as a percentage of total CPU time. |
| `sys.system.SystemTime` | `DGAUGE` | System process execution time, as a percentage of total CPU time. |
| `sys.system.UpTime` | `DGAUGE` | Total time since last system startup in `N days, hh:mm:ss` format. |
| `sys.system.UpTimeRaw` | `DGAUGE` | Total time since last system startup, in seconds. |
| `sys.system.UserTime` | `DGAUGE` | User process execution time, as a percentage of total CPU time. |