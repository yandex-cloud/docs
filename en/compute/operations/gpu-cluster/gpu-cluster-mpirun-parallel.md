---
title: Running parallel tasks in a GPU cluster
description: Follow this guide to use mpirun to run distributed jobs in a GPU cluster.
---

# Running parallel tasks in a GPU cluster


1. [Connect](../../../compute/operations/vm-connect/ssh.md) to each VM in the cluster over SSH.
1. Install [Open MPI](https://www.open-mpi.org/) and [NCCL](https://github.com/NVIDIA/nccl) on each VM:

   ```bash
   sudo apt-get update
   sudo apt-get install openmpi-bin libnccl2 libnccl-dev
   ```

1. On the main VM:
   1. Clone the test repository:
      ```bash
      git clone https://github.com/NVIDIA/nccl-tests
      ```

   1. Build the tests:

      ```bash
      cd nccl-tests
      MPI_HOME=/usr/lib/x86_64-linux-gnu/openmpi MPI=1 make
      ```

   1. Copy the binary `all_reduce_perf` file from the `build` folder to all cluster VMs. The `all_reduce_perf` file must be in the same directory on all VMs as on the main one (e.g., `~/nccl-tests/build/`).

1. On the main VM, create paswordless SSH keys:

   ```bash
   ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519 -N ""
   ```

1. Copy the `id_ed25519` and `id_ed25519.pub` files to all VMs.
1. Add a public key to `authorized_keys` on each VM:

   ```bash
   cat ~/.ssh/id_ed25519.pub >> ~/.ssh/authorized_keys
   ```

1. Run this command on the main VM:

   ```bash
   mpirun --host <IP_1>:8,<IP_2>:8 \
       --allow-run-as-root -np 16 \
       -mca btl_tcp_if_include eth0 \
       ~/nccl-tests/build/all_reduce_perf -b 512M -e 8G -f 2 -g 1
   ```

   Where:

   * `IP_1:8` and `IP_2:8`: VM IP addresses and number of GPUs
   * `np`: Total number of processes, (number_of_VMs) × (GPUs_per_VM)

   Result:

   ```text
   #                                                              out-of-place                       in-place
   #       size         count      type   redop    root     time   algbw   busbw #wrong     time   algbw   busbw #wrong
   #        (B)    (elements)                               (us)  (GB/s)  (GB/s)            (us)  (GB/s)  (GB/s)
      536870912     134217728     float     sum      -1   8476.3   63.34  118.76      0   8573.0   62.62  117.42      0
   1073741824     268435456     float     sum      -1    16512   65.03  121.92      0    16493   65.10  122.07      0
   2147483648     536870912     float     sum      -1    32742   65.59  122.98      0    32757   65.56  122.92      0
   4294967296    1073741824     float     sum      -1    65409   65.66  123.12      0    65376   65.70  123.18      0
   8589934592    2147483648     float     sum      -1   132702   64.73  121.37      0   133186   64.50  120.93      0
   # Out of bounds values : 0 OK
   # Avg bus bandwidth    : 121.467
   ```