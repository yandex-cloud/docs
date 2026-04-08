# NVIDIA DCGM Dashboard with MIG metrics

{{ grafana-name }}'s NVIDIA DCGM dashboard with MIG support enables comprehensive monitoring of NVIDIA GPUs in a {{ k8s }} cluster. The dashboard supports both standard GPUs and GPUs using multi-instance GPU (MIG) technology, delivering metrics on temperature, power consumption, GPU utilization, memory usage, and other critical GPU operational parameters.

To open a dashboard:

1. Open {{ grafana-name }}.
1. In the dashboard list, select **NVIDIA DCGM Dashboard with MIG metrics**.

The GPU monitoring dashboard with MIG support will open.

## General info

**Dashboard title**: NVIDIA DCGM Dashboard with MIG metrics.
**UID**: `gpu-with-mig`.
**Refresh interval**: 30 seconds.
**Data source**: {{ prometheus-name }}.

## Dashboard variables

The dashboard uses the following variables for data filtering:

* **DS_PROMETHEUS**: {{ prometheus-name }} data source.
* **Hostname**: Selects a specific host or all hosts (multi-select supported).
* **gpu**: Selects a specific GPU ID or all GPUs (multi-select supported).
* **mig**: Selects a specific MIG profile or all profiles (multi-select supported).

## Panels and metrics

The dashboard is divided into several sections for convenient monitoring of different GPU operational aspects.

### **Aggregate** section

Aggregated metrics across all selected GPUs and MIG instances.

#### 1. GPU Engine Utilization

**Description**: Average GPU SM core utilization percentage. Indicates how actively the GPU's computing resources are being used.

**Metric**: `100 * avg(DCGM_FI_PROF_GR_ENGINE_ACTIVE)`.

**Unit of measurement**: Percentage (0-100).

**Thresholds**:
* Green: Utilization below 60%.
* Yellow: Utilization from 60% to 80%.
* Orange: Utilization from 80% to 90%.
* Red: Utilization above 90%.

#### 2. Tensor Utilization

**Description**: Average tensor core utilization. Tensor cores are specialized compute units for matrix operations, commonly used in machine learning tasks.

**Metric**: `100 * avg(DCGM_FI_PROF_PIPE_TENSOR_ACTIVE)`.

**Unit of measurement**: Percentage (0-100).

**Thresholds**:
* Green: Utilization below 60%.
* Yellow: Utilization from 60% to 80%.
* Orange: Utilization from 80% to 90%.
* Red: Utilization above 90%.

**Recommendations**: High tensor core utilization is typical for deep learning tasks. Low utilization during ML workloads may indicate suboptimal GPU usage.

#### 3. GPU Memory Utilization

**Description**: Average GPU memory (DRAM) utilization. Reflects how intensively GPU memory is being accessed.

**Metric**: `100 * avg(DCGM_FI_PROF_DRAM_ACTIVE)`.

**Unit of measurement**: Percentage (0-100).

**Thresholds**:
* Green: Utilization below 60%.
* Yellow: Utilization from 60% to 80%.
* Orange: Utilization from 80% to 90%.
* Red: Utilization above 90%.

#### 4. GPU Memory Usage

**Description**: Total amount of video memory used by all GPUs. Displayed as a gauge with a maximum value equal to the sum of used and free memory.

**Metric**: `sum(DCGM_FI_DEV_FB_USED)`.

**Unit of measurement**: Megabytes.

**Thresholds**:
* Green: Usage below 60%.
* Yellow: Usage from 60% to 80%.
* Orange: Usage from 80% to 90%.
* Red: Usage above 90%.

**Recommendations**: Monitor the GPU memory usage. Exceeding the available memory will cause task execution errors.

### **per GPU** section

Metrics for each individual GPU.

#### 5. GPU temperature

**Description**: Temperature of each GPU in degrees Celsius. The chart displays temperature individually for each GPU.

**Metric**: `avg by(Hostname, gpu) (DCGM_FI_DEV_GPU_TEMP)`.

**Unit of measurement**: Degrees Celsius.

**Thresholds**:
* Green: Normal temperature.
* Red: Temperature above 80°C.

**Recommendations**: If the temperature exceeds 80°C, check the cooling system and GPU load.

#### 6. Power Usage

**Description**: Power consumption of each GPU in watts. The chart shows current power draw per GPU.

