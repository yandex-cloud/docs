---
title: Testing a GPU cluster physical state
description: Follow this guide to test InfiniBand connections between cluster GPUs.
---

# Testing a GPU cluster physical state


## Test the state of InfiniBand ports {#check-state}

1. [Connect](../../../compute/operations/vm-connect/ssh.md) to the VM over SSH.
1. Install the `infiniband-diags` package:

   ```bash
   sudo apt update
   sudo apt install infiniband-diags
   ```

1. Run the `ibstatus` command:

   Result:

   ```text
   state:           4: ACTIVE
   phys state:      5: LinkUp
   ```

1. Make sure the `phys state` parameter is set to `LinkUp` for all ports.

## Test network performance

To test the data transfer rate between GPUs on different VMs:

1. Install the `perftest` package on each test VM:

   ```bash
   sudo apt install perftest
   ```

1. Connect to the first VM over SSH.
1. Run this command:

   ```bash
   ib_send_bw --report_gbits
   ```

1. Connect to the second VM over SSH.
1. Run this command:

   ```bash
   ib_send_bw <first_VM_internal_IP> --report_gbits
   ```

   Result:
   
   ```text
   #bytes     #iterations    BW peak[Gb/sec]    BW average[Gb/sec]   MsgRate[Mpps]
   65536      1000             245.54             244.08             0.465536
   ```

1. Make sure the output shows non-zero values for these parameters:
   * `BW average[Gb/sec]`: Average transfer rate
   * `MsgRate[Mpps]`: Message frequency