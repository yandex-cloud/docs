# NVIDIA DCGM dashboard metrics without MIG

{{ grafana-name }}'s NVIDIA DCGM dashboard without MIG enables comprehensive monitoring of NVIDIA GPUs without Multi-Instance GPU (MIG) support in a {{ k8s }} cluster. The dashboard presents the metrics of performance, temperature, power consumption, GPU utilization, memory usage, as well as the advanced GPU performance and health analysis metrics.

To open a dashboard:

1. Open {{ grafana-name }}.
1. In the dashboard list, select **NVIDIA DCGM Dashboard w/o MIG metrics**.

The GPU monitoring dashboard without MIG will open.

## General info

**Dashboard title**: NVIDIA DCGM Dashboard w/o MIG metrics.
**UID**: `gpu-wo-mig`.
**Refresh interval**: 30 seconds.
**Data source**: {{ prometheus-name }}.

## Dashboard variables

The dashboard uses the following variables for data filtering:

* **DS_PROMETHEUS**: {{ prometheus-name }} data source.
* **Hostname**: Selects a specific host or all hosts (multi-select supported, all hosts selected by default).
* **gpu**: Selects a specific GPU ID or all GPUs (multi-select supported, all hosts selected by default).

## Panels and metrics

### **Aggregate** section

The section contains aggregated metrics across all selected GPUs.

#### 1. GPU Engine Utilization

**Description**: Average GPU SM core utilization percentage. Shows how active the GPU's main compute pipeline is.

**Metric**: `100 * avg(DCGM_FI_PROF_GR_ENGINE_ACTIVE)`.

**Unit of measurement**: Percentage (0-100).

**Thresholds**:
* Green: Utilization below 60%.
* Yellow: Utilization from 60% to 80%.
* Orange: Utilization from 80% to 90%.
* Red: Utilization above 90%.

#### 2. Tensor Utilization

**Description**: Average tensor core utilization. Tensor cores are specialized compute units for matrix operations, commonly used in machine learning tasks.

**Metric**: `100 * avg(DCGM_FI_PROF_PIPE_TENSOR_ACTIVE)`

**Unit of measurement**: Percentage (0-100)

**Thresholds**:
* Green: Utilization below 60%.
* Yellow: Utilization from 60% to 80%.
* Orange: Utilization from 80% to 90%.
* Red: Utilization above 90%.

**Recommendations**: High tensor core utilization is typical for deep learning tasks. Low utilization during ML workloads may indicate suboptimal GPU usage.

#### 3. GPU Memory Utilization

**Description**: Average GPU memory (DRAM) utilization. Shows how actively the video memory is accessed.

**Metric**: `100 * avg(DCGM_FI_PROF_DRAM_ACTIVE)`.

**Unit of measurement**: Percentage (0-100).

**Thresholds**:
* Green: Utilization below 60%.
* Yellow: Utilization from 60% to 80%.
* Orange: Utilization from 80% to 90%.
* Red: Utilization above 90%.

#### 4. GPU Memory Usage

**Description**: Total amount of video memory used by all GPUs. A gauge panel displays the current usage relative to the total available memory.

**Metrics**:
* `sum(DCGM_FI_DEV_FB_USED)`: Used memory.
* `sum(DCGM_FI_DEV_FB_USED) + sum(DCGM_FI_DEV_FB_FREE)`: Total memory.

**Unit of measurement**: Megabytes.

**Thresholds**:
* Green: Usage below 60%.
* Yellow: Usage from 60% to 80%.
* Orange: Usage from 80% to 90%.
* Red: Usage above 90%.

**Recommendations**: Monitor the GPU memory usage. Exceeding the available memory will cause task execution errors.

### **per GPU** section

This section contains detailed metrics for each individual GPU.

#### 5. GPU temperature

**Description**: Temperature of each GPU in degrees Celsius. The chart displays temperature individually for each GPU.

**Metric**: `avg by(Hostname, gpu) (DCGM_FI_DEV_GPU_TEMP)`.

**Unit of measurement**: Degrees Celsius.

**Thresholds**:
* Green: Normal temperature.
* Red: Temperature above 80°C.

#### 6. Power Usage

**Description**: Power consumption of each GPU in watts. The chart shows current power draw per GPU.

**Metric**: `avg by(Hostname, gpu) (DCGM_FI_DEV_POWER_USAGE)`.