**Metric**: `avg by(Hostname, gpu) (DCGM_FI_DEV_POWER_USAGE)`.

**Unit of measurement**: Watts.

#### 7. GPU Energy Draw Total

**Description**: Total energy consumed by all GPUs over the last hour and last 24 hours.

**Metrics**:
* `sum(increase(DCGM_FI_DEV_TOTAL_ENERGY_CONSUMPTION[1h]) / 3600000)`: Over the last hour.
* `sum(increase(DCGM_FI_DEV_TOTAL_ENERGY_CONSUMPTION[24h]) / 3600000)`: Over the last 24 hours.

**Unit of measurement**: Watt-hours.

**Thresholds for the last-hour metric**:
* Green: Below 5,000 Wh.
* Yellow: From 5,000 to 10,000 Wh.
* Red: Above 10,000 Wh.

**Thresholds for the last-24-hours metric**:
* Green: Below 120,000 Wh.
* Yellow: From 120,000 to 150,000 Wh.
* Red: Above 150,000 Wh.

#### 8. SM clock

**Description**: Clock frequency of GPU streaming multiprocessors (SMs).

**Metric**: `avg by(modelName) (DCGM_FI_DEV_SM_CLOCK)`.

**Unit of measurement**: MHz.

**Thresholds**:
* Green: Normal frequency.
* Yellow: Frequency above 1,500 MHz.
* Red: Frequency above 2,000 MHz.

**Description**: An SM (streaming multiprocessor) is the NVIDIA GPU architecture's primary compute unit responsible for parallel computing.

#### 9. Memory clock

**Description**: GPU memory clock frequency.

**Metric**: `avg by(modelName) (DCGM_FI_DEV_MEM_CLOCK)`.

**Unit of measurement**: MHz.

**Thresholds**:
* Green: Normal frequency.
* Yellow: Frequency above 1,500 MHz.
* Red: Frequency above 2,000 MHz.

#### 10. Memory temperature

**Description**: Memory temperature of each GPU in degrees Celsius.

**Metric**: `avg by(Hostname, gpu) (DCGM_FI_DEV_MEMORY_TEMP)`.

**Unit of measurement**: Degrees Celsius.

**Thresholds**:
* Green: Normal temperature.
* Red: Temperature above 80°C.

#### 11. NVLink bandwidth

**Description**: Bandwidth of NVLink, the high-speed interconnect between GPUs.

**Metric**: `avg by(Hostname, gpu) (rate(DCGM_FI_DEV_NVLINK_BANDWIDTH_TOTAL))`.

**Unit of measurement**: Bytes per second.

**Description**: NVLink enables high-speed data transfer between GPUs, which is critical for distributed computing.

#### 12. Instance type

**Description**: Pie chart showing the distribution of GPU types in the cluster.

**Metric**: `count by(modelName) (DCGM_FI_DEV_SM_CLOCK)`.

**Description**: Allows a quick look at the GPU resources in the cluster.

### **per MIG profile** section

Metrics for each individual MIG instance. With MIG (Multi-Instance GPU), you can divide a single physical GPU into multiple isolated instances.

#### 13. Memory Usage (chart)

**Description**: Memory usage per MIG instance visualized as a time series.

**Metric**: `avg by(GPU_I_ID, Hostname, gpu, GPU_I_PROFILE) (DCGM_FI_DEV_FB_USED)`.

**Unit of measurement**: Megabytes.

**Legend format**: `Node:not_var{{Hostname}} GPU:not_var{{gpu}} MIG:not_var{{GPU_I_PROFILE}} ID:not_var{{GPU_I_ID}}`.

#### 14. Memory Usage (bar gauge)

**Description**: Memory usage per MIG instance visualized as horizontal bars with color-coded indicators.

**Metric**: `avg by(GPU_I_ID, Hostname, gpu, GPU_I_PROFILE) (DCGM_FI_DEV_FB_USED)`.

**Unit of measurement**: Megabytes.

**Specifics**:
* For profiles with 20 GB of memory, the maximum is set at 20,480 MB.
* For profiles with 10 GB of memory, the maximum is set at 10,240 MB.

#### 15. GPU Utilization

**Description**: SM core utilization for each MIG instance.

**Metric**: `avg by(GPU_I_ID, Hostname, gpu, GPU_I_PROFILE) (DCGM_FI_PROF_GR_ENGINE_ACTIVE)`.

**Unit of measurement**: Fraction from 0 to 1 (0% to 100%).

