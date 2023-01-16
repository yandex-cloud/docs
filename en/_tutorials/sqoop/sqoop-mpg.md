# Importing data from {{ mpg-full-name }} to {{ dataproc-full-name }} using Sqoop

{% include [What is the Sqoop](./header.md) %}

## Before you begin {#before-you-begin}

{% include [Same Network](../_tutorials_includes/note-same-network.md) %}

1. [Create a cloud network](../../vpc/operations/network-create.md).
1. [Create a subnet](../../vpc/operations/subnet-create.md) in the `{{ zone-id }}` availability zone.
1. [Set up an NAT gateway](../../vpc/operations/create-nat-gateway.md) for the new subnet: this is required for the {{ dataproc-name }} cluster operation.

You can create other resources manually or using {{ TF }}.

### Manually {#create-manual}

1. [Create an {{ mpg-name }} cluster](../../managed-postgresql/operations/cluster-create.md) in any suitable [configuration](../../managed-postgresql/concepts/instance-types.md) with the following settings:

   * A database named `db1`.
   * A user named `user1`.

1. To import the data to the {{ objstorage-name }} bucket:

   1. [Create a bucket](../../storage/operations/buckets/create.md).
   1. [Create a service account](../../iam/operations/sa/create.md).
   1. [Grant this service account](../../storage/operations/buckets/edit-acl.md) read and write permissions for this bucket.

1. [Create a {{ dataproc-name }} cluster](../../data-proc/operations/cluster-create.md) in any suitable [configuration](../../data-proc/concepts/instance-types.md).

   {% include [Settings for DataProc cluster](./data-proc-cluster-settings.md) %}

1. [Create a virtual machine](../../compute/operations/vm-create/create-linux-vm.md) to connect to {{ mpg-name }} and {{ dataproc-name }} clusters.