**Unit of measurement**: Watts.

#### 7. GPU Energy Draw Total

**Description**: Total energy consumed by all GPUs over the last hour and last 24 hours.

**Metrics**:
* `sum(increase(DCGM_FI_DEV_TOTAL_ENERGY_CONSUMPTION[1h]) / 3600000)`: Over the last hour.
* `sum(increase(DCGM_FI_DEV_TOTAL_ENERGY_CONSUMPTION[24h]) / 3600000)`: Over the last 24 hours.

**Unit of measurement**: Watt-hours.

**Thresholds**:
* Green: Below 120,000 Wh (for 24 hours) or 5,000 Wh (for 1 hour).
* Yellow: From 120,000 Wh to 150,000 Wh (for 24 hours) or from 5,000 Wh to 10,000 Wh (for 1 hour).
* Red: Above 150,000 Wh (for 24 hours) or 10,000 Wh (for 1 hour).

#### 8. SM clock

**Description**: Average clock frequency of GPU streaming multiprocessors (SMs). An SM is the primary compute unit in NVIDIA GPU architecture.

**Metric**: `avg by(modelName) (DCGM_FI_DEV_SM_CLOCK)`.

**Unit of measurement**: Megahertz.

**Thresholds**:
* Green: Frequency within the normal range.
* Yellow: Frequency from 1500 MHz upward.
* Red: Frequency above 2,000 MHz.

#### 9. Memory clock

**Description**: Average GPU memory clock frequency.

**Metric**: `avg by(modelName) (DCGM_FI_DEV_MEM_CLOCK)`.

**Unit of measurement**: Megahertz.

**Thresholds**:
* Green: Frequency within the normal range.
* Yellow: Frequency from 1500 MHz upward.
* Red: Frequency above 2,000 MHz.

#### 10. Memory temperature

**Description**: Memory temperature of each GPU in degrees Celsius.

**Metric**: `avg by(Hostname, gpu) (DCGM_FI_DEV_MEMORY_TEMP)`.

**Unit of measurement**: Degrees Celsius.

**Thresholds**:
* Green: Normal temperature.
* Red: Temperature above 80°C.

#### 11. NVLink bandwidth

**Description**: Bandwidth of NVLink, the high-speed connection between GPUs. Shows the data transfer rate between GPUs.

**Metric**: `avg by(Hostname, gpu) (rate(DCGM_FI_DEV_NVLINK_BANDWIDTH_TOTAL))`.

**Unit of measurement**: Bytes per second.

#### 12. Instance type

**Description**: GPU distribution by model. The pie chart shows the number of GPUs of each model model.

**Metric**: `count by(modelName) (DCGM_FI_DEV_SM_CLOCK)`.

### **Error** section

This section contains GPU error and issue metrics (collapsed by default).

#### 13. PCIe retry rate

**Description**: Rate of PCIe bus transmission retries. High values may indicate PCIe bus issues or connection instability.

**Metric**: `avg by(Hostname, gpu) (rate(DCGM_FI_DEV_PCIE_REPLAY_COUNTER))`.

**Unit of measurement**: Retries per second.

#### 14. XID error

**Description**: XID errors are critical GPU errors that require attention. Each XID code corresponds to a specific type of hardware error.

**Metric**: `avg by(Hostname, gpu) (DCGM_FI_DEV_XID_ERRORS)`.

**Unit of measurement**: Number of errors.

**Recommendations**: Any XID errors require immediate investigation. They may indicate hardware issues, overheating, or driver problems.

### **Advanced Monitoring (GPU Efficiency & Health)** section

This section covers advanced metrics for GPU performance analysis and detection of issues.

#### 15. GPU Utilization (Activity %)

**Description**: GPU active time percentage. Shows the percentage of time the GPU performs computations. Compare with Tensor Utilization to evaluate ML task performance.

**Metric**: `max by(Hostname, gpu, UUID) (DCGM_FI_DEV_GPU_UTIL)`.

**Unit of measurement**: Percentage (0-100).

**Recommendations**: Low GPU utilization despite active tasks may indicate data transfer bottlenecks or suboptimal code.

#### 16. Memory Copy Utilization (Bandwidth)

**Description**: Memory bandwidth utilization. Shows the intensity of utilizing the GPU memory data transfer channel. High memory copy activity combined with low SM utilization suggests a data transfer bottleneck.