**Legend format**: `Node:not_var{{Hostname}} GPU:not_var{{gpu}} MIG:not_var{{GPU_I_PROFILE}} ID:not_var{{GPU_I_ID}}`.

#### 16. Tensor Utilization

**Description**: Tensor core utilization for each MIG instance.

**Metric**: `avg by(GPU_I_ID, Hostname, gpu, GPU_I_PROFILE) (DCGM_FI_PROF_PIPE_TENSOR_ACTIVE)`

**Unit of measurement**: Fraction from 0 to 1 (0% to 100%).

**Legend format**: `Node:not_var{{Hostname}} GPU:not_var{{gpu}} MIG:not_var{{GPU_I_PROFILE}} ID:not_var{{GPU_I_ID}}`.

#### 17. Memory Utilization

**Description**: Memory utilization for each MIG instance.

**Metric**: `avg by(GPU_I_ID, Hostname, gpu, GPU_I_PROFILE) (DCGM_FI_PROF_DRAM_ACTIVE)`.

**Unit of measurement**: Fraction from 0 to 1 (0% to 100%).

**Legend format**: `Node:not_var{{Hostname}} GPU:not_var{{gpu}} MIG:not_var{{GPU_I_PROFILE}} ID:not_var{{GPU_I_ID}}`.

#### 18. Allocation Table

**Description**: Table allocating MIG instances to Kubernetes pods.

**Metric**: `count by(Hostname, gpu, GPU_I_PROFILE, GPU_I_ID, exported_namespace, exported_pod) (DCGM_FI_DEV_SM_CLOCK)`.

**Table columns**:
* **Hostname**: Host name.
* **GPU ID**: Physical GPU ID.
* **MIG Profile**: MIG instance profile.
* **MIG ID**: MIG instance ID.
* **namespace**: Kubernetes namespace.
* **pod**: Pod name.

**Description**: Allows you to follow which MIG instances are used by which pods.

### **Error** section

GPU error and issue metrics (section collapsed by default).

#### 19. PCIe retry rate

**Description**: Rate of PCIe bus transmission retries. High values may indicate PCIe bus issues.

**Metric**: `avg by(Hostname, gpu) (rate(DCGM_FI_DEV_PCIE_REPLAY_COUNTER))`.

**Unit of measurement**: Retries per second.

**Recommendations**: A significant increase of this metric may signal GPU connectivity or PCIe bus problems.

#### 20. XID error

**Description**: NVIDIA driver XID error codes. XID errors indicate various GPU-related issues.

**Metric**: `avg by(Hostname, gpu) (DCGM_FI_DEV_XID_ERRORS)`

**Unit of measurement**: Error code.

**Recommendations**: Any non-zero values require attention. Refer to NVIDIA documentation for XID code interpretation.

### **Advanced Monitoring (GPU Efficiency & Health)** section

Advanced metrics for GPU performance and health analysis.

#### 21. GPU Utilization (Activity %)

**Description**: Percentage of time the GPU was active. Compare with Tensor Utilization to evaluate ML task performance.

**Metric**: `max by(Hostname, gpu, UUID) (DCGM_FI_DEV_GPU_UTIL)`.

**Unit of measurement**: Percentage (0-100).

**Recommendations**: Low GPU utilization despite active tasks may indicate data transfer bottlenecks or suboptimal code.

#### 22. Memory Copy Utilization (Bandwidth)

**Description**: Memory bandwidth utilization. High memory copy activity combined with low SM utilization suggests a data transfer bottleneck.

**Metric**: `max by(Hostname, gpu, UUID) (DCGM_FI_DEV_MEM_COPY_UTIL)`.

**Unit of measurement**: Percentage (0-100).

**Recommendations**: If this metric is high while SM utilization is low, the bottleneck likely lies in data transfer between CPU and GPU.

#### 23. GPU Memory Growth Rate (Leak Detection)

**Description**: Rate of GPU memory usage growth. Positive values indicate continuous memory growth, which may signal a memory leak.

**Metric**: `rate(max by(Hostname, gpu, UUID) (DCGM_FI_DEV_FB_USED)[1h:]) * 3600`.

**Unit of measurement**: Bytes per second.

**Thresholds**:
* Green: No growth or negative growth.
* Yellow: Positive growth.
* Red: Growth exceeding 1 MB/s.

**Recommendations**: Continuous memory growth when more than 80% of available memory is in use indicates a risk of an out-of-memory error.

