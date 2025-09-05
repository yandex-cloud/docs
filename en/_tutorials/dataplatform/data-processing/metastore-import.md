# Transferring metadata between {{ dataproc-name }} clusters using {{ metastore-name }}


You can transfer metadata between [{{ dataproc-full-name }} clusters](../../../data-proc/concepts/index.md) with the Hive DBMS. First, you need to export metadata from a cluster, then import it into a different one using [{{ metastore-full-name }}](../../../metadata-hub/concepts/metastore.md).

To transfer metadata between {{ dataproc-name }} clusters:

1. [Create a test table](#create-table).
1. [Export data](#export-data).
1. [Connect {{ dataproc-name }} to {{ metastore-name }}](#connect).
1. [Import data](#import-data).
1. [Check the result](#check-result).

If you no longer need the resources you created, [delete them](#clear-out).

{% note warning %}

{% include [connect-metastore-to-s3-with-policy](../../_tutorials_includes/metastore-to-s3-with-policy.md) %}

{% endnote %}

{% note info %}

{{ metastore-name }} is at the [Preview](../../../overview/concepts/launch-stages.md) stage.

{% endnote %}

## Required paid resources {#paid-resources}

The infrastructure support cost includes:

* Fee for the {{ dataproc-name }} cluster computing resources and storage (see [{{ dataproc-name }} pricing](../../../data-proc/pricing.md)).
* Fee for the {{ metastore-name }} cluster computing resources (see [{{ metadata-hub-full-name }} pricing](../../../metadata-hub/pricing.md#metastore)).
* Fee for data storage and operations in a bucket (see [{{ objstorage-full-name }} pricing](../../../storage/pricing.md)).
* Fee for NAT gateway usage and outbound traffic (see [{{ vpc-full-name }} pricing](../../../vpc/pricing.md#nat-gateways)).

## Getting started {#before-you-begin}

Set up your infrastructure:

{% list tabs group=instructions %}

- Manually {#manual}

    1. [Create a service account](../../../iam/operations/sa/create.md) named `dataproc-s3-sa` and assign it the `dataproc.agent`, `dataproc.provisioner`, `managed-metastore.integrationProvider`, and `storage.uploader` roles.
    1. In {{ objstorage-full-name }}, [create a bucket](../../../storage/operations/buckets/create.md) named `dataproc-bucket`. Grant the `READ and WRITE` permission for this bucket to the service account.
    1. [Create a cloud network](../../../vpc/operations/network-create.md) named `dataproc-network`.
    1. In this network, [create a subnet](../../../vpc/operations/subnet-create.md) named `dataproc-subnet`.
    1. [Set up a NAT gateway](../../../vpc/operations/create-nat-gateway.md) for the subnet you created.
    1. [Create a security group](../../../vpc/operations/security-group-create.md) named `dataproc-security-group` with the following rules:

        {% cut "Security group rules" %}

        #|
        || **Target service for the rule** | **Rule purpose** | **Rule settings** ||
        || {{ dataproc-name }} | For incoming service traffic.
        |
        * Port range: `{{ port-any }}`
        * Protocol: `Any`
        * Source: `Security group`
        * Security group: `Self` ||
        || {{ dataproc-name }} | For incoming traffic, to allow access to NTP servers for time syncing.
        |
        * Port range: `123`
        * Protocol: `UDP`
        * Source: `CIDR`
        * CIDR blocks: `0.0.0.0/0` ||
        || {{ dataproc-name }} | For incoming traffic, to connect from the internet via SSH to subcluster hosts with public access.
        |
        * Port range: `22`
        * Protocol: `TCP`
        * Source: `CIDR`
        * CIDR blocks: `0.0.0.0/0` ||
        || {{ metastore-name }} | For incoming client traffic.
        |
        * Port range: `30000-32767`
        * Protocol: `Any`
        * Source: `CIDR`
        * CIDR blocks: `0.0.0.0/0` ||
        || {{ metastore-name }} | For incoming load balancer traffic.
        |
        * Port range: `10256`
        * Protocol: `Any`
        * Source: `Load balancer health checks` ||
        || {{ dataproc-name }} | For outgoing service traffic.
        |
        * Port range: `{{ port-any }}`
        * Protocol: `Any`
        * Source: `Security group`
        * Security group: `Self` ||
        || {{ dataproc-name }} | For outgoing HTTPS traffic.
        |
        * Port range: `{{ port-https }}`
        * Protocol: `TCP`
        * Destination: `CIDR`
        * CIDR blocks: `0.0.0.0/0` ||
        || {{ dataproc-name }} | For outgoing traffic, to allow access to NTP servers for time syncing.
        |
        * Port range: `123`
        * Protocol: `UDP`
        * Source: `CIDR`
        * CIDR blocks: `0.0.0.0/0` ||
        || {{ dataproc-name }} | For outgoing traffic, to allow {{ dataproc-name }} cluster connections to {{ metastore-name }}.
        |
        * Port range: `{{ port-metastore }}`
        * Protocol: `Any`
        * Source: `CIDR`
        * CIDR blocks: `0.0.0.0/0` ||
        |#

        {% endcut %}

    1. [Create two {{ dataproc-name }} clusters](../../../data-proc/operations/cluster-create.md) named `dataproc-source` and `dataproc-target` with the following settings:

        * **{{ ui-key.yacloud.mdb.forms.base_field_environment }}**: `PRODUCTION`.
        * **{{ ui-key.yacloud.mdb.forms.config_field_services }}**:

            * `HDFS`
            * `HIVE`
            * `SPARK`
            * `YARN`
            * `ZEPPELIN`

        * **{{ ui-key.yacloud.mdb.forms.base_field_service-account }}**: `dataproc-s3-sa`.
        * **{{ ui-key.yacloud.mdb.forms.config_field_zone }}**: Zone where `dataproc-subnet` resides.
        * **{{ ui-key.yacloud.mdb.forms.config_field_properties }}**: `spark:spark.sql.hive.metastore.sharedPrefixes` with the `com.amazonaws,ru.yandex.cloud` value. It is required for PySpark jobs and integration with {{ metastore-name }}.
        * **{{ ui-key.yacloud.mdb.forms.config_field_bucket }}**: `dataproc-bucket`.
        * **{{ ui-key.yacloud.mdb.forms.config_field_network }}**: `dataproc-network`.
        * **{{ ui-key.yacloud.mdb.forms.field_security-group }}**: `dataproc-security-group`.
        * **{{ ui-key.yacloud.mdb.forms.config_field_ui_proxy }}**: Enabled.
        * **{{ ui-key.yacloud.mdb.forms.host_column_subnetwork }}** for the {{ dataproc-name }} subclusters: `dataproc-subnet`.
        * **{{ ui-key.yacloud.mdb.forms.field_assign-public-ip }}** for the master host: Enabled.

- {{ TF }} {#tf}

    1. {% include [terraform-install-without-setting](../../../_includes/mdb/terraform/install-without-setting.md) %}
    1. {% include [terraform-authentication](../../../_includes/mdb/terraform/authentication.md) %}
    1. {% include [terraform-setting](../../../_includes/mdb/terraform/setting.md) %}
    1. {% include [terraform-configure-provider](../../../_includes/mdb/terraform/configure-provider.md) %}
    1. Download the [metastore-import.tf](https://github.com/yandex-cloud-examples/yc-data-proc-metadata-import/blob/main/metastore-import.tf) configuration file to the same working directory.

        This file describes:

        * [Network](../../../vpc/concepts/network.md#network).
        * [NAT gateway](../../../vpc/concepts/gateways.md) and route table required for {{ dataproc-name }}.
        * [Subnet](../../../vpc/concepts/network.md#subnet).
        * [Security group](../../../vpc/concepts/security-groups.md) for {{ dataproc-name }} and {{ metastore-name }}.
        * [Service account](../../../iam/concepts/users/service-accounts.md) for the {{ dataproc-name }} cluster.
        * Service account required to create an {{ objstorage-name }} bucket.
        * [Static access key](../../../iam/concepts/authorization/access-key.md) to create a [{{ objstorage-full-name }}](../../../storage/concepts/bucket.md) bucket.
        * Bucket.
        * Two {{ dataproc-name }} clusters.

    1. Specify the following in the `metastore-import.tf` file:

        * `folder_id`: Cloud folder ID, same as in the provider settings.
        * `dp_ssh_key`: Absolute path to the public key for the {{ dataproc-name }} clusters. For more information, see [{#T}](../../../data-proc/operations/connect.md#data-proc-ssh).

    1. Make sure the {{ TF }} configuration files are correct using this command:

        ```bash
        terraform validate
        ```

        {{ TF }} will show any errors found in your configuration files.

    1. Create the required infrastructure:

        {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

        {% include [explore-resources](../../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

## Create a test table {#create-table}

In the `dataproc-source` cluster, create a test table named `countries`:

1. Navigate to the [folder dashboard]({{ link-console-main }}) and select **{{ ui-key.yacloud.iam.folder.dashboard.label_data-proc }}**.
1. Open the `dataproc-source` cluster page.
1. Click the **Zeppelin Web UI** link under **{{ ui-key.yacloud.mdb.cluster.overview.section_ui-proxy }}**.
1. Select **Notebook**, then select ![image](../../../_assets/console-icons/plus.svg) **Create new note**.
1. In the window that opens, specify the name for the note and click **Create**.
1. To run a PySpark job, paste a Python script into the input line:

    ```python
    %pyspark

    from pyspark.sql.types import *

    schema = StructType([StructField('Name', StringType(), True),
    StructField('Capital', StringType(), True),
    StructField('Area', IntegerType(), True),
    StructField('Population', IntegerType(), True)])

    df = spark.createDataFrame([('Australia', 'Canberra', 7686850, 19731984), ('Austria', 'Vienna', 83855, 7700000)], schema)
    df.write.mode("overwrite").option("path","s3a://dataproc-bucket/countries").saveAsTable("countries")
    ```

1. Click ![image](../../../_assets/console-icons/play.svg) **Run all paragraphs** and wait until the job is complete.
1. Replace the Python code in the input line with this SQL query:

    ```sql
    %sql

    SELECT * FROM countries;
    ```

1. Click ![image](../../../_assets/console-icons/play.svg) **Run all paragraphs**.

    Result:

    ```text
    |   Name    |  Capital |  Area   | Population |
    | --------- | -------- | ------- | ---------- |
    | Australia | Canberra | 7686850 | 19731984   |
    | Austria   | Vienna   | 83855   | 7700000    |
    ```

## Export data {#export-data}

To transfer data from one {{ dataproc-name }} cluster to another, back up the data in the `dataproc-source` cluster using `pg_dump`:

1. [Use SSH to connect](../../../data-proc/operations/connect.md#data-proc-ssh) to the `dataproc-source` cluster's master host:

    ```bash
    ssh ubuntu@<master_host_FQDN>
    ```

    [Learn how to get the FQDN](../../../data-proc/operations/connect.md#fqdn).

1. Create a backup and save it to the `metastore_dump.sql` file:

    ```bash
    pg_dump --data-only --schema public postgres://hive:hive-p2ssw0rd@localhost/metastore > metastore_dump.sql
    ```

1. Disconnect from the master host.
1. Download the `metastore_dump.sql` file to your local current directory:

    ```bash
    scp ubuntu@<master_host_FQDN>:metastore_dump.sql .
    ```

1. [Upload](../../../storage/operations/objects/upload.md#simple) the `metastore_dump.sql` file to the `dataproc-bucket` bucket.

## Connect {{ dataproc-name }} to {{ metastore-name }} {#connect}

1. [Create a {{ metastore-name }} cluster](../../../metadata-hub/operations/metastore/cluster-create.md) with the following parameters:

    * **{{ ui-key.yacloud.mdb.forms.base_field_service-account }}**: `dataproc-s3-sa`.
    * **{{ ui-key.yacloud.mdb.forms.label_network }}**: `dataproc-network`.
    * **{{ ui-key.yacloud.mdb.forms.network_field_subnetwork }}**: `dataproc-subnet`.
    * **{{ ui-key.yacloud.mdb.forms.field_security-group }}**: `dataproc-security-group`.

1. [Add](../../../data-proc/operations/cluster-update.md) to the `dataproc-target` cluster settings the `spark:spark.hive.metastore.uris` property with the following value: `thrift://<{{ metastore-name }}_cluster_IP_address>:{{ port-metastore }}`.

    To find out the {{ metastore-name }} cluster IP address, select **{{ ui-key.yacloud.iam.folder.dashboard.label_metadata-hub }}** in the management console and then select the ![image](../../../_assets/console-icons/database.svg) **{{ ui-key.yacloud.metastore.label_metastore }}** page in the left-hand panel. Copy the **{{ ui-key.yacloud.metastore.field_metastore-endpoint-ip }}** column value for the cluster in question.

## Import data {#import-data}

1. Open the {{ metastore-name }} cluster page.
1. Click ![image](../../../_assets/console-icons/arrow-down-to-square.svg) **{{ ui-key.yacloud.metastore.action_import }}**.
1. In the window that opens, specify the `dataproc-bucket` and the `metastore_dump.sql` file.
1. Click **{{ ui-key.yacloud.metastore.dialog.import-export.action_import }}**.
1. Wait for the import to complete. You can check the import status on the {{ metastore-name }} cluster page under ![image](../../../_assets/console-icons/list-check.svg) **{{ ui-key.yacloud.dataproc.switch_operations }}**.

## Check the result {#check-result}

1. Open the `dataproc-target` cluster page.
1. Click the **Zeppelin Web UI** link under **{{ ui-key.yacloud.mdb.cluster.overview.section_ui-proxy }}**.
1. Select **Notebook**, then select ![image](../../../_assets/console-icons/plus.svg) **Create new note**.
1. In the window that opens, specify the name for the note and click **Create**.
1. Run the following SQL query:

    ```sql
    %sql

    SELECT * FROM countries;
    ```

1. Click ![image](../../../_assets/console-icons/play.svg) **Run all paragraphs**.

    Result:

    ```text
    |   Name    |  Capital |  Area   | Population |
    | --------- | -------- | ------- | ---------- |
    | Australia | Canberra | 7686850 | 19731984   |
    | Austria   | Vienna   | 83855   | 7700000    |
    ```

The metadata from the `dataproc-source` cluster was successfully imported into the `dataproc-target` cluster.

## Delete the resources you created {#clear-out}

Some resources are not free of charge. Delete the resources you no longer need to avoid paying for them:

1. [Delete the {{ metastore-name }} cluster](../../../metadata-hub/operations/metastore/cluster-delete.md).
1. [Delete the objects](../../../storage/operations/objects/delete.md) from the bucket.
1. Delete other resources depending on how they were created:

    {% list tabs group=instructions %}

    - Manually {#manual}

        1. [{{ dataproc-name }} clusters](../../../data-proc/operations/cluster-delete.md).
        1. [{{ objstorage-name }} bucket](../../../storage/operations/buckets/delete.md).
        1. [Route table](../../../vpc/operations/delete-route-table.md).
        1. [NAT gateway](../../../vpc/operations/delete-nat-gateway.md).
        1. [Security group](../../../vpc/operations/security-group-delete.md).
        1. [Subnet](../../../vpc/operations/subnet-delete.md).
        1. [Network](../../../vpc/operations/network-delete.md).
        1. [Service account](../../../iam/operations/sa/delete.md).

    - {{ TF }} {#tf}

        {% include [terraform-clear-out](../../../_includes/mdb/terraform/clear-out.md) %}

    {% endlist %}
