# Monitoring resource consumption

#### Why does the vCPU on the graph show more than 100%? {#why-cpu-more-100}

If you use cores with guaranteed, say, 5% vCPU performance, then this 5% represents 100% of the expected load for the monitoring system. If there are no "neighbors" on the physical core, you can be allocated up to 100% of vCPU performance, which is 20 times higher than the maximum expected load (×20 of 5%). Thus, the graph can show up to 2000%.

If you see the upper limit of 100% exceeded for quite a while in the graphs, we recommend increasing the guaranteed vCPU performance because "neighbors" may appear on the physical core at any time and your real utilization of physical core resources will drop to the guaranteed 5% (about 100 MHz). In this case, the guest system may not cope with the load and you'll lose access to the VM.

#### How do I track vRAM use using monitoring? {#track-vRAM-use}

The {{ compute-name }} service can't measure vRAM consumption inside the guest operating system because for the service, memory consumption by the virtual machine is always the same: the one that is allocated the moment it is started.

To track the vRAM state, use the {{ monitoring-full-name }} service. It allows you to record your own metrics. See [{#T}](../../monitoring/operations/metric/add.md). Just schedule a task to download data about the vRAM state and {{ monitoring-name }} will display them.