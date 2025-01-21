# Getting started with {{ metastore-full-name }}

{% include notitle [preview](../../_includes/note-preview.md) %}

In {{ metadata-hub-name }}, you can [create {{ metastore-full-name }} clusters](#create-metastore-cluster) and [use them](#connect-metastore-to-dataproc) to work with {{ dataproc-full-name }} clusters.

## Getting started {#before-you-begin}

1. Go to the [management console]({{ link-console-main }}) and log in to {{ yandex-cloud }} or sign up if not signed up yet.

1. If you do not have a folder yet, create one:

   {% include [create-folder](../../_includes/create-folder.md) %}

1. To link your [service account](../../iam/concepts/users/service-accounts.md) to a {{ metastore-name }} cluster, [make sure](../../iam/operations/roles/get-assigned-roles.md) your {{ yandex-cloud }} account has the [iam.serviceAccounts.user](../../iam/security/index.md#iam-serviceAccounts-user) role or higher.

1. [Set up a NAT gateway](../../vpc/operations/create-nat-gateway.md) in the subnet to host {{ metastore-name }} and {{ dataproc-name }} clusters.

1. [Create a security group](../../vpc/operations/security-group-create.md) for {{ metastore-name }} and {{ dataproc-name }} clusters.

1. [Add](../../vpc/operations/security-group-add-rule.md) {{ metastore-name }} cluster rules to the security group:

   * For incoming client traffic:

       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `30000-32767`
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` (`Any`)
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`

   * For incoming load balancer traffic:

       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `10256`
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` (`Any`)
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-balancer }}`

1. Add {{ dataproc-name }} cluster rules to the security group:

   * One rule for inbound and another one for outbound service traffic:

       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-any }}`
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}`
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**/**{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-sg }}`
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-sg-type }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-sg-type-self }}`

   * A separate rule for outgoing HTTPS traffic to all addresses. This will allow you to use {{ objstorage-full-name }} [buckets](../../storage/concepts/bucket.md), [UI Proxy](../../data-proc/concepts/interfaces.md), and [autoscaling](../../data-proc/concepts/autoscaling.md) of {{ dataproc-name }} subclusters.

       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-https }}`
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`

   * Rule that allows access to NTP servers for time syncing:

       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `123`
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_udp }}`
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`
       * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`

1. [Create a service account](../../iam/operations/sa/create.md#create-sa) with the `dataproc.agent`, `dataproc.provisioner`, and `{{ roles.metastore.integrationProvider }}` roles.

1. [Create an {{ objstorage-name }} bucket](../../storage/operations/buckets/create.md) to interact with a {{ dataproc-name }} cluster.

1. In the network you created earlier, [create a {{ dataproc-name }}](../../data-proc/operations/cluster-create.md#create-cluster) cluster. In the settings, set:

   * `SPARK` and `YARN` services.
   * Service account you created earlier.
   * The `spark:spark.sql.hive.metastore.sharedPrefixes` property to `com.amazonaws,ru.yandex.cloud`. Required for PySpark jobs and integration with {{ metastore-name }}.
   * Bucket you created earlier.
   * Security group you configured earlier.

## Create a {{ metastore-name }} cluster {#create-metastore-cluster}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the management console, go to the folder you created earlier.
    1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}**.
    1. In the left-hand panel, select the ![image](../../_assets/console-icons/database.svg) **{{ ui-key.yacloud.metastore.label_metastore }}**.
    1. Click **{{ ui-key.yacloud.mdb.clusters.button_create }}**.
    1. Enter a name for the cluster. It must be unique within the folder.
    1. Select a [service account](../../iam/concepts/users/service-accounts.md) under which the {{ metastore-name }} cluster will interact with other {{ yandex-cloud }} services, or [create](../../iam/operations/sa/create.md) a new one.
    1. Under **{{ ui-key.yacloud.mdb.forms.section_network-settings }}**, select the network and subnet you created earlier. Specify the security group you configured previously.
    1. Optionally, under **{{ ui-key.yacloud.logging.label_title }}**, enable logging, select the minimum logging level, and specify the folder or [log group](../../logging/concepts/log-group.md).
    1. If required, enable protection of the cluster from accidental deletion by a user.
    1. Click **{{ ui-key.yacloud.common.create }}**.

{% endlist %}

## Connect the {{ metastore-name }} cluster to the {{ dataproc-name }} cluster {#connect-metastore-to-dataproc}

{% list tabs group=instructions %}

- Management console {#console}

    1. In the {{ dataproc-name }} cluster you created earlier, specify the following [property](../../data-proc/concepts/settings-list.md):

        ```text
        spark:spark.hive.metastore.uris : thrift://<{{ metastore-name }}_cluster_IP_address>:{{ port-metastore }}
        ```

        To find out the {{ metastore-name }} cluster IP address, select **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}** in the management console, then ![image](../../_assets/console-icons/database.svg) **{{ ui-key.yacloud.metastore.label_metastore }}** in the left-hand panel, and open the relevant cluster. You will see the cluster IP address under **{{ ui-key.yacloud.common.section-base }}**.

    1. Add the following outgoing traffic rule to the security group:

        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `{{ port-metastore }}`
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` (`Any`)
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`
        * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: `0.0.0.0/0`

{% endlist %}

## What's next {#what-is-next}

* [Work with tables using {{ metastore-name }}](../tutorials/sharing-tables.md).
* [Use {{ metastore-name }} to move data between {{ dataproc-name }} clusters](../tutorials/metastore-import.md).
* [Store tabular data in {{ metastore-name }} when using {{ AF }}](../../data-proc/tutorials/airflow-automation.md).
* [Export and import Hive metadata in a {{ metastore-name }} cluster](../operations/metastore/export-and-import.md).
