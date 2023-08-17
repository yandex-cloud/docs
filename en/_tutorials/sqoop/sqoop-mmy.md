# Importing data from {{ mmy-full-name }} to {{ dataproc-full-name }} using Sqoop

{% include [What is the Sqoop](./header.md) %}

## Getting started {#before-you-begin}

{% include [Same Network](../_tutorials_includes/note-same-network.md) %}

1. [Create a cloud network](../../vpc/operations/network-create.md).
1. [Create a subnet](../../vpc/operations/subnet-create.md) in the `{{ zone-id }}` availability zone.
1. [Set up an NAT gateway](../../vpc/operations/create-nat-gateway.md) for the new subnet: this is required for the {{ dataproc-name }} cluster operation.

You can create other resources manually or using {{ TF }}.

### Manually {#create-manual}

1. [Create an {{ mmy-name }} cluster](../../managed-mysql/operations/cluster-create.md) in any suitable [configuration](../../managed-mysql/concepts/instance-types.md) with the following settings:

   * A database named `db1`.
   * A user named `user1`.

1. To import the data to the {{ objstorage-name }} bucket:

   1. [Create a bucket](../../storage/operations/buckets/create.md) with restricted access.
   1. [Create a service account](../../iam/operations/sa/create.md).
   1. [Grant this service account](../../storage/operations/buckets/edit-acl.md) read and write permissions for this bucket.

1. [Create a {{ dataproc-name }} cluster](../../data-proc/operations/cluster-create.md) in any suitable [configuration](../../data-proc/concepts/instance-types.md).

   {% include [Settings for DataProc cluster](./data-proc-cluster-settings.md) %}

1. [Create a virtual machine](../../compute/operations/vm-create/create-linux-vm.md) to connect to {{ mmy-name }} and {{ dataproc-name }} clusters.

