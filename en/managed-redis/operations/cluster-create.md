# Creating a [!KEYREF RD] cluster

A [!KEYREF RD] cluster is one or more database hosts that replication can be configured between. Replication is enabled by default in any cluster consisting of more than one host: the master host accepts write requests and asynchronously duplicates changes on replicas.

The number of hosts that can be created together with a [!KEYREF RD] cluster depends on the host type selected:

* In a cluster with **high-memory** hosts, you can create an unlimited number of hosts (from 1 to the current maximum [quota](../concepts/limits.md)).

* In a cluster with **burstable** hosts, you can create only one host.

## How to create a [!KEYREF RD] cluster {#create-cluster}

---

**[!TAB Management console]**

1. In the management console, select the folder where you want to create a DB cluster.
1. Click **[!KEYREF mrd-name]**.
1. Click **Create cluster** and select the necessary DBMS.
1. Enter the cluster name in the **Cluster name** field. The cluster name must be unique within the Cloud.
1. Select the environment where you want to create the cluster (you cannot change the environment after cluster creation):
    - <q>production</q> — for stable versions of your apps.
    - <q>prestable</q> — to perform testing, including that of the [!KEYREF mrd-short-name] service itself. The prestable environment is updated more often, which means that known problems are fixed sooner in it, but this may cause backward incompatible changes.
1. Select the DBMS version.
1. In the **Host class** section:
    - Select the host type: it determines the [performance](../../compute/concepts/performance-levels) level of the processor cores. **High-memory** hosts allow full core usage, whereas **burstable** hosts only a portion.

    - Select the amount of RAM for the host.

    - Select the disk size.
1. In **Cluster settings** under **Password**, set the user password (from 8 to 128 characters).
1. Under **Network**, select the network whose subnets the hosts will be connected to.
1. Under **Hosts**, click **Add host** and select the availability zone and subnet to connect the host to. Create the necessary number of hosts. To change the availability zone and the added host, click the pencil icon in the host line.
1. Click **Create cluster**.

**[!TAB CLI]**

[!INCLUDE [cli-install](../../_includes/cli-install.md)]

[!INCLUDE [default-catalogue](../../_includes/default-catalogue.md)]

To create a cluster:

1. Check whether the folder has any subnets for the cluster hosts:

   ```
   $ yc vpc subnet list
   ```

   If there are no subnets in the folder, [create the necessary subnets](../../vpc/operations/subnet-create.md) in the [!KEYREF vpc-short-name] service.

1. See the description of the CLI's create cluster command:

    ```
    $ [!KEYREF yc-mdb-rd] cluster create --help
    ```

1. View available host classes:

   ```
   $ [!KEYREF yc-mdb-rd] resource-preset list
   ```

1. Specify the cluster parameters in the create command (only some of the supported flags are given in the example):

    ```bash
    $ [!KEYREF yc-mdb-rd] cluster create \
       --name <cluster name> \
       --environment <prestable or production> \
       --network-name <network name> \
       --host zone-id=<availability zone>,subnet-id=<subnet ID> \
       --resource-preset <host class> \
       --disk-size <storage size in GB> \
       --password=<user password> \
    ```

    The subnet ID `subnet-id` should be specified if the selected availability zone contains two or more subnets.

---

## Examples

### Creating a single-host cluster

To create a cluster with a single host, you should pass a single parameter, `--host`.

Let's say we need to create a [!KEYREF RD] cluster with the following characteristics:

- Named `myredis`.
- In the `production` environment.
- In the `default` network.
- With a single `b1.nano` class host in the `b0rcctk2rvtr8efcch64` subnet and the `ru-central1-c` availability zone.
- With SSD network storage of 4 GB.
- With the `user1user1` password.

Run the command:

```
$ [!KEYREF yc-mdb-rd] cluster create \
     --name myredis \
     --environment production \
     --network-name default \
     --resource-preset b1.nano \
     --host zone-id=ru-central1-c,subnet-id=b0rcctk2rvtr8efcch64 \
     --disk-size 20 \
     --password=user1user1
```

