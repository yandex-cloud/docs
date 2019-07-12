# Active Directory Deployment

This scenario provides an example of how to install Active Directory in Yandex.Сloud using Terraform. Terraform statuses are stored in Object Storage.

Once you install Active Directory, configure it. Read more about configuring AD [on the official website](https://docs.microsoft.com/en-us/windows-server/identity/ad-ds/active-directory-domain-services).

To deploy the Active Directory infrastructure:

1. [Create a service account, access keys, and authorized keys](#create-service-account)
1. [Prepare configurations for Terraform and Active Directory](#prepare-tf-and-ad)
1. [Initialize Terraform](#terraform-init)
1. [Define Terraform variables](#tfvars)
1. [Deploy the infrastructure](#terraform-plan)

## Before you start {#prepare}

1. Install the Yandex.Cloud [command line interface](../../cli/quickstart.md#install).
1. [Create](../../storage/operations/buckets/create.md) a bucket named Object Storage.

## 1. Create a service account and keys {#create-service-account}

To work with Object Storage and create resources in the cloud, you need to create a service account, access keys, and authorized keys.

1. Create a service account:

   ```
   $ yc iam service-account create --name ad-sa
   ```

1. Create access keys:

   ```
   $ yc iam access-key create --service-account-name ad-sa
   ```

   Save the `key_id` and `secret_key` field values as they will be used by Terraform to access Object Storage.

1. Create authorized keys and save them to file:

   ```
   $ yc iam key create --service-account-name ad-sa -o ad-sa.json
   ```

   This creates the `ad-sa.json` file. Specify the path in the Terraform configuration.

1. Get a list of service accounts and their IDs using the `yc iam service-account list` command. Assign the `ad-sa` service account the `editor` role in the folder where operations will be performed:

   ```
   $ yc resource-manager folder add-access-binding <folder_name> \ 
     --role editor \
     --subject serviceAccount:<service account ID>
   ```

## 2. Prepare configurations for Terraform and Active Directory {#prepare-tf-and-ad}

Clone the [repository](https://github.com/yandex-cloud/examples) with the examples.

The project contains the following files:

* **Terraform**:
   * `main.tf`: infrastructure configuration.
   * `variables.tf`: description of variables for the infrastructure configuration.
* **PowerShell**:
   * `bootstrap.ps1`: a PowerShell script run by cloudbase-init before the OS boots. The script creates a user and a task Windows Task Scheduler. The task will start a custom PowerShell script in the `deploy` attribute specified in the [VM metadata](../../compute/concepts/vm-metadata.md).
   * `deploy-forestroot.ps1`: a script to install the first domain controller.
   * `deploy-domaincontroller.ps1`: a script to install a domain controller.

## 3. Initialize Terraform {#terraform-init}

Go to the project directory and run the following command:

```
$ terraform init \
  -backend-config="endpoint=storage.yandexcloud.net" \
  -backend-config="region=us-east-1" \
  -backend-config="bucket=<bucket name>" \
  -backend-config="key=ad-sa.json" \
  -backend-config="access_key=<access key ID — key_id>" \
  -backend-config="secret_key=<secret key — secret_key>" \
  -backend-config="skip_region_validation=true" \
  -backend-config="skip_credentials_validation=true"
```

## 4. Define Terraform variables {#tfvars}

Create a file named `terraform.tfvars` and enter the following fields:

```
service_account_key_file = "<path to the file with the authorized key>"
cloud_id                 = "<cloud ID>"
folder_id                = "<folder ID>"

##########
# vpc
##########

vpc_name         = "ad-demo"
subnet_cidr      = "10.0.0.0/16"
zone_names       = ["ru-central1-a", "ru-central1-b", "ru-central1-c"]
zone_short_names = ["rc1a", "rc1b", "rc1c"]

##########
# instance
##########

name      = "ad"
number    = 9
user      = "<name of the Active Directory user>"
pass      = "<password of the Active Directory user>"
user_data = "powershell/bootstrap.ps1"

ad_smadminpass = "P@ssw0rd!1"
ad_domainname  = "mydomain.local"
ad_deploy_root = "powershell/deploy-forestroot.ps1"
ad_deploy_dc   = "powershell/deploy-domaincontroller.ps1"
```

The availability zones where VMs will be created are defined in the `zone_names` line and their short names in the `zone_short_names` line. If you need to create a VM in only two zones, enter the following:

```
zone_names       = ["ru-central1-a", "ru-central1-b"]
zone_short_names = ["rc1a", "rc1b"]
```

## 5. Deploy the infrastructure {#terraform-plan}

Run the command:

```
$ terraform plan
```

If the configuration and variables are set correctly, Terraform displays a list of created resources.

{% note alert %}

All resources created via Terraform are charged, therefore check the plan carefully.

{% endnote %}

If the configuration is correct, run the command:

```
$ terraform apply
```

Type `yes` in the terminal to confirm the creation of the infrastructure.

Deployment may take a long time. You can monitor the Active Directory installation process in the serial port output:

```
$ yc compute instance get-serial-port-output <VM name>
```

