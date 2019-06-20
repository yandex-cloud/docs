# Creating a {{ MG }} cluster

{{ MG }} cluster is one or more database hosts that can have replication configured between them. Replication is enabled by default in any cluster consisting of more than one host (the primary host accepts write requests and asynchronously duplicates changes in the secondary hosts).

The number of hosts that can be created together with a {{ MG }} cluster depends on the storage option selected:

* When using network drives, you can request any number of hosts (from one to the limits of the current [quota](../concepts/limits.md)).

* When using SSDs, you can create at least three replicas along with the cluster (a minimum of three replicas is required to ensure fault tolerance). If the [available folder resources](../concepts/limits.md) are still sufficient after creating a cluster, you can add extra replicas.

{% list tabs %}

- Management console
  
  1. In the management console, select the folder where you want to create a DB cluster.
  
  2. Click **{{ mmg-name }}**.
  
  3. Click **Create cluster** and select the necessary DBMS. Once a cluster is created, you cannot change the DBMS.
  
  4. Enter the cluster name in the **Cluster name** field. The cluster name must be unique within the folder.
  
  5. Select the environment where you want to create the cluster (you cannot change the environment after cluster creation):
  
      * <q>production</q> — for stable versions of your apps.
  
      * <q>prestable</q> — to perform testing, including that of the {{ mmg-short-name }} service itself. The prestable environment is updated more often, which means that known problems are fixed sooner in it, but this may cause backward incompatible changes.
  
  6. Select the DBMS version.
  
  7. Select the host class that will define the technical specifications of the VMs where the DB hosts will be deployed. When you change the host class for the cluster, the characteristics of all existing hosts change, too.
  
  8. In the **Storage size** section:
  
      * Select the type of storage, either a more flexible network type (**network-hdd** or **network-nvme**) or faster local SSD storage (**local-nvme**). The size of the local storage can only be changed in increments of 100 GB.
  
      * Select the size to be used for data and backups. For more information about how backups take up storage space, see [#T](../concepts/backup.md).
  
  9. In the **Database** section, specify DB attributes:
  
      * DB name
  
      * User name
  
      * User password (a minimum of 8 characters).
  
  10. In the **Hosts** section, select parameters for database hosts created with the cluster (keep in mind that if you use SSDs when creating {{ MG }} clusters, you can set at least three hosts). If you open the **Advanced settings** section, you can choose specific subnets for each host. By default, each host is created in a separate subnet.
  
  11. Click **Create cluster**.
  
- CLI
  
  {% include [cli-install](../../_includes/cli-install.md) %}
  
  {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
  To create a cluster:
  
  1. Check whether the folder has any subnets for the cluster hosts:
  
      ```
      $ yc vpc subnet list
      ```
  
      If there are no subnets in the folder, [create the necessary subnets](../../vpc/operations/subnet-create.md) in the {{ vpc-short-name }} service.
  
  1. See the description of the CLI's create cluster command:
  
      ```
      $ {{ yc-mdb-mg }} cluster create --help
      ```
  
  2. Specify the cluster parameters in the create command (the example shows only mandatory flags):
  
      ```
      $ {{ yc-mdb-mg }} cluster create \
         --name <cluster name> \
         --environment=<prestable or production> \
         --network-name <network name> \
         --host zone-id=<availability zone>,subnet-id=<subnet ID> \
         --resource-preset <host class> \
         --user name=<user name>,password=<user password> \
         --database name=<database name>,owner=<database owner name> \
         --mongod-disk-type <network-hdd | network-nvme | local-nvme> \
         --mongod-disk-size <storage size in GB>
      ```
  
      The subnet ID `subnet-id` should be specified if the selected availability zone contains two or more subnets.
  
{% endlist %}

## Examples

### Creating a single-host cluster

To create a cluster with a single host, you should pass a single parameter, `--host`.

Let's say we need to create a {{ MG }} cluster with the following characteristics:

* Named `mymg`.

* In the `production` environment.

* In the `default` network.

* With a single host of the `s1.nano` class in the `b0rcctk2rvtr8efcch64` subnet and the `ru-central1-c` availability zone.

* With SSD network storage of 20 GB.

* With one user (`user1`) and the password `user1user1`.

* With one `db1` database.

Run the command:

```
$ {{ yc-mdb-mg }} cluster create \
     --name mymg \
     --environment production \
     --network-name default \
     --mongod-resource-preset s1.nano \
     --host zone-id=ru-central1-c,subnet-id=b0rcctk2rvtr8efcch64 \
     --mongod-disk-size 20 \
     --mongod-disk-type network-nvme \
     --user name=user1,password=user1user1 \
     --database name=db1
```

