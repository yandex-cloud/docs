# Migrating data to {{ mch-name }}

To migrate your database to {{ mch-name }}, you need to transfer the data directly, close the old database for writing, and then transfer the load to the database cluster in Yandex.Cloud.

To transfer data to a {{ mch-name }} cluster, you can use [Apache ZooKeeper](http://zookeeper.apache.org) and [clickhouse-copier]( https://clickhouse.yandex/docs/enoperations/utils/clickhouse-copier/).

Transfer data to an intermediate virtual machine in Compute Cloud if:

* The {{ mch-name }} cluster isn't accessible from the internet.
* Your network equipment or connection to the {{ CH }} cluster in Yandex.Cloud isn't
very reliable.
* There is no environment to run `clickhouse-copier`.

Migration stages:

1. [Prepare for migration](#prepare).
1. [Install ZooKeeper](#zookeeper-install).
1. [Create a cluster {{ mch-name }}](#create-cluster).
1. [Create a task](#copier-task) for `clickhouse-copier`.
1. [Add a task](#zookeeper-task) for `clickhouse-copier` in ZooKeeper.
1. [Run](#copier-run) `clickhouse-copier`.

## Prepare for migration {#prepare}

1. Compatible software versions
    * {{ CH }} versions must be the same in both clusters.
    * `clickhouse-copier` version must be the same (or higher) than the {{ CH }} version in the
 {{ mch-name }} cluster.
    * ZooKeeper ver. 3.4.10 and higher.

2. Check that the source cluster is ready to migrate:
    * SSL is enabled for encrypting traffic.
    * The load on the database or shard that data will be copied from won't createproblems.
    * `clickhouse-copier` has access to the database, and the account used hasread-only access.

3. If you are using a virtual machine in Yandex.Cloud for migration:
    * Create your VMs in the same cloud network as the {{ mch-name }} cluster.
    * The computing power of the VM should be chosen based on the amount of data transferred.

## Install Zookeeper {#zookeeper-install}

To migrate data, start a ZooKeeper node.

1. Install Java Runtime Environment:

    ```bash
    $ sudo apt-get install default-jre
    ```

1. Add the user that you want to run ZooKeeper under:

    ```
    $ sudo adduser hadoop
    ```

1. Create a directory for ZooKeeper data:

    ```bash
    $ sudo mkdir -p /var/data/zookeeper
    $ sudo chown -R hadoop:hadoop /var/data
    ```

1. Install ZooKeeper (single-node setup):

    1. Download a distribution, such as version 3.4.13:

        ```bash
        $ cd /opt
        $ sudo wget http://apache.is.co.za/zookeeper/zookeeper-3.4.13/zookeeper-3.4.13.tar.gz
        $ sudo tar -xvf zookeeper-3.4.13.tar.gz
        $ sudo chown hadoop:hadoop -R  zookeeper-3.4.13
        ```

    1. Switch to the user you created earlier to launch ZooKeeper:

        ```
        $ su hadoop
        ```

    1. Create the file `/opt/zookeeper-3.4.13/conf/zoo.cfg` with the following contents:

        ```ini
        tickTime=2000
        dataDir=/var/data/zookeeper
        clientPort=2181
        ```

    1. The master node must have a unique ID. To do this, create a `/var/data/zookeeper/myid` file with ID as its contents (for example, "1").

1. To launch ZooKeeper for debugging:

    ```bash
    $ bash /opt/zookeeper-3.4.13/bin/zkServer.sh start-foreground
    ```

1. To launch ZooKeeper as normal:

    ```bash
     $ bash /opt/zookeeper-3.4.13/bin/zkServer.sh start
    ```

## Create a cluster {{ mch-name }} {#create-cluster}

Make sure that the computing power and storage size of the cluster are appropriate for the environment,where the existing databases are deployed, and [create a cluster](cluster-create.md).

## Create a task for clickhouse-copier {#copier-task}

To launch `clickhouse-copier` using ZooKeeper, you need to prepare:

* A ZooKeeper configuration file (`config.xml`).
* A file describing the task (`cp-task.xml`).

Instructions for `clickhouse-copier` can be found in the [ClickHouse documentation](https://clickhouse.yandex/docs/en/operations/utils/clickhouse-copier/).

### Prepare a configuration file for ZooKeeper {#zookeeper-config}

The configuration file (`config.xml`) has to specify:

* In the `<zookeeper>` element — The address of the host where you installed ZooKeeper.
* In the `<caConfig>` element — The path to the certificate for connecting to {{ mch-name }}.

You can download a certificate at [https://{{ s3-storage-host }}{{ pem-path }}](https://{{ s3-storage-host }}{{ pem-path }}).

Sample configuration:

```xml
<yandex>
  <zookeeper>
    <node>
      <host>127.0.0.1</host>
      <port>2181</port>
    </node>
  </zookeeper>

  <logger>
    <level>trace</level>
    <log>log.log</log>
    <errorlog>log.err.log</errorlog>
    <size>never</size>
  </logger>

  <openSSL>
    <client>
      <loadDefaultCAFile>true</loadDefaultCAFile>
      <caConfig>CA.pem</caConfig>
      <cacheSessions>true</cacheSessions>
      <disableProtocols>sslv2,sslv3</disableProtocols>
      <preferServerCiphers>true</preferServerCiphers>
      <invalidCertificateHandler>
        <name>RejectCertificateHandler</name>
      </invalidCertificateHandler>
    </client>
  </openSSL>
</yandex>
```

### Describe the task {#task-description}

Example of data migration task description (`cp-task.xml`):

```xml
<yandex>
    <tcp_port_secure>9440</tcp_port_secure> <!-- optional -->
    <remote_servers>
        <source_cluster>
            <shard>
                <internal_replication>false</internal_replication>
                    <replica>
                        <host>your-clickhouse-server.com</host>
                        <port>9440</port>
                        <user>your-user</user>
                        <password>password</password>
                        <secure>1</secure>
                    </replica>
            </shard>
        </source_cluster>

        <destination_cluster>
               <shard>
                <internal_replication>false</internal_replication>
                    <replica>
                        <host>your-cloud-clickhouse.mdb.cloud.yandex.net</host>
                        <port>9440</port>
                        <user>your-user</user>
                        <password>password</password>
                        <secure>1</secure>
                    </replica>
               </shard>
        </destination_cluster>
    </remote_servers>

    <max_workers>2</max_workers>

    <settings_pull>
        <readonly>1</readonly>
    </settings_pull>

    <settings_push>
        <readonly>0</readonly>
    </settings_push>

    <settings>
        <connect_timeout>3</connect_timeout>
        <insert_distributed_sync>1</insert_distributed_sync>
    </settings>

    <tables>
        <table_hits>
            <cluster_pull>source_cluster</cluster_pull>
    	    <database_pull>your-db</database_pull>
            <table_pull>your-table</table_pull>

            <cluster_push>destination_cluster</cluster_push>
            <database_push>your-db</database_push>
            <table_push>your-table</table_push>

            <engine>
                <!-- Description of the table engine, the same as in the CREATE TABLE procedure
                in the source cluster. For an existing table, you can
                get a description with the query SHOW CREATE table_name -->
	            ENGINE = MergeTree() PARTITION BY Year ORDER BY (Year, FlightDate) SETTINGS index_granularity=8192
	        </engine>

    	    <sharding_key>jumpConsistentHash(intHash64(Year), 2)</sharding_key>

            <enabled_partitions>
                <partition>'2017'</partition>
	        </enabled_partitions>
        </table_hits>
    </tables>
</yandex>
```

## Add a task for clickhouse-copier to Zookeeper {#zookeeper-task}

To add a task in ZooKeeper, run the following commands:

```bash
/opt/zookeeper-3.4.13/bin/zkCli.sh -server localhost:2181 rmr /cp-task.xml/description
/opt/zookeeper-3.4.13/bin/zkCli.sh -server localhost:2181 rmr /cp-task.xml/task_active_workers
/opt/zookeeper-3.4.13/bin/zkCli.sh -server localhost:2181 rmr /cp-task.xml

fc=$(cat ./cp-task.xml)
/opt/zookeeper-3.4.13/bin/zkCli.sh -server localhost:2181 create /cp-task.xml ""
/opt/zookeeper-3.4.13/bin/zkCli.sh -server localhost:2181 create /cp-task.xml/description "$fc"
```

## Launch clickhouse-copier {#copier-run}

{% note important %}

If you didn't create the folders that you specified in the `--base-dir` flag or for saving logs, `clickhouse-copier` might not start.

{% endnote %}

You can launch copier using the following command (to run it in daemon mode,add a `--daemon` flag):

```bash
$ clickhouse-copier
  --config ./config.xml \
  --task-path ./cp-task.xml \
  --base-dir ./clickhouse \
  --log-level debug
```

Once the operation is complete, check the logs to make sure that everything wascopied successfully.

