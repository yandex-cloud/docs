<!-- Looks like that information here has already been adopted in /maintenance/embedded_monitoring/ydb_monitoring.md -->

# Viewer

## Nodes page

```
http://<endpoint>:8765/viewer/v2/nodes
```

![feature/YCDOCS-3515-ydb-maintanence](../../../_assets/ydb/viewer_node.png)

This is the home page of the viewer where you can see each node's health.

The viewer tabs are located at the very top and you can use them to switch to other pages.

Below them, you'll see the Nodes page and the following elements:

1. List of node grouping options:

    * **DC**/**Domain**/**Rack**/**Host**: By location
    * **Role**: By node role (storage, tenant)
    * **Tenant**: By the tenants the nodes are linked to
    * **Status**: By node status (Good, Bad)
    * **Uptime**: By node uptime
    * **Version**: By version
    * **Usage**: By the amount of used space on the fullest block store volume per node

1. Node groups grouped by the attribute selected above

Each node is a string with information presented in the following order:

1. Node ID
1. Node host
    * Hostname
    * The CPU utilization indicator is under the node name
1. Node uptime
1. CPU utilization by different tasks on the node
1. RAM utilization by the node
1. VDisks and block store volumes
   * At the bottom, you can see block store volumes with an indicator of the space used
   * At the top, you can see vdisks that use the block store volume below them
1. Tablets running on this node to enable the database

When you hover over a vdisk, a pop-up window with basic information shows up:

![Alt text](../../../_assets/ydb/viewer_node_vdisk.png)

1. **VDisk** is a unique identifier consisting of several values separated by dashes

    * Group ID
    * Group generation
    * FailRealm
    * FailDomain
    * Slot number on the block store volume

1. **State**: The state of the vdisk

1. **Storage pool**: The data storage pool

1. **Allocated**: The space used by the vdisk

1. **Read**: The vdisk's data read rate

1. **Write**: The vdisk's data write rate

If no space has been used on the vdisk or no read or write queries have been sent to it, then the last 3 items might be omitted.

When hovering over a block store volume, basic information also appears:

![Alt text](../../../_assets/ydb/viewer_node_pdisk.png)

1. **PDisk** is a unique identifier consisting of several pairs of values separated by dashes

    * Node ID
    * Block store volume ID

1. **State**: The state of the block store volume

1. **Path**: The path to the store volume's part label

1. **Available**: The memory available on the store volume

By clicking on a vdisk or a block store volume, you can go to the details pages.

## Storages page

```
http://<endpoint>:8765/viewer/v2/storage
```

![Alt text](../../../_assets/ydb/viewer_storage.png)

This page shows the health of storage groups.

Below the viewer tabs, the page has the following structure:

1. Page header

    * Statistics summary by group
        * **Pools**: The number of data storage pools
        * **Groups**: The total number of data storage groups in all pools
        * **VDisks**: The number of vdisks in all groups
        * **PDisks**: The number of block store volumes used by vdisks
        * **Total**: The total space on all block store volumes
        * **Used**: The used space on all block store volumes

    * Field for entering a group filtering expression

    * List of grouping options for storage groups
        * **Pool**: By data storage pool
        * **Color**: By color showing the storage group health
        * **Status**: By health status (Good, Bad)
        * **Usage**: By the amount of used space on the fullest block store volume per group
        * **Missing**: By the number of missing or replicating vdisks

1. Grouped storage groups

Each storage group is a string:

1. **Group Id**: The ID of the storage group
1. **Erasure**: The data storage topology used
1. **Units**: The number of tablets writing to this group
1. **Allocated**: The total amount of space used by all the vdisks of the group
1. **Available**: The total available space on all pdisks in the group
1. **Read**: The rate of reading data from the group
1. **Write**: The rate of writing data to the group
1. **Latency**: The group's status in the context of response delay
1. **VDisks**: The vdisks in the groups, with their health represented by a color
1. **PDisks**: The block store volumes used by the group

When you hover over a vdisk or a block store volume, a tooltip shows the details of the vdisk and the block store volume hosting the vdisk.

![Alt text](../../../_assets/ydb/viewer_storage_vpdisks.png)

## VDisk page

In the case of using Kubernetes, when you go to the vdisk page, the link to the page includes the private address of the node hosting the vdisk.

Before going to the page, in Kubernetes, forward the node's port to the local machine, then replace the address with localhost:<the port you selected>.

![Alt text](../../../_assets/ydb/viewer_vdisk.png)

The page provides detailed information about the vdisk.

To find out the percentage of inefficiently used memory on the vdisk, follow these steps:

1. Find the `Logoblobs` section, then click `Huge Stat`

    ![Alt text](../../../_assets/ydb/viewer_vdisk_logoblobs.png)

1. In the page that opens, the `GarbageOverheadWithRespectToSlotAlignmentPercentage` field shows the percentage of inefficiently used memory on the vdisk.
