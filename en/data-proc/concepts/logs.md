# Logs in {{ dataproc-name }}

{{ dataproc-name }} cluster logs are collected and displayed by [{{ cloud-logging-full-name }}](../../logging/).

All log entries sent by the cluster contain [regular filtering parameters](../../logging/concepts/filter.md):

* `resource_type`: Always takes the `dataproc.cluster` value.
* `resource_id`: Cluster ID.

{{ dataproc-name }} log entries also contain additional parameters:

* `hostname`: Host FQDN.
* `log_type`: [Type of entries](#log-types) in cluster logs.

## Types of log entries {{ dataproc-name }} {#types}

### Cluster component logs {#components}

Depending on the subcluster role, the following types of entries are used for component logs:

* All cluster hosts:
   * `cloud-init`: {{ dataproc-name }} clusters with the [image version](../concepts/environment.md) of 2.0 or higher.
   * `salt-minion`: Initialization log of the {{ dataproc-name }} cluster service.
   * `syslog`: System log.
   * `telegraf`: Log of sending {{ dataproc-name }} cluster metrics to [{{ monitoring-name }}](../../monitoring/).
   * `yandex-dataproc-start`: Log of service initialization for the {{ dataproc-name }} cluster.

* Master host:
   * `flume`: {{ dataproc-name }} clusters with [image version](../concepts/environment.md) below 2.0.
   * `hadoop-hdfs-namenode`.
   * `hadoop-hdfs-secondarynamenode`.
   * `hadoop-mapreduce`.
   * `hadoop-yarn-resourcemanager`.
   * `hadoop-yarn-timelineserver`.
   * `hbase-master`.
   * `hbase-rest`.
   * `hbase-thrift`.
   * `hive-metastore`.
   * `hiveserver2`.
   * `hive-webhcat-console`: {{ dataproc-name }} clusters with [image version](../concepts/environment.md) below 2.0.
   * `hive-webhcat-console-error`: {{ dataproc-name }} clusters with [image version](../concepts/environment.md) below 2.0.
   * `hive-webhcat`: {{ dataproc-name }} clusters with [image version](../concepts/environment.md) below 2.0.
   * `knox`: {{ dataproc-name }} clusters with [image version](../concepts/environment.md) below 2.0.
   * `livy-out`.
   * `livy-request`.
   * `oozie`.
   * `oozie-audit`.
   * `oozie-error`.
   * `oozie-instrumentation`.
   * `oozie-jetty`.
   * `oozie-jpa`.
   * `oozie-ops`.
   * `postgres`.
   * `sqoop`: {{ dataproc-name }} clusters with [image version](../concepts/environment.md) below 2.0.
   * `supervisor`: {{ dataproc-name }} clusters with [image version](../concepts/environment.md) below 2.0.
   * `yandex-dataproc-agent`.
   * `zeppelin`.
   * `zookeeper`.

* Data storage subcluster hosts:
   * `hadoop-hdfs-datanode`.
   * `hadoop-yarn-nodemanager`.

* Data storage subcluster hosts contain `hadoop-yarn-nodemanager` logs.

### Job logs {#jobs}

The following types of entries are added to job logs:

* Entries of YARN container logs.

   The entry type is `containers`.

   The entries also have tags:
   * `yarn_log_type`: Name of the log file YARN saves as a container log.

      Examples:
      * `stdout`
      * `stderr`
      * `launch_container.sh`
      * `prelaunch.out`
      * `directory.info`
   * `container_id`: ID of the YARN container, e.g., `container_1638976919626_0002_01_000001`.
   * `application_id`: ID of the YARN application, e.g., `application_1638976919626_0002`.

* Log entries of the launching process output. They are saved if the job has been started via the {{ dataproc-name }} API rather than on cluster hosts.

   For the entry type, specify `job_output`.

   The entries contain the `job_id` tag with the job ID created via the {{ dataproc-name }} API. If the job started but has not been completed at the validation stage, the entries include the `application_id` tag.