1. If you are using security groups for the clusters and the VM instance, configure them to allow connecting:

   * [To the VM instance and the {{ dataproc-name }} cluster](../../data-proc/operations/connect.md).
   * [To the {{ mmy-name }} cluster](../../managed-mysql/operations/connect.md#configure-security-groups).

   {% include [preview-pp.md](../../_includes/preview-pp.md) %}

### Using {{ TF }} {#create-terraform}

1. If you do not have {{ TF }} yet, [install it](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
1. Download [the file with provider settings](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/provider.tf). Place it in a separate working directory and [specify the parameter values](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider).
1. Download the [clusters-mysql-data-proc-and-vm.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/sqoop/clusters-mysql-data-proc-and-vm.tf) configuration file and save it to the same working directory.

   This file describes:

   * [Security groups](../../vpc/concepts/security-groups.md) for the clusters and VM.
   * [Service account](../../iam/concepts/users/service-accounts.md) for the {{ dataproc-name }} cluster.
   * [{{ objstorage-name }} bucket](../../storage/concepts/bucket.md).
   * {{ mmy-name }} cluster.
   * {{ dataproc-name }} cluster.
   * A virtual machine with public internet access.

1. Specify the infrastructure parameters in the `clusters-mysql-data-proc-and-vm.tf` configuration file under `locals`:

   * `folder_id`: [ID of the folder](../../resource-manager/operations/folder/get-id.md) to create resources in.
   * `network_id`: ID of the previously created cloud network.
   * `subnet_id`: ID of the previously created subnet.
   * `storage_sa_id`: ID of the service account to use for creating a bucket in {{ objstorage-name }}.
   * `data_proc_sa`: Name of the service account for the {{ dataproc-name }} cluster. The name must be unique within the folder.
   * `my_cluster_version`: {{ MY }} version of the {{ mmy-name }} cluster.
   * `my_cluster_password`: Password of the `user1` user of the `db1` {{ mmy-name }} database.
   * `vm_image_id`: ID of the public [image](../../compute/operations/images-with-pre-installed-software/get-list) with Ubuntu and no GPU, e.g., for [Ubuntu 20.04 LTS](/marketplace/products/yc/ubuntu-20-04-lts).
   * `vm_username` and `vm_public_key`: Username and absolute path to a [public SSH key](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) that will be used to access the virtual machine. By default, the specified username is ignored in the [Ubuntu 20.04 LTS](/marketplace/products/yc/ubuntu-20-04-lts) image. A user with the `ubuntu` username is created instead. Use it to connect to the instance.
   * `bucket_name`: {{ objstorage-name }} bucket name. The name must be unique within the entire {{ objstorage-name }}.
   * `dp_public_key`: Absolute path to a [public SSH key](../../data-proc/operations/connect.md#data-proc-ssh) for the {{ dataproc-name }} cluster.

      For an SSH connection to the hosts of {{ dataproc-name }} cluster version 1.x , use the `root` username.

1. Run the `terraform init` command in the directory with the configuration file. This command initializes the provider specified in the configuration files and enables you to use the provider's resources and data sources.
1. Make sure the {{ TF }} configuration files are correct using this command:

   ```bash
   terraform validate
   ```

   If there are any errors in the configuration files, {{ TF }} will point to them.

1. Create the required infrastructure:

   {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

## Preparing the source cluster {#prepare}

1. [Connect to the](../../managed-mysql/operations/connect.md) `db1` database of the {{ mmy-full-name }} cluster as `user1`.
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

To enable [database parallelism](https://sqoop.apache.org/docs/1.4.2/SqoopUserGuide.html#_controlling_parallelism), Sqoop lets you split imported data both by the primary key and other table columns. In the example, the data is split by the `age` column.

Let:

{% include [Shared settings](./shared-properties.md) %}
* {{ mmy-name }} cluster ID: `c9qgcd6lplrsjt9jhtuu`.

{% list tabs %}

* {{ objstorage-name }}

   1. [Complete all the prerequisite steps](../../data-proc/operations/sqoop-usage.md#object-storage).
   1. Run this command:

      ```bash
      sqoop import "-Dorg.apache.sqoop.splitter.allow_text_splitter=true" \
          --connect "jdbc:mysql://c-c9qgcd6lplrsjt9jhtuu.rw.{{ dns-zone }}:{{ port-mmy }}/db1" \
          --username "user1" \
          --P \
          --table "persons" \
          --target-dir "s3a://<bucket_name>/import-directory" \
          --split-by "age"
      ```

* HDFS directory

   1. [Complete all the prerequisite steps](../../data-proc/operations/sqoop-usage.md#hdfs).
   1. Run this command:

      ```bash
      sqoop import "-Dorg.apache.sqoop.splitter.allow_text_splitter=true" \
          --connect "jdbc:mysql://c-c9qgcd6lplrsjt9jhtuu.rw.{{ dns-zone }}:{{ port-mmy }}/db1" \
          --username "user1" \
          --table "persons" \
          --target-dir "import-directory" \
          --P \
          --split-by "age"
      ```

* Apache Hive

   1. [Complete all the prerequisite steps](../../data-proc/operations/sqoop-usage.md#apache-hive).
   1. Run this command:

      ```bash
      sqoop import "-Dorg.apache.sqoop.splitter.allow_text_splitter=true" \
          --connect "jdbc:mysql://c-c9qgcd6lplrsjt9jhtuu.rw.{{ dns-zone }}:{{ port-mmy }}/db1" \
          --username "user1" \
          --P \
          --table "persons" \
          --hive-import \
          --create-hive-table \
          --hive-database "db-hive" \
          --hive-table "import-table" \
          --split-by "age"
      ```

* Apache HBase

   1. [Complete all the prerequisite steps](../../data-proc/operations/sqoop-usage.md#apache-hbase).
   1. Run this command:

      ```bash
      sqoop import "-Dorg.apache.sqoop.splitter.allow_text_splitter=true" \
          --connect "jdbc:mysql://c-c9qgcd6lplrsjt9jhtuu.rw.{{ dns-zone }}:{{ port-mmy }}/db1" \
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

## Deletе created resources {#clear-out}

Some resources are not free of charge. To avoid paying for them, delete the resources you no longer need:

{% list tabs %}

* Manually

   1. [Delete the VM](../../compute/operations/vm-control/vm-delete.md).
   1. If you reserved a public static IP address for the VM, release and [delete it](../../vpc/operations/address-delete.md).
   1. Delete the clusters:

      * [{{ mmy-name }}](../../managed-mysql/operations/cluster-delete.md).
      * [{{ dataproc-name }}](../../data-proc/operations/cluster-delete.md).

   1. If you created an {{ objstorage-full-name }} bucket, [delete it](../../storage/operations/buckets/delete.md).
   1. Delete the [subnet](../../vpc/operations/subnet-delete.md).
   1. Delete the [cloud network](../../vpc/operations/network-delete.md).

* Using Terraform

   To delete the infrastructure created with {{ TF }}:

   1. In the terminal window, switch to the directory containing the infrastructure plan.
   1. Delete the `clusters-mysql-data-proc-and-vm.tf` configuration file.
   1. Make sure the {{ TF }} configuration files are correct using this command:

      ```bash
      terraform validate
      ```

      If there are any errors in the configuration files, {{ TF }} will point to them.

   1. Confirm the resources have been updated.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      This will delete all the resources described in `clusters-mysql-data-proc-and-vm.tf`.

   Delete the resources you created manually:

   1. [Subnet](../../vpc/operations/subnet-delete.md).
   1. [Cloud network](../../vpc/operations/network-delete.md).

{% endlist %}
