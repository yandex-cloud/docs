# Syncing MySQL data using {{ data-transfer-full-name }}

In this scenario, you'll learn how to ensure periodic delivery of changes from an external database to the cloud using {{ data-transfer-name }}. To synchronize data in your cloud, you need to create intermediate staging data storage, {{ mmy-name }}, to replicate tables to. The data is synchronized almost in real time.

To set up the transfer of changes:

1. [Prepare your cloud](#before-begin).
1. [Create a VM with an online store](#create-vm-mysql).
1. [Create staging storage](#create-staging-dwh).
1. [Configure the transfer parameters](#create-transfer).
1. [Monitor the transfer of changes in the DB in the cloud](#start-sync).

If you no longer need the resources you created, [delete them](#clear-out).

## Prepare your cloud {#before-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

Infrastructure costs for data transfers include:

1. Fee for continuously running VM (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
1. Fee for using a dynamic or a static public IP (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).
1. Fee for continuously running cluster {{ mmy-name }} (see [{{ mmy-name }} pricing](../../managed-mysql/pricing.md)).
1. Fee for {{ data-transfer-name }} (see [{{ data-transfer-name }} pricing](../../data-transfer/pricing)).


## Create a VM with an online store {#create-vm-mysql}

1. Create a VM with an online store named `web-store-vm` based on MySQL:

   {% list tabs %}

   - CLI

      Create a disk with a pre-configured public image of the VM with the online store:

      ```bash
      yc compute disk create \
         --name web-store-lab-dataplatform \
         --source-image-id fd8lcf21vlpfdhb84m2s \
         --folder-id <your-yc-folder-id>
      ```

      Create a virtual machine:

      ```bash
      yc compute instance create \
         --name magento \
         --zone {{ region-id }}-a \
         --network-interface subnet-name=default-{{ region-id }}-a,nat-ip-version=ipv4 \
         --hostname ya-sample-store \
         --use-boot-disk disk-name=web-store-lab-dataplatform \
         --ssh-key ~/.ssh/id_ed25519.pub
      ```

   {% endlist %}

1. In the security group settings, add permission for incoming and outgoing traffic from ports `80` and `443` and from MySQL port `3306`.

1. Connect to the VM via SSH:
   ```
   ssh yc-user@<VM's_public_IP_address>
   ```

1. Open the `hosts` (C:\Windows\System32\drivers\etc\hosts) file as an administrator and add the line:
   ```
   <ip-address-vm> ya-sample-store.local
   ```

1. Connect to the online store at `http://ya-sample-store.local/`.

1. You can view the schema of the online store using [DBeaver](https://dbeaver.com/).

## Create staging storage {#create-staging-dwh}

To replicate tables with information about online store orders, create a {{ mmy-name }} cluster:

1. In the [management console]({{ link-console-main }}), select the folder where you want to create a DB cluster.
1. Select **{{ mmy-name }}** and click **Create cluster**.
1. Specify a name for the cluster: `ya-sample-cloud-mysql`.
1. Select the host class: `s2.small`.
1. Under **Storage size**:

   * Select the storage type: `network-ssd`.
   * Select the volume: `32GB`.

1. Under **Database**, enter:

   * Enter the database name: `magento-cloud`.
   * Enter the `yc-user` username and `12345678` password.

1. Under **Network settings**, select the cloud network to host the cluster in and security groups for cluster network traffic.
1. Under **Hosts**, select the parameters for the DB hosts created with the cluster:

   * Availability zone: `{{ region-id }}-a`.
   * Subnet: `default-{{ region-id }}-a`.

1. Click **Create cluster**.
   For more information about creating clusters, see [Getting started with {{ mmy-short-name }}](../../managed-mysql/quickstart.md#cluster-create.md).

## Configure the transfer parameters {#create-transfer}

To synchronize the order information from the MySQL database of the website with the intermediate data storage hosted in the cloud, configure {{ data-transfer-name }}:

1. In the management console, select the folder where you want to create a configuration for the connection.
1. Select **{{ data-transfer-name }}** and click **Create endpoint**.
1. Define the parameters of the data source, that is, the VM of the online store with a MySQL instance running on it:

   * **Name**: `magento-source`.
   * Select the `MySQL` DB type from the list.
   * **Host IP**: <VM's_public_IP_address>.
   * **Database name**: `ya_sample_store`.
   * **Username** (`magento-svc`) and password (`m@gent0`).
   * In the whitelist, specify the prefixes of the tables to be replicated. For example, `sales_*`.
   * Click **Create**.

1. Define the parameters of the target database for the data: a managed {{ mmy-name }} database hosted in the cloud:

   * **Name**: `magento-report-dest`.
   * **Database**: `Managed Service for MySQL`.
   * Select the cluster ID from the list: `ya-sample-cloud-mysql`.
   * **Database name**: `magento-cloud`.
   * **Replication user's name** (`yc-user`) and password (`12345678`).
   * Select **Disable constraint checks**.
     In this case, if the data transfer sequence is violated, no error messages are returned.
   * Click **Create**.

1. Select **Transfers** in the menu and click **Create transfer**.
1. Define the transfer parameters:

   * **Name**: `sales-order-sync`.
   * Under **Source**, select the `magento-source` endpoint.
   * Under **Target**, select the `magento-report-dest` endpoint.
   * Under **Transfer type**, select `Copy and replicate`.
   * Click **Create**.
   * Click ![horizontal-ellipsis](../../_assets/console-icons/ellipsis.svg) in the line with the transfer description and select **Activate**.

   As a result, the initial synchronization of data schemas and other information is performed and, in the future, the data will be automatically synchronized when changes appear in the source database. For the synchronization status and error messages, see **Logs**.

1. Check that the database schemas appear in the staging storage:

   * Go to the **SQL** section of the `ya-sample-cloud-mysql` staging storage.
   * Enter the `yc-user` username and `12345678` password.
   * Select the `magento-cloud` database
   * Click **Connect**.

   The online store's database schema appears in the window.

## Monitor the transfer of changes to {{ yandex-cloud }} {#start-sync}

1. Create an order in the online store at `http://ya-sample-store.local/`.
1. Make a query to the database in the cloud:
   ```sql
   SELECT so.*, soi.* FROM sales_order_grid so
   INNER JOIN sales_order_item soi ON so.entity_id = soi.order_id
   ORDER BY entity_id DESC
   LIMIT 10
   ```
1. Make sure that your order data appeared in the database.

## How to delete the resources you created {#clear-out}

Delete the resources you no longer need to avoid paying for them:

* [Delete](../../compute/operations/vm-control/vm-delete.md) the `magento` VM.
* [Delete](../../managed-mysql/operations/cluster-delete.md) the `ya-sample-cloud-mysql` cluster.
* If you reserved a public static IP address, [delete it](../../vpc/operations/address-delete.md).
