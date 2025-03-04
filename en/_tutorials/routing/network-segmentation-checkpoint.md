# Cloud infrastructure segmentation with a Check Point next-generation firewall

This tutorial will tell you how to deploy a secure network infrastructure based on the Check Point next-generation firewall. The infrastructure comprises three segments, each one hosting an isolated set of resources grouped by function. For example, the dedicated [`dmz`](https://en.wikipedia.org/wiki/DMZ_(computing)) segment hosts public applications, while the `mgmt` segmentcontains the cloud infrastructure management resources. The segments communicate over a virtual [Check Point](https://www.checkpoint.com/quantum/next-generation-firewall/) [next-generation firewall (NGFW)](https://en.wikipedia.org/wiki/Next-generation_firewall), which provides end-to-end protection and traffic control across the segments.

If you need to ensure the NGFW’s fault tolerance and the deployed applications’ high availability, use [this recommended solution](../../tutorials/routing/high-accessible-dmz.md).


The solution has these basic segments, or folders:

* The `public` folder contains the internet-facing resources.
* The `mgmt` folder manages the cloud infrastructure and hosts internal resources. It includes VMs for infrastructure protection and network segmentation into security zones (`fw`), a VM of the centralized firewall management server (`mgmt-server`), and a [WireGuard VPN](https://www.wireguard.com/) VM for secure management segment access (`jump-vm`).
* The **`dmz`** folder enables you to publish open-access applications.

For more information, see the project repository [here](https://github.com/yandex-cloud-examples/yc-network-segmentation-with-checkpoint). 

To deploy a secure network infrastructure based on a Check Point next-generation firewall:

1. [Get your cloud ready](#prepare-cloud).
1. [Prepare the environment](#prepare-environment).
1. [Deploy your resources](#create-resources).
1. [Configure the firewall gateway](#configure-gateway).
1. [Test the solution](#test-functionality).
1. [Check the production deployment requirements](#deployment-requirements).

If you no longer need the resources you created, [delete them](#clear-out).

### Next-Generation Firewall {#next-generation-firewall}

[{{ marketplace-full-name }}](/marketplace?categories=security) offers multiple NGFW solutions. This scenario uses [Check Point CloudGuard IaaS](/marketplace?publishers=f2evobrhpbdrcue7s9l5&tab=software). Its features include:
* Firewall, NAT, IPS, antivirus, and anti-bot protection.
* Application-level granular traffic management and session logging.
* Centralized management using Check Point security management.
* This example features basic access and NAT policies for Check Point.

Yandex Cloud Marketplace offers both PAYG and BYOL licensing for Check Point CloudGuard IaaS. This example uses the BYOL option with a 15-day trial:
* NGFW VM [Check Point CloudGuard IaaS: Firewall & Threat Prevention BYOL](/marketplace/products/checkpoint/cloudguard-iaas-firewall-tp-byol-m).
* NGFW management server VM: [Check Point CloudGuard IaaS: Security Management BYOL](/marketplace/products/checkpoint/cloudguard-iaas-security-management-byol-m).

We recommend these options for production use:
* NGFW [Check Point CloudGuard IaaS - Firewall & Threat Prevention PAYG](/marketplace/products/checkpoint/cloudguard-iaas-firewall-tp-payg-m).
* The Check Point CloudGuard IaaS: Security Management server requires a separate license. Alternatively, you can use your on-premise management server.

## Get your cloud ready {#prepare-cloud}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

The infrastructure support cost includes:

* Fee for continuously running VMs (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* Fee for using public IP addresses and outbound traffic (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).

### Required quotas {#required-quotes}

{% note warning %}

The tutorial involves deploying a resource-intensive infrastructure.

{% endnote %}

Make sure your cloud has sufficient [quotas](../../overview/concepts/quotas-limits.md) that are not currently used by resources for other tasks.

{% cut "Amount of resources the tutorial requires" %}

| Resource | Amount |
| ----------- | ----------- |
| Folders | 3 |
| Virtual machines | 4 |
| VM vCPUs | 12 |
| VM RAM | 20 GB |
| Disks | 4 |
| SSD size | 240 GB |
| HDD size | 20 GB |
| Cloud networks | 3 |
| Subnets | 3 |
| Route tables | 2 |
| Security groups | 5 |
| Static public IP addresses | 2 |
| Static routes | 3 |

{% endcut %}

## Prepare the environment {#prepare-environment}

This tutorial uses Windows software and [Windows Subsystem for Linux](https://en.wikipedia.org/wiki/Windows_Subsystem_for_Linux) (WSL).
The infrastructure is deployed using [{{ TF }}](https://www.terraform.io/). 

### Set up WSL {#setup-wsl}

1. Check whether you have WSL installed on your PC. To do this, run this command in the CLI terminal:
  
   ```bash
   wsl -l
   ```

   With WSL installed, the terminal will display a list of available distribution kits, e.g.:
   
   ```bash
   Windows Subsystem for Linux Distributions:
   docker-desktop (Default)
   docker-desktop-data
   Ubuntu
   ```

1. Otherwise, [install](https://learn.microsoft.com/en-us/windows/wsl/install) it and repeat the previous step.
1. In addition, you can install a familiar Linux distribution kit, e.g., [Ubuntu](https://ubuntu.com/tutorials/install-ubuntu-on-wsl2-on-windows-11-with-gui-support#1-overview), on top of WSL.

1. To make the installed distribution kit the default system, run:
   
   ```bash
   wsl --setdefault ubuntu
   ```

1. To switch the terminal to Linux subsystem operation mode, run:

   ```bash
   wsl ~
   ```

{% note info %}

Perform all steps below in the Linux terminal.

{% endnote %}

### Create a service account with admin permissions for the cloud {#create-account}
   
{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create a service account.
   1. From the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
   1. Click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
   1. Enter a name for the service account, e.g., `sa-terraform`.

      The naming requirements are as follows:

      {% include [name-format](../../_includes/name-format.md) %}

   1. Click **Create**.

   1. Assign the admin [role](../../iam/concepts/access-control/roles.md) to the account:

         1. On the management console [home page]({{ link-console-main }}), select the cloud.
         1. Click the **Access permissions** tab.
         1. In the list, find the `sa-terraform` account and click ![image](../../_assets/options.svg).
         1. Click **Edit roles**.
         1. In the dialog box that opens, click **Add role** and select `admin`. 

- CLI {#cli}

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
         id: ajehr0to1g8b********
         folder_id: b1gv87ssvu49********
         created_at: "2024-01-04T09:03:11.665153755Z"
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

- API {#api}

   To create a service account, use the [create](../../iam/api-ref/ServiceAccount/create.md) REST API method for the [ServiceAccount](../../iam/api-ref/ServiceAccount/index.md) resource or the [ServiceAccountService/Create](../../iam/api-ref/grpc/ServiceAccount/create.md) gRPC API call.

   {% include [grant-role-for-sa-to-folder-via-api](../../_includes/iam/grant-role-for-sa-to-folder-via-api.md) %}

{% endlist %}

### Install the required utilities {#install-utilities}

1. Install [Git](https://en.wikipedia.org/wiki/Git) using this command:

   ```bash
   sudo apt install git
   ```

1. Install {{ TF }}:

   1. Go to the root directory:

      ```bash
      cd ~
      ```

   1. Create a directory named `terraform` and open it:
   
      ```bash
      mkdir terraform
      cd terraform
      ```

   1. Run this command to download the `terraform_1.3.9_linux_amd64.zip` archive from the official website:

      ```bash
      curl --location --remote-name https://hashicorp-releases.yandexcloud.net/terraform/1.3.9/terraform_1.3.9_linux_amd64.zip
      ```

   1. Install the `zip` utility and unpack the ZIP archive:
      
      ```bash
      apt install zip
      unzip terraform_1.3.9_linux_amd64.zip
      ```

   1. Add the path to the directory with the executable to the `PATH` variable: 
      
      ```bash
      export PATH=$PATH:~/terraform
      ```

   1. Make sure you installed {{ TF }} by running this command:
   
      ```bash
      terraform -help
      ```

1. Create a configuration file specifying the provider source for {{ TF }}:

   1. Create a file named `.terraformrc` using the native `nano` editor:

      ```bash
      cd ~
      nano .terraformrc
      ```

   1. Add this section to the file:

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

      For more information about setting up mirrors, see [this {{ TF }}](https://www.terraform.io/cli/config/config-file#explicit-installation-method-configuration) overview article.

## Deploy your resources {#create-resources}

1. Clone the GitHub [repository](https://github.com/yandex-cloud-examples/yc-network-segmentation-with-checkpoint) and go to the `yc-network-segmentation-with-checkpoint` script directory:
   
   ```bash
   git clone https://github.com/yandex-cloud-examples/yc-network-segmentation-with-checkpoint.git
   cd yc-network-segmentation-with-checkpoint
   ```

1. Set up the CLI profile to perform operations under the service account:

   {% list tabs group=instructions %}

   - CLI {#cli}

      {% include [cli-install](../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../_includes/default-catalogue.md) %}

      1. Create an [authorized key](../../iam/concepts/authorization/key.md) for your service account and save the file:
         
         ```bash
         yc iam key create \
           --service-account-id <service_account_ID> \
           --folder-id <service_account_folder_ID> \
           --output key.json
         ```

         Where:
         
         * `service-account-id`: Service account ID.
         * `folder-id`: ID of the folder where you created the service account.
         * `output`: Name of the authorized key file.

         Result:
         
         ```text
         id: aje8nn871qo4********
         service_account_id: ajehr0to1g8b********
         created_at: "2023-03-04T09:16:43.479156798Z"
         key_algorithm: RSA_2048
         ```

      1. Create a CLI profile to perform operations under the service account:
        
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

1. Get the IP address of your PC:
      
      ```bash
      curl 2ip.ru
      ```

      Result:
      
      ```text
      192.240.24.87
      ```

1. Open the `terraform.tfvars` file in `nano` and edit it as follows:

   1. The line with the cloud ID:
      
      ```text
      cloud_id = "<cloud_ID>"
      ```

   1. The line with the list of allowed public IP addresses for `jump-vm` access:
      
      ```text
      trusted_ip_for_access_jump-vm = ["<PC_external_IP>/32"]
      ```

   {% cut "Description of variables in `terraform.tfvars`" %}

   | Name<br>of parameter | Needs<br>editing | Description | Type | Example |
   | ----------- | ----------- | ----------- | ----------- | ----------- |
   | `cloud_id` | Yes | ID of your cloud in Yandex Cloud | `string` | `b1g8dn6s3v2e********` |
   | `az_name` | - | Yandex Cloud <a href="https://yandex.cloud/ru/docs/overview/concepts/geo-scope">availability zone</a> to host your resources. | `string` | `{{ region-id }}-d` |
   | `security_segment_names` | - | List of segment names. The first segment is for the management resources, the second, for the resources with public internet access, and the third, for `dmz`. If you need more segments, add them at the end of the list. When adding a segment, make sure to specify the subnet prefix in `subnet_prefix_list`. | `list(string)` |  `["mgmt", "public", "dmz"]` |
   | `subnet_prefix_list` | - | List of subnet prefixes as per the `security_segment_names` list. Specify one prefix for each segment. | `list(string)` | `["192.168.1.0/24", "172.16.1.0/24", "10.160.1.0/24"]` |
   | `public_app_port` | - | TCP port for a `dmz` application open for external internet connection. | `number` | `80` |
   | `internal_app_port` | - | Internal TCP port of a `dmz` application to which the NGFW will direct traffic. You may specify the same port as `public_app_port` or a different one. | `number` | `8080` |
   | `trusted_ip_for_access_jump-vm` | Yes | List of public IPs or subnets trusted to access `jump-vm`, used in the incoming rule of the `jump-vm` security group. | `list(string)` | `["A.A.A.A/32", "B.B.B.0/24"]` |
   | `jump_vm_admin_username` | - | Username for connecting to `jump-vm` over SSH. | `string` | `admin` |
   | `wg_port` | - | UDP port for inbound traffic as per the `jump-vm` WireGuard settings. | `number` | `51820` |

   {% endcut %}

   {% note warning %}

   We recommend specifying additional segments in advance if you may need them later on, since a cloud-based NGFW VM does not support adding new network interfaces after it is created. 

   {% endnote %}

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

   1. Create the resources:
       
      ```bash
      terraform apply
      ```

1. After `terraform apply` is complete, the command line will output a list of information on the deployed resources. Later on, you can view this information by running the `terraform output` command:

   {% cut "Expand to view the information on deployed resources" %}

   | Name | Description | Sample value |
   | ----------- | ----------- | ----------- |
   | `dmz-web-server_ip_address` | The IP address of the `dmz` web server for publishing a test application from the `dmz` segment, used for configuring destination NAT on a firewall. | `10.160.1.100` |
   | `fw-mgmt-server_ip_address` | Firewall management server IP address. | `192.168.1.100` |
   | `fw_gaia_portal_mgmt-server_password` | Default password for the initial connection to the IP address of the firewall management server over HTTPS. | `admin` |
   | `fw_mgmt_ip_address` | Firewall IP address in the management network. | `192.168.1.10` |
   | `fw_public_ip_address` | Public firewall IP address. | `D.D.D.D` |
   | `fw_sic-password` | One-time password for adding a firewall to the firewall management server. | The `terraform output` command does not return this variable. To view its value, run `terraform output fw_sic-password`. |
   | `fw_smartconsole_mgmt-server_password` | Password for connecting to the firewall management server through the Check Point SmartConsole GUI. | The `terraform output` command does not return this variable. To view its value, run `terraform output fw_smartconsole_mgmt-server_password`. |
   | `jump-vm_path_for_WireGuard_client_config` | Configuration file for enabling a secure WireGuard VPN connection to the jump VM. | `./jump-vm-wg.conf` |
   | `jump-vm_public_ip_address_jump-vm` | Jump VM public IP address. | `E.E.E.E` |
   | `path_for_private_ssh_key` | File with a private key for connecting to VMs over SSH (`jump-vm`, `fw`, `mgmt-server`, and the web server in `dmz`). | `./pt_key.pem` |
   
   {% endcut %}

## Configure the firewall gateway {#configure-gateway}

This guide tells you how to configure firewalls with basic access management and NAT policies required for performance testing; however, this setup is insufficient for [production deployment](#deployment-requirements).

To learn more about Check Point features and configuration, check out our free course, [Deep Dive into Network Security](https://yandex.cloud/ru/training/network-security).

### Connect to the management segment through a VPN {#connect-via-vpn}

After deploying the infrastructure, the `mgmt` folder will contain a VM named `jump-vm` based on an Ubuntu image with the [WireGuard VPN](https://www.wireguard.com/) configured for a secure connection. Set up a VPN tunnel to `jump-vm` on your PC to access the `mgmt`, `dmz`, and `public` segment subnets.

To set up the VPN tunnel:

1. Get the username in the Linux subsystem:

   ```bash
   whoami
   ```

1. [Install](https://download.wireguard.com/windows-client/wireguard-installer.exe) WireGuard on your PC.
1. Open WireGuard and click **Add Tunnel**.
1. In the dialog box that opens, select the `jump-vm-wg.conf` file in the `yc-network-segmentation-with-checkpoint` directory.
   To find the directory created in a Linux subsystem, e.g., Ubuntu, type the file path in the dialog box address bar:

   ```bash
   \\wsl$\Ubuntu\home\<Ubuntu_user_name>\yc-network-segmentation-with-checkpoint
   ```
   
   Where `<Ubuntu_user_name>` is the name of the current Linux distribution user.

1. Click **Activate** to activate the tunnel.
1. Check network connectivity with the management server through the WireGuard VPN tunnel by running this command in the terminal:
   
   ```bash
   ping 192.168.1.100
   ```

   {% note warning %}

   If the packets fail to reach the management server, make sure the `mgmt-jump-vm-sg` [security group](../../vpc/concepts/security-groups.md) rules for incoming traffic have the external IP address of your PC specified.

   {% endnote %}

### Run SmartConsole {#setup-smartconsole}

To manage and set up [Check Point](https://en.wikipedia.org/wiki/Check_Point), install and run the SmartConsole GUI client: 

1. Connect to the NGFW management server by opening `https://192.168.1.100` in your browser. 
1. Sign in using `admin` as both the username and password. 
1. In the Gaia Portal interface that opens, download the SmartConsole GUI client. To do this, click **Manage Software Blades using SmartConsole. Download Now!**.
1. Install SmartConsole on your PC.
1. Get the SmartConsole access password:
   
   ```bash
   terraform output fw_smartconsole_mgmt-server_password
   ```

1. Open SmartConsole and sign in with `admin` as the username, `192.168.1.100` as the management server IP, and your SmartConsole password.

### Add the firewall gateway {#add-gateway}

Add the FW firewall gateway to the management server using the wizard:

1. In the **Objects** drop-down list at the top left, select **More object types → Network Object → Gateways and Servers → New Gateway...**.
1. Click **Wizard Mode**.
1. In the dialog box that opens, enter the following:
   * **Gateway name:** `FW`
   * **Gateway platform:** `CloudGuard IaaS`
   * **IPv4:** `192.168.1.10`
1. Click **Next**.
1. Get the firewall access password:
   
   ```bash
   terraform output fw_sic-password
   ```

1. In the **One-time password** field, type the password you got previously.
1. Click **Next** and then **Finish**.

### Configure the FW gateway network interfaces {#setup-gateways-fw}

Configure the `eth0` network interface:

1. In the **Gateways & Servers** tab, open the FW gateway setup dialog. To do this, double-click the added FW in the list.
1. In the **Network Management** tab of the **Topology** table, select the `eth0` interface, click **Edit**, and then click **Modify...** in the window that opens.
1. Under **Security Zone**, activate **Specify Security Zone** and select **InternalZone**.

In the same way, configure the `eth1` and `eth2` network interfaces:

1. For the `eth1` interface, specify **ExternalZone** under **Security Zone**.
1. For the `eth2` interface, in the **Leads To** section, select **Override** and enable **Interface leads to `dmz`**. Under **Security Zone**, set **DMZZone**.

| Interface | IPv4 address/mask | Leads To | Security Zone | Anti Spoofing |
| ----------- | ----------- | ----------- | ----------- | ----------- |
| eth0 | 192.168.1.10/24 | This network (Internal) | InternalZone | Prevent and Log |
| eth1 | 172.16.1.10/24 | Internet (External) | ExternalZone | Prevent and Log |
| eth2 | 10.160.1.10/24 | This network, DMZ (Internal) | DMZZone | Prevent and Log |

### Create network objects {#create-network-objects}

1. From the **Objects** drop-down list at the top left, select **New Network...** to create networks named `mgmt`, `public`, and `dmz` with the following properties:

   | Name | Network address | Net mask |
   | ----------- | ----------- | ----------- |
   | mgmt | 192.168.1.0 | 255.255.255.0 |
   | public | 172.16.1.0 | 255.255.255.0 |
   | dmz | 10.160.1.0 | 255.255.255.0 |

   For the `dmz` network, set up Automatic Hide NAT to hide the addresses of the internet-facing VMs hosted in the `dmz` segment behind the FW gateway IP address in the `public` segment. To do this:
      1. In the `dmz` network editing dialog box, go to the **NAT** tab.
      1. Activate **Add automatic address translation rules**, select **Hide** from the drop-down list, and enable **Hide behind the gateway**.

1. From the **Objects** drop-down list at the top left, select **New Host...** and create hosts named `dmz-web-server` and `FW-public-IP` with the following properties:

   | Name | IPv4 address |
   | ----------- | ----------- |
   | dmz-web-server | 10.160.1.100 |
   | FW-public-IP | 172.16.1.10 |

1. Select **More object types → Service → New TCP...** to create a TCP service for the application deployed in the `dmz` segment and specify `TCP_8080` as its name and `8080` as its port.

### Set security policy rules {#define-policies}

To add a security rule:

1. In the **Security policies** tab, select **Policy** under **Access Control**.
1. In the rule table, right-click next to the **New Rule** option in the context menu and select **Above** or **Below**.
1. In a new line:
   * In the **Name** column, enter `Web-server port forwarding on FW`.
   * In the **Destination** column, select the `FW-public-IP` object.
   * In the **Services & Applications** column, select the `http` object.
   * In the **Action** column, select `Accept`.
   * In the **Track** column, select `Log`.

In the same way, add the other basic rules from the table below to test the firewall policies, publish a test application from the `dmz` segment, and test its fault tolerance.

| No | Name | Source | Destination | VPN | Services & Applications | Action | Track | Install On |
| ----------- | ----------- | ----------- | ----------- | ----------- | ----------- | ----------- | ----------- | ----------- |
| 1 | Web-server port forwarding on FW | Any | FW-public-IP | Any | http | Accept | Log | Policy Targets (All gateways) |
| 2 | FW management | mgmt | FW, mgmt-server | Any | https, ssh | Accept | Log | Policy Targets (All gateways)  |
| 3 | Stealth | Any | FW, mgmt-server | Any | Any | Drop | Log | Policy Targets (All gateways) |
| 4 | mgmt to DMZ | mgmt | dmz | Any | Any | Accept | Log | Policy Targets (All gateways) |
| 5 | mgmt to public | mgmt | public | Any | Any | Accept | Log | Policy Targets (All gateways) |
| 6 | ping from dmz to internet | dmz | ExternalZone | Any | icmp-reguests (Group) | Accept | Log | Policy Targets (All gateways) |
| 7 | Cleanup rule | Any | Any | Any | Any | Drop | Log | Policy Targets (All gateways) |

{% cut "Details of the access management policy rules" %}

| Number | Name | Description |
| ----------- | ----------- | ----------- |
| 1 | Web-server port forwarding on FW | Allows external internet access to the IP address of a `public` segment firewall on TCP port 80. | 
| 2 | FW management | Allows access to firewalls and the firewall management server from the `mgmt` segment to address management tasks. |
| 3 | Stealth | Denies access to firewalls and the firewall management server from other segments. |
| 4 | mgmt to DMZ | Allows access from the `mgmt` segment to `dmz` for management tasks. |
| 5 | mgmt to public | Allows access from `mgmt` to the public segment for management tasks. |
| 6 | ping from dmz to internet | Allows outbound ICMP packets from the `dmz` segment to the internet for performance testing. |
| 7 | Cleanup rule | Denies access for other traffic. |

{% endcut %}

### Set up a static NAT table {#setup-static-nat}

Destination NAT routes user requests to the application web server in the `dmz` segment.

It will translate the destination IP address to the web server IP and the destination port to TCP port 8080 in the headers of packets with user requests to a `dmz` application.

To set up the NAT tables of the FW gateway:

1. Go to the **NAT** subsection of the **Access Control** section.
1. In the rule table menu, select **Add rule to top**.
1. In a new line:
   * In the **Original Destination** column, select the `FW-public-IP` object.
   * In the **Original Services** column, select the `http` object.
   * In the **Translated Destination** column, select the `dmz-web-server` object.
   * In the **Translated Services** column, select the `TCP_8080` object.

   The NAT table will now display this rule:

   | No | Original Source | Original Destination | Original Services | Translated Source | Translated Destination | Translated Services | Install On |
   | ----------- | ----------- | ----------- | ----------- | ----------- | ----------- | ----------- | ----------- | 
   | 1 | Any | FW-public-IP | http | Original | dmz-web-server | TCP_8080 | Policy Targets (All gateways) |

### Apply the security policy rules {#apply-policies}

1. Click **Install Policy** at the top left of the screen.
1. In the dialog box that opens, click **Publish & Install**.
1. In the next dialog, click **Install** and wait for the process to complete.

## Test the solution {#test-functionality}

1. To find out the public IP address of the firewall, run this command in the terminal:

   ```bash
   terraform output fw_public_ip_address
   ```

1. Make sure the network infrastructure is accessible from the outside by following this URL in the browser:

   ```bash
   http://<FW_public_IP_address>
   ```
   If the system is accessible from the outside, you will see the `Welcome to nginx!` page.

1. Make sure the firewall security policy rules that allow traffic are active. To do this, go to the `yc-network-segmentation-with-checkpoint` directory on your PC and connect to the `dmz` VM over SSH:

   ```bash
   cd ~/yc-network-segmentation-with-checkpoint
   ssh -i pt_key.pem admin@<internal_IP_address_of_VM_in_dmz_segment>
   ```

1. To make sure a public resource on the internet is accessible from the VM in the `dmz` segment, run this command:    

   ```bash
   ping ya.ru
   ```

   The command must run as per the `ping from dmz to internet` rule that allows traffic.

1. Make sure the security policy rules that prohibit traffic are active.
   To make sure `jump-vm` in the `mgmt` segment is not accessible from the `dmz` segment, run this command: 

   ```bash
   ping 192.168.1.101
   ```

   This command must fail as per the `Cleanup rule` that prohibits traffic.

1. In SmartConsole, open the `LOGS & MONITOR` section; in the `Logs` tab, find the entries made during testing to see which security rules and actions were applied to the traffic.

## Check the production deployment requirements {#deployment-requirements}

* If you need to ensure the fault tolerance of the NGFW and the high availability of the deployed applications, use [this recommended solution](../../tutorials/routing/high-accessible-dmz.md).
* Make sure to change the passwords provided in the `check-init...yaml` files through the `metadata` service:
   * SIC password for connecting the firewall and the firewall management server.
   * Check Point SmartConsole password.
   * Admin user password for the firewall management server. You can change this password in Gaia Portal.
* Save the `pt_key.pem` private SSH key to a secure location or recreate it separately from {{ TF }}.
* If you do not intend to use the jump VM, delete its public IP address.
* If you do plan to use the jump VM for connecting to the management segment with the WireGuard VPN, change the WireGuard keys in the jump VM and admin workstation.
* Set up access management and NAT policies for your installation in the Check Point NGFW.
* In the security groups within segments, set up the required rules for deployed applications.
* Do not assign public IP addresses to the VMs in those segments that use the Check Point NGFW routing tables. The only exception is the `mgmt` segment, where the routing tables do not use the default route (`0.0.0.0/0`). 
* Select your preferred Check Point CloudGuard IaaS license and image (see [Next-Generation Firewall](#next-generation-firewall)).

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created, run this command:

   ```bash
   terraform destroy
   ```
   {{ TF }} will **permanently** delete all the resources: networks, subnets, VMs, folders, etc.

As the resources you created reside in folders, a faster way to delete all resources is to delete all folders using the {{ yandex-cloud }} console and then delete the `terraform.tfstate` file from the `yc-network-segmentation-with-checkpoint` directory on your PC.
