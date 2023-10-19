# Uploading {{ TF }} states to {{ objstorage-name }}

This guide describes the steps for uploading a {{ TF }} state to [{{ objstorage-full-name }}](../../storage/).

A {{ TF }} state describes the current deployed infrastructure and is stored in files with the `.tfstate` extension. The state file is created after the infrastructure is deployed and can be immediately uploaded to {{ objstorage-name }}. The uploaded state file is updated as the infrastructure you created changes.

In this example, the saved state allows other users to get the ID of one of the created [subnets](../../vpc/concepts/network.md#subnet) to connect a new [VM](../../compute/concepts/vm.md) to it.

To configure {{ TF }} state storage in {{ objstorage-name }} and use it to create new resources:

1. [Prepare your cloud](#before-you-begin).
1. [Required paid resources](#paid-resources).
1. [Install {{ TF }}](#install-terraform).
1. [Create a {{ TF }} configuration file](#configure-terraform).
1. [Configure a provider](#configure-provider).
1. [Create a service account and static access key](#create-service-account).
1. [Create a bucket](#create-service-account).
1. [Configure the backend](#set-up-backend).
1. [Deploy the configuration](#deploy).
1. [Check the saved state](#check-condition).
1. [Retrieve the state from the backend](#retrieve-state).

If you no longer need the resources you created, [delete them](#clear-out).

{{ TF }} and its providers are distributed under the [Business Source License](https://github.com/hashicorp/terraform/blob/main/LICENSE).

## Prepare your cloud {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

{% note alert %}

All resources created using {{ TF }} are chargeable. Make sure to check the configuration prior to creating any resources.

{% endnote %}

In this use case, you will create three VMs with public IP addresses, a virtual network, and two subnets.

The cost of supporting this infrastructure includes:
* Data storage fees (see [{{ objstorage-name }} pricing](../../storage/pricing.md#prices-storage)).
* Charge for the disks and continuously running VMs (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* Fee for using a dynamic public IP address (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).


## Install {{ TF }} {#install-terraform}

{% include [terraform-install](../../_tutorials/terraform-install.md) %}

## Create a {{ TF }} configuration file {#configure-terraform}

{% include [configure-terraform](../_tutorials_includes/configure-terraform.md) %}

## Configure a provider {#configure-provider}

{% include [terraform-configure-provider](../../_tutorials/terraform-configure-provider.md) %}

## Create a service account and static access key {#create-service-account}

1. [Create a service account](../../iam/operations/sa/create.md) with the [editor](../../iam/concepts/access-control/roles.md#editor) [role](../../iam/concepts/access-control/roles.md) for the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) specified in the provider settings.
1. [Get a static access key](../../iam/operations/sa/create-access-key.md). Save the key ID and secret key: you will need them in the next steps.

## Create a bucket {#create-service-account}

[Create a bucket](../../storage/operations/buckets/create.md) with restricted access. It stores the {{ TF }} state file.

## Configure the backend {#set-up-backend}

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

     backend "s3" {
       endpoint   = "{{ s3-storage-host }}"
       bucket     = "<bucket_name>"
       region     = "{{ region-id }}"
       key        = "<path_to_state_file_in_bucket>/<state_file_name>.tfstate"

       skip_region_validation      = true
       skip_credentials_validation = true
     }
   }

   provider "yandex" {
     token     = "<service_account_OAuth_or_static_key>"
     cloud_id  = "<cloud_ID>"
     folder_id = "<folder_ID>"
     zone      = "<default_availability_zone>"
   }
   ```



   To read more about the state storage backend, see the [{{ TF }} site](https://www.terraform.io/docs/backends/types/s3.html).

1. Run the following command in the folder with the configuration file:

   ```bash
   terraform init -backend-config="access_key=$ACCESS_KEY" -backend-config="secret_key=$SECRET_KEY"
   ```

{% include [deploy-infrastructure-step](../_tutorials_includes/deploy-infrastructure-step.md) %}

{% include [check-condition-step](../_tutorials_includes/check-condition-step.md) %}

## Retrieve the state from the backend {#retrieve-state}

You can request the {{ objstorage-name }} state saved in {{ TF }} from another configuration to expand the infrastructure you created.

Create another configuration and use the saved state to create another VM in one of the existing subnets:
1. Create the `remote-state` directory.
1. Go to the created directory and create the configuration file `remote-state.tf`:

   
   ```hcl
   terraform {
     required_providers {
       yandex = {
         source = "yandex-cloud/yandex"
       }
     }
   }

   provider "yandex" {
     token     = "<service_account_OAuth_or_static_key>"
     cloud_id  = "<cloud_ID>"
     folder_id = "<folder_ID>"
     zone      = "{{ region-id }}-a"
   }

   data "terraform_remote_state" "vpc" {
     backend = "s3"
     config = {
       endpoint   = "{{ s3-storage-host }}"
       bucket     = "<bucket_name>"
       region     = "{{ region-id }}"
       key        = "<path_to_state_file_in_bucket>/<state_file_name>.tfstate"

       skip_region_validation      = true
       skip_credentials_validation = true
     }
   }

   resource "yandex_compute_instance" "vm-3" {
     name = "terraform3"

     resources {
       cores  = 2
       memory = 2
     }

     boot_disk {
       initialize_params {
         image_id = "fd87va5cc00gaq2f5qfb"
       }
     }

     network_interface {
       subnet_id = data.terraform_remote_state.vpc.outputs.subnet-1
       nat       = true
     }

     metadata = {
       ssh-keys = "ubuntu:${file("~/.ssh/id_ed25519.pub")}"
     }
   }
   ```



1. Run the `terraform init` command.
1. Run the `terraform plan` command. The terminal will display the plan for creating the VM.
1. Run the `terraform apply` command.
1. Go to the management console and make sure you can see the `terraform3` instance in the {{ compute-name }} section.

## Delete the resources you created {#clear-out}

To delete the resources you created, run the `terraform destroy` command; start with the second configuration, and then proceed to the first.

## See also {#see-also}


* [{#T}](../../tutorials/infrastructure-management/terraform-state-lock.md)

