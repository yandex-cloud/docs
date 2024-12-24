# Importing data from {{ mpg-full-name }} to {{ dataproc-full-name }} using Sqoop


{% include [What is the Sqoop](./header.md) %}

## Getting started {#before-you-begin}

{% include [Same Network](../../_tutorials_includes/note-same-network.md) %}

1. [Create a cloud network](../../../vpc/operations/network-create.md).
1. [Create a subnet](../../../vpc/operations/subnet-create.md) in the `{{ zone-id }}` availability zone.
1. [Set up a NAT gateway](../../../vpc/operations/create-nat-gateway.md) for the new subnet: this is a prerequisite for the {{ dataproc-name }} cluster.

You can create other resources manually or using {{ TF }}.

### Manually {#create-manual}

1. [Create a {{ mpg-name }} cluster](../../../managed-postgresql/operations/cluster-create.md) in any suitable [configuration](../../../managed-postgresql/concepts/instance-types.md) with the following settings:

    * **{{ ui-key.yacloud.mdb.forms.database_field_name }}**: `db1`
    * **{{ ui-key.yacloud.mdb.forms.database_field_user-login }}**: `user1`

1. To import the data to the {{ objstorage-name }} bucket:

    1. [Create a bucket](../../../storage/operations/buckets/create.md) with restricted access.
    1. [Create a service account](../../../iam/operations/sa/create.md) with the following roles:

        * [dataproc.agent](../../../data-proc/security/index.md#dataproc-agent)
        * [dataproc.provisioner](../../../data-proc/security/index.md#dataproc-provisioner)
        * [{{ roles-monitoring-viewer }}](../../../monitoring/security/index.md#monitoring-viewer)
        * [storage.viewer](../../../storage/security/index.md#storage-viewer)
        * [storage.uploader](../../../storage/security/index.md#storage-uploader)

    1. [Grant this service account](../../../storage/operations/buckets/edit-acl.md) read and write permissions for this bucket.

1. [Create a {{ dataproc-name }} cluster](../../../data-proc/operations/cluster-create.md) in any suitable [configuration](../../../data-proc/concepts/instance-types.md).

    {% include [Settings for DataProc cluster](./data-processing-cluster-settings.md) %}

1. [Create a virtual machine](../../../compute/operations/vm-create/create-linux-vm.md) to connect to {{ mpg-name }} and {{ dataproc-name }} clusters.

1. If you are using security groups for the clusters and the VM instance, configure them to allow connecting:

    * [To the VM instance and the {{ dataproc-name }} cluster](../../../data-proc/operations/connect.md).
    * [To the {{ mpg-name }} cluster](../../../managed-postgresql/operations/connect.md#configuring-security-groups).

### Using {{ TF }} {#create-terraform}

1. {% include [terraform-install-without-setting](../../../_includes/mdb/terraform/install-without-setting.md) %}
1. {% include [terraform-authentication](../../../_includes/mdb/terraform/authentication.md) %}
1. {% include [terraform-setting](../../../_includes/mdb/terraform/setting.md) %}
1. {% include [terraform-configure-provider](../../../_includes/mdb/terraform/configure-provider.md) %}

1. Download the [clusters-postgresql-data-proc-and-vm.tf](https://github.com/yandex-cloud-examples/yc-data-proc-postgresql-data-import/blob/main/clusters-postgresql-data-proc-and-vm.tf) configuration file and save it to the same working directory.

    This file describes:

    * [Security groups](../../../vpc/concepts/security-groups.md) for the clusters and VM.
    * [Service account](../../../iam/concepts/users/service-accounts.md) for the {{ dataproc-name }} cluster.
    * [{{ objstorage-name }} bucket](../../../storage/concepts/bucket.md).
    * {{ mpg-name }} cluster.
    * {{ dataproc-name }} cluster.
    * Virtual machine with public internet access.

1. Specify the infrastructure parameters in the `clusters-postgresql-data-proc-and-vm.tf` configuration file under `locals`:

    * `folder_id`: [ID of the folder](../../../resource-manager/operations/folder/get-id.md) to create resources in.
    * `network_id`: ID of the cloud network you previously created.
    * `subnet_id`: ID of the previously created subnet.
    * `storage_sa_id`: ID of the service account to use for creating a bucket in {{ objstorage-name }}.
    * `data_proc_sa`: Name of the {{ dataproc-name }} cluster service account. The name must be unique within the folder.
    * `pg_cluster_version`: {{ PG }} version of the {{ mpg-name }} cluster.
    * `pg_cluster_password`: Password for `user1` in the {{ mpg-name }} database named `db1`.
    * `vm_image_id`: ID of the public [image](../../../compute/operations/images-with-pre-installed-software/get-list.md) with Ubuntu without GPU, e.g., for [Ubuntu 20.04 LTS](/marketplace/products/yc/ubuntu-20-04-lts).
    * `vm_username` and `vm_public_key`: Username and absolute path to the [public SSH key](../../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) to use to access the virtual machine. By default, the specified username is ignored in the [Ubuntu 20.04 LTS](/marketplace/products/yc/ubuntu-20-04-lts) image. A user with the `ubuntu` username is created instead. Use it to connect to the instance.
    * `bucket_name`: Bucket name in {{ objstorage-name }}. The name must be unique within the entire {{ objstorage-name }}.
    * `dp_public_key`: Absolute path to the [public SSH key](../../../data-proc/operations/connect.md#data-proc-ssh) for the {{ dataproc-name }} cluster.

        For an SSH connection to the hosts of a {{ dataproc-name }} cluster version 1.x , use the `root` username.

1. Check that the {{ TF }} configuration files are correct using this command:

    ```bash
    terraform validate
    ```

    If there are any errors in the configuration files, {{ TF }} will point them out.

1. Create the required infrastructure:

    {% include [terraform-apply](../../../_includes/mdb/terraform/apply.md) %}

    {% include [explore-resources](../../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

## Preparing the source cluster {#prepare}

1. [Connect to the {{ mpg-name }} cluster's database](../../../managed-postgresql/operations/connect.md) named `db1` as `user1`.
1. Add test data to the database. The example uses a simple table with people's names and ages:

    1. Create a table:

        ```sql
        CREATE TABLE persons (
            Name VARCHAR(30) NOT NULL,
            Age INTEGER DEFAULT 0,
            PRIMARY KEY (Name)
        );
        ```

    1. Populate the table with data:

        ```sql
        INSERT INTO persons (Name, Age) VALUES
            ('Anna', 19),
            ('Michael', 65),
            ('Fred', 28),
            ('Alsou', 50),
            ('Max', 27),
            ('John', 34),
            ('Dmitry', 42),
            ('Oleg', 19),
            ('Alina', 20),
            ('Maria', 28);
        ```

## Importing the database {#import}

To enable [database parallelism](https://sqoop.apache.org/docs/1.4.2/SqoopUserGuide.html#_controlling_parallelism), Sqoop allows you to split imported data not only by the primary key but also other table columns. In the example, the data is split by the `age` column.

Let's assume that:

{% include [Shared settings](./shared-properties.md) %}
* {{ mpg-name }} cluster ID: `c9qgcd6lplrs********`.

{% list tabs group=storage_system %}

- {{ objstorage-name }} {#storage}

    1. [Complete all the prerequisite steps](../../../data-proc/operations/sqoop-usage.md#object-storage).
    1. Run this command:

        ```bash
        sqoop import "-Dorg.apache.sqoop.splitter.allow_text_splitter=true" \
            --connect "jdbc:postgresql://c-c9qgcd6lplrs********.rw.{{ dns-zone }}:{{ port-mpg }}/db1" \
            --username "user1" \
            --P \
            --table "persons" \
            --target-dir "s3a://<bucket_name>/import-directory" \
            --split-by "age"
        ```

- HDFS directory {#hdfs}

    1. [Complete all the prerequisite steps](../../../data-proc/operations/sqoop-usage.md#hdfs).
    1. Run this command:

        ```bash
        sqoop import "-Dorg.apache.sqoop.splitter.allow_text_splitter=true" \
            --connect "jdbc:postgresql://c-c9qgcd6lplrs********.rw.{{ dns-zone }}:{{ port-mpg }}/db1" \
            --username "user1" \
            --table "persons" \
            --target-dir "import-directory" \
            --P \
            --split-by "age"
        ```

- Apache Hive {#hive}

    1. [Complete all the prerequisite steps](../../../data-proc/operations/sqoop-usage.md#apache-hive).
    1. Run this command:

        ```bash
        sqoop import "-Dorg.apache.sqoop.splitter.allow_text_splitter=true" \
            --connect "jdbc:postgresql://c-c9qgcd6lplrs********.rw.{{ dns-zone }}:{{ port-mpg }}/db1" \
            --username "user1" \
            --P \
            --table "persons" \
            --hive-import \
            --create-hive-table \
            --hive-database "db-hive" \
            --hive-table "import-table" \
            --split-by "age"
        ```

- Apache HBase {#hbase}

    1. [Complete all the prerequisite steps](../../../data-proc/operations/sqoop-usage.md#apache-hbase).
    1. Run this command:

        ```bash
        sqoop import "-Dorg.apache.sqoop.splitter.allow_text_splitter=true" \
            --connect "jdbc:postgresql://c-c9qgcd6lplrs********.rw.{{ dns-zone }}:{{ port-mpg }}/db1" \
            --username "user1" \
            --P \
            --table "persons" \
            --hbase-create-table \
            --column-family "family1" \
            --hbase-table "import-table" \
            --split-by "age"
        ```

{% endlist %}

## Verify the import {#check}

{% include [Check import](./check-import.md) %}

## Deleting the created resources {#clear-out}

Some resources are not free of charge. To avoid paying for them, delete the resources you no longer need:

{% list tabs group=instructions %}

- Manually {#manual}

    1. [Delete the VM](../../../compute/operations/vm-control/vm-delete.md).
    1. If you reserved a public static IP address for the VM, release and [delete it](../../../vpc/operations/address-delete.md).
    1. Delete the clusters:

        * [{{ mpg-name }}](../../../managed-postgresql/operations/cluster-delete.md).
        * [{{ dataproc-name }}](../../../data-proc/operations/cluster-delete.md).

    1. If you created a {{ objstorage-name }} bucket, [delete it](../../../storage/operations/buckets/delete.md).
    1. [Delete the subnet](../../../vpc/operations/subnet-delete.md).
    1. [Delete the route table](../../../vpc/operations/delete-route-table.md).
    1. [Delete the NAT gateway](../../../vpc/operations/delete-nat-gateway.md).
    1. [Delete the cloud network](../../../vpc/operations/network-delete.md).
    1. [Delete the service account](../../../iam/operations/sa/delete.md).

- {{ TF }} {#tf}

    To delete the infrastructure created with {{ TF }}:

    {% include [terraform-clear-out](../../../_includes/mdb/terraform/clear-out.md) %}

    Delete the resources you created manually:

    1. [Subnet](../../../vpc/operations/subnet-delete.md)
    1. [Route table](../../../vpc/operations/delete-route-table.md)
    1. [NAT gateway](../../../vpc/operations/delete-nat-gateway.md)
    1. [Cloud network](../../../vpc/operations/network-delete.md)

{% endlist %}
