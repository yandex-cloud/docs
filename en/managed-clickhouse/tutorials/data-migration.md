# Migrating data to {{ mch-name }}

To migrate your database to {{ mch-name }}, you need to directly transfer your data, lock the old database for write access, and transfer the load on the database cluster to {{ yandex-cloud }}.

To transfer data to a {{ mch-name }} cluster, you can use [Apache {{ ZK }}](http://zookeeper.apache.org) and [clickhouse-copier]({{ ch.docs }}/operations/utilities/clickhouse-copier/).

Transfer your data to an intermediate VM in {{ compute-name }} if:

* The {{ mch-name }} cluster is not accessible from the internet.
* The network equipment or connection to the {{ CH }} cluster in {{ yandex-cloud }} is not reliable enough.
* There is no environment to run `clickhouse-copier`.

Migration stages:
1. [Prepare for migration](#prepare).
1. [Install {{ ZK }}](#zookeeper-install).
1. [Create a {{ mch-name }} cluster](#create-cluster).
1. [Create a task](#copier-task) for `clickhouse-copier`.
1. [Add a task](#zookeeper-task) for `clickhouse-copier` to {{ ZK }}.
1. [Launch](#copier-run) `clickhouse-copier`.

If you no longer need the resources you created, [delete them](#clear-out).

## Prepare for migration {#prepare}

1. Compatible software versions

   * {{ CH }} versions must be the same in both clusters.
   * The `clickhouse-copier` version must be the same as the {{ CH }} version in the cluster
      {{ mch-name }} or higher.
   * The {{ ZK }} version must be 3.5 or higher.


1. Check that the source cluster is ready to migrate:

   * SSL is enabled for encrypting traffic.
   * The load on the database or shard the data is copied from does not cause
      any issues.
   * `Clickhouse-copier` has access to the database, and the account being used has
      read-only access.

1. If you are using a virtual machine in {{ yandex-cloud }} for migration:
   * Create your VMs in the same cloud network as the {{ mch-name }} cluster.
   * Choose the computing capacity of the VM based on the amount of the data being transferred.


## Install {{ ZK }} {#zookeeper-install}

To migrate data, just start a single {{ ZK }} node.

1. Install Java Runtime Environment:

   ```bash
   sudo apt-get install default-jre
   ```

1. Add the user you want to run {{ ZK }} under:

   ```bash
   sudo adduser hadoop
   ```

1. Create a directory for {{ ZK }} data:

   ```bash
   sudo mkdir -p /var/data/zookeeper && \
   sudo chown -R hadoop:hadoop /var/data
   ```

1. Install {{ ZK }} (single-node setup):

   1. Download the latest stable version of the distribution. To learn more, see the [page with releases](https://zookeeper.apache.org/releases.html).

      ```bash
      cd /opt && \
      sudo wget https://downloads.apache.org/zookeeper/zookeeper-3.6.2/apache-zookeeper-3.6.2-bin.tar.gz && \
      sudo mkdir zookeeper && \
      sudo tar -C /opt/zookeeper -xvf apache-zookeeper-3.6.2-bin.tar.gz --strip-components 1 && \
      sudo chown hadoop:hadoop -R zookeeper
      ```

   1. Switch to the user you previously created to run {{ ZK }}:

      ```bash
      su hadoop
      ```

   1. Create a file named `zoo.cfg`:

      ```bash
      nano /opt/zookeeper/conf/zoo.cfg
      ```

      With the following content:

      ```ini
      tickTime=2000
      dataDir=/var/data/zookeeper
      clientPort=2181
      ```

   1. The master node must have a unique ID. To configure it, create the `myid` file.

      ```bash
      nano /var/data/zookeeper/myid
      ```

      Specify a unique ID as the content (for example, "1").

1. To run {{ ZK }} for debugging:

   ```bash
   bash /opt/zookeeper/bin/zkServer.sh start-foreground
   ```

1. To start {{ ZK }} in normal mode:

   ```bash
   bash /opt/zookeeper/bin/zkServer.sh start
   ```


## Create a {{ mch-name }} cluster {#create-cluster}

Make sure that the computing capacity and storage size of the cluster are appropriate for the environment
where the existing databases are deployed and [create a cluster](../operations/cluster-create.md).


## Create a task for clickhouse-copier {#copier-task}

To run `clickhouse-copier` using {{ ZK }}, you need to prepare:

* {{ ZK }} configuration file (`config.xml`).
* File describing the task (`cp-task.xml`).

You can find the `clickhouse-copier` guide in the [{{ CH }} documentation]({{ ch.docs }}/operations/utils/clickhouse-copier/).

### Prepare a configuration file for {{ ZK }} {#zookeeper-config}

The configuration file (`config.xml`) has to specify:

* In the `<zookeeper>` element : Address of the host where you installed {{ ZK }}.
* In the `<caConfig>` element: Path to the certificate for connecting to {{ mch-name }}.

You can download a certificate at [{{ crt-web-path-root }}]({{ crt-web-path-root }}).

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
      <caConfig>{{ crt-local-file-root }}</caConfig>
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
                        <host>your-cloud-clickhouse.{{ mdb-host }}</host>
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


## Add a task for clickhouse-copier to {{ ZK }} {#zookeeper-task}

To add a task to {{ ZK }}, run the following commands:

```bash
/opt/zookeeper/bin/zkCli.sh -server localhost:2181 deleteall /cp-task.xml/description && \
/opt/zookeeper/bin/zkCli.sh -server localhost:2181 deleteall /cp-task.xml/task_active_workers && \
/opt/zookeeper/bin/zkCli.sh -server localhost:2181 deleteall /cp-task.xml && \
fc=$(cat ./cp-task.xml) && \
/opt/zookeeper/bin/zkCli.sh -server localhost:2181 create /cp-task.xml "" && \
/opt/zookeeper/bin/zkCli.sh -server localhost:2181 create /cp-task.xml/description "$fc"
```


## Launch clickhouse-copier {#copier-run}

{% note warning %}

If you didn't create the folders that you specified in the `-- base-dir` flag or for saving logs, `clickhouse-copier` might not start.

{% endnote %}

You can start the copier using the following command (to run in daemon mode
, add the `--daemon` flag):

```bash
clickhouse-copier \
  --config ./config.xml \
  --task-path ./cp-task.xml \
  --base-dir ./clickhouse \
  --log-level debug
```

Once the operation is complete, check the logs to make sure that everything was
copied successfully.

## Delete the resources you created {#clear-out}

If you no longer need the resources you created, delete the [{{ mch-full-name }} cluster](../operations/cluster-delete.md).

{% include [clickhouse-disclaimer](../../_includes/clickhouse-disclaimer.md) %}
