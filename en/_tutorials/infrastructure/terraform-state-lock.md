# Locking {{ TF }} states using {{ ydb-full-name }}


{% include [terraform-ref-intro](../../_includes/terraform-ref-intro.md) %}

To allow multiple users to manage the infrastructure, you can [automatically upload {{ TF }} states and store them in {{ objstorage-full-name }}](../../tutorials/infrastructure-management/terraform-state-storage.md).

When multiple users simultaneously try to access one and the same state from {{ objstorage-name }}, this may lead to conflicts. To prevent such conflicts, you can deploy a database in [{{ ydb-full-name }}](../../ydb/) and use it to implement {{ TF }}'s native state locking mechanism. Every time you use {{ TF }} to update the infrastructure, the state will be automatically locked until the update is applied.

To set up storing {{ TF }} states in {{ objstorage-name }} and locking them with {{ ydb-name }}:
1. [Get your cloud ready](#before-you-begin).
1. [Create a service account and static access key](#create-service-account).
1. [Create a bucket](#create-service-account).
1. [Create a {{ ydb-name }} database](#db-create).
1. [Install and configure {{ TF }}](#prepare-terraform).
1. [Configure your backend](#set-up-backend).
1. [Deploy the configuration](#deploy).
1. [Check the saved state](#check-condition).
1. [Check whether the state is locked](#check-state-lock).

If you no longer need the resources you created, [delete them](#clear-out).

## Get your cloud ready {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

The infrastructure support cost for {{ TF }} states includes:
* Fees for data storage (see [{{ objstorage-name }} pricing](../../storage/pricing.md#prices-storage)).
* Fee for running queries against the database (see [{{ ydb-name }} pricing](../../ydb/pricing/serverless.md)).

The cost of support for the sample infrastructure deployed through {{ TF }} in this tutorial includes:
* Fee for a continuously running [VM](../../compute/concepts/vm.md) (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* Fee for a dynamic [public IP address](../../vpc/concepts/address.md#public-addresses) (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).

If you deploy resources from other {{ yandex-cloud }} services, the cost will change as per the respective service [plans](/prices).

## Create a service account and static access key {#create-service-account}

1. [Create a service account](../../iam/operations/sa/create.md) with the [storage.editor](../../storage/security/index.md#storage-editor) and [ydb.admin](../../ydb/security/index.md#ydbadmin) [roles](../../iam/concepts/access-control/roles.md) for the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) specified in the provider settings.
1. [Get a static access key](../../iam/operations/authentication/manage-access-keys.md#create-access-key). Save the key ID and secret key: you will need them later as you follow this tutorial.

## Create a bucket {#create-service-account}

[Create a bucket](../../storage/operations/buckets/create.md) with restricted access. This bucket will store the {{ TF }} state file.

## Create a {{ ydb-name }} database {#db-create}

[Create](../../ydb/operations/manage-databases.md#create-db-serverless) a [serverless](../../ydb/concepts/resources.md#serverless) [DB](../../ydb/concepts/resources.md#database) named `state-lock-db`.

### Create a table {#table-create}

{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where the database is located.
  1. From the list of services, select **{{ ydb-name }}**.
  1. From the DB list, select `state-lock-db`.
  1. Go the **Navigation** tab.
  1. In the top-right corner, click **Create** and select **Table**.
  1. Specify the table name: `state-lock-table`.
  1. In the table properties, opt for the document table as the **Table type**.
  1. Under **Columns**, specify:
     * **Name**: `LockID`.
     * **Type**: `String`.
     * **Partitioning key**: Enable this option by ticking the checkbox.

     Delete the other columns.
  1. Click **Create table**.

- AWS CLI {#cli}

  To create a table through the [AWS CLI](../../storage/tools/aws-cli.md):
  1. Run this command:

     ```bash
     aws dynamodb create-table \
       --table-name <table_name> \
       --attribute-definitions \
         AttributeName=LockID,AttributeType=S \
       --key-schema \
         AttributeName=LockID,KeyType=HASH \
       --endpoint <DB_document-api-endpoint>
     ```

     Where:
     * `--table-name`: [Table](../../ydb/concepts/dynamodb-tables.md) name
     * `--attribute-definitions`: Column properties:
       * `AttributeName`: Column name.
       * `AttributeType`: Data type. In our example, we are using string data (`S`).
     * `--key-schema`: Key schema for the column:
       * `AttributeName`: Column name.
       * `KeyType`: Key type. In our example, we are using a partitioning key (`HASH`).
     * `--endpoint`: Document API endpoint of the DB. You can find it on the database main page under **Document API endpoint**.

{% endlist %}

## Install and configure {{ TF }} {#prepare-terraform}

{% include notitle [terraform-prepare.md](../../_tutorials/infrastructure/terraform-prepare.md) %}

## Configure your backend {#set-up-backend}

{% note info %}

The following backend settings apply in {{ TF }} `1.6.3` and higher.

{% endnote %}

To save the {{ TF }} state in {{ objstorage-name }} and enable state locking:
1. Add the key ID and secret key [you got earlier](#create-service-account) to environment variables:

   {% list tabs group=programming_language %}

   - Bash {#bash}

     ```bash
     export ACCESS_KEY="<key_ID>"
     export SECRET_KEY="<secret_key>"
     ```

   - PowerShell {#powershell}

    ```powershell
    $Env:AWS_ACCESS_KEY_ID="<key_ID>"
    $Env:AWS_SECRET_ACCESS_KEY="<secret_key>"
    ```

   {% endlist %}

1. Add the provider and backend settings to the configuration file:

   ```hcl
   terraform {
     required_providers {
       yandex = {
         source = "yandex-cloud/yandex"
       }
     }
     required_version = ">= 0.13"

     backend "s3" {
       endpoints = {
         s3       = "https://{{ s3-storage-host }}"
         dynamodb = "<DB_Document_API_endpoint>"
       }
       bucket            = "<bucket_name>"
       region            = "{{ region-id }}"
       key               = "<path_to_state_file_in_bucket>/<state_file_name>.tfstate"

       dynamodb_table = "<table_name>"

       skip_region_validation      = true
       skip_credentials_validation = true
       skip_requesting_account_id  = true # This option is required for {{ TF }} 1.6.1 or higher.
       skip_s3_checksum            = true # This option is required to describe a backend for {{ TF }} 1.6.3 or higher.
     }
   }

   provider "yandex" {
     zone = "<default_availability_zone>"
   }
   ```

   Where:
   * `bucket`: [Bucket](../../storage/concepts/bucket.md) name.
   * `dynamodb`: Document API of the DB, formatted as `https://docapi.serverless.yandexcloud.net/{{ region-id }}/b1gia87mbaom********`.
   * `key`: Object key in the bucket (name and path to the {{ TF }} state file in the bucket).
   * `dynamodb_table`: Table name.

   To read more about the state storage backend, see the [{{ TF }} website](https://www.terraform.io/docs/backends/types/s3.html).
1. Run the following command in the folder with the configuration file:

    ```bash
    terraform init
    ```


## Deploy your configuration {#deploy}

In this example, you will create a VM named `terraform-vm` connected to [`subnet-1`](../../vpc/concepts/network.md#subnet) in the `{{ region-id }}-d` [availability zone](../../overview/concepts/geo-scope.md). This subnet will be part of the cloud [network](../../vpc/concepts/network.md#network) named `network-1`.

This VM instance will have 2 cores and 4 GB RAM. It will automatically get a public and [private IP addresses](../../vpc/concepts/address.md#internal-addresses) from the `192.168.10.0/24` range in `subnet-1`. The VM will run Ubuntu and host the public part of the key to enable SSH access.
1. Save the following configuration as a separate `example-vm.tf` file in the folder with the backend configuration file:

   ```hcl
   resource "yandex_compute_image" "ubuntu_2004" {
     source_family = "ubuntu-2004-lts"
   }

   resource "yandex_compute_disk" "boot-disk" {
     name     = "boot-disk"
     type     = "network-hdd"
     zone     = "{{ region-id }}-d"
     size     = "20"
     image_id = yandex_compute_image.ubuntu_2004.id
   }

   resource "yandex_compute_instance" "vm-1" {
     name = "terraform-vm"

     resources {
       cores  = 2
       memory = 4
     }

     boot_disk {
       disk_id = yandex_compute_disk.boot-disk.id
     }

     network_interface {
       subnet_id = yandex_vpc_subnet.subnet-1.id
       nat       = true
     }

     metadata = {
       user-data = "#cloud-config\nusers:\n  - name: <username>\n    groups: sudo\n    shell: /bin/bash\n    sudo: 'ALL=(ALL) NOPASSWD:ALL'\n    ssh_authorized_keys:\n      - ${file("<path_to_public_SSH_key>")}"
     }
   }

   resource "yandex_vpc_network" "network-1" {
     name = "network1"
   }

   resource "yandex_vpc_subnet" "subnet-1" {
     name           = "subnet1"
     zone           = "{{ region-id }}-d"
     network_id     = yandex_vpc_network.network-1.id
     v4_cidr_blocks = ["192.168.10.0/24"]
   }

   output "internal_ip_address_vm_1" {
     value = yandex_compute_instance.vm-1.network_interface.0.ip_address
   }

   output "external_ip_address_vm_1" {
     value = yandex_compute_instance.vm-1.network_interface.0.nat_ip_address
   }

   output "subnet-1" {
     value = yandex_vpc_subnet.subnet-1.id
   }
   ```

1. Check the configuration using the `terraform plan` command.
1. Deploy your configuration using the `terraform apply` command.

{% include [check-condition-step](../_tutorials_includes/check-condition-step.md) %}

## Test the state lock {#check-state-lock}

Try to update the infrastructure simultaneously with another user. If the lock mechanism works correctly, {{ TF }} will return the following message after running `terraform apply`:

```text
member Error: Error acquiring the state lock

member Error message: ConditionalCheckFailedException: Condition not satisfied
member Lock Info:
member   ID:        <...>
member   Path:      terraform-object-storage-tutorial/TF/cloud-storage.tfstate
member   Operation: OperationTypeApply
member   Who:       LD\user@i7293
member   Version:   1.4.2
member   Created:   <...>
member   Info:

member {{ TF }} acquires a state lock to protect the state from being written
member by multiple users at the same time. Please resolve the issue above and try
member again. For most commands, you can disable locking with the "-lock=false"
member flag, but this is not recommended.
```

## How to delete the resources you created {#clear-out}

If you no longer need the resources you created, delete them:
1. [Delete](../../ydb/operations/schema.md#drop-table) the table from the database.
1. [Delete](../../ydb/operations/manage-databases.md#delete-db) `state-lock-db`.
1. [Delete](../../storage/operations/buckets/delete.md) the bucket.

## See also {#see-also}

* [Getting started with {{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md).
* [Uploading {{ TF }} states to {{ objstorage-name }}](../../tutorials/infrastructure-management/terraform-state-storage.md).
* [Using {{ yandex-cloud }} modules in {{ TF }}](../../tutorials/infrastructure-management/terraform-modules.md).
* [{{ TF }} data sources](../../tutorials/infrastructure-management/terraform-data-sources.md).
