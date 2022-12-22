# Logs in {{ dataproc-name }}

{{ dataproc-name }} cluster logs are collected and displayed by [{{ cloud-logging-full-name }}](../../logging/).

All log entries sent by the cluster contain [standard filtering parameters](../../logging/concepts/filter.md):

* `resource_type`: Always has the value `dataproc.cluster`.
* `resource_id`: The cluster ID.

{{ dataproc-name }} log entries also contain additional parameters:

* `hostname`: The FQDN of the host.
* `log_type`: The [type of entries](#log-types) in the cluster logs.

## Types of log entries {{ dataproc-name }} {#types}

### Logs of cluster components {#components}

Depending on the subcluster role, the following types of entries are used for logs of components:

* All cluster hosts:
   * `cloud-init`: {{ dataproc-name }} clusters with the [image version](../concepts/environment.md) of 2.0 or higher.
   * `salt-minion`: The initialization log of the {{ dataproc-name }} cluster service.
   * `syslog`: The system log.
   * `telegraf`: The log of sending {{ dataproc-name }} cluster metrics to [{{ monitoring-name }}](../../monitoring/).
   * `yandex-dataproc-start`: The log of service initialization for the {{ dataproc-name }} cluster.

* Managing hosts in the subcluster that have the `Master` role:
   * `flume`: The {{ dataproc-name }} clusters with the [image version](../concepts/environment.md) below 2.0.
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
   * `hive-webhcat-console`: The {{ dataproc-name }} clusters with the [image version](../concepts/environment.md) below 2.0.
   * `hive-webhcat-console-error`: The {{ dataproc-name }} clusters with the [image version](../concepts/environment.md) below 2.0.
   * `hive-webhcat`: The {{ dataproc-name }} clusters with the [image version](../concepts/environment.md) below 2.0.
   * `knox`: The {{ dataproc-name }} clusters with the [image version](../concepts/environment.md) below 2.0.
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
   * `sqoop`: The {{ dataproc-name }} clusters with the [image version](../concepts/environment.md) below 2.0.
   * `supervisor`: The {{ dataproc-name }} clusters with the [image version](../concepts/environment.md) below 2.0.
   * `yandex-dataproc-agent`.
   * `zeppelin`.
   * `ZooKeeper`.

* Hosts of `Data` subclusters:
   * `hadoop-hdfs-datanode`.
   * `hadoop-yarn-nodemanager`.

* The `Compute` hosts in subclusters contain `hadoop-yarn-nodemanager` logs.

### Job logs {#jobs}

The following types of entries are added to job logs:

* Entries of YARN container logs.

  For the entry type, `containers` are specified.

  Tags are added to entries:
    * `yarn_log_type`: The name of the log file that YARN saves as a container log.

       Examples:
         * `stdout`
         * `stderr`
         * `launch_container.sh`
         * `prelaunch.out`
         * `directory.info`
    * `container_id`: The ID of the YARN container. Example: `container_1638976919626_0002_01_000001`.
    * `application_id`: The ID of the YARN application. Example: `application_1638976919626_0002`.

* Log entries of the launching process output. Saved if the job has been started via the {{ dataproc-name }} API rather than on cluster hosts.

  For the entry type, specify `job_output`.

  Entries contain the `job_id` tag with the job ID created via the {{ dataproc-name }} API. If the job started, but hasn't been completed at the validation stage, the entries include the `application_id` tag.
