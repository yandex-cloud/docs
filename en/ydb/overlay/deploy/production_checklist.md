# Preparation

This page provides recommendations for deploying a {{ ydb-short-name }} cluster.

## Topology

To store data securely and in a fault-tolerant manner, {{ ydb-short-name }} redundantly writes data to multiple block store volumes using a topology to survive a loss of two nodes or a loss of an availability zone and a node, depending on the data storage mode adopted.

{{ ydb-short-name }} supports the following data storage modes:

* **block-4-2**: Works in 1 availability zone. The data is split into 4 fragments and 2 redundancy fragments are added. Fragments are written to different disks (hosted on different nodes). However, recovery is possible when no more than 2 fragments are lost at the same time. For data to be written successfully, you need to write all 6 fragments. That's why, to ensure successful writing on failure of 2 disks, you need 2 additional disks, meaning you need 8 nodes in total.

* **mirror-3-dc**: Works in 3 availability zones. Data can be stored either as 3 replicas, with one replica in each availability zone, or as 4 replicas, with two replicas in two availability zones. Replicas in each availability zone are written to different disks (hosted on different nodes). In this mode, uptime is preserved when 1 availability zone and 1 node in one of the remaining availability zones are lost. For healthy operation, you need 9 nodes: 3 in each availability zone.

Node loss here means both complete and partial unavailability, for example, the loss of one disk on a node.

## Software

For proper {{ ydb-short-name }} operation, we recommend that you use [Ubuntu](https://ubuntu.com/) version 16.04 or higher.

## Block store volumes

The minimum disk size must be at least 80 GB, otherwise the node won't be able to use the block store volume. Correct and uninterrupted operation with minimum-size disks is not guaranteed. We recommend using such disks exclusively for testing purposes.

For proper {{ ydb-short-name }} operation, we recommend production-grade block store volumes larger than 800 GB.

{{ ydb-short-name }} doesn't use a file system to store data and accesses store volumes directly. Don't mount a file system or perform other operations with a partition that uses {{ ydb-short-name }}.

We also won't recommend sharing a block store volume with other processes. This may drastically degrade performance.

## RAM

{{ ydb-short-name }} provides no protection against memory errors, so we recommend using ECC memory.

## Introspection tools

To ensure smooth {{ ydb-short-name }} operation, make sure to replace faulty disks and nodes on time. You can monitor your cluster status using the [introspection tools](../monitoring/overview.md).