**Metric**: `max by(Hostname, gpu, UUID) (DCGM_FI_DEV_MEM_COPY_UTIL)`.

**Unit of measurement**: Percentage (0-100).

**Recommendations**: High values combined with low compute unit utilization indicate that the GPU is waiting for data.

#### 17. GPU Memory Growth Rate (Leak Detection)

**Description**: GPU memory usage growth rate. Detects memory leaks by monitoring memory consumption growth rate. Positive values with memory usage exceeding 80% indicate a risk of an out-of-memory (OOM) error.

**Metric**: `rate(max by(Hostname, gpu, UUID) (DCGM_FI_DEV_FB_USED)[1h:]) * 3600`.

**Unit of measurement**: Bytes per second.

**Thresholds**:
* Green: Negative or zero growth.
* Yellow: Positive growth.
* Red: Growth exceeding 1 MB/s.

**Recommendations**: GPUs do not feature automatic garbage collection, so allocated memory remains allocated until explicitly freed. Continuous memory usage growth indicates a leak.

#### 18. GPU Memory Usage % (OOM Risk)

**Description**: GPU memory usage percentage. Values above 80% combined with a positive growth rate indicate a risk of an out-of-memory error.

**Metric**: `100 * max by(Hostname, gpu, UUID) (DCGM_FI_DEV_FB_USED) / (max by(Hostname, gpu, UUID) (DCGM_FI_DEV_FB_USED) + max by(Hostname, gpu, UUID) (DCGM_FI_DEV_FB_FREE))`.

**Unit of measurement**: Percentage (0-100)

**Thresholds** (inverted):
* Red: Usage below 70%.
* Orange: Usage from 70% to 80%.
* Yellow: Usage from 80% to 90%.
* Green: Usage above 90%.

#### 19. Thermal Throttling Risk

**Description**: Risk of thermal throttling. GPUs reduce clock frequency when temperature exceeds 80°C. Aggressive throttling begins at 85°C, reducing performance by 30-50%.

**Metric**: `max by(Hostname, gpu, UUID) (DCGM_FI_DEV_GPU_TEMP)`.

**Unit of measurement**: Degrees Celsius.

**Thresholds**:
* Green: Temperature below 70°C.
* Yellow: Temperature from 70°C to 80°C.
* Orange: Temperature from 80°C to 85°C.
* Red: Temperature above 85°C.

**Recommendations**: If the temperature exceeds 80°C, check the cooling system. Temperature above 85°C is critical and leads to significant performance degradation.

#### 20. Temperature Change Rate (°C/min)

**Description**: Temperature change rate over 5 minutes. Positive values indicate rising temperature, which may be due to cooling issues or fan failure. Use together with the _Thermal Throttling Risk_ pannel.

**Metric**: `rate(max by(Hostname, gpu, UUID) (DCGM_FI_DEV_GPU_TEMP)[5m:]) * 60`.

**Unit of measurement**: Degrees Celsius per minute.

**Thresholds**:
* Green: Negative or zero change rate.
* Red: Growth exceeding 0.1°C/min.

#### 21. GPU Efficiency Gap (Engine vs Tensor Activity)

**Description**: Difference between SM core utilization and tensor core utilization. High GPU utilization with low tensor core utilization means the GPU is busy but not performing efficient ML/AI calculations. Target value: Gap under 30%.

**Metric**: `100 * (max by(Hostname, gpu, UUID) (DCGM_FI_PROF_GR_ENGINE_ACTIVE) - max by(Hostname, gpu, UUID) (DCGM_FI_PROF_PIPE_TENSOR_ACTIVE))`.

**Unit of measurement**: Percentage (0-100).

**Thresholds**:
* Green: Gap below 30%.
* Yellow: Gap from 30% to 50%.
* Red: Gap above 50%.

**Recommendations**: A large gap indicates inefficient use of specialized GPU capabilities for ML tasks.

#### 22. Idle/Underutilized GPU cores (<30% Utilization)

**Description**: Table of GPUs with utilization below 30%. These GPUs are allocated but perform no useful work, which is a potential waste of resources.

**Metric**: `max by(Hostname, gpu, UUID, exported_namespace, exported_pod) (DCGM_FI_DEV_GPU_UTIL) < 30`.

**Unit of measurement**: Percentage.

