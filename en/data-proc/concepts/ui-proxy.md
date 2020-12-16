# Data Proc component web interfaces {{ dataproc-name }}

Some {{ dataproc-name }} components, such as Hadoop, Spark, Yarn, and Zeppelin, have custom web interfaces that are available on the `MASTER` cluster node. These interfaces can be used:

* To manage and monitor cluster resources: YARN Resource Manager and HDFS Name Node.
* To view job statuses and debug jobs: Spark History and JobHistory.
* For collaboration, experiments, or ad-hoc operations: Apache Zeppelin.

For more information about the interfaces, see [Working with component network interfaces](./interfaces.md).

You can connect to the web interfaces of {{ dataproc-name }} components using either an [intermediate VM](./interfaces.md) or UI proxy. UI proxy is a mechanism that lets you proxy cluster component interfaces with HTTP traffic encryption and authentication via the {{ yandex-cloud }} IAM. To access the interfaces, the user must be logged into {{ yandex-cloud }}, have cluster view permissions and the `dataproc.user` role.

UI Proxy is disabled by default. To use it, enable it when creating or configuring a cluster.

Interfaces:

| Service | URL |
| ----- | ----- |
| HDFS Name Node | https://cluster-{cluster_id}.dataproc-ui.yandexcloud.net/gateway/default-topology/hdfs/ |
| YARN Resource Manager | https://cluster-{cluster_id}.dataproc-ui.yandexcloud.net/gateway/default-topology/yarn/ |
| Livy | https://cluster-{cluster_id}.dataproc-ui.yandexcloud.net/gateway/default-topology/livy/ |
| YARN Application History | https://cluster-{cluster_id}.dataproc-ui.yandexcloud.net/gateway/default-topology/jobhistory/ |
| Hive Server2 | https://cluster-{cluster_id}.dataproc-ui.yandexcloud.net/gateway/default-topology/hive/ |
| Zeppelin | https://cluster-{cluster_id}.dataproc-ui.yandexcloud.net/gateway/default-topology/zeppelin/ |
| Oozie | https://cluster-{cluster_id}.dataproc-ui.yandexcloud.net/gateway/default-topology/oozieui/ |