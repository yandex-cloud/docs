# Component interfaces and ports in {{ dataproc-name }}

Custom web interfaces of some {{ dataproc-name }} components, such as Hadoop, Spark, Yarn, and Zeppelin, are available on the master cluster host. These interfaces can be used:

* To manage and monitor cluster resources: YARN Resource Manager and HDFS Name Node.
* To view job statuses and debug jobs: Spark History and JobHistory.
* For collaboration, experiments, or ad-hoc operations: Apache Zeppelin.

{{ dataproc-name }} enables you to create clusters accessible from the internet or only from a cloud network. However, we recommend making service component interfaces inaccessible from outside {{ yandex-cloud }} in any configuration. You can connect to {{ dataproc-name }} component interfaces either using [UI Proxy](../operations/connect-interfaces.md#ui-proxy) or an [intermediate virtual machine](../operations/connect-interfaces.md#routing).

UI proxy is a mechanism that lets you proxy cluster component interfaces with HTTP traffic encryption and authentication via the {{ yandex-cloud }} IAM. To access the interfaces, the user must be logged into {{ yandex-cloud }}, have cluster view permissions and the `dataproc.user` role.

UI Proxy is disabled by default. To take advantage of UI Proxy, enable it when [creating](../operations/cluster-create.md#create) or [configuring](../operations/connect-interfaces.md#ui-proxy-enable) a cluster and [view](../operations/connect-interfaces.md#ui-proxy-list) a list of web interfaces available for connection.

{% note warning %}

You may need to additionally [set up security groups](../operations/connect.md#configuring-security-groups) to use UI Proxy (this feature is in the [Preview](../../overview/concepts/launch-stages.md) stage).

{% endnote %}

## Components and ports {#port-numbers}

{% include [ports-table](../../_includes/data-proc/ports-table.md) %}
