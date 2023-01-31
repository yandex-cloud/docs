# Exporting audit logs to {{ mes-full-name }}

Create a trail to upload audit logs for a single cloud's resources to a {{ objstorage-full-name }} bucket. Then configure continuous log delivery to a {{ mes-full-name }} cluster.

The solution described in the tutorial follows the procedure below:
1. A [trail](../audit-trails/concepts/trail.md) uploads logs to a {{ objstorage-name }} bucket.
1. A [bucket](../storage/concepts/bucket.md) is mounted to a folder on the intermediate VM.
1. The intermediate VM runs a script that pulls logs from the bucket on a schedule and pushes them to the {{ mes-name }} cluster.

The following data required for log analysis is uploaded to the {{ mes-name }} cluster:
* A dashboard with use cases and statistics.
* A set of `Saved Queries` to search for security events.
* A set of `Detection Rules` with correlation rules for which alerts are preset.

All the [source files](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/auditlogs/export-auditlogs-to-ELK_k8s) for the solution are stored in the [{{ yandex-cloud }} Security Solution Library](https://github.com/yandex-cloud/yc-solution-library-for-security).

{% include [Yc-solution-library-for-security](../_includes/security-solution-library.md) %}

In addition to using the solution for your cloud logs, you can use it for organization or folder logs. To do this, create a trail by following the instructions for [organizations](../audit-trails/operations/export-organization-bucket.md) or [folders](../audit-trails/operations/export-folder-bucket.md), respectively.

To export audit logs:
1. [Before you start](#before-begin).
1. [Prepare the environment](#environment-preparing).
1. [Create a trail](#create-trail).
1. [Deploy a {{ ES }} cluster and intermediate VM](#create-cluster-vm).

If you no longer need these resources, [delete them](#clear-out).

## Before you begin {#before-begin}

{% include [before-you-begin](_tutorials_includes/before-you-begin.md) %}

{% include [cli-install](../_includes/cli-install.md) %}

Some steps are completed in [{{ TF }}](https://www.terraform.io/intro). If you don't have {{ TF }}, [install it and configure the {{ yandex-cloud }} provider](../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

Some {{ yandex-cloud }} features described in this tutorial are at the [Preview](../overview/concepts/launch-stages.md) stage. [Request access to these features from the support team]({{ link-console-support }}/create-ticket):
* [{{ at-name }}](../audit-trails/).
* [Security groups](../vpc/concepts/security-groups.md).

### Required paid resources {#paid-resources}

The infrastructure support cost includes:
* A fee for computing resources and {{ ES }} cluster storage capacity in the `Platinum` edition (see [{{ mes-full-name }} pricing](../managed-elasticsearch/pricing.md)).
* A fee for the intermediate VM's computing resources and disk (see [{{ compute-full-name }} pricing](../compute/pricing.md)).
* A fee for storing the intermediate VM's Docker image in {{ container-registry-name }} (see [{{ container-registry-full-name }} pricing](../container-registry/pricing.md)).
* A fee for data storage in a bucket and operations with data (see [{{ objstorage-full-name }} pricing](../storage/pricing.md)).

## Prepare the environment {#environment-preparing}

### Create a new bucket to use for uploading audit logs {#create-backet}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create a [bucket](../storage/concepts/bucket.md).
   1. Select **{{ objstorage-name }}**.
   1. Click **Create bucket**.
   1. On the bucket creation page:
      1. Enter the bucket name following the [naming guidelines](../storage/concepts/bucket.md#naming), such as `trails-bucket`.
      1. Specify the maximum size of the bucket: **No limit**.
      1. Select the **Limited** [access](../storage/concepts/bucket.md#bucket-access) type.
      1. Select the [storage class](../storage/concepts/storage-class.md): **Standard**.
      1. Click **Create bucket** to complete the operation.

{% endlist %}

### Create a service account {#create-sa}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you wish to create a service account.
   1. Go to the **Service accounts** tab.
   1. Click **Create service account**.
   1. Enter a name for the service account, such as `trails-bucket`.
   1. Click **Create**.

- CLI

   To create a service account, run the command:

   ```bash
   yc iam service-account create --name <service_account_name>
   ```

   Where `name` is the service account name, such as `trails-sa`.

{% endlist %}

### Assign roles to the service account {#add-roles}

Assign the `audit-trails.viewer` and `storage.uploader` roles to the service account:

{% list tabs %}

- Management console

   1. The `storage.uploader` [role](../storage/security/index.md#storage-uploader) to the folder with a bucket:

      1. In the [management console]({{ link-console-main }}), select the folder containing your bucket.
      1. Go to the **Access bindings** tab.
      1. Click **Assign bindings**.
      1. In the **Configure access bindings** window, click **Select user**.
      1. Go to the **Service accounts** tab.
      1. Select the `trails-sa` service account.
      1. Click **Add role**.
      1. Select the `storage.uploader` role.
      1. Click **Save**.

   1. The `audit-trails.viewer` [role](../audit-trails/security/index.md#roles) to the cloud whose logs will be sent to the {{ ES }} cluster:

      1. In the [management console]({{ link-console-main }}), go to the appropriate cloud.
      1. Go to the **Access bindings** tab.
      1. Click **Assign bindings**.
      1. In the **Configure access bindings** window, click **Select user**.
      1. Go to the **Service accounts** tab.
      1. Select the `trails-sa` service account.
      1. Click **Add role**.
      1. Select the `audit-trails.viewer` role.
      1. Click **Save**.

- CLI

   1. Assign the `storage.uploader` [role](../storage/security/index.md#storage-uploader) to the folder with your bucket:

      ```bash
      yc resource-manager folder add-access-binding \
      --role storage.uploader \
      --id <folder_ID> \
      --service-account-id <trails-sa_service_account_ID>
      ```

      Where:
      * `role`: The role assigned.
      * `id`: The ID of the folder with the bucket.
      * `service-account-id`: The ID of your service account.

   1. Assign the `audit-trails.viewer` [role](../audit-trails/security/index.md#roles) to the cloud whose logs will be sent to the {{ ES }} cluster:

      ```bash
      yc resource-manager cloud add-access-binding \
      --role audit-trails.viewer \
      --id <cloud_ID> \
      --service-account-id <trails-sa_service_account_ID>
      ```

      Where:
      * `role`: The role assigned.
      * `id`: The ID of the cloud whose logs will be sent to the {{ ES }} cluster.
      * `service-account-id`: The ID of your service account.

{% endlist %}

### Check your roles {#check-roles}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the cloud to collect the audit logs from.
   1. Click the **Access bindings** tab.
   1. At the top right, select **Inherited roles** to display the roles inherited from the organization.
   1. Make sure that you have the following roles:
      * `iam.serviceAccounts.user` for the service account.
      * `audit-trails.editor` for the folder to host the trail.
      * `audit-trails.viewer` for the cloud whose audit logs will be collected.
      * `storage.viewer` for the bucket or the folder.

{% endlist %}

### Create a cloud network {#create-network}

If you don't have a [cloud network](../vpc/concepts/network.md), create one:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), go to the folder where you need to create a cloud network.
   1. In the list of services, select **{{ vpc-name }}**.
   1. Click **Create network**.
   1. Enter a network name, such as `trails-network`.
   1. Select the **Create subnets** option.
   1. Click **Create network**.

- CLI

   To create a cloud network, run the command:

   ```bash
   yc vpc network create --name <cloud_network_name>
   ```

   Where `name` is the name of your cloud network, like `trails-network`.

{% endlist %}

### Create subnets {#create-subnets}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder to create a subnet in.
   1. In the list of services, select **{{ vpc-name }}**.
   1. Select a cloud network, such as `trails-network`.
   1. Click **Add subnet**.
   1. Name the subnet, such as `trails-subnet-1`.
   1. Select an availability zone, such as `{{ region-id }}-a`.
   1. Enter the subnet CIDR: its IP address and mask (for example, `10.128.0.0/24`).
   1. Click **Create subnet**.
   1. Create two more subnets:
      * `trails-subnet-2` in the `{{ region-id }}-b` availability zone with the `10.129.0.0/24` subnet CIDR.
      * `trails-subnet-3` in the `{{ region-id }}-c` availability zone with the `10.130.0.0/24` subnet CIDR.

- CLI

   1. Get the name of the cloud network to create a subnet in:

      ```bash
      yc vpc network list --folder-id <folder_ID>
      ```

      Where `folder-id` is the ID of the folder where the cloud network is located.

      Result:

      ```text
      +----------------------+----------------+
      |          ID          |      NAME      |
      +----------------------+----------------+
      | enpavfmgapumnl7cqin8 | trails-network |
      +----------------------+----------------+
      ```

   1. Create a subnet:

      ```bash
      yc vpc subnet create \
      --name <subnet_name> \
      --folder-id <folder_ID> \
      --network-name <cloud_network_name> \
      --zone <availability_zone> \
      --range <subnet_CIDR>
      ```

      Where:
      * `name`: Name of the subnet, such as `trails-subnet-1`.
      * `folder-id`: ID of the folder where the cloud network is located.
      * `network-name`: Name of the cloud network, such as `trails-network`.
      * `zone`: Availability zone, for example `{{ region-id }}-a`.
      * `range`: Subnet CIDR, like `10.128.0.0/24`.
   1. Create two more subnets:
      * `trails-subnet-2` in the `{{ region-id }}-b` availability zone with the `10.129.0.0/24` subnet CIDR.
      * `trails-subnet-3` in the `{{ region-id }}-c` availability zone with the `10.130.0.0/24` subnet CIDR.

{% endlist %}

### Configure the subnet {#configure-subnet}

1. [Enable](../vpc/operations/create-nat-gateway.md) an NAT gateway for the subnet where the intermediate VM will be deployed.
1. Configure network traffic permissions in the [default security group](../vpc/concepts/security-groups.md#default-security-group). If a security group is unavailable, any incoming or outgoing traffic will be allowed for the {{ ES }} cluster.

   If a security group is available, [add](../vpc/operations/security-group-update.md#add-rule) to it the rules below:

   | Traffic<br>direction | Description | Port<br>range | Protocol | Source<br>type | Source/Purpose |
   --- | --- | --- | --- | --- | ---
   | Incoming | incoming-https | 443 | TCP | CIDR | 0.0.0.0/0 |
   | Incoming | incoming-9002 | 9200 | TCP | CIDR | 0.0.0.0/0 |

{% note info %}

You can also deploy the required environment using {{ TF }}. See a [sample configuration file](https://github.com/yandex-cloud/yc-solution-library-for-security/blob/master/auditlogs/export-auditlogs-to-ELK_main/terraform/example/main.tf).

{% endnote %}

## Create a trail {#create-trail}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you wish to host the trail.
   1. Select **{{ at-name }}**.
   1. Click **Create trail**.
   1. In the **Name** field, enter a name for the trail.
   1. Under **Filter**, set up the audit log scope:
      * **Resource**: Select `Cloud`.
      * **Cloud**: An automatically populated field showing the name of the cloud to host the trail.
      * **Folders**: Leave the default `all folders` value.
   1. Under **Destination**, set up the destination object:
      * **Destination**: `{{ objstorage-name }}`.
      * **Bucket**: Select the bucket where you want to upload audit logs, such as `trails-bucket`.
      * **Object prefix**: An optional parameter used in the [full name](../audit-trails/concepts/format.md#log-file-name) of the audit log file.
   1. Under **Service account**, select the service account that the trail will use to upload audit log files to the bucket, such as `trails-sa`.
   1. Click **Create**.

{% endlist %}

{% note warning %}

The solution will delete the audit logs from the bucket after they are exported to the {{ ES }} cluster.

To store the logs in the bucket and the {{ ES }} cluster simultaneously, create two trails for two buckets: one to store the logs and the other one to export them to the {{ ES }} cluster.

{% endnote %}

## Deploy a {{ ES }} cluster and intermediate VM {#create-cluster-vm}

{% list tabs %}

- {{ TF }}

1. Download a directory with [{{ TF }} modules](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/auditlogs/export-auditlogs-to-ELK_main/terraform/modules):
   * `yc-managed-elk` creates a {{ ES }} cluster and assigns a password to the `admin` user. Cluster parameters:
      * Number of hosts: Three, one in each availability zone.
      * [Host class](../managed-elasticsearch/concepts/instance-types.md#available-flavors): s2.medium.
      * Edition: `Platinum`.
      * Storage: network-hdd, 1 TB.
      * Number of index replicas: 2.
      * Policy for creating new indexes: [Rollover](https://www.elastic.co/guide/en/elasticsearch/reference/current/ilm-rollover.html) (new indexes are created once in 30 days or after reaching 50 GB). For more information, see [Recommendations for high data availability](https://github.com/yandex-cloud/yc-solution-library-for-security/blob/master/auditlogs/export-auditlogs-to-ELK_main/CONFIGURE-HA_RU.md).
   * `yc-elastic-trail`:
      * Creates a static access key for the service account to use JSON objects in the bucket and encrypt or decrypt secrets.
      * Creates an intermediate VM based on the `cr.yandex/sol/s3-elk-importer:latest` image with a script that transfers audit logs from the bucket to the {{ ES }} cluster.
      * Creates an SSH key pair and saves the private part to the disk and the public part to the VM.
      * Creates a {{ kms-short-name }} key.
      * Assigns the `kms.keys.encrypterDecrypter` role to the service account for the secret encryption key.
      * Encrypts secrets and passes them to a Docker container.
1. Create a file named `main.tf` and copy the following {{ TF }} configuration there:

   ```hcl
   terraform {
   required_providers {
       yandex = {
       source = "yandex-cloud/yandex"
       }
   }
   required_version = ">= 0.13"
   }

   provider "yandex" {
   token     = "<OAuth>"
   cloud_id  = "<cloud_ID>"
   folder_id = "<folder_ID>"
   }

   module "yc-managed-elk" {
   source     = "<path_to_yc-managed-elk_directory>"
   folder_id  = "<folder_ID>"
   subnet_ids = ["<ID_of_subnet_1>", "<ID_of_subnet_2>", "<ID_of_subnet_3>"]
   network_id = "<cloud_network_ID>"
   elk_edition = "platinum"
   elk_datanode_preset = "s2.medium"
   elk_datanode_disk_size = 1000
   elk_public_ip = false
   }

   module "yc-elastic-trail" {
   source          = "<path_to_yc-elastic-trail_directory>"
   folder_id       = "<folder_ID>"
   elk_credentials = module.yc-managed-elk.elk-pass
   elk_address     = module.yc-managed-elk.elk_fqdn
   bucket_name     = "<bucket_name>"
   bucket_folder   = "<bucket_log_prefix>"
   sa_id           = "<service_account_ID>"
   coi_subnet_id   = "<ID_of_subnet_1>"
   }

   output "elk-pass" {
   value     = module.yc-managed-elk.elk-pass
   sensitive = true
   }
   output "elk_fqdn" {
   value = module.yc-managed-elk.elk_fqdn
   }

   output "elk-user" {
   value = "admin"
   }
   ```

   Where:
   * `token`: [OAuth token](../iam/concepts/authorization/oauth-token.md).
   * `cloud_id`: Cloud ID.
   * `folder_id`: ID of the folder.
   * `source` in the `yc-managed-elk` module section: Path to the `yc-managed-elk` directory.
   * `source` in the `yc-elastic-trail` module section: Path to the `yc-elastic-trail` directory.
   * `subnet_ids`: IDs of the subnets that will host the {{ ES }} cluster, such as `trails-subnet-1`, `trails-subnet-2`, and `trails-subnet-3`.
   * `network_id`: ID of the cloud network that will host the {{ ES }} cluster, such as `trails-network`.
   * `elk_public_ip`: Set `true` if public access to the {{ ES }} cluster is required, or else, set `false`.
   * `bucket_name`: Name of the bucket to send audit logs to, such as `trails-bucket`.
   * `bucket_folder`: Prefix of audit logs in the bucket. Leave it empty if logs are written to the bucket's root directory.
   * `sa_id`: ID of the service account on whose behalf audit logs are transferred, such as `trails-sa`.
   * `coi_subnet_id`: ID of the subnet that will host the intermediate VM, such as `trails-subnet-1`.

1. Initiate {{ TF }}. In the terminal, go to the directory where you created the configuration file and run the command:

   ```bash
   terraform init
   ```

1. Make sure that the configuration files are correct:

   ```bash
   terraform plan
   ```

   If the configuration is described correctly, the terminal displays a list of created resources and their parameters. If the configuration contain errors, {{ TF }} will point them out.

1. Deploy cloud resources:

   ```bash
   terraform apply
   ```

1. Confirm resource creation: type `yes` in the terminal and press **Enter**.

   The command output will contain the parameters required to access the {{ ES }} cluster:
   * `elk_fqdn`: {{ ES }} cluster network address.
   * `elk-user`: {{ ES }} cluster user name.

   You can use the [management console]({{ link-console-main }}) to check the created resources.

1. Get the password to access the {{ ES }} cluster:

   ```bash
   terraform output elk-pass
   ```

{% endlist %}

To connect to the {{ ES }} cluster, type the cluster address in the browser and specify the username and password on the page that opens.

### Keep the infrastructure up-to-date {#actualization}

To use the latest version of the solution for exporting audit logs to your {{ ES }} cluster:

* Make sure you're using the current version of the intermediate VM's Docker container and the latest available version of the `cr.yandex/sol/s3-elk-importer:latest` image. You can update the Docker container in one of the following ways:
   * Delete the intermediate VM and create it again using {{ TF }}.
   * Stop and delete the `audit-trail-worker-*` Docker container on the intermediate VM, delete the `s3-elk-importer` image, and restart the intermediate VM. Once restarted, a new image is downloaded and a new container is created.
* Make sure the correlation rules and security event queries are up-to-date. To update the data in Kibana, run the `elk-updater` container:

   ```bash
   docker run \
       -it \
       --rm \
       -e ELASTIC_AUTH_USER='<{{ ES }}_cluster_user_name>' \
       -e ELASTIC_AUTH_PW='<{{ ES }}_cluster_access_password>' \
       -e KIBANA_SERVER='<{{ ES }}_cluster_network_address>' \
       --name elk-updater cr.yandex/sol/elk-updater:latest
   ```

   Where:
   * `ELASTIC_AUTH_USER` is the {{ ES }} cluster user name.
   * `ELASTIC_AUTH_PW` is the password to access the {{ ES }} cluster.
   * `KIBANA_SERVER` is the {{ ES }} cluster network address.

{% note tip %}

You can also check the [yandex-cloud/yc-solution-library-for-security](https://github.com/yandex-cloud/yc-solution-library-for-security/tree/master/auditlogs/export-auditlogs-to-ELK_main) repository for solution updates.

{% endnote %}

## How to delete created resources {#clear-out}

To stop paying for the resources created:

* Delete the resources created with {{ TF }}:

   ```bash
   terraform destroy
   ```

   Confirm resource deletion: type `yes` in the terminal and press **Enter**.

* [Delete](../storage/operations/buckets/delete.md) the respective bucket.