**Thresholds**:
* Red: Utilization below 5%.
* Yellow: Utilization from 5% to 10%.
* Green: Utilization above 10%.

**Recommendations**: Check why the allocated GPUs are not being used. Tasks may have been completed, or there are issues with the application.

#### 23. Idle/Underutilized Memory (<30% Utilization)

**Description**: Table of GPUs with memory utilization below 30%. This memory is allocated but not used, which is a potential waste of resources.

**Metric**: `max by(Hostname, gpu, UUID, exported_namespace, exported_pod) (DCGM_FI_DEV_FB_USED) / (max by(Hostname, gpu, UUID, exported_namespace, exported_pod) (DCGM_FI_DEV_FB_USED) + max by(Hostname, gpu, UUID, exported_namespace, exported_pod) (DCGM_FI_DEV_FB_FREE)) * 100 < 30`.

**Unit of measurement**: Percentage.

**Thresholds**:
* Red: Utilization below 15%.
* Yellow: Utilization from 15% to 30%.
* Green: Utilization above 30%.

#### 24. Processes per GPU (Context Switch Risk)

**Description**: Count of processes per GPU. When more than eight processes share a GPU via time-slicing, context-switching overhead typically exceeds 20%. High values indicate resource contention.

**Metric**: `count by(Hostname, gpu) (DCGM_FI_DEV_GPU_UTIL >= 0)`.

**Unit of measurement**: Number of processes.

**Thresholds**:
* Green: Less than four processes.
* Yellow: From four to six processes.
* Orange: From six to eight processes.
* Red: More than eight processes.

**Recommendations**: With a large count of processes per GPU, consider redistributing the load.

#### 25. GPU Memory Usage by Pod

**Description**: Table of all pods using GPUs with actual GPU memory consumption figures. Displays the namespace, pod name, host, GPU ID, and memory usage. Useful for finding which workloads consume the most GPU memory.

**Metric**: `max by(Hostname, gpu, UUID, exported_namespace, exported_pod, exported_container) (DCGM_FI_DEV_FB_USED)`.

**Unit of measurement**: Megabytes.

**Recommendations**: Use this table to analyze memory distribution across pods and detect pods with abnormally high memory consumption.

## Monitoring best practices

### Critical metrics

The following metrics require immediate attention when they deviate from normal values:

1. **Thermal Throttling Risk**: Temperature must stay below 80°C; exceeding 85°C is critical.
1. **GPU Memory Usage % (OOM Risk)**: Memory usage above 80% with a positive growth rate indicates a risk of an out-of-memory error.
1. **XID error**: Any XID errors require immediate investigation.
1. **Temperature Change Rate**: Rapid temperature increase may indicate cooling issues.

### Performance metrics

To assess GPU utilization efficiency, monitor these metrics:

1. **GPU Utilization (Activity %)**: GPU utilization should be high during computing tasks.
1. **Tensor Utilization**: Should be substantial for ML tasks.
1. **GPU Efficiency Gap**: Difference between SM and tensor core utilization should be under 30%.
1. **Memory Copy Utilization**: High values with low SM utilization suggest a data transfer bottleneck.

### Resource optimization metrics

To identify inefficient use of resources:

1. **Idle/Underutilized GPU cores**: Detects GPUs with utilization below 30%.
1. **Idle/Underutilized Memory**: Detects GPUs with memory utilization below 30%.
1. **Processes per GPU**: High count of processes per GPU reduces efficiency.
1. **GPU Memory Usage by Pod**: Helps identify pods which consume the most resources.

### GPU health metrics

For hardware status monitoring:

1. **GPU Temperature** and **Memory temperature**: The temperature must be within the normal range.
1. **Power Usage**: Power consumption must match the workload.
1. **PCIe retry rate**: High values may indicate PCIe bus issues.
1. **GPU Memory Growth Rate**: Continuous growth indicates a memory leak.

## Extra resources

* [NVIDIA DCGM Documentation](https://docs.nvidia.com/datacenter/dcgm/latest/)
* [DCGM Exporter on GitHub](https://github.com/NVIDIA/dcgm-exporter)
* [NVIDIA GPU Architecture](https://www.nvidia.com/en-us/data-center/resources/)
* [Tensor Cores Documentation](https://www.nvidia.com/en-us/data-center/tensor-cores/)
