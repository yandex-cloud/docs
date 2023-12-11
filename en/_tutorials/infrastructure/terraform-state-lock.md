---
title: "Locking {{ TF }} states"
description: "When using {{ TF }} in the cloud, you need to ensure that multiple users cannot modify the infrastructure at the same time. This is what {{ TF }} state locking is used for."
---

# Locking {{ TF }} states using {{ ydb-name }}

{{ yandex-cloud }} supports [infrastructure management through {{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md). To allow multiple users to manage the infrastructure, you can [automatically upload the {{ TF }} states and store them in {{ objstorage-full-name }}](../../tutorials/infrastructure-management/terraform-state-storage.md).

When multiple users try to access the same state from {{ objstorage-name }}, this may lead to conflicts. To prevent such conflicts, you can deploy a database in [{{ ydb-full-name }}](../../ydb/) and use it to implement {{ TF }}'s native state locking mechanism. Every time you use {{ TF }} to update the infrastructure, the state will be automatically locked until the update is applied.

To set up storing {{ TF }} states in {{ objstorage-name }} and locking them by {{ ydb-name }}:
1. [Prepare your cloud](#before-you-begin).
1. [Create a service account and static access key](#create-service-account).
1. [Create a bucket](#create-service-account).
1. [Create a {{ ydb-name }} database](#db-create).
1. [Create a table](#table-create).
1. [Install {{ TF }}](#install-terraform).
1. [Create a {{ TF }} configuration file](#configure-terraform).
1. [Configure a provider](#configure-provider).
1. [Configure the backend](#set-up-backend).
1. [Deploy the configuration](#deploy).
1. [Check the saved state](#check-condition).
1. [Check whether the state is locked](#check-state-lock).

If you no longer need the resources you created, [delete them](#clear-out).

{{ TF }} and its providers are distributed under the [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE).

## Prepare your cloud {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

The infrastructure support cost for {{ TF }} states includes:
* Data storage fees (see [{{ objstorage-name }} pricing](../../storage/pricing.md#prices-storage)).
* Fee for running queries to the database (see [{{ ydb-name }} pricing](../../ydb/pricing/serverless.md)).

The cost for supporting the infrastructure deployed through {{ TF }} in this sample scenario includes:
* Fee for a continuously running VM (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* Fee for using a dynamic external IP address (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).

If you deploy resources of other {{ yandex-cloud }} services, the cost will change according to the relevant service [plans](/prices).

## Create a service account and static access key {#create-service-account}

1. [Create a service account](../../iam/operations/sa/create.md) with the [storage.editor](../../iam/concepts/access-control/roles.md#storage-editor) and [ydb.admin](../../ydb/security/index.md#ydbadmin) [roles](../../iam/concepts/access-control/roles.md) for the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) specified in the provider settings.
1. [Get a static access key](../../iam/operations/sa/create-access-key.md). Save the key ID and secret key: you will need them at the next steps.

## Create a bucket {#create-service-account}

[Create a bucket](../../storage/operations/buckets/create.md) with restricted access. This bucket will store the {{ TF }} state file.

## Create a {{ ydb-name }} database {#db-create}

[Create](../../ydb/operations/manage-databases.md#create-db-serverless) a [Serverless](../../ydb/concepts/resources.md#serverless) [DB](../../ydb/concepts/resources.md#database) named `state-lock-db`:

### Create a table {#table-create}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where the database is located.
   1. In the list of services, select **{{ ydb-name }}**.
   1. In the DB list, select `state-lock-db`.
   1. Go to the **Navigation** tab.
   1. In the top-right corner, click **Create** and choose **Table**.
   1. Enter the table name: `state-lock-table`.
   1. In the table parameters, specify document table as **Table type**.
   1. Under **Columns**, specify:
      * **Name**: `LockID`.
      * **Type**: `String`.
      * **Partitioning key**: Enable this option by ticking the checkbox.

      Delete the other columns.
   1. Click **Create table**.

- AWS CLI

   To create a table through the [AWS CLI](../../storage/tools/aws-cli.md):
   1. Run this command:

      ```bash
      aws dynamodb create-table \
        --table-name <table_name> \
        --attribute-definitions \
          AttributeName=LockID,AttributeType=S \
        --key-schema \
          AttributeName=LockID,KeyType=HASH \
        --endpoint <document-api-endpoint_of_the_database>
      ```

      Where:
      * `--table-name`: [Table](../../ydb/concepts/dynamodb-tables.md) name.
      * `--attribute-definitions`: Column parameters:
         * `AttributeName`: Column name.
         * `AttributeType`: Data type. In our example, we use string data (`S`).
      * `--key-schema`: Key schema for the column:
         * `AttributeName`: Column name.
         * `KeyType`: Key type. In our example, we use a partitioning key (`HASH`).
      * `--endpoint`: Document API DB endpoint. You can find it on the database main page under **Document API endpoint**.

{% endlist %}

## Install {{ TF }} {#install-terraform}

{% include [terraform-install](../../_tutorials/terraform-install.md) %}

## Create a {{ TF }} configuration file {#configure-terraform}

{% include [configure-terraform](../_tutorials_includes/configure-terraform.md) %}

## Configure a provider {#configure-provider}

{% include [terraform-configure-provider](../../_tutorials/terraform-configure-provider.md) %}

## Configure the backend {#set-up-backend}

To save the {{ TF }} state in {{ objstorage-name }} and activate state locking:

1. Add the [previously obtained](#create-service-account) key ID and secret key to environment variables:

   {% list tabs %}

   - Bash

      ```bash
      export ACCESS_KEY="<key_ID>"
      export SECRET_KEY="<secret_key>"
      ```

   - PowerShell

      ```powershell
      $Env:ACCESS_KEY="<key_ID>"
      $Env:SECRET_KEY="<secret_key>"
      ```

   {% endlist %}

1. Add provider and backend settings to the configuration file:

   
   ```hcl
   terraform {
     required_providers {
       yandex = {
         source = "yandex-cloud/yandex"
       }
     }
     required_version = ">= 0.13"

     backend "s3" {
       endpoint          = "{{ s3-storage-host }}"
       bucket            = "<bucket_name>"
       region            = "{{ region-id }}"
       key               = "<path_to_state_file_in_bucket>/<state_file_name>.tfstate"
       dynamodb_endpoint = "<Document_API_DB_endpoint>"
       dynamodb_table    = "<table_name>"

       skip_region_validation      = true
       skip_credentials_validation = true
     }
   }

   provider "yandex" {
     zone = "<default_availability_zone>"
   }
   ```



   To read more about the state storage backend, see the [{{ TF }} site](https://www.terraform.io/docs/backends/types/s3.html).

1. Run the following command in the folder with the configuration file:

   ```bash
   terraform init -backend-config="access_key=$ACCESS_KEY" -backend-config="secret_key=$SECRET_KEY"
   ```

## Deploy the configuration {#deploy}

In this example, you will create a [VM](../../compute/concepts/vm.md) named `terraform-vm` that will be connected to the `subnet-1` [subnet](../../vpc/concepts/network.md#subnet) in the `{{ region-id }}-a` [availability zone](../../overview/concepts/geo-scope.md). This subnet will be in the `network-1` cloud [network](../../vpc/concepts/network.md#network).

The VM will have 2 vCPUs and 4 GB RAM. It will be automatically assigned a [public](../../vpc/concepts/address.md#public-addresses) and a [private IP address](../../vpc/concepts/address.md#internal-addresses) from the `192.168.10.0/24` range in `subnet-1`. The VM will run Ubuntu and host the public part of the key to enable SSH access.
1. Save the following configuration as a separate `example-vm.tf` file in the folder with the backend configuration file:

   
   ```hcl
   resource "yandex_compute_image" "ubuntu_2004" {
     source_family = "ubuntu-2004-lts"
   }

   resource "yandex_compute_instance" "vm-1" {
     name = "terraform-vm"

     resources {
       cores  = 2
       memory = 4
     }

     boot_disk {
       initialize_params {
         image_id = yandex_compute_image.ubuntu_2004.id
       }
     }

     network_interface {
       subnet_id = yandex_vpc_subnet.subnet-1.id
       nat       = true
     }

     metadata = {
       ssh-keys = "ubuntu:${file("~/.ssh/id_ed25519.pub")}"
     }
   }

   resource "yandex_vpc_network" "network-1" {
     name = "network1"
   }

   resource "yandex_vpc_subnet" "subnet-1" {
     name           = "subnet1"
     zone           = "{{ region-id }}-a"
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
1. Deploy the configuration using the `terraform apply` command.

{% include [check-condition-step](../_tutorials_includes/check-condition-step.md) %}

## Check the state lock {#check-state-lock}

Try to update the infrastructure concurrently with another user. If the lock mechanism works, {{ TF }} will return the following message after running `terraform apply`:

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
1. [Delete](../../ydb/operations/manage-databases.md#delete-db) the `state-lock-db` database.
1. [Delete](../../storage/operations/buckets/delete.md) the bucket.
