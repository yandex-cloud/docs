# Getting started with {{ metastore-full-name }}

{% include notitle [preview](../../_includes/note-preview.md) %}

In {{ metadata-hub-name }} you can [create {{ metastore-full-name }} clusters](#create-metastore-cluster) и [use them](#connect-metastore-to-dataproc) to work with {{ dataproc-full-name }} clusters.

## Getting started {#before-you-begin}

1. Go to the [management console]({{ link-console-main }}) and log in to {{ yandex-cloud }} or create an account if you do not have one yet.

1. If you do not have a folder yet, create one:

   {% include [create-folder](../../_includes/create-folder.md) %}

1. [Set up a NAT gateway](../../vpc/operations/create-nat-gateway.md) in the subnet to host {{ metastore-name }} and {{ dataproc-name }} clusters.

1. [Create a security group](../../vpc/operations/security-group-create.md) for {{ metastore-name }} and {{ dataproc-name }} clusters.

1. [Add rules](../../vpc/operations/security-group-add-rule.md) for the {{ metastore-name }} cluster to the security group:

   * For incoming client traffic::

       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `30000-32767`.
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` (`Any`).
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.

   * For incoming load balancer traffic:

       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `10256`.
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` (`Any`).
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-balancer }}`.

1. Add rules for the {{ dataproc-name }} cluster to the security group:

   * One rule for inbound and another one for outbound service traffic:

       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `{{ port-any }}`.
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}`.
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**/**{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}`.
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-self }}`.

   * A separate rule for outgoing HTTPS traffic. This will allow you to use [{{ objstorage-full-name }}](../../storage/) [buckets](../../storage/concepts/bucket.md), [UI Proxy](../../data-proc/concepts/interfaces.md), and [autoscaling](../../data-proc/concepts/autoscaling.md) of {{ dataproc-name }} subclusters.

       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `{{ port-https }}`.
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.common.label_tcp }}`.
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.

   * Rule that allows access to NTP servers for time syncing:

       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `123`.
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.common.label_udp }}`.
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.

1. [Create a service account](../../iam/operations/sa/create.md#create-sa) for the {{ dataproc-name }} cluster with `dataproc.agent` and `dataproc.provisioner` roles.

1. [Create an {{ objstorage-name }} bucket](../../storage/operations/buckets/create.md) to use with the {{ dataproc-name }} cluster.

1. [Create a {{ dataproc-name }} cluster](../../data-proc/operations/cluster-create.md#create-cluster) in the previously created network. In the settings:
   * Choose `SPARK` and `YARN` services.
   * Specify the `spark:spark.sql.hive.metastore.sharedPrefixes` setting with the value `com.amazonaws,ru.yandex.cloud`.

## Create a {{ metastore-name }} cluster {#create-metastore-cluster}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the [management console]({{ link-console-main }}), select the folder you created.
    1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
    1. In the left-hand panel, select ![image](../../_assets/console-icons/database.svg) **{{ ui-key.yacloud.metastore.label_metastore }}**.
    1. Click **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
    1. Enter a name for the cluster. It must be unique within the folder.
    1. Under **{{ ui-key.yacloud.mdb.forms.section_network-settings }}**, select the network and subnet you created.
    1. Under **{{ ui-key.yacloud.mdb.forms.field_security-group }}**, specify the security group that you previously set up.
    1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

## Connect {{ metastore-name }} to the {{ dataproc-name }} cluster {#connect-metastore-to-dataproc}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the {{ dataproc-name }} cluster you previously created specify the following [property](../../data-proc/concepts/settings-list.md):

        ```text
        spark:spark.hive.metastore.uris : thrift://<{{ metastore-name }}_cluster_IP_address>:{{ port-metastore }}
        ```

       To find out the {{ metastore-name }} cluster IP address, select **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}** in the [management console]({{ link-console-main }}) and then select the ![image](../../_assets/console-icons/database.svg) **{{ ui-key.yacloud.metastore.label_metastore }}** page in the left-hand panel. You will see the cluster IP address under **{{ ui-key.yacloud.common.section-base }}**.

    1. Add the following rule for outgoing traffic to the security group:

        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}** — `{{ port-metastore }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` (`Any`).
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** — `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** — `0.0.0.0/0`.

{% endlist %}

## What's next {#what-is-next}

* [Work with tables using {{ metastore-name }}](../tutorials/sharing-tables.md).
* [Use {{ metastore-name }} to transfer data between {{ dataproc-name }} cluster](../tutorials/metastore-import.md).
* [Store table data in {{ metastore-name }} when working with {{ AF }}](../../data-proc/tutorials/airflow-automation.md).
* [Export or import Hive metadata in a {{ metastore-name}} cluster](../operations/metastore/export-and-import.md).
