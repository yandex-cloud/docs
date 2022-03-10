# Emergency recovery to {{ yandex-cloud }} using Hystax Acura

You can protect your infrastructure using Hystax Acura. Hystax Disaster Recovery ensures your resources are backed up regardless of where they're located. They can be hosted in private data centers on virtual machines or physical servers, or they can be on virtual machines from a cloud service provider.

Supported platforms:

* Amazon Web Services.
* Google Cloud Platform.
* Microsoft Azure.
* Oracle Cloud.
* Alibaba Cloud.
* VMware.
* Hyper-V.
* OpenStack.
* Physical servers.

To perform disaster recovery, create an auxiliary VM with Hystax Acura in your cloud. This VM will set up and run your disaster recovery scenario. The recovery process is run by the auxiliary VM with Hystax Acura Cloud Agent. It restores your resources to {{ yandex-cloud }}. Once you start the process, replicas are created for deploying the infrastructure. Hystax Acura Cloud Agent also backs up the disaster recovery VM.

To run a disaster recovery scenario:

1. [Before you start](#before-begin).
1. [Required paid resources](#paid-resources).
1. [Create a service account and authorized key](#create-sa).
1. [Create a VM with Hystax Acura](#create-acura-vm).
1. [Set up Hystax Acura](#setup-hystax-acura).
1. [Set up the platform](#set-up-dr-flow).
1. [Prepare and install the agents for disaster recovery](#prepare-agent).
1. [Create a disaster recovery plan](#disaster-recovery-plan).
1. [Start disaster recovery](#start-dr).

## Before you start {#before-begin}

Before deploying the server, you need to sign up for {{ yandex-cloud }} and create a billing account:

{% include [prepare-register-billing](../_common/prepare-register-billing.md) %}

If you have an active billing account, you can create or select a folder to run your VM in from the [{{ yandex-cloud }} page](https://console.cloud.yandex.ru/cloud).

[Learn more about clouds and folders](../../../resource-manager/concepts/resources-hierarchy.md).

### Required paid resources {#paid-resources}

{% note info %}

Please note that the infrastructure for Hystax Acura and Hystax Acura Cloud Agent, as well as all migrated VMs, consume quotas and require payment.

* A Hystax Acura VM uses 4 vCPUs, 8 GB of RAM, and a 70 GB disk.
* A Hystax Acura Cloud Agent VM uses 2 vCPUs, 4 GB of RAM, and an 8 GB disk. A single Hystax Acura Cloud Agent VM can serve up to 6 replicated disks at the same time. If there are more than 6 disks, additional Hystax Acura Cloud Agent VMs are created automatically.

{% endnote %}

Resource costs for Hystax Acura and Hystax Acura Cloud Agent include:

* A fee for the disks and continuously running VMs (see [{{ compute-full-name }} pricing](../../../compute/pricing.md)).
* A fee for storing images (see [{{ compute-full-name }} pricing](../../../compute/pricing.md)).
* A fee for using a dynamic or static external IP address (see [{{ vpc-full-name }} pricing](../../../vpc/pricing.md)).

## Create a service account and authorized key {#create-sa}

[Create a service account](../../../iam/operations/sa/create.md) with the `editor` and `marketplace.meteringAgent` roles, and an [authorized key](../../../iam/operations/authorized-key/create.md). Save the service account ID, private key ID, and the private key. You'll need them when setting up Hystax Acura.

## Create a VM with Hystax Acura {#create-acura-vm}

Create a VM with a boot disk from an `acura` image:

{% list tabs %}

- CLI

   In the terminal, run the following command:

   ```
   $ yc compute instance create \
     --name hystax-acura-vm \
     --zone <availability zone> \
     --cores 4 \
     --memory 8 \ 
     --network-interface subnet-id=<subnet ID>,nat-ip-version=ipv4 \
     --create-boot-disk name=hystax-acura-disk,size=70,image-id=<Hystax Acura image ID> \
          --service-account-id <service account ID> \
     --ssh-key ~/.ssh/id_rsa.pub
   ```

{% endlist %}

## Set up Hystax Acura {#setup-hystax-acura}

1. Open the `hystax-acura-vm` VM page in the management console and find its public IP address.

1. Open the `hystax-acura-vm` VM public IP address in the browser. The Hystax Acura initial setup screen opens.

1. On the page that opens, fill in the following fields:
   - **Organization**: The name of your organization.
   - **Admin user login**: The email address for logging in to the Hystax Acura Control Panel.
   - **Password**: The administrator password.
   - **Confirm password**: Re-enter the administrator password.

1. Click **Next**.

1. Set up your {{ yandex-cloud }} connection parameters:
   - **Service Account id**: The ID of your service account.
   - **Key id**: The ID of the authorized key of your service account.
   - **Private Key**: The private part of the authorized key of your service account.
   - **Default Folder id**: The ID of your folder.
   - **zone**: Availability zone.
   - **Hystax Service Network id**: The ID of the subnet that the `hystax-acura-vm` virtual machine is connected to.
   - **Control Panel Public IP**: The public IP address to access the Hystax Control Panel. This field is populated by the VM public IP address by default, so leave it unchanged.

1. Click **Next**.

Hystax Acura automatically checks that it can access your cloud. If everything is correct, you can now log in to the Hystax Acura Control Panel using your email address and password.

## Configure the platform {#set-up-dr-flow}

Specify a platform for disaster recovery:

1. Open the Hystax Acura Control Panel. Click on the Hystax logo.

1. On the screen that opens, click **Add** and fill in the following fields:
   - **Company name**: The name of your company.
   - **Contact email**: Your email address.
   - **Cloud**: Select `Yandex Cloud`.
   - **Use custom replication agent settings**: Enabled.
   - **Replication agent endpoint IP**: The public IP address of the `hystax-acura-vm` virtual machine.
   - **Replication agent logging IP**: The public IP address of the `hystax-acura-vm` virtual machine.

   Click **Save**.

## Prepare and install the agents for disaster recovery {#prepare-agent}

Agents are installed on virtual machines to be recovered to {{ yandex-cloud }}. To download and install an agent:

1. In the Hystax Acura Control Panel, click the **Download agents** tab.

1. Select the source cloud platform for disaster recovery. Click **Next**.

1. Choose one out of three types of agents depending on the OS:
   - VMware.
   - Windows.
   - Linux.

   Click **Next**.

1. Download and install the agent on the VMs you would like to protect:

   {% list tabs %}

   - VMware

     1. Select **New VMware vSphere** and fill in the fields:
        - **Platform Name**: The name of the platform.
        - **Endpoint**: The public IP address of the ESXi host.
        - **Login**: The user's login (the user must have the Administrator permissions).
        - **Password**: The user's password.

         Click **Next**.

     1. Click **Download Agent** and wait for the agent to download.

     1. Unpack the downloaded OVA file with the agent on the ESXi host.

     1. Start the VMs with the agent.

   - Windows
     1. Click **Next**.
     1. Click **Download Agent** and wait for the agent to download.
     1. Unpack the archive and install the agent from the file `hwragent.msi` on the VMs you would like to migrate.

   - Linux

     1. Select the package type for your OS:
        - **CentOS/RHEL (.rpm package)**: For CentOS or Red Hat-based operating systems.
        - **Debian/Ubuntu (.deb package)**: For Ubuntu and Debian.

     1. Click **Next**.

     1. Upload the agent to the migrated VMs and install it:
        - For Debian and Ubuntu, run the command `dpkg -i <package path>`.
        - For CentOS and Red Hat-based OS, run the command `rpm -i <package path>`.

   {% endlist %}

## Create a disaster recovery plan {#disaster-recovery-plan}

To create a disaster recovery plan:

1. Open the Hystax Acura Control Panel. Click on the Hystax logo.

1. Under **Customers**, click a company you want to create a plan for.

1. Click **Add DR Plan**.

1. In the **Name** field, type: `YC Disaster Recovery`.

1. Select and configure one of the modes:
    - `Basic`: Create a plan with standard settings.
    - `Expert`: Create a plan with flexible settings based on a JSON script ([detailed syntax description](https://docs.hystax.com/dr_overview.html#dr-plan-syntax)).

1. Select all the VMs that you want to apply the disaster recovery plan to and specify the order they're initialized in.

    {% note warning %}

    Make sure that a valid IP address is specified for each VM.

    {% endnote %}

1. When the disaster recovery plan is created, the status of the selected VMs changes to **Protected**.

## Launching a disaster recovery scenario {#start-dr}

1. Open the Hystax Acura Control Panel. Click on the Hystax logo.
1. Under **Customers**, click a company you want to launch a disaster recovery plan for.
1. Select the disaster recovery plan you created in the previous step.
1. Click **Run recover**.
1. Check that the plan is up-to-date and correct.
1. Click **Next**.
1. In the window that opens, specify the time of the recovery point to create the VMs from.
1. Click **Run recover**.

Wait until the disaster recovery procedure is complete. Make sure the necessary resources migrated and all your applications are ready.

