# Creating {{ PG }} clusters

{{ PG }} clusters are one or more database hosts that replication can be configured between. Replication is enabled by default in any cluster consisting of more than one host: the master host accepts write requests, synchronously duplicates changes in the primary replica, and does it asynchronously in all the others.

{% note info %}

If database storage is 95% full, the cluster switches to read-only mode. Plan and increase the required storage size in advance.

{% endnote %}

{% if audience != "internal" %}

The number of hosts that can be created with a {{ PG }} cluster depends on the storage option selected:

* When using network drives, you can request any number of hosts (from one to the current [quota](../concepts/limits.md) limit).

* When using SSDs, you can create at least three replicas along with the cluster (a minimum of three replicas is required to ensure fault tolerance). If the [available folder resources](../concepts/limits.md) are still sufficient after creating a cluster, you can add extra replicas.

{% endif %}

By default, {{ mpg-short-name }} limits the maximum number of connections to each {{ PG }} cluster host. This maximum is calculated as follows: `200 × <number of vCPUs per host>`. For example, for a [s1.micro class](../concepts/instance-types.md) cluster, the `max_connections` default parameter value is 400 and can't be increased.

{% include [note-pg-user-connections.md](../../_includes/mdb/note-pg-user-connections.md) %}

## How to create a {{ PG }} cluster {#create-cluster}

{% list tabs %}

- Management console

  1. In the management console, select the folder where you want to create a DB cluster.

  1. Select **{{ mpg-name }}**.

  1. Click **Create cluster**.

  1. Enter the cluster name in the **Cluster name** field. The cluster name must be unique within the Cloud.

  1. Select the environment where you want to create the cluster (you can't change the environment once the cluster is created):
      - <q>production</q>: For stable versions of your apps.
      - <q>prestable</q>: For testing, including the {{ mpg-short-name }} service itself. The prestable environment is updated more often, which means that known problems are fixed sooner, but this may cause backward incompatible changes.

  1. Select the DBMS version.
{% note info %}

     When using version `10-1c` ({{ PG }} 10 for 1C), to comfortably host 50 users, we recommend selecting the `s2.medium` host class. For 30 users and less, the `s2.small` class is probably going to be enough.

     {% endnote %}

  1. Select the host class that defines the technical specifications of the VMs where the DB hosts will be deployed. All available options are listed in [{#T}](../concepts/instance-types.md). When you change the host class for the cluster, the characteristics of all existing hosts change, too.

  1. Under **Storage size**:

      {% if audience != "internal" %} - Выберите тип хранилища — более гибкое сетевое (**network-hdd** или **network-ssd**) или более быстрое локальное SSD-хранилище (**local-ssd**). Размер локального хранилища можно менять только с шагом 100 ГБ. {% endif %}
      - Select the size to be used for data and backups. For more information about how backups take up storage space, see [{#T}](../concepts/backup.md).

  1. Under **Database**, specify the DB attributes:
      - Database name. The DB name must be unique within the folder and contain only Latin letters, numbers, and underscores.
      - The name of the user who is the DB owner. The username may only contain Latin letters, numbers, and underscores. By default, the new user is assigned 50 connections to each host in the cluster.
      - User password (from 8 to 128 characters).

      For the database created with the cluster, the character set and collate settings are specified as `LC_CTYPE=C` and `LC_COLLATE=C`. You can't change these settings after the database is created, but you can [create a new database](databases.md#add-the db) with the right settings.

  1. Under **Hosts**, select parameters for the database hosts created with the cluster (keep in mind that if you use SSDs when creating a {{ PG }} cluster, you can set at least three hosts). If you open **Advanced settings**, you can choose specific subnets for each host. By default, each host is created in a separate subnet.

  1. Click **Create cluster**.

- CLI

  {% include [cli-install](../../_includes/cli-install.md) %}

  {% include [default-catalogue](../../_includes/default-catalogue.md) %}

  To create a cluster:

  {% if audience != "internal" %} 1. Check whether the folder has any subnets for the cluster hosts:

     ```
     $ yc vpc subnet list
     ```

     If there are no subnets in the folder, [create the necessary subnets](../../vpc/operations/subnet-create.md) in {{ vpc-short-name }}. {% endif %}

  1. View a description of the CLI's create cluster command:

      ```
      $ {{ yc-mdb-pg }} cluster create --help
      ```

  1. Specify the cluster parameters in the create command (only some of the supported parameters are given in the example):

      {% if audience != "internal" %}

      ```bash
      $ {{ yc-mdb-pg }} cluster create \
         --name <cluster name> \
         --environment <prestable or production> \
         --network-name <network name> \
         --host zone-id=<availability zone>,subnet-id=<subnet ID> \
         --resource-preset <host class> \
         --user name=<username>,password=<user password> \
         --database name=<database name>,owner=<database owner name> \
         --disk-size <storage size in GB>
      ```

      The subnet ID `subnet-id` should be specified if the selected availability zone contains two or more subnets.

      {% else %}

      ```bash
      $ {{ yc-mdb-pg }} cluster create \
         --name <cluster name> \
         --environment <prestable or production> \
         --network-id {{ network-name }} \
         --host zone-id=<availability zone> \
         --resource-preset <host class> \
         --user name=<username>,password=<user password> \
         --database name=<database name>,owner=<database owner name> \
         --disk-size <storage size in GB>
      ```

      {% endif %}

{% endlist %}

## Examples {#examples}

### Creating a single-host cluster {#creating-a-single-host-cluster}

To create a cluster with a single host, you should pass a single parameter, `--host`.

Let's say we need to create a {{ PG }} cluster with the following characteristics:

{% if audience != "internal" %}

- Named `mypg`.
- In the `production` environment.
- In the `default` network.
- With a single host of the `s1.nano` class in the `b0rcctk2rvtr8efcch64` subnet and the `ru-central1-c` availability zone.
- With SSD network storage of 20 GB.
- With one user (`user1`) with the password `user1user1`.
- With one `db1` database owned by the user `user1`.

{% else %}

- Named `mypg`.
- In the `production` environment.
- With a single `db1.micro` class host in the `man` availability zone.
- With 20 GB of SSD storage.
- With one user (`user1`) with the password `user1user1`.
- With one `db1` database owned by the user `user1`.

{% endif %}

Run the command:

{% if audience != "internal" %}

```
$ {{ yc-mdb-pg }} cluster create \
     --name mypg \
     --environment production \
     --network-name default \
     --resource-preset s1.nano \
     --host zone-id=ru-central1-c,subnet-id=b0rcctk2rvtr8efcch64 \
     --disk-type network-ssd \
     --disk-size 20 \
     --user name=user1,password=user1user1 \
     --database name=db1,owner=user1
```

{% else %}

```
$ {{ yc-mdb-pg }} cluster create \
     --name mypg \
     --environment production \
     --network-id ' ' \
     --host zone-id=man \
     --resource-preset db1.micro \
     --disk-type local-ssd \
     --disk-size 20 \
     --user name=user1,password=user1user1 \
     --database name=db1,owner=user1
```

{% endif %}