#### 24. GPU Memory Usage % (OOM Risk)

**Description**: Percentage of GPU memory usage. Values above 80% combined with a positive growth rate indicate a risk of an out-of-memory error.

**Metric**: `100 * max by(Hostname, gpu, UUID) (DCGM_FI_DEV_FB_USED) / (max by(Hostname, gpu, UUID) (DCGM_FI_DEV_FB_USED) + max by(Hostname, gpu, UUID) (DCGM_FI_DEV_FB_FREE))`.

**Unit of measurement**: Percentage (0-100).

**Thresholds** (inverted):
* Red: Usage below 70%.
* Orange: Usage from 70% to 80%.
* Yellow: Usage from 80% to 90%.
* Green: Usage above 90%.

**Recommendations**: GPUs do not feature garbage collection, so allocated memory remains allocated until explicitly freed.

#### 25. Thermal Throttling Risk

**Description**: Risk of thermal throttling. GPUs reduce clock frequency if temperature exceeds 80°C. Aggressive throttling begins at 85°C, reducing performance by 30-50%.

**Metric**: `max by(Hostname, gpu, UUID) (DCGM_FI_DEV_GPU_TEMP)`.

**Unit of measurement**: Degrees Celsius.

**Thresholds**:
* Green: Temperature below 70°C.
* Yellow: Temperature from 70°C to 80°C.
* Orange: Temperature from 80°C to 85°C.
* Red: Temperature above 85°C.

**Recommendations**: GPU performance drops significantly at temperatures above 85°C.

#### 26. Temperature Change Rate (°C/min)

**Description**: Temperature change rate over 5 minutes. Positive values indicate rising temperature, which may be due to cooling issues or fan failure.

**Metric**: `rate(max by(Hostname, gpu, UUID) (DCGM_FI_DEV_GPU_TEMP)[5m:]) * 60`.

**Unit of measurement**: Degrees Celsius per minute.

**Thresholds**:
* Green: Change below 0.1°C/min.
* Red: Change above 0.1°C/min.

**Recommendations**: Use together with the _Thermal Throttling Risk_ metric to diagnose cooling problems.

#### 27. GPU Efficiency Gap (Engine vs Tensor Activity)

**Description**: Difference between SM core utilization and tensor core utilization. High GPU utilization with low tensor core activity means the GPU is busy but ML/AI tasks are running inefficiently.

**Metric**: `100 * (max by(Hostname, gpu, UUID) (DCGM_FI_PROF_GR_ENGINE_ACTIVE) - max by(Hostname, gpu, UUID) (DCGM_FI_PROF_PIPE_TENSOR_ACTIVE))`.

**Unit of measurement**: Percentage (0-100).

**Thresholds**:
* Green: Gap below 30%.
* Yellow: Gap from 30% to 50%.
* Red: Gap above 50%.

**Recommendations**: Target value: Gap under 30%. A large gap indicates inefficient use of GPU for ML tasks.

#### 28. Idle/Underutilized GPU cores (<30% Utilization)

**Description**: Table of GPUs with utilization below 30%. These GPUs are allocated but perform no useful work, which is a potential waste of resources.

**Metric**: `max by(Hostname, gpu, UUID, exported_namespace, exported_pod) (DCGM_FI_DEV_GPU_UTIL) < 30`.

**Table columns**:
* **Hostname**: Host name.
* **gpu**: GPU ID.
* **UUID**: Unique GPU ID.
* **Namespace**: Kubernetes namespace.
* **Pod**: Pod name.
* **GPU Util %**: GPU utilization percentage.

**Cell thresholds**:
* Red: Utilization below 5%.
* Yellow: Utilization from 5% to 10%.
* Green: Utilization above 10%.

#### 29. Idle/Underutilized Memory (<30% Utilization)

**Description**: Table of GPUs with memory utilization below 30%. This memory is allocated but performs no useful work, which is a potential waste of resources.

**Metric**: `max by(Hostname, gpu, UUID, exported_namespace, exported_pod) (DCGM_FI_DEV_FB_USED) / (max by(Hostname, gpu, UUID, exported_namespace, exported_pod) (DCGM_FI_DEV_FB_USED) + max by(Hostname, gpu, UUID, exported_namespace, exported_pod) (DCGM_FI_DEV_FB_FREE)) * 100 < 30`.

**Table columns**:
* **Hostname**: Host name.
* **gpu**: GPU ID.
* **UUID**: Unique GPU ID.
* **Namespace**: Kubernetes namespace.
* **Pod**: Pod name.
* **Memory Util %**: Memory utilization percentage.

**Cell thresholds**:
* Red: Utilization below 15%.
* Yellow: Utilization from 15% to 30%.
* Green: Utilization above 30%.

#### 30. Processes per GPU (Context Switch Risk)

**Description**: Count of processes per GPU. When more than eight processes share a single GPU via time-slicing, context-switching overhead typically exceeds 20%.

**Metric**: `count by(Hostname, gpu) (DCGM_FI_DEV_GPU_UTIL{exported_pod!=""} >= 0)`.

**Unit of measurement**: Number of processes.

**Thresholds**:
* Green: Less than four processes.
* Yellow: From four to six processes.
* Orange: From six to eight processes.
* Red: More than eight processes.

**Recommendations**: A high process count indicates GPU resource contention.

#### 31. GPU Memory Usage by Pod

**Description**: Table of all pods using GPUs with their actual GPU memory consumption figures.

**Metric**: `max by(Hostname, gpu, UUID, exported_namespace, exported_pod, exported_container) (DCGM_FI_DEV_FB_USED{exported_pod!=""})`.

**Table columns**:
* **Hostname**: Host name.
* **gpu**: GPU ID.
* **Namespace**: Kubernetes namespace.
* **Pod**: Pod name.
* **Container**: Container name.
* **GPU Memory Used**: Used GPU memory in MB.

**Description**: Useful for identifying which workloads consume the most GPU memory.

## Monitoring best practices

### Critical metrics

The following metrics require immediate attention when they deviate from normal values:

1. **Thermal Throttling Risk**: Temperature must stay below 80°C; exceeding 85°C is critical.
1. **GPU Memory Usage % (OOM Risk)**: Memory usage above 80% with a positive growth rate indicates a risk of an out-of-memory error.
1. **XID error**: Any non-zero values require attention.

### Performance metrics

To assess GPU utilization efficiency, monitor these metrics:

1. **GPU Utilization (Activity %)**: GPU utilization should be high during computing tasks.
1. **Tensor Utilization**: Should be substantial for ML tasks.
1. **GPU Efficiency Gap**: Difference between SM and tensor core utilization should be under 30%.
1. **Memory Copy Utilization**: High values with low SM utilization suggest a data transfer bottleneck.

### Temperature metrics and power consumption metrics

For thermal and power monitoring:

1. **GPU temperature**: The temperature of each GPU must be within the normal range.
1. **Temperature Change Rate**: Positive values indicate cooling issues.
1. **Power Usage**: Power consumption must match the workload.
1. **GPU Energy Draw Total**: Monitor total energy consumption.

### Memory metrics

To monitor video memory usage:

1. **GPU Memory Usage**: Monitor your memory usage.
1. **GPU Memory Growth Rate**: Continuous growth indicates a potential memory leak.
1. **Memory Usage (per MIG profile)**: Keep track of how much memory is used by each MIG instance.

### Resource efficiency metrics

To optimize GPU resource efficiency:

1. **Idle/Underutilized GPU cores**: Identify unused GPUs.
1. **Idle/Underutilized Memory**: Detect inefficient use of memory.
1. **Processes per GPU**: Keep track of the number of processes per GPU.
1. **GPU Memory Usage by Pod**: Identify pods which consume the most resources.

### MIG metrics

For MIG instance monitoring:

1. **Allocation Table**: Monitor MIG instance allocation to pods.
1. **Memory Usage (per MIG profile)**: Keep track of how much memory is used by each instance.
1. **GPU Utilization (per MIG profile)**: Monitor utilization per MIG instance.
1. **Tensor Utilization (per MIG profile)**: For ML tasks on MIG instances.

## Extra resources

* [NVIDIA DCGM Documentation](https://docs.nvidia.com/datacenter/dcgm/latest/)
* [DCGM Exporter on GitHub](https://github.com/NVIDIA/dcgm-exporter)
* [NVIDIA MIG User Guide](https://docs.nvidia.com/datacenter/tesla/mig-user-guide/)
* [NVIDIA GPU Architecture](https://www.nvidia.com/en-us/data-center/resources/)
* [Tensor Cores Documentation](https://www.nvidia.com/en-us/data-center/tensor-cores/)
