# Logs in {{ dataproc-name }}

Cluster logs are collected and displayed by [{{ cloud-logging-name }}](../../logging/).

Every log message sent by {{ dataproc-name }} cluster has [standard fields for filtering](../../logging/concepts/filter.md):

* `resource_type`: `dataproc.cluster`.
* `resource_id`: the ID of {{ dataproc-name }} cluster.

Also {{ dataproc-name }} log messages has additional fields:

* `hostname`: hostname FQDN.
* `log_type`: [the type of the log message](#log-types).

## {{ dataproc-name }} cluster log messages types {#types}

### Cluster component logs {#components}

For cluster component logs, the log record types depend on sub-cluster role:

* All cluster hosts:
    * `cloud-init`: {{ dataproc-name }} clusters with [image version](../concepts/environment.md) 2.0 or higher;
    * `salt-minion`: {{ dataproc-name }} service init log;
    * `syslog`: system log;
    * `telegraf`: logs for the agent that sends metrics to [{{ monitoring-name }}](../../monitoring/));
    * `yandex-dataproc-start`: {{ dataproc-name }} service init log.

* Hosts from sub-cluster with `Master` role:
    * `hadoop-hdfs-namenode`;
    * `hadoop-hdfs-secondarynamenode`;
    * `hadoop-mapreduce`;
    * `hadoop-yarn-resourcemanager`;
    * `hadoop-yarn-timelineserver`;
    * `hbase-master`;
    * `hbase-rest`;
    * `hbase-thrift`;
    * `hive-metastore`;
    * `hiveserver2`;
    * `livy-out`;
    * `livy-request`;
    * `oozie`;
    * `oozie-audit`;
    * `oozie-error`;
    * `oozie-instrumentation`;
    * `oozie-jetty`;
    * `oozie-jpa`;
    * `oozie-ops`;
    * `postgres`;
    * `yandex-dataproc-agent`;
    * `zeppelin`;
    * `zookeeper`.
    * Only {{ dataproc-name }} clusters with [image version](../concepts/environment.md) lower than 2.0:
       * `flume`;
       * `hive-webhcat-console`;
       * `hive-webhcat-console-error`;
       * `hive-webhcat`;
       * `knox`;
       * `sqoop`;
       * `supervisor`.

* Hosts from sub-clusters with `Data` role
    * `hadoop-hdfs-datanode`;
    * `hadoop-yarn-nodemanager`.

* Hosts from sub-clusters with `Compute` role contain `hadoop-yarn-nodemanager` log types.

### Job logs {#jobs}

The following log types are used in {{ dataproc-name }} jobs log:

* YARN container logs

  For the log type `containers` value is used.

  Log message has also the following tags:

    * `yarn_log_type`: the name of the corresponding YARN log file.

       Examples:
         * `stdout`,
         * `stderr`,
         * `launch_container.sh`,
         * `prelaunch.out`,
         * `directory.info`
    * `container_id`: YARN container ID. Example: `container_1638976919626_0002_01_000001`
    * `application_id`: YARN application ID. Example: `application_1638976919626_0002`

* Job runner process output. Saved when the job are being run via {{ dataproc-name }} API rather than on cluster hosts directly.

  For the log type `job_output` value is used.

  Log messages has tag `job_id` with the identifier of the job run by {{ dataproc-name }} API. If YARN application is created, there will be `application_id` with YARN application ID as well.
