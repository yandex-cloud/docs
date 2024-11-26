# Logs in {{ dataproc-name }}

[{{ cloud-logging-full-name }}](../../logging/) collects and displays {{ dataproc-name }} cluster logs. They are automatically saved to the log group linked to the cluster when you [create](../operations/cluster-create.md) or [modify](../operations/cluster-update.md) it. This can be the folder's default log group or a log group pre-configured by the user.

To view the logs of a {{ dataproc-name }} cluster, from its page, go to the cluster log group. Then, in the **{{ ui-key.yacloud.logging.label_filter-query }}** field, [enter a filter](../../logging/concepts/filter.md):

* Standard filtering parameters:

   * `resource_type`: Always takes the `dataproc.cluster` value.
   * `resource_id`: Cluster ID.

* Additional filtering parameters:

   * `hostname`: Host FQDN.
   * `log_type`: Type of entries in cluster logs.

As a result, the log group page will display a histogram of logs and records from them.

## Types of log entries {{ dataproc-name }} {#types}

### Cluster component logs {#components}

Depending on the subcluster role, the following types of entries are used for component logs:

* All cluster hosts:
   * `cloud-init`: {{ dataproc-name }} clusters with the [image version](../concepts/environment.md) of 2.0 or higher.
   * `salt-minion`: Service initialization log for the {{ dataproc-name }} cluster.
   * `syslog`: System log.
   * `telegraf`: Log of outgoing {{ dataproc-name }} cluster metrics sent to [{{ monitoring-name }}](../../monitoring/).

* Master host:
   * `flume`: {{ dataproc-name }} clusters with [image version](../concepts/environment.md) below 2.0.
   * `hadoop-hdfs-namenode`
   * `hadoop-hdfs-secondarynamenode`
   * `hadoop-mapreduce`
   * `hadoop-yarn-resourcemanager`
   * `hadoop-yarn-timelineserver`
   * `hbase-master`
   * `hbase-rest`
   * `hbase-thrift`
   * `hive-metastore`
   * `hiveserver2`
   * `hive-webhcat-console`: {{ dataproc-name }} clusters with [image version](../concepts/environment.md) below 2.0.
   * `hive-webhcat-console-error`: {{ dataproc-name }} clusters with [image version](../concepts/environment.md) below 2.0.
   * `hive-webhcat`: {{ dataproc-name }} clusters with [image version](../concepts/environment.md) below 2.0.
   * `knox`: {{ dataproc-name }} clusters with [image version](../concepts/environment.md) below 2.0.
   * `livy-out`
   * `livy-request`
   * `oozie`
   * `oozie-audit`
   * `oozie-error`
   * `oozie-instrumentation`
   * `oozie-jetty`
   * `oozie-jpa`
   * `oozie-ops`
   * `postgres`
   * `sqoop`: {{ dataproc-name }} clusters with [image version](../concepts/environment.md) below 2.0.
   * `supervisor`: {{ dataproc-name }} clusters with [image version](../concepts/environment.md) below 2.0.
   * `yandex-dataproc-agent`
   * `zeppelin`
   * `zookeeper`

* Data storage subcluster hosts:
   * `hadoop-hdfs-datanode`
   * `hadoop-yarn-nodemanager`

* Data processing subcluster hosts contain `hadoop-yarn-nodemanager` logs.

### Job logs {#jobs}

The following types of entries are added to job logs:

* Entries of YARN container logs.

  For the entry type, specify `containers`.

  The entries also have tags:
    * `yarn_log_type`: Name of the log file YARN saves as a container log.

       Examples:
         * `stdout`
         * `stderr`
         * `launch_container.sh`
         * `prelaunch.out`
         * `directory.info`
    * `container_id`: YARN container ID. Example: `container_1638976919626_0002_01_000001`.
    * `application_id`: YARN application ID. Example: `application_1638976919626_0002`.

* Log entries of the launching process output. They are saved if the job has been started via the {{ dataproc-name }} API rather than on cluster hosts.

  For the entry type, specify `job_output`.

  The entries contain the `job_id` tag with the job ID created via the {{ dataproc-name }} API. If the job started but was not completed at the validation stage, the entries contain the `application_id` tag.
