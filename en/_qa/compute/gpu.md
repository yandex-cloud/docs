---
title: FAQ on graphics processing units (GPUs)
description: Answers to frequently asked questions about GPUs in the {{ yandex-cloud }} infrastructure.
keywords:
  - gpu
  - cluster
  - graphics processing units
---

# Graphics processing units (GPUs)

{% include [minitoc](minitoc/gpu.md) %}


#### How do I test a GPU cluster physical state? {#test-physical-state}

* Test the InfiniBand ports.
* Test the network.

For more information, see [{#T}](../../compute/operations/gpu-cluster/gpu-cluster-test-physical-state.md).

#### How do I run parallel tasks in a GPU cluster? {#mpirun-parallel}

To run parallel tasks in a GPU cluster:

1. Connect to each VM over SSH and install [Open MPI](https://www.open-mpi.org/) and [NCCL](https://github.com/NVIDIA/nccl).
1. On the main VM, build NVIDIA tests and set up passwordless SSH keys.
1. Add a public key to `authorized_keys` on each VM.
1. On the main VM, run the `mpirun` command specifying the VM IP addresses and number of GPUs.

For more information, see [{#T}](../../compute/operations/gpu-cluster/gpu-cluster-mpirun-parallel.md).

#### How do I test InfiniBand throughput? {#preinstall-software}

To check InfiniBand throughput, create and run a script for starting `perftest` tests with `numactl`.

For more information, see [{#T}](../../compute/operations/gpu-cluster/test-infiniband-bandwidth.md).


#### What should I do if there is a GPU failure on the VM? {#gpu-not-working}

Try [stopping](../../compute/operations/vm-control/vm-stop-and-start.md#stop) and [restarting](../../compute/operations/vm-control/vm-stop-and-start.md#start) the VM. This is usually more effective than a reboot, since when you reboot a VM, it remains on the same host where the GPU issue occurred.
