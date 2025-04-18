---
title: Testing InfiniBand throughput
description: Follow this guide to run a InfiniBand throughput test on a single machine with NUMA node resource isolation.
---

# Testing InfiniBand throughput

1. [Connect](../../../compute/operations/vm-connect/ssh.md) to the VM over SSH.
1. Install tools for testing:

   ```bash
   sudo apt update
   sudo apt install perftest numactl
   ```

1. Create a file named `/etc/security/limits.d/limits.conf` with the following contents:

   ```text
   * soft memlock unlimited
   * hard memlock unlimited
   ```

1. Log out and log back in or reboot the machine to apply the changes. Check the limit using this command:

   ```text
   ulimit -l
   ```

   The result should be `unlimited`.

1. Create a file named `infiniband_test.sh` with the following contents:

   ```bash
   #!/bin/bash
   set -eu

   # Testing the memlock limit
   echo "Current memlock limit:"
   ulimit -l
   if [[ $(ulimit -l) != "unlimited" ]]; then
      echo "Memlock limit is not unlimited."
      echo "Create a file named /etc/security/limits.d/limits.conf with the following content:"
      echo "* soft memlock unlimited"
      echo "* hard memlock unlimited"
      exit 1
   fi

   # Cleanup funciton: Terminate all ib_write_bw processes upon script completion
   clean() {
      killall -9 ib_write_bw &>/dev/null
   }
   trap clean EXIT

   # Test parameters
   size=33554432  # Block size in bytes
   iters=10000    # Number of iterations
   q=1

   # Specify CPU numbers and network device names for different NUMA nodes
   # Example:
   numa0_cpu=40      # Client CPU (NUMA node 0)
   numa1_cpu=130     # Server CPU (NUMA node 1)
   numa0_net=mlx5_0  # Network interface for the client
   numa1_net=mlx5_7  # Network interface for the server

   # Start the server on NUMA node 1
   numactl -C $numa1_cpu --membind 1 /usr/bin/ib_write_bw --ib-dev=$numa1_net --report_gbits -s $size  --iters $iters -q $q &>/dev/null &
   sleep 1

   # Start the client on NUMA node 0 with high priority
   nice -20 numactl -C $numa0_cpu  --membind 0 /usr/bin/ib_write_bw --ib-dev=$numa0_net --report_gbits -s $size --iters $iters -q $q localhost &
   wait
   ```

1. Make the script executable:

   ```bash
   chmod +x infiniband_test.sh
   ```

1. Run the script:

   ```bash
   ./infiniband_test.sh
   ```

   Result:

   ```text
   ---------------------------------------------------------------------------------------
   #bytes     #iterations    BW peak[Gb/sec]    BW average[Gb/sec]   MsgRate[Mpps]
   33554432    10000            394.58             394.40                    0.001469
   ---------------------------------------------------------------------------------------
   ```