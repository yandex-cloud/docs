# NVIDIA DCGM dashboard metrics

{{ grafana-name }}'s NVIDIA DCGM dashboard enables comprehensive monitoring of NVIDIA GPUs in a {{ stackland-name }} cluster. The dashboard presents the metrics of temperature, power consumption, GPU utilization, memory usage, and other critical GPU performance parameters.

To open a dashboard:

1. Open {{ grafana-name }}.
1. Select **NVIDIA DCGM official** in the dashboard list.

The GPU monitoring dashboard will open.

## General info

**Dashboard title**: NVIDIA DCGM official.
**UID**: `gpu-official`.
**Refresh interval**: 30 seconds.
**Data source**: {{ prometheus-name }}.

## Dashboard variables

The dashboard uses the following variables for data filtering:

* **DS_PROMETHEUS**: {{ prometheus-name }} data source.
* **instance**: Selects a specific DCGM Exporter instance (multi-select supported).
* **gpu**: Selects a specific GPU ID or all GPUs (multi-select supported, all GPUs selected by default).

## Panels and metrics

### 1. GPU Temperature

**Description**: Temperature of each GPU in degrees Celsius. The chart displays temperature for each GPU, calculating the average, last, and maximum values.

**Metric**: `DCGM_FI_DEV_GPU_TEMP`.

**Unit of measurement**: Degrees Celsius.

**Thresholds**:
* Green: Normal temperature.
* Red: Temperature above 80°C.

### 2. GPU Avg. Temp

**Description**: Average temperature of all GPUs. A gauge panel displays the current average temperature value with color indication.

**Metric**: `avg(DCGM_FI_DEV_GPU_TEMP)`.

**Unit of measurement**: Degrees Celsius.

**Thresholds**:
* Green: Temperature below 83°C.
* Yellow: Temperature from 83°C to 87°C.
* Red: Temperature above 87°C.

**Recommendations**: If the temperature exceeds 83°C, check the cooling system and GPU load. Temperatures above 87°C may lead to throttling and reduced performance.

### 3. GPU Power Usage

**Description**: Power consumption of each GPU in watts. The chart shows current power draw per GPU, calculating the average, last, and maximum values.

**Metric**: `DCGM_FI_DEV_POWER_USAGE`.

**Unit of measurement**: Watts.

### 4. GPU Power Total

**Description**: Total power consumption of all GPUs. A gauge panel displays the total power consumption of all GPUs.

**Metric**: `sum(DCGM_FI_DEV_POWER_USAGE)`.

**Unit of measurement**: Watts.

**Thresholds**:
* Green: Below 1,800 W.
* Yellow: From 1800 W to 2200 W.
* Red: Above 2200 W.

**Recommendations**: Monitor the total power consumption not to exceed the power supply unit's limits or the capacity allocated for the rack.

### 5. GPU SM Clocks

**Description**: Clock frequency of the GPU streaming multiprocessors (SMs), in Hz. The metric is multiplied by 1,000,000 to convert MHz to Hz.

**Metric**: `DCGM_FI_DEV_SM_CLOCK * 1000000`.

**Unit of measurement**: Hertz.

**Description**: An SM (streaming multiprocessor) is the NVIDIA GPU architecture's primary compute unit responsible for parallel computing. SM frequency determines the speed of computing operations.

### 6. GPU Utilization

**Description**: GPU utilization percentage. Shows the currently used portion of the the GPU's computing resources.

**Metric**: `DCGM_FI_DEV_GPU_UTIL`.

**Unit of measurement**: Percentage (0-100).

**Recommendations**: Low GPU utilization despite active tasks may indicate data transfer bottlenecks or suboptimal code. High utilization (close to 100%) is normal for computing tasks.

### 7. GPU Framebuffer Mem Used

**Description**: The amount of framebuffer memory used per GPU. Framebuffer is the GPU memory area used to store data, textures, and intermediate computation results.

**Metric**: `DCGM_FI_DEV_FB_USED`.

**Unit of measurement**: Megabytes.

**Recommendations**: Monitor the GPU memory usage. Exceeding the available memory will cause task execution errors or reduced performance due to swapping.

### 8. Tensor Core Utilization

**Description**: GPU tensor core utilization Tensor cores are specialized compute units for matrix operations, commonly used in machine learning and AI tasks.

**Metric**: `DCGM_FI_PROF_PIPE_TENSOR_ACTIVE`.

**Unit of measurement**: Fraction from 0 to 1 (0% to 100%).

**Description**: High tensor core utilization is typical for deep learning tasks that employ matrix operations (e.g., neural network training). Low utilization during ML tasks may indicate suboptimal GPU usage.

## Monitoring best practices

### Critical metrics

The following metrics require immediate attention when they deviate from normal values:

1. **GPU Avg. Temp** must be less than 83°C; exceeding 87°C is critical.
1. **GPU Power Total**: Monitor total energy consumption, make sure it does not exceed 2200 W.
1. **GPU Framebuffer Mem Used**: Keep track of how much memory is used to avoid out-of-memory errors.

### Performance metrics

To evaluate GPU utilization efficiency, pay attention to:

1. **GPU Utilization**: Should be high during computing tasks.
1. **Tensor Core Utilization**: Should be substantial for ML tasks.
1. **GPU SM Clocks**: SM clock frequency must be aligned with the GPU specifications.

### Temperature metrics and power consumption metrics

For thermal and power monitoring:

1. **GPU Temperature**: The temperature of each GPU must be within the normal range.
1. **GPU Power Usage**: Power consumption must correspond to workload.
1. **GPU Avg. Temp**: Average temperature must not exceed the safe thresholds.

### Memory metrics

For video memory usage monitoring:

1. **GPU Framebuffer Mem Used**: Monitor memory used by each GPU.
1. Compare the used memory against the total available GPU memory.

## Extra resources

* [NVIDIA DCGM Documentation](https://docs.nvidia.com/datacenter/dcgm/latest/)
* [DCGM Exporter on GitHub](https://github.com/NVIDIA/dcgm-exporter)
* [NVIDIA GPU Architecture](https://www.nvidia.com/en-us/data-center/resources/)
* [Tensor Cores Documentation](https://www.nvidia.com/en-us/data-center/tensor-cores/)
