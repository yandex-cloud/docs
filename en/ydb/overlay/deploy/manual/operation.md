# Normal operation

## Cluster extension {#expand_cluster}

(add instructions)

## SelfHeal {#selfheal}

During cluster operation, individual block store volumes used by YDB or entire nodes may fail. To maintain the cluster's uptime and fault tolerance when it's impossible to promptly fix the failed nodes or volumes, YDB provides SelfHeal.

SelfHeal includes two parts. Detecting faulty disks and moving them carefully to avoid data loss and disintegration of storage groups.

SelfHeal is enabled by default.
Below are instructions how to enable or disable SelfHeal.

1. Enabling detection

    Open the page

    ```http://localhost:8765/cms#show=config-items-25```

    It can be enabled via the viewer -> Cluster Management System -> CmsConfigItems

    Status field: Enable

    Or via the CLI

    * Go to any node

    * Create a file with modified configs

        Sample config.txt file

        ```
        Actions {
            AddConfigItem {
                ConfigItem {
                    Config {
                        CmsConfig {
                            SentinelConfig {
                                Enable: true
                            }
                        }
                    }
                }
            }
        }
        ```

    * Update the config on the cluster

        ```bash
        kikimr admin console configs update config.txt
        ```

2. Enable SelfHeal

    ```bash
    kikimr -s <endpoint> admin bs config invoke --proto 'Command{EnableSelfHeal{Enable: true}}'
    ```

## Move one vdisk from a block store volume {#moving_vdisk}

To move a disk from a block store volume, log in to the node via ssh and execute the following command:

```bash
kikimr admin bs config invoke --proto 'Command { ReassignGroupDisk { GroupId: <Storage group ID> GroupGeneration: <Storage group generation> FailRealmIdx: <FailRealm> FailDomainIdx: <FailDomain> VDiskIdx: <Slot number> } }'
```

You can find the parameters for the command in the viewer (link).

## Move vdisks from a broken/missing block store volume {#removal_from_a_broken_device}

If SelfHeal is disabled or fails to move vdisks, you'll have to run this operation manually.

1. Make sure that the disk has actually failed.

    Write down the node's fqdn, ic-port, disk path, and pdiskId

2. Go to any cluster node

3. Move the disk

    ```bash
    kikimr admin bs config invoke --proto 'Command { UpdateDriveStatus { HostKey: { Fqdn: "<Host>" IcPort: <IC Port>} Path: "<Path to the storage volume part label>" PDiskId: <PDisk ID> Status: BROKEN  } }'
    ```

## Enable the disk back after reassignment {#return_a_device_to_work}

1. In Monitoring, make sure that the disk is actually operable

    Write down the node's fqdn, ic-port, disk path, and pdiskId

2. Go to any cluster node

3. Re-enable the disk

    ```bash
    kikimr admin bs config invoke --proto 'Command { UpdateDriveStatus { HostKey: { Fqdn: "<Host>" IcPort: <IC Port>} Path: "<Path to the device part label>" PDiskId: <PDisk ID> Status: ACTIVE } }'
    ```

## Stopping/restarting a YDB process on a node {#restart_process}

To make sure that the process is stoppable, follow these steps.

1. Access the node via ssh.

1. Execute the command

    ```bash
    kikimr cms request restart host {node_id} --user {user} --duration 60 --dry --reason 'format disk'
    ```

    If the process is stoppable, you'll see `ALLOW`.

1. Stop the process

    ```bash
    sudo systemctl stop kikimr
    ```

1. Restart the process if needed

   ```bash
    sudo systemctl start kikimr
   ```

## Replacing equipment {#replace_hardware}

Before replacing equipment, make sure that the YDB process is [stoppable](#restart_process).
If the replacement is going to take a long time, first move all the vdisks from this node and wait until replication is complete.
After replication is complete, you can safely shut down the node.
