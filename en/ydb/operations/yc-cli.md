# Database management using the YC CLI

This article describes commands that are used most frequently. For a full description of all YDB commands in the Yandex Cloud CLI, see the context help that is also available in the [Yandex Cloud documentation](../../cli/cli-ref/managed-services/ydb/).

{% include [cli-install](../../_includes/cli-install.md) %}

{% include [default-catalogue](../../_includes/default-catalogue.md) %}

## Creating a database {#create}

You can create a database in a Serverless configuration or with dedicated servers. For more information about differences in configurations, see [Serverless and Dedicated modes](../concepts/serverless-and-dedicated.md).

{% list tabs %}

- Serverless

   To create a Serverless database, run the following command by replacing  `<name>` with the name of the database to create:

   ```bash
   yc ydb database create <name> --serverless
   ```

   **Example**

   Creating a Serverless database named `testdb`:

   ```bash
   yc ydb database create testdb --serverless
   ```

   Any Serverless database is created with geographic redundancy in three availability zones.

   You can update any parameter later by running the CLI [`update` command](#update) or using the management console.

- Dedicated

   To create a Dedicated database, run the following command by replacing `<name>` with the name of the database to create and specifying additional parameters:

   ```bash
   yc ydb database create <name> --dedicated <parameters>
   ```

   Required parameters specify what resources and network are allocated to the database:

   * `--network-name STR`: The name of the cloud network to create the database in. You can specify the `default` network.
   * `--storage STR`: The media type and number of storage groups in `type=<type>,groups=<groups>` format. For the `ssd` type, a single storage group can store up to 100 GB of data.
   * `--resource-preset STR`: The configuration of node computing resources. Possible values are listed in the "Configuration name" column of the [Computing resources](../concepts/index.md#resource-presets) table on the page with information about databases.

   You can also set additional parameters, including the following key ones:

   * `--public-ip`: A flag indicating that public IP addresses are assigned. Without it, you can't connect to the database you create from the internet.
   * `--fixed-size INT`: The number of cluster nodes, defaults to 1. Nodes are allocated in different availability zones, so a configuration of three nodes will be geographically distributed across three availability zones.
   * `--async`: The asynchronous DB creation flag. Creating a Dedicated database may take a long time, up to several minutes. You can set this flag so that control is returned as soon as the create DB command is accepted by the cloud.

   **Examples**

   Creating a single-node Dedicated YDB database with the minimum configuration, named `dedb` and accessible from the internet:

   ```bash
   yc ydb database create dedb --dedicated --network-name default \
     --storage type=ssd,groups=1 --resource-preset medium --public-ip
   ```

   Asynchronously creating a three-node Dedicated YDB database with geographic redundancy, 300 GB of storage, and computing nodes with 64 GB RAM each, named `dedb3` and accessible from the internet:

   ```bash
   yc ydb database create dedb3 --dedicated --network-name default \
     --storage type=ssd,groups=3 --resource-preset medium-m64 --public-ip \
     --fixed-size 3 --async
   ```

{% endlist %}

## List of databases {#list}

To get a list of databases in the current cloud folder, run the command:

```bash
yc ydb database list
```

## Database parameters {#get}

O get the current DB parameter values, run the following command by replacing `<name>` with the name of the appropriate database:

```bash
yc ydb database get <name>
```

## Updating database parameters {#update}

To update the DB parameters, use the `update` command. You can get a list of the names of updatable parameters in the context help for this command:

```bash
yc ydb database update --help
```

Serverless and Dedicated databases have only one parameter in common: DB name. Serverless DB parameter names begin with `sls-`. Other parameters are only applicable to Dedicated databases.

**Examples**

Renaming the `dbtest` database to `mydb`:

```bash
yc ydb database update dbtest --new-name mydb
```

Setting a consumption limit of 100 Request Units per second for a Serverless database named `db5`:

```bash
yc ydb database update db5 --sls-throttling-rcu 100
```

## Deleting a database {#delete}

To delete a database, run the `delete` command:

```bash
yc ydb database delete <name>
```
