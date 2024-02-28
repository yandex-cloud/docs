---
title: "Locking {{ TF }} states"
description: "When using {{ TF }} in the cloud, you need to ensure that multiple users cannot modify the infrastructure at the same time. This is what {{ TF }} state locking is used for."
---

# Locking {{ TF }} states using {{ ydb-name }}

{{ yandex-cloud }} supports [infrastructure management through {{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md). To allow multiple users to manage the infrastructure, you can [automatically upload the {{ TF }} states and store them in {{ objstorage-full-name }}](../../tutorials/infrastructure-management/terraform-state-storage.md).

When multiple users try to access the same state from {{ objstorage-name }} at the same time, conflicts may occur. To prevent such conflicts, you can deploy a database in [{{ ydb-full-name }}](../../ydb/) and use it to implement {{ TF }}'s native state locking mechanism. Every time you use {{ TF }} to update the infrastructure, the state will be automatically locked until the update is applied.

To set up storing {{ TF }} states in {{ objstorage-name }} and locking them by {{ ydb-name }}:
1. [Prepare your cloud](#before-you-begin).
1. [Create a service account and static access key](#create-service-account).
1. [Create a bucket](#create-service-account).
1. [Create a {{ ydb-name }} database](#db-create).
1. [Install and configure {{ TF }}](#prepare-terraform).
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

1. [Create a service account](../../iam/operations/sa/create.md) with the [storage.editor](../../storage/security/index.md#storage-editor) and [ydb.admin](../../ydb/security/index.md#ydbadmin) [roles](../../iam/concepts/access-control/roles.md) for the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) specified in the provider settings.
1. [Get a static access key](../../iam/operations/sa/create-access-key.md). Save the key ID and secret key: you will need them at the next steps.

## Create a bucket {#create-service-account}

[Create a bucket](../../storage/operations/buckets/create.md) with restricted access. This bucket will store the {{ TF }} state file.

## Create a {{ ydb-name }} database {#db-create}

[Create](../../ydb/operations/manage-databases.md#create-db-serverless) a [Serverless](../../ydb/concepts/resources.md#serverless) [DB](../../ydb/concepts/resources.md#database) named `state-lock-db`:

### Create a table {#table-create}

{% list tabs group=instructions %}

- Management console {#console}

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

## Install and configure {{ TF }} {#prepare-terraform}

### Install {{ TF }} {#install-terraform}


#### From a mirror {#from-yc-mirror}

You can download a {{ TF }} distribution for your platform from a [mirror]({{ terraform-mirror }}). When the download is complete, add the path to the folder with the executable to the `PATH` variable:

```bash
export PATH=$PATH:/path/to/terraform
```

#### From the Hashicorp website {#from-hashicorp-site}


{% list tabs group=operating_system %}

- Windows {#windows}

   Use one of the following methods:

   * [Download a {{ TF }} distribution](https://www.terraform.io/downloads.html) and follow [this guide](https://learn.hashicorp.com/tutorials/terraform/install-cli?in=terraform/aws-get-started) to install it.
   * Install {{ TF }} using the [Chocolatey](https://chocolatey.org/install) package manager and the command below:

      ```
      choco install terraform
      ```

- Linux {#linux}

   [Download a {{ TF }} distribution](https://www.terraform.io/downloads.html) and follow [this guide](https://learn.hashicorp.com/tutorials/terraform/install-cli?in=terraform/aws-get-started) to install it.

- macOS {#macos}

   Use one of the following methods:

   * [Download a {{ TF }} distribution](https://www.terraform.io/downloads.html) and follow [this guide](https://learn.hashicorp.com/tutorials/terraform/install-cli?in=terraform/aws-get-started) to install it.
   * Install {{ TF }} using the [Homebrew](https://brew.sh) package manager and the command below:

      ```
      brew install terraform
      ```

{% endlist %}

### Get the authentication credentials {#get-credentials}

Use a [service account](../../iam/concepts/users/service-accounts.md) to manage the {{ yandex-cloud }} infrastructure using {{ TF }}. It will help you to flexibly configure access rights for resources.

You can also access {{ TF }} from your [Yandex account](../../iam/concepts/index.md#passport),, or a [federated account](../../iam/concepts/index.md#saml-federation), but this method is less secure. For more information, see the end of this section.

1. If you do not have the {{ yandex-cloud }} command line interface, [install](../../cli/quickstart.md#install) it.

1. Set up the CLI profile to run operations on behalf of the service account:

   {% list tabs group=instructions %}

   - CLI {#cli}

      1. Create an [authorized key](../../iam/concepts/authorization/key.md) for your service account and save the file:

         ```bash
         yc iam key create \
           --service-account-id <service_account_ID> \
           --folder-name <name_of_folder_with_service_account> \
           --output key.json
         ```

         Where:
         * `service-account-id`: ID of your service account.
         * `folder-name`: Name of the folder the service account was created in.
         * `output`: Name of the file with the authorized key.

         Result:

         ```yaml
         id: aje8nn871qo4********
         service_account_id: ajehr0to1g8b********
         created_at: "2022-09-14T09:11:43.479156798Z"
         key_algorithm: RSA_2048
         ```

      1. Create a CLI profile to run operations on behalf of the service account. Name the profile:

         ```bash
         yc config profile create <profile_name>
         ```

         Result:

         ```text
         Profile 'sa-terraform' created and activated
         ```

      1. Set the profile configuration:

         ```bash
         yc config set service-account-key key.json
         yc config set cloud-id <cloud_ID>
         yc config set folder-id <folder_ID>
         ```

         Where:
         * `service-account-key`: File with the authorized key of the service account.
         * `cloud-id`: [Cloud ID](../../resource-manager/operations/cloud/get-id.md).
         * `folder-id`: [Folder ID](../../resource-manager/operations/folder/get-id.md).

   {% endlist %}

1. Add the credentials to the environment variables:

   {% include [terraform-token-variables](../../_includes/terraform-token-variables.md) %}


{% cut "Managing resources on behalf of a Yandex account or a federated account" %}

{% include [terraform-credentials-user](../../_tutorials/terraform-credentials-user.md) %}

{% endcut %}



### Create a {{ TF }} configuration file {#configure-terraform}

{% include [configure-terraform](../_tutorials_includes/configure-terraform.md) %}

### Configure a provider {#configure-provider}

{% include [terraform-configure-provider](../../_tutorials/terraform-configure-provider.md) %}

## Configure the backend {#set-up-backend}

{% note info %}

The backend settings apply to {{ TF }} `1.6.3` and higher.

{% endnote %}

To save the {{ TF }} state in {{ objstorage-name }} and activate state locking:

1. Add the [previously obtained](#create-service-account) key ID and secret key to environment variables:

   {% list tabs group=programming_language %}

   - Bash {#bash}

      ```bash
      export ACCESS_KEY="<key_ID>"
      export SECRET_KEY="<secret_key>"
      ```

   - PowerShell {#powershell}

      ```powershell
      $ACCESS_KEY="<key_ID>"
      $SECRET_KEY="<secret_key>"
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
       endpoints = {
         s3       = "https://{{ s3-storage-host }}"
         dynamodb = "<Document_API_DB_endpoint>"

       bucket            = "<bucket_name>"
       region            = "{{ region-id }}"
       key               = "<path_to_state_file_in_bucket>/<state_file_name>.tfstate"

       dynamodb_table = "<table_name>"

       skip_region_validation      = true
       skip_credentials_validation = true
       skip_requesting_account_id  = true # This option is required for {{ TF }} 1.6.1 or higher.
       skip_s3_checksum            = true # This option is required to describe backend for {{ TF }} version 1.6.3 or higher.
     }
   }

   provider "yandex" {
     zone = "<default_availability_zone>"
   }
   ```



   Where:

   * `bucket`: Bucket name.
   * `dynamodb`: Document API DB in `https://docapi.serverless.yandexcloud.net/{{ region-id }}/b1gia87mbaom********` format.
   * `key`: Object key in the bucket (name and path to the {{ TF }} state file in the bucket).
   * `dynamodb_table`: Table name.

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

   resource "yandex_compute_disk" "boot-disk" {
     name     = "boot-disk"
     type     = "network-hdd"
     zone     = "{{ region-id }}-a"
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
       user-data = "#cloud-config\nusers:\n  - name: <username>\n    groups: sudo\n    shell: /bin/bash\n    sudo: 'ALL=(ALL) NOPASSWD:ALL'\n    ssh-authorized-keys:\n      - ${file("<path_to_public_SSH_key>")}"
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



   Where:
   * `vm_user`: VM username.
   * `ssh_key_path`: Path to the file with a public SSH key to authenticate the user on the VM. For more information, see [{#T}](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys).
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

## See also {#see-also}

* [Getting started with {{ TF }}](../../tutorials/infrastructure-management/terraform-quickstart.md).
* [Uploading {{ TF }} states to {{ objstorage-name }}](../../tutorials/infrastructure-management/terraform-state-storage.md).