1. Set up security groups for the clusters and the VM instance to allow connecting:

   * [To the VM instance and the {{ dataproc-name }} cluster](../../data-proc/operations/connect.md).
   * [To the {{ mpg-name }} cluster](../../managed-postgresql/operations/connect.md#configuring-security-groups).

### Using {{ TF }} {#create-terraform}

1. If you don't have {{ TF }}, [install it](../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
1. Download [the file with provider settings](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/provider.tf). Place it in a separate working directory and [specify the parameter values](../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider).
1. Download the [clusters-postgresql-data-proc-and-vm.tf](https://github.com/yandex-cloud/examples/tree/master/tutorials/terraform/sqoop/clusters-postgresql-data-proc-and-vm.tf) configuration file and save it to the same working directory.

   This file describes:

   * [Security groups](../../vpc/concepts/security-groups.md) for the clusters and VM.
   * [Service account](../../iam/concepts/users/service-accounts.md) for the {{ dataproc-name }} cluster.
   * [{{ objstorage-name }} bucket](../../storage/concepts/bucket.md).
   * {{ mpg-name }} cluster.
   * {{ dataproc-name }} cluster.
   * A virtual machine with public internet access.

1. Specify the infrastructure parameters in the `clusters-postgresql-data-proc-and-vm.tf` configuration file under `locals`:

   * `folder_id`: [ID of the folder](../../resource-manager/operations/folder/get-id.md) to create resources in.
   * `network_id`: ID of the previously created cloud network.
   * `subnet_id`: ID of the previously created subnet.
   * `storage_sa_id`: ID of the service account to use for creating a bucket in {{ objstorage-name }}.
   * `data_proc_sa`: Name of the service account for the {{ dataproc-name }} cluster. The name must be unique within the folder.
   * `pg_cluster_version`: {{ PG }} version of the {{ mpg-name }} cluster.
   * `pg_cluster_password`: Password of the `user1` user of the `db1` {{ mpg-name }} database.
   * `vm_image_id`: ID of the public [image](../../compute/operations/images-with-pre-installed-software/get-list) with Ubuntu and no GPU. For example, for [Ubuntu 20.04 LTS](https://cloud.yandex.com/en/marketplace/products/yc/ubuntu-20-04-lts).
   * `vm_username` and `vm_public_key`: Username and absolute path to a [public SSH key](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) that will be used to access the virtual machine. By default, the specified username is ignored in the [Ubuntu 20.04 LTS](https://cloud.yandex.com/en/marketplace/products/yc/ubuntu-20-04-lts) image: a user with the `ubuntu` username is created instead. Use it to connect to the instance.
   * `bucket_name`: {{ objstorage-name }} bucket name. The name must be unique within the entire {{ objstorage-name }}.
   * `dp_public_key`: Absolute path to a [public SSH key](../../data-proc/operations/connect.md#data-proc-ssh) for the {{ dataproc-name }} cluster.

      For an SSH connection to the hosts of {{ dataproc-name }} cluster version 1.x , use the `root` username.

1. Run the command `terraform init` in the directory with the configuration file. This command initializes the provider specified in the configuration files and enables you to use the provider resources and data sources.
1. Make sure the {{ TF }} configuration files are correct using the command:

   ```bash
   terraform validate
   ```

   If there are errors in the configuration files, {{ TF }} will point to them.

1. Create the required infrastructure:

   {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

   {% include [explore-resources](../../_includes/mdb/terraform/explore-resources.md) %}

{% endlist %}

## Preparing the source cluster {#prepare}

1. [Connect to the](../../managed-postgresql/operations/connect.md) `db1` database of the {{ mpg-name }} cluster as `user1`.
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
* {{ mpg-name }} cluster ID: `c9qgcd6lplrsjt9jhtuu`.

{% list tabs %}

* {{ objstorage-name }}

   1. [Complete all the prerequisite steps](../../data-proc/operations/sqoop-usage.md#object-storage).
   1. Run the command:

      ```bash
      sqoop import "-Dorg.apache.sqoop.splitter.allow_text_splitter=true" \
          --connect "jdbc:postgresql://c-c9qgcd6lplrsjt9jhtuu.rw.{{ dns-zone }}:{{ port-mpg }}/db1" \
          --username "user1" \
          --P \
          --table "persons" \
          --target-dir "s3a://my-bucket/import-directory" \
          --split-by "age"
      ```

* HDFS directory

   1. [Complete all the prerequisite steps](../../data-proc/operations/sqoop-usage.md#hdfs).
   1. Run the command:

      ```bash
      sqoop import "-Dorg.apache.sqoop.splitter.allow_text_splitter=true" \
          --connect "jdbc:postgresql://c-c9qgcd6lplrsjt9jhtuu.rw.{{ dns-zone }}:{{ port-mpg }}/db1" \
          --username "user1" \
          --table "persons" \
          --target-dir "import-directory" \
          --P \
          --split-by "age"
      ```

* Apache Hive

   1. [Complete all the prerequisite steps](../../data-proc/operations/sqoop-usage.md#apache-hive).
   1. Run the command:

      ```bash
      sqoop import "-Dorg.apache.sqoop.splitter.allow_text_splitter=true" \
          --connect "jdbc:postgresql://c-c9qgcd6lplrsjt9jhtuu.rw.{{ dns-zone }}:{{ port-mpg }}/db1" \
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
   1. Run the command:

      ```bash
      sqoop import "-Dorg.apache.sqoop.splitter.allow_text_splitter=true" \
          --connect "jdbc:postgresql://c-c9qgcd6lplrsjt9jhtuu.rw.{{ dns-zone }}:{{ port-mpg }}/db1" \
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

## Delete created resources {#clear-out}

{% list tabs %}

* Manually

   If you no longer need these resources, delete them:

   1. [Delete the VM](../../compute/operations/vm-control/vm-delete.md).
   1. If you reserved a public static IP address for the VM, release and [delete it](../../vpc/operations/address-delete.md).
   1. Delete the clusters:

      * [{{ mpg-name }}](../../managed-postgresql/operations/cluster-delete.md);
      * [{{ dataproc-name }}](../../data-proc/operations/cluster-delete.md).

   1. If you created an {{ objstorage-name }} bucket, [delete it](../../storage/operations/buckets/delete.md).
   1. Delete the [subnet](../../vpc/operations/subnet-delete.md).
   1. Delete the [cloud network](../../vpc/operations/network-delete.md).

* Using Terraform

   To delete the infrastructure created with {{ TF }}:

   1. In the terminal window, change to the directory containing the infrastructure plan.
   1. Delete the `clusters-postgresql-data-proc-and-vm.tf` configuration file.
   1. Make sure the {{ TF }} configuration files are correct using the command:

      ```bash
      terraform validate
      ```

      If there are errors in the configuration files, {{ TF }} will point to them.

   1. Confirm the update of resources.

      {% include [terraform-apply](../../_includes/mdb/terraform/apply.md) %}

      This will delete all the resources described in `clusters-postgresql-data-proc-and-vm.tf`.

   Delete the resources you created manually:

   1. [Subnet](../../vpc/operations/subnet-delete.md).
   1. [Cloud network](../../vpc/operations/network-delete.md).

{% endlist %}
