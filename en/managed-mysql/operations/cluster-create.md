# Creating {{ MY }} clusters

A {{ MY }} cluster is one or more database hosts that replication can be configured between. Replication is enabled by default in any cluster consisting of more than one host: the master host accepts write requests, synchronously duplicates changes in the primary replica, and does it asynchronously in all the others.


The number of hosts that can be created together with a {{ MY }} cluster depends on the storage option selected:

  - When using network drives, you can request any number of hosts (from one to the limits of the current [quota](../concepts/limits.md)).
  - When using SSDs, you can create at least three replicas along with the cluster (a minimum of three replicas is required to ensure fault tolerance). If the [available folder resources](../concepts/limits.md) are still sufficient after creating a cluster, you can add extra replicas.


By default, {{ mmy-short-name }} limits the maximum number of connections to each {{ MY }} cluster host to ` 200 x <number of vCPUs on host>`. For example, for a host of the [s1.micro class](../concepts/instance-types.md) the `max_connections` default parameter value is 400.

{% note info %}

If database storage is 95% full, the cluster switches to read-only mode. Increase the storage size in advance.

{% endnote %}

## How to create a cluster {{ MY }} {#create-cluster}

{% list tabs %}

- Management console

  1. In the management console, select the folder where you want to create a DB cluster.

  1. Select **{{ mmy-name }}**.

  1. Click **Create cluster**.

  1. Enter the cluster name in the **Cluster name** field. The cluster name must be unique within the Cloud.

  1. Select the environment where you want to create the cluster (you cannot change the environment after cluster creation):
      - <q>production</q> — For stable versions of your apps.
      - <q>prestable</q> — For testing, including the {{ mmy-short-name }} service itself. The prestable environment is updated more often, which means that known problems are fixed sooner in it, but this may cause backward incompatible changes.

  1. Select the DBMS version.

  1. Select the host class that will define the technical specifications of the VMs where the DB hosts will be deployed. All available options are listed in [{#T}](../concepts/instance-types.md). When you change the host class for the cluster, the characteristics of all existing hosts change, too.

  1. In the **Storage size** section:
      - Select the type of storage, either a more flexible network type (**network-hdd** or **network-ssd**) or faster local SSD storage (**local-ssd**). The size of the local storage can only be changed in 100 GB increments.
      - Select the size to be used for data and backups. For more information about how backups take up storage space, see [{#T}](../concepts/backup.md).

  1. In the **Database** section, specify DB attributes:
      - Database name. The DB name must be unique within the folder and contain only Latin letters, numbers, and underscores.
      - The name of the user who is the DB owner. The username may only contain Latin letters, numbers, and underscores.
      - User's password (from 8 to 128 characters).

  1. Under **Hosts**, select parameters for the database hosts created with the cluster (keep in mind that if you use SSDs when creating a {{ MY }} cluster, you can set at least three hosts). If you open the **Advanced settings** section, you can choose specific subnets for each host. By default, each host is created in a separate subnet.

  1. Click **Create cluster**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To create a cluster:

  1. Check whether the folder has any subnets for the cluster hosts:

     ```
     $ yc vpc subnet list
     ```

     If there are no subnets in the folder, [create the necessary subnets](../../vpc/operations/subnet-create.md) in {{ vpc-short-name }}.

  1. See the description of the CLI's create cluster command:

      ```
      $ yc managed-mysql cluster create --help
      ```

  1. Specify the cluster parameters in the create command:

     ```
     $ yc managed-mysql cluster create \
        --cluster-name <cluster name> \
        --environment <prestable or production> \
        --network-name <network name> \
        --host zone-id=<availability zone>,subnet-id=<subnet ID> \
        --mysql-version <MySQL version> \
        --resource-preset <host class> \
        --user name=<username>,password=<user password> \
        --database name=<DB name>
     ```

      The subnet ID `subnet-id` should be specified if the selected availability zone contains two or more subnets.

{% endlist %}

