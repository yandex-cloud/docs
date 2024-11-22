# Implementing a secure high-availability network infrastructure with a dedicated DMZ based on the Check Point NGFW


Follow this tutorial to deploy a high-availability fail-safe network infrastructure with a dedicated [DMZ](https://en.wikipedia.org/wiki/DMZ_(computing)) segment and comprehensive protection based on the [Check Point next-generation firewall](https://www.checkpoint.com/ru/cloudguard/cloud-network-security/iaas-public-cloud-security/).

The infrastructure elements are hosted in two [availability zones](../../overview/concepts/geo-scope.md) and grouped by purpose into individual [folders](../../resource-manager/concepts/resources-hierarchy.md#folder). This solution enables you to publish generally available web resources, such as front-end applications, in a DMZ that is isolated from the internal infrastructure and ensures security and high availability of the entire perimeter.

![image](../../_assets/tutorials/high-accessible-dmz.svg)

The solution has the following basic segments (folders):

* The **public** folder contains [{{ alb-name }}](../../application-load-balancer/) to enable public access from the internet to applications published in the DMZ.
* The **mgmt** folder is designed for hosting NGFWs and cloud infrastructure management resources. It includes two VMs with firewalls (fw-a and fw-b), a VM of the centralized firewall management server (mgmt-server), and a VM for accessing the VPN-based control segment (jump-vm).
* The **dmz** folder enables you to publish applications with public access from the internet.
* The **app** and **database** folders can be used to host the business logic of applications (in this tutorial, no VMs are placed there).

For more information, see the [project repository](https://github.com/yandex-cloud-examples/yc-dmz-with-high-available-ngfw/blob/main/README.md).

To deploy a secure high-availability network infrastructure with a dedicated DMZ based on the Check Point next-generation firewall:

1. [Prepare your cloud](#prepare-cloud).
1. [Prepare the environment](#prepare-environment).
1. [Deploy your resources](#create-resources).
1. [Set up firewall gateways](#configure-gateways).
1. [Enable the route-switcher module](#enable-route-switcher).
1. [Test the solution for performance and fault tolerance](#test-accessibility).

If you no longer need the resources you created, [delete them](#clear-out).

## Next-Generation Firewall {#ngfw}

A next-generation firewall is used for cloud network protection and segmentation with a dedicated DMZ for public-facing applications. [{{ marketplace-full-name }}]({{ link-cloud-marketplace }}?categories=security) offers multiple NGFW solutions.

This scenario deploys the [Check Point CloudGuard IaaS]({{ link-cloud-marketplace }}/products/checkpoint/cloudguard-iaas-firewall-tp-payg-m) solution offering the following features:

* Firewalling
* NAT
* Intrusion prevention
* Antivirus
* Bot protection 
* Application layer granular traffic control
* Session logging
* Centralized management with Check Point Security Management

In this guide, the Check Point CloudGuard IaaS solution is configured with basic access control and NAT policies.

## Prepare your cloud {#prepare-cloud}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

The infrastructure support cost includes:

* Fee for continuously running VMs (see [{{ compute-full-name }}](../../compute/pricing.md) pricing).
* Fee for using {{ alb-name }} (see [{{ alb-full-name }}](../../application-load-balancer/pricing.md) pricing).
* Fee for using {{ network-load-balancer-name }} (see [{{ network-load-balancer-full-name }}](../../network-load-balancer/pricing.md) pricing).
* Fee for using public IP addresses and outgoing traffic (see [{{ vpc-full-name }}](../../vpc/pricing.md) pricing).
* Fee for using functions (see [{{ sf-full-name }}](../../functions/pricing.md) pricing).
* Fee for using the [CheckPoint NGFW](/marketplace/products/checkpoint/cloudguard-iaas-firewall-tp-payg-m).


### Required quotas {#required-quotes}

{% note warning %}

The tutorial involves deploying a resource-intensive infrastructure.

{% endnote %}

Make sure your cloud has sufficient [quotas](../../overview/concepts/quotas-limits.md) not being used by resources for other jobs.

{% cut "Amount of resources used by the tutorial" %}

   | Resource | Amount |
   | ----------- | ----------- |
   | Folders | 7 |
   | Instance groups | 1 |
   | Virtual machines | 6 |
   | VM vCPUs | 18 |
   | VM RAM | 30 GB |
   | Disks | 6 |
   | SSD size | 360 GB |
   | HDD size | 30 GB |
   | Cloud networks | 7 |
   | Subnets | 14 |
   | Route tables | 4 |
   | Security groups | 10 |
   | Static public IP addresses | 2 |
   | Public IP addresses | 2 |
   | Static routes | 17 |
   | Buckets | 1 |
   | Cloud functions | 1 |
   | Triggers for cloud functions | 1 |
   | Total RAM for all running functions | 128 MB |
   | Network load balancers (NLB) | 2 |
   | NLB target groups | 2 |
   | Application load balancers (ALB) | 1 |
   | ALB backend groups | 1 |
   | ALB target groups | 1 |

{% endcut %}

## Prepare the environment {#prepare-environment}

The tutorial uses Windows software and the [Windows Subsystem for Linux](https://en.wikipedia.org/wiki/Windows_Subsystem_for_Linux) (WSL).
The infrastructure is deployed using [{{ TF }}](https://www.terraform.io/).

### Configure WSL {#setup-wsl}

1. Check if WSL is installed on your PC. To do this, run the following command in the CLI terminal:

   ```bash
   wsl -l
   ```

   If WSL is installed, the terminal will display a list of available distributions, for example:

   ```bash
   Windows Subsystem for Linux Distributions:
   docker-desktop (Default)
   docker-desktop-data
   Ubuntu
   ```

1. If WSL is not installed, [install](https://learn.microsoft.com/en-us/windows/wsl/install) it and repeat the previous step.
1. In addition, you can install a familiar Linux distribution, e.g., [Ubuntu](https://ubuntu.com/tutorials/install-ubuntu-on-wsl2-on-windows-11-with-gui-support#1-overview), on top of WSL.
1. To make the installed distribution the default system, run this command:

   ```bash
   wsl --setdefault ubuntu
   ```

1. To switch the terminal to the Linux subsystem operation mode, run:

   ```bash
   wsl ~
   ```

{% note info %}

All steps described below are completed in the Linux terminal.

{% endnote %}

### Create a service account with the admin privileges for the cloud {#create-account}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create a service account.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
   1. Click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
   1. Enter a name for the service account, e.g., `sa-terraform`.

       The name format requirements are as follows:

       {% include [name-format](../../_includes/name-format.md) %}

       {% include [sa-uniq-name](../../_includes/iam/sa-uniq-name.md) %}

   1. Click **{{ ui-key.yacloud.iam.folder.service-account.popup-robot_button_add }}**.

   1. Assign the admin [role](../../iam/concepts/access-control/roles.md) to the service account.

       1. On the management console [home page]({{ link-console-main }}), select the cloud.
       1. Go to the **{{ ui-key.yacloud.common.resource-acl.label_access-bindings }}** tab.
       1. Click **{{ ui-key.yacloud.common.resource-acl.button_configure-access }}**.
       1. In the window that opens, select **{{ ui-key.yacloud_components.acl.label.service-accounts}}** and then select the `sa-terraform` service account.
       1. Click ![image](../../_assets/console-icons/plus.svg) **{{ ui-key.yacloud_components.acl.button.add-role }}** and select the `admin` role.
       1. Click **{{ ui-key.yacloud_components.acl.action.apply }}**.

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. Create a service account:

         ```bash
         yc iam service-account create --name sa-terraform
         ```

         Where `name` is the service account name. The naming requirements are as follows:

         {% include [name-format](../../_includes/name-format.md) %}

         Result:

         ```text
         id: ajehr0to1g8bh0la8c8r
         folder_id: b1gv87ssvu497lpgjh5o
         created_at: "2023-03-04T09:03:11.665153755Z"
         name: sa-terraform
         ```

   1. Assign the account the admin [role](../../iam/concepts/access-control/roles.md):

         ```bash
         yc resource-manager cloud add-access-binding <cloud_ID> \
           --role admin \
           --subject serviceAccount:<service_account_ID>
         ```

         Result:

         ```text
         done (1s)
         ```

- API

   To create a service account, use the [create](../../iam/api-ref/ServiceAccount/create.md) REST API method for the [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) resource or the [ServiceAccountService/Create](../../iam/api-ref/grpc/ServiceAccount/create.md) gRPC API call.

   {% include [grant-role-for-sa-to-folder-via-api](../../_includes/iam/grant-role-for-sa-to-folder-via-api.md) %}

{% endlist %}

### Install the required utilities {#install-utilities}

1. Install [Git](https://en.wikipedia.org/wiki/Git) using the following command:

   ```bash
   sudo apt install git
   ```

1. Install {{ TF }}:

   1. Go to the root folder:

      ```bash
      cd ~
      ```

   1. Create a folder named `terraform` and open it:

      ```bash
      mkdir terraform
      cd terraform
      ```

   1. Download the `terraform_1.3.9_linux_amd64.zip` file:

      ```bash
      curl \
        --location \
        --remote-name \
        https://hashicorp-releases.yandexcloud.net/terraform/1.3.9/terraform_1.3.9_linux_amd64.zip
      ```

   1. Install the `zip` utility and unpack the ZIP archive:

      ```bash
      apt install zip
      unzip terraform_1.3.9_linux_amd64.zip
      ```

   1. Add the path to the folder with the executable to the `PATH` variable:

      ```bash
      export PATH=$PATH:~/terraform
      ```

   1. Make sure {{ TF }} is installed by running this command:

      ```bash
      terraform -help
      ```

1. Create a configuration file specifying the provider source for {{ TF }}:

   1. Create a file named `.terraformrc` using the native `nano` editor:

      ```bash
      cd ~
      nano .terraformrc
      ```

   1. Add the following section to the file:

      ```text
      provider_installation {
        network_mirror {
          url = "https://terraform-mirror.yandexcloud.net/"
          include = ["registry.terraform.io/*/*"]
        }
        direct {
          exclude = ["registry.terraform.io/*/*"]
        }
      }
      ```

      For more information about setting up mirrors, see the [{{ TF }}](https://www.terraform.io/cli/config/config-file#explicit-installation-method-configuration) documentation.

## Deploy your resources {#create-resources}

1. Clone the `yandex-cloud-examples/yc-dmz-with-high-available-ngfw` GitHub repository and go to the `yc-dmz-with-high-available-ngfw` folder:

    ```bash
    git clone https://github.com/yandex-cloud-examples/yc-dmz-with-high-available-ngfw.git
    cd yc-dmz-with-high-available-ngfw
    ```

1. Set up the CLI profile to run operations on behalf of the service account:

   {% list tabs %}

   - CLI

      {% include [cli-install](../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../_includes/default-catalogue.md) %}

      1. Create an [authorized key](../../iam/concepts/authorization/key.md) for your service account and save the file:

         ```bash
         yc iam key create \
           --service-account-id <service_account_ID> \
           --folder-id <ID_of_folder_with_service_account> \
           --output key.json
         ```

         Where:

         * `service-account-id`: Service account ID.
         * `folder-id`: ID of the folder in which the service account was created.
         * `output`: Name of the file with the authorized key.

         Result:

         ```text
         id: aje8nn871qo4********
         service_account_id: ajehr0to1g8b********
         created_at: "2023-03-04T09:16:43.479156798Z"
         key_algorithm: RSA_2048
         ```

      1. Create a CLI profile to run operations on behalf of the service account:

         ```bash
         yc config profile create sa-terraform
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

         * `service-account-key`: File with the service account authorized key.
         * `cloud-id`: [Cloud ID](../../resource-manager/operations/cloud/get-id.md).
         * `folder-id`: [Folder ID](../../resource-manager/operations/folder/get-id.md).

      1. Add the credentials to the environment variables:

         ```bash
         export YC_TOKEN=$(yc iam create-token)
         export YC_CLOUD_ID=$(yc config get cloud-id)
         export YC_FOLDER_ID=$(yc config get folder-id)
         ```

    {% endlist %}

1. Get your PC's IP address:

      ```bash
      curl 2ip.ru
      ```

      Result:

      ```text
      192.2**.**.**
      ```

1. Open the `terraform.tfvars` file in the `nano` editor to edit as follows:

   1. The line with the cloud ID:

      ```text
      cloud_id = "<cloud_ID>"
      ```

   1. The line with a list of allowed public IP addresses for `jump-vm` access:

      ```text
      trusted_ip_for_access_jump-vm = ["<PC_external_IP_address>/32"]
      ```

1. Deploy the resources in the cloud using {{ TF }}:

   1. Initialize {{ TF }}:

       ```bash
       terraform init
       ```

   1. Check the {{ TF }} file configuration:

       ```bash
       terraform validate
       ```

   1. Check the list of cloud resources you are about to create:

       ```bash
       terraform plan
       ```

   1. Create resources:

       ```bash
       terraform apply
       ```

## Set up firewall gateways {#configure-gateways}

As an example, this tutorial describes steps for configuring firewalls named FW-A and FW-B with basic access control policies and NAT required to test performance and fault tolerance, but insufficient to deploy an infrastructure in the production environment.

### Connect to the control segment via a VPN {#connect-via-vpn}

After deploying the infrastructure, the `mgmt` folder will contain a VM named `jump-vm` based on an Ubuntu image with the [WireGuard VPN](https://www.wireguard.com/) configured for a secure connection. Set up a VPN tunnel to `jump-vm` on your PC to access the `mgmt`, `dmz`, `app`, and `database` segment subnets.

To set up the VPN tunnel:

1. Get the username in the Linux subsystem:

   ```bash
   whoami
   ```

1. [Install](https://download.wireguard.com/windows-client/wireguard-installer.exe) WireGuard on your PC.
1. Open WireGuard and click **Add Tunnel**.
1. In the dialog box that opens, select the `jump-vm-wg.conf` file in the `yc-dmz-with-high-available-ngfw` folder.

   To find the directory created in a Linux subsystem, e.g., Ubuntu, type the file path in the dialog box address bar:

   ```bash
   \\wsl$\Ubuntu\home\<Ubuntu_user_name>\yc-dmz-with-high-available-ngfw
   ```

   Where `<Ubuntu_user_name>` is the previously obtained name of the current Linux distribution user.

1. Click **Activate** to activate the tunnel.
1. Check network connectivity with the management server via the WireGuard VPN tunnel by running the following command in the terminal:

   ```bash
   ping 192.168.1.100
   ```

   {% note warning %}

   If the packets fail to reach the management server, make sure the `mgmt-jump-vm-sg` [security group](../../vpc/concepts/security-groups.md) rules for incoming traffic have your PC external IP address specified correctly.

   {% endnote %}


### Run SmartConsole {#setup-smartconsole}

To manage and set up the [Check Point](https://en.wikipedia.org/wiki/Check_Point) solution, install and run the SmartConsole GUI client: 

1. Connect to the NGFW management server. To do so, in your browser, go to `https://192.168.1.100`.
1. Sign in using `admin` as both username and password.
1. In the Gaia Portal interface that opens, download the SmartConsole GUI client. To do this, click **Manage Software Blades using SmartConsole. Download Now!**.
1. Install SmartConsole on your PC.
1. Get a password for access to SmartConsole. Run the following command in the terminal window:

    ```bash
    terraform output fw_smartconsole_mgmt-server_password
    ```

1. Open SmartConsole and sign in with `admin` for username, `192.168.1.100` for management server IP address, and the SmartConsole password you got in the previous step.

### Add the firewall gateways {#add-gateways}

Add an FW-A firewall gateway to the management server using the Wizard:

1. In the **Objects** drop-down list at the top left, select **More object types → Network Object → Gateways and Servers → New Gateway...**.
1. Click **Wizard Mode**.
1. In the dialog box that opens, enter the following:

   * **Gateway name**: `FW-A`
   * **Gateway platform**: `CloudGuard IaaS`
   * **IPv4**: `192.168.1.10`

1. Click **Next**.
1. Get a password for access to firewalls. Run the following command in the terminal window:

    ```bash
    terraform output fw_sic-password
    ```

1. In the **One-time password** field, enter the password you obtained in the previous step.
1. Click **Next**, and then **Finish**.

Similarly, add the FW-B firewall gateway with the following values to the management server:

   * **Gateway name**: `FW-B`
   * **IPv4**: `192.168.2.10`

### Configure the FW-A gateway network interfaces {#setup-gateways-fw-a}

Configure the `eth0` network interface of the FW-A gateway:

1. In the **Gateways & Servers** tab, open the FW-A gateway setup dialog.
1. In the **Network Management** tab, the **Topology** table, select the `eth0` interface and click **Modify...**.
1. Under **Leads To**, select **Override**.
1. Next to the **Specific** option, hover over the `FW-A-eth0` interface name and click the edit icon in the window that opens.
1. In the dialog box that opens, rename `FW-A-eth0` to `mgmt`.
1. Under **Security Zone**, activate **Specify Security Zone** and select **InternalZone**.

Similarly, configure the `eth1`, `eth2`, `eth3`, and `eth4` network interfaces:

1. For the `eth1` interface, specify **ExternalZone** under **Security Zone**. Do not rename this interface.
1. Rename the `eth2` interface to `dmz`, activate **Interface leads to DMZ**, and specify **DMZZone**.

   Set up Automatic Hide NAT to hide the addresses of VMs hosted in the DMZ segment with access to the internet. To do this:

      1. In the `dmz` interface editing dialog box, click `Net_10.160.1.0` and go to the **NAT** tab.
      1. Activate **Add automatic address translation rules**, select **Hide** from the drop-down list and enable **Hide behind gateway**.
      1. Repeat these same steps for `Net_10.160.2.0`.

1. Rename the `eth3` interface to `app` and specify **InternalZone**.
1. Rename the `eth4` interface to `database` and specify **InternalZone**.

### Configure the FW-B gateway network interfaces {#setup-gateways-fw-b}

Configure the FW-B gateway network interfaces the same way as those of the FW-A gateway. When naming the interfaces, select existing names from the list.

To select an interface name from currently set ones:

1. Under **Leads To**, select **Override**.
1. Find the relevant name in the drop-down list next to the **Specific** option.

{% note warning %}

Renaming the interfaces again will cause the network object name replication error when setting security policies.

{% endnote %}


### Create network objects {#create-network-objects}

1. In the **Objects** drop-down list at the top left, select **New Network...** to create networks named `public - a` and `public - b` with the following parameters:

    | Name | Network address | Net mask |
    | ----------- | ----------- | ----------- |
    | public - a | 172.16.1.0 | 255.255.255.0 |
    | public - b | 172.16.2.0 | 255.255.255.0 |

1. Select **New Network Group...** to create a group named `public` and add the `public - a` and `public - b` networks to it.
1. Select **New Host...** to create hosts with the following parameters:

    | Name | IPv4 address |
    | ----------- | ----------- |
    | dmz-web-server | 10.160.1.100 |
    | FW-a-dmz-IP | 10.160.1.10 |
    | FW-a-public-IP | 172.16.1.10 |
    | FW-b-dmz-IP | 10.160.2.10 |
    | FW-b-public-IP | 172.16.2.10 |

1. Select **More object types → Network Object → Service → New TCP...** to create a TCP service for the application deployed in the DMZ segment and specify `TCP_8080` as its name and `8080` as the port.

### Set security policy rules {#define-policies}

To add a security rule:

1. In the **Security policies** tab, select **Policy** under **Access Control**.
1. In the rule table, right-click next to the **New Rule** option in the context menu that opens and select **Above** or **Below**.
1. In a new line:
   * In the **Name** column, enter `Web-server port forwarding on FW-a`.
   * In the **Source** column, click `+` and select the `public` object.
   * In the **Destination** column, select the `FW-a-public-IP` object.
   * In the **Services & Applications** column, select the `TCP_8080` object.
   * In the **Action** column, select `Accept`.
   * In the **Track** column, select `Log`.
   * In the **Install On** column, select the `FW-a` object.


In the same way, add other rules from the basic rule table below to test the firewall policies, run NLB health checks, publish a test application from the DMZ segment, and test its fault tolerance.

   | No | Name | Source | Destination | VPN | Services & Applications | Action | Track | Install On |
   | ----------- | ----------- | ----------- | ----------- | ----------- | ----------- | ----------- | ----------- | ----------- |
   | 1 | Web-server port forwarding on FW-a | public | FW-a-public-IP | Any | TCP_8080 | Accept | Log | FW-a |
   | 2 | Web-server port forwarding on FW-b | public | FW-b-public-IP | Any | TCP_8080 | Accept | Log | FW-b |
   | 3 | FW management & NLB healthcheck | mgmt | FW-a, FW-b, mgmt-server | Any | https, ssh | Accept | Log | Policy Targets (All gateways)  |
   | 4 | Stealth | Any | FW-a, FW-b, mgmt-server | Any | Any | Drop | Log | Policy Targets (All gateways) |
   | 5 | mgmt to DMZ | mgmt | dmz | Any | Any | Accept | Log | Policy Targets (All gateways) |
   | 6 | mgmt to app | mgmt | app | Any | Any | Accept | Log | Policy Targets (All gateways) |
   | 7 | mgmt to database | mgmt | database | Any | Any | Accept | Log | Policy Targets (All gateways) |
   | 8 | ping from dmz to internet | dmz | ExternalZone | Any | icmp-requests (Group) | Accept | Log | Policy Targets (All gateways) |
   | 9 | Cleanup rule | Any | Any | Any | Any | Drop | Log | Policy Targets (All gateways) |

### Set up a static NAT table {#setup-static-nat}

`Source NAT` ensures that an application's response passes through the same firewall as the user's request. `Destination NAT` routes user requests to the network traffic load balancer downstream of which there is the application's group of web servers.

Headers of packets received from {{ alb-name }} with user requests to the application published in the DMZ will be translated to the `Source IP` of the firewall DMZ interfaces and the `Destination IP` of the web server traffic load balancer.

To set up the NAT tables of the FW-A gateway:

1. Go to the **NAT** subsection of the **Access Control** section.
1. In the rule table, right-click next to the **New Rule** option in the context menu that opens and select **Above** or **Below**.
1. In a new line:
   * In the **Original Source** column, click `+`and select the `public` object.
   * In the **Original Destination** column, select the `FW-a-public-IP ` object.
   * In the **Original Services** column, select the `TCP_8080` object.
   * In the **Translated Source** column, select the `FW-a-dmz-IP` object.
   * In the **Translated Destination** column, select the `dmz-web-server` object.
   * In the **Install On** column, select the `FW-a` object.
1. Make sure to change the NAT method for `FW-a-dmz-IP`. To do this, right-click the `FW-a-dmz-IP` object in the table and select **NAT Method > Hide**.

In the same way, set up the static NAT table for the FW-B gateway based on the table below:

   | No | Original Source | Original Destination | Original Services | Translated Source | Translated Destination | Translated Services | Install On |
   | ----------- | ----------- | ----------- | ----------- | ----------- | ----------- | ----------- | ----------- |
   | 1 | public | FW-a-public-IP | TCP_8080 | FW-a-dmz-IP (Hide) | dmz-web-server | Original | FW-a |
   | 2 | public | FW-b-public-IP | TCP_8080 | FW-b-dmz-IP (Hide) | dmz-web-server | Original | FW-b |

### Apply the security policy rules {#apply-policies}

1. Click **Install Policy** at the top left of the screen.
1. In the dialog box that opens, click **Push & Install**.
1. In the next dialog, click **Install** and wait for the process to complete.

## Enable the route-switcher module {#enable-route-switcher}

After you complete the NGFW setup, make sure that FW-A and FW-B health checks return `Healthy`. To do this, in the {{ yandex-cloud }} [management console]({{ link-console-main }}), the `mgmt` folder, select **{{ ui-key.yacloud.iam.folder.dashboard.label_load-balancer }}** and go to the `route-switcher-lb-...` network load balancer page. Expand the target group and make sure the target resources are `Healthy`. If they are `Unhealthy`, make sure that FW-A and FW-B are up and running and [configured](#configure-gateways).

Once the FW-A and FW-B status changes to `Healthy`, open the `route-switcher.tf` file and change the `start_module` parameter value of the `route-switcher` module to `true`. To enable the module, run these commands:

```bash
terraform plan
terraform apply
```

Within 5 minutes, the `route-switcher` module starts providing fault tolerance of outgoing traffic across the segments.

## Test the solution for performance and fault tolerance {#test-accessibility}

### Test the system performance {#test-accessibility}

1. To find out the public IP address of the load balancer, run this command in the terminal:

    ```bash
    terraform output fw-alb_public_ip_address
    ```

1. Make sure the network infrastructure is externally accessible. To do so, in your browser, go to:

    ```bash
    http://<ALB_load_balancer_public_IP_address>
    ```
    If the system is accessible from the outside, you will see the `Welcome to nginx!` page.

1. Make sure the firewall security policy rules that allow traffic are active. To do this, go to the `yc-dmz-with-high-available-ngfw` folder on your PC and connect to a VM in the DMZ segment over SSH:

    ```bash
    cd ~/yc-dmz-with-high-available-ngfw
    ssh -i pt_key.pem admin@<VM_internal_IP_address_in_DMZ_segment>
    ```

1. To check that there is access from the VM in the DMZ segment to a public resource on the Internet, run this command:

    ```bash
    ping ya.ru
    ```

    The command must run according to the `ping from dmz to internet` rule that allows traffic.

1. Make sure the security policy rules that prohibit traffic are applied.

   To check that `Jump VM` in the `mgmt` segment cannot be accessed from the `dmz` segment, run this command:

   ```bash
   ping 192.168.1.101
   ```

   The command must fail according to the `Cleanup rule` rule that prohibits traffic.

### Testing fault tolerance {#fault-tolerance-check}

1. Install `httping` on your PC to make regular HTTP requests:

    ```bash
    sudo apt-get install httping
    ```

1. To find out the public IP address of the load balancer, run this command in the terminal:

    ```bash
    terraform output fw-alb_public_ip_address
    ```

1. Enable incoming traffic to the application published in the DMZ segment by making the following request to the ALB public IP:

    ```bash
    httping http://<ALB_load_balancer_public_IP_address>
    ```

1. Open another terminal window and connect to a VM in the DMZ segment over SSH:

    ```bash
    ssh -i pt_key.pem admin@<VM_internal_IP_address_in_DMZ_segment>
    ```

1. Set a password for the `admin` user:

    ```bash
    sudo passwd admin
    ```

1. In the {{ yandex-cloud }} [management console]({{ link-console-main }}), change the parameters of this VM:

    1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
    1. In the left-hand panel, select ![image](../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.switch_instances }}**.
    1. In the line with the appropriate VM, click ![ellipsis](../../_assets/console-icons/ellipsis.svg) and select ![pencil](../../_assets/console-icons/pencil.svg) **{{ ui-key.yacloud.common.edit }}**.
    1. In the window that opens, under **{{ ui-key.yacloud.compute.instances.create.section_additional }}**, enable **{{ ui-key.yacloud.compute.instances.create.field_serial-port-enable }}**.
    1. Click **{{ ui-key.yacloud.compute.instance.edit.button_update }}**.

1. Connect to the VM serial console, enter the `admin` username and the password you set earlier.

1. Enable outgoing traffic from the VM in the DMZ segment to a resource on the internet using the `ping` command:

    ```bash
    ping ya.ru
    ```

1. In the {{ yandex-cloud }} [management console]({{ link-console-main }}), in the `mgmt` folder, [stop](../../compute/operations/vm-control/vm-stop-and-start.md#stop) the `fw-a` VM by emulating the recovery of the main firewall.
1. Monitor the loss of packets sent by `httping` and `ping`. After FW-A fails, there may be a traffic loss for approximately 1 minute with subsequent traffic recovery.
1. Make sure the FW-B address is used in the `dmz-rt` route table in the `dmz` folder for `next hop`.
1. In the {{ yandex-cloud }} [management console]({{ link-console-main }}), [run](../../compute/operations/vm-control/vm-stop-and-start.md#start) the `fw-a` VM by emulating the recovery of the main firewall.
1. Monitor the loss of packets sent by `httping` and `ping`. After FW-A is restored, there may be a traffic loss for approximately 1 minute with subsequent traffic recovery.
1. Make sure the FW-A address is used in the `dmz-rt` route table in the `dmz` folder for `next hop`.

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created, run this command:

  ```bash
  terraform destroy
  ```
  {{ TF }} will **permanently** delete all the resources: networks, subnets, VMs, load balancers, folders, etc.

As the resources you created reside in folders, a faster way to delete all resources is to delete all the folders using the {{ yandex-cloud }} console and then delete the `terraform.tfstate` file from the `yc-dmz-with-high-available-ngfw` folder on your PC.
