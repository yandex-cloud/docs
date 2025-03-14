# Cloud infrastructure segmentation with the Check Point next-generation firewall

In this tutorial, we will deploy a secure network infrastructure based on the Check Point next-generation firewall. It will include three segments hosting resources grouped by function and isolated from other resources. We will host public-facing applications in the [`dmz`](https://en.wikipedia.org/wiki/DMZ_(computing)) segment and cloud management resources in the `mgmt` segment. The segments will communicate through a [Check Point](https://www.checkpoint.com/quantum/next-generation-firewall/) [next-generation firewall](https://en.wikipedia.org/wiki/Next-generation_firewall) VM providing complex protection and traffic management.

To ensure NGFW fault tolerance and application high availability, use [this recommended solution](../../tutorials/routing/high-accessible-dmz.md).

* **public** folder with internet-facing resources.
* **mgmt** folder with cloud management resources including `FW`: protection and network segmentation VM, `mgmt-server`: firewall management VM, and `jump`: [WireGuard VPN](https://www.wireguard.com/) VM providing secure access to the management segment.
* **dmz** folder with public-facing applications.

For more information, see the [project repository](https://github.com/yandex-cloud-examples/yc-network-segmentation-with-checkpoint). 

To deploy a secure Check Point NGFW-based network infrastructure:

1. [Get your cloud ready](#prepare-cloud).
1. [Prepare your environment](#prepare-environment).
1. [Deploy your resources](#create-resources).
1. [Set up your firewall gateway](#configure-gateway).
1. [Test the solution](#test-functionality).
1. [Requirements for production deployment](#deployment-requirements).

If you no longer need the resources you created, [delete them](#clear-out).

### Next-Generation Firewall {#next-generation-firewall}

Among various [{{ marketplace-full-name }}](/marketplace?categories=security) NGFW solutions we will choose [Check Point CloudGuard IaaS](/marketplace?publishers=f2evobrhpbdrcue7s9l5&tab=software). Its features include:
* Firewall, NAT, IPS, antivirus and anti-bot protection.
* Application layer granular traffic management, session logging.
* Centralized Check Point security management.
* In our example, we will configure Check Point firewall with basic access control and NAT policies.

Yandex Cloud Marketplace offers PAYG and BYOL licensing for Check Point CloudGuard IaaS. We will use BYOL with a 15-day trial:
* NGFW VM [Check Point CloudGuard IaaS: Firewall & Threat Prevention BYOL](/marketplace/products/checkpoint/cloudguard-iaas-firewall-tp-byol-m).
* Management server VM [Check Point CloudGuard IaaS: Security Management BYOL](/marketplace/products/checkpoint/cloudguard-iaas-security-management-byol-m).

For production deployment, we recommend to use the following options:
* NGFW [Check Point CloudGuard IaaS: Firewall & Threat Prevention PAYG](/marketplace/products/checkpoint/cloudguard-iaas-firewall-tp-payg-m)
* Separate license for the Check Point CloudGuard IaaS: Security Management server. Alternatively, you can use your on-premise server.

## Get your cloud ready {#prepare-cloud}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

The infrastructure support cost includes:

* Fee for continuously running VMs (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* Fee for public IP addresses and outgoing traffic (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).

### Required quotas {#required-quotes}

{% note warning %}

In this tutorial, you will have to deploy a resource-intensive infrastructure.

{% endnote %}

Make sure your cloud has sufficient [quotas](../../overview/concepts/quotas-limits.md) that are not used by other projects.

{% cut "Resources used by this tutorial" %}

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

## Set up your environment {#prepare-environment}

In this tutorial, we will use Windows software and [Windows Subsystem for Linux](https://en.wikipedia.org/wiki/Windows_Subsystem_for_Linux) (WSL).
Also, we will use [{{ TF }}](https://www.terraform.io/) to deploy the infrastructure. 

### Configure WSL {#setup-wsl}

1. Check whether WSL is installed on your PC by running this command in the CLI terminal:
  
   ```bash
   wsl -l
   ```

   If WSL is installed, the terminal will display the list of available distributions, for example:
   
   ```bash
   Windows Subsystem for Linux Distributions:
   docker-desktop (Default)
   docker-desktop-data
   Ubuntu
   ```

1. If WSL is not installed, [install](https://learn.microsoft.com/en-us/windows/wsl/install) it and repeat the previous step.
1. Additionally, you can install your preferred Linux distribution, e.g., [Ubuntu](https://ubuntu.com/tutorials/install-ubuntu-on-wsl2-on-windows-11-with-gui-support#1-overview), on top of WSL.

1. To make it the default system, run this command:
   
   ```bash
   wsl --setdefault ubuntu
   ```

1. To switch your terminal to Linux, run this command:

   ```bash
   wsl ~
   ```

{% note info %}

To perform the following steps, we use Linux terminal.

{% endnote %}

### Create a cloud administrator service account {#create-account}
   
{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create a service account.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_iam }}**.
   1. Click **{{ ui-key.yacloud.iam.folder.service-accounts.button_add }}**.
   1. Specify the service account name, e.g., `sa-terraform`.

      The name should meet the following requirements:

      {% include [name-format](../../_includes/name-format.md) %}

   1. Click **Create**.

   1. Assign the admin [role](../../iam/concepts/access-control/roles.md) to the account:

         1. On the management console [home page]({{ link-console-main }}), select your cloud.
         1. Click the **Access permissions** tab.
         1. Find the `sa-terraform` account in the list and click ![image](../../_assets/options.svg).
         1. Click **Edit roles**.
         1. In the dialog that opens, click **Add role** and select the `admin` role. 

- CLI {#cli}

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. Create a service account:

         ```bash
         yc iam service-account create --name sa-terraform
         ```

         Where `name` is the service account name. The name should meet the following requirements:

         {% include [name-format](../../_includes/name-format.md) %}

         Result:

         ```text
         id: ajehr0to1g8b********
         folder_id: b1gv87ssvu49********
         created_at: "2024-01-04T09:03:11.665153755Z"
         name: sa-terraform
         ```
      
   1. Assign the admin [role](../../iam/concepts/access-control/roles.md) to the account:

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

### Install the required tools {#install-utilities}

1. Install [Git](https://en.wikipedia.org/wiki/Git) using the following command:

   ```bash
   sudo apt install git
   ```

1. Install {{ TF }}:

   1. Navigate to the root directory:

      ```bash
      cd ~
      ```

   1. Create the `terraform` directory and open it:
   
      ```bash
      mkdir terraform
      cd terraform
      ```

   1. Run the following command to download the `terraform_1.3.9_linux_amd64.zip` archive from the official website:

      ```bash
      curl --location --remote-name https://hashicorp-releases.yandexcloud.net/terraform/1.3.9/terraform_1.3.9_linux_amd64.zip
      ```

   1. Install `zip` and unpack the ZIP archive:
      
      ```bash
      apt install zip
      unzip terraform_1.3.9_linux_amd64.zip
      ```

   1. Add the executable directory to your `PATH`: 
      
      ```bash
      export PATH=$PATH:~/terraform
      ```

   1. Make sure that {{ TF }} is installed by running this command:
   
      ```bash
      terraform -help
      ```

1. Create a configuration file specifying the {{ TF }} provider source:

   1. Create the `.terraformrc` file in `nano`:

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

      For more information about mirror settings, see the relevant [{{ TF }}](https://www.terraform.io/cli/config/config-file#explicit-installation-method-configuration) guides.

## Deploy your resources {#create-resources}

1. Clone the GitHub [repository](https://github.com/yandex-cloud-examples/yc-network-segmentation-with-checkpoint) and navigate to the `yc-network-segmentation-with-checkpoint` script directory:
   
   ```bash
   git clone https://github.com/yandex-cloud-examples/yc-network-segmentation-with-checkpoint.git
   cd yc-network-segmentation-with-checkpoint
   ```

1. Set up a CLI profile to run operations on behalf of the service account:

   {% list tabs group=instructions %}

   - CLI {#cli}

      {% include [cli-install](../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../_includes/default-catalogue.md) %}

      1. Create an [authorized key](../../iam/concepts/authorization/key.md) for your service account and save it to the file:
         
         ```bash
         yc iam key create \
           --service-account-id <service_account_ID> \
           --folder-id <ID_of_folder_with_service_account> \
           --output key.json
         ```

         Where:
         
         * `service-account-id`: Service account ID.
         * `folder-id`: ID of the folder where you created the service account.
         * `output`: Authorized key file name.

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

      1. Configure the profile:
         
         ```bash
         yc config set service-account-key key.json
         yc config set cloud-id <cloud_ID>
         yc config set folder-id <folder_ID>  
         ```

         Where:

         * `service-account-key`: Service account authorized key file.
         * `cloud-id`: [Cloud ID](../../resource-manager/operations/cloud/get-id.md).
         * `folder-id`: [Folder ID](../../resource-manager/operations/folder/get-id.md).

      1. Export your credentials to environment variables:
         
         ```bash
         export YC_TOKEN=$(yc iam create-token)
         export YC_CLOUD_ID=$(yc config get cloud-id)
         export YC_FOLDER_ID=$(yc config get folder-id)
         ```

   {% endlist %}

1. Get your PC IP address:
      
      ```bash
      curl 2ip.ru
      ```

      Result:
      
      ```text
      192.240.24.87
      ```

1. Open the `terraform.tfvars` file in `nano` and edit it as follows:

   1. The cloud ID line:
      
      ```text
      cloud_id = "<cloud_ID>"
      ```

   1. The `jump-vm` allowed public IP addresses:
      
      ```text
      trusted_ip_for_access_jump-vm = ["<PC_external_IP>/32"]
      ```

   {% cut "terraform.tfvars variable description" %}

   | Name<br>of parameter | Needs<br>editing | Description | Type | Example |
   | ----------- | ----------- | ----------- | ----------- | ----------- |
   | `cloud_id` | Yes | Your Yandex Cloud ID | `string` | `b1g8dn6s3v2e********` |
   | `az_name` | - | Your Yandex Cloud resources<a href="https://yandex.cloud/ru/docs/overview/concepts/geo-scope">availability zone</a> | `string` | `{{ region-id }}-d` |
   | `security_segment_names` | - | Segment names Specify three segments: for management resources, public-facing resources, and DMZ.. If you need more segments, add them at the end of the list. When adding a segment, make sure to specify its subnet prefix in `subnet_prefix_list`. | `list(string)` |  `["mgmt", "public", "dmz"]` |
   | `subnet_prefix_list` | - | Segment subnet prefixes. Specify one prefix for each segment from the `security_segment_names` list. | `list(string)` | `["192.168.1.0/24", "172.16.1.0/24", "10.160.1.0/24"]` |
   | `public_app_port` | - | DMZ application external TCP port | `number` | `80` |
   | `internal_app_port` | - | DMZ application internal TCP port receiving traffic from NGFW. Internal and external `public_app_port` TCP ports may be the same. | `number` | `8080` |
   | `trusted_ip_for_access_jump-vm` | Yes | List of IP addresses allowed to access the `jump` VM according to its inbound traffic rules | `list(string)` | `["A.A.A.A/32", "B.B.B.0/24"]` |
   | `jump_vm_admin_username` | - | `jump` VM username for SSH connections | `string` | `admin` |
   | `wg_port` | - | ‘jump` VM WireGuard inbound UDP port | `number` | `51820` |

   {% endcut %}

   {% note warning %}

   If you think you may need additinal segments later, add them now because you will not be able to add extra network interfaces to the NGFW VM once it is created. 

   {% endnote %}

1. Deploy your cloud resources with {{ TF }}:

   1. Initialize {{ TF }}:
       
      ```bash
      terraform init
      ```

   1. Check the {{ TF }} configuration:
       
      ```bash
      terraform validate
      ```

   1. Preview the list of new cloud resources:
       
      ```bash
      terraform plan
      ```

   1. Create resources:
       
      ```bash
      terraform apply
      ```

1. Once the process is completed, you will see the list of created resources. You can also display this list with the `terraform output` command:

   {% cut "Expand to see the list of deployed resources" %}

   | Name | Description | Value (example) |
   | ----------- | ----------- | ----------- |
   | `dmz-web-server_ip_address` | DMZ web server IP address. Used for testing the DMZ application and configuring destination NAT on the firewall. | `10.160.1.100` |
   | `fw-mgmt-server_ip_address` | Firewall management server IP address | `192.168.1.100` |
   | `fw_gaia_portal_mgmt-server_password` | Default password for the firewall management server HTTPS handshake | `admin` |
   | `fw_mgmt_ip_address` | Management network firewall IP address | `192.168.1.10` |
   | `fw_public_ip_address` | Public firewall IP address | `D.D.D.D` |
   | `fw_sic-password` | OTP for adding a firewall to the firewall management server | The `terraform output` command does not show this value. To see it, run `terraform output fw_sic-password`. |
   | `fw_smartconsole_mgmt-server_password` | Password for connecting to the firewall management server from the Check Point SmartConsole GUI | The `terraform output` command does not show this value. To see it, run `terraform output fw_smartconsole_mgmt-server_password`. |
   | `jump-vm_path_for_WireGuard_client_config` | WireGuard VPN `jump` VM connection configuration file | `./jump-vm-wg.conf` |
   | `jump-vm_public_ip_address_jump-vm` | `Jump` VM public IP | `E.E.E.E` |
   | `path_for_private_ssh_key` | SSH private key used to connect to the `jump` VM, firewall, management server, and DMZ web server | `./pt_key.pem` |
   
   {% endcut %}

## Configure the firewall gateway {#configure-gateway}

In this guide, you will configure a firewall with basic access control and NAT policies required for performance testing but insufficient for [production use](#deployment-requirements).

Learn more about Check Point features and configuration options with our free course, [A Deep Dive into Network Security](https://yandex.cloud/ru/training/network-security).

### Connect to the control segment through a VPN {#connect-via-vpn}

Once you deployed the infrastructure, the `mgmt` folder will contain an Ubuntu `jump-vm` instance with a configured [WireGuard VPN](https://www.wireguard.com/). Set up a VPN tunnel between your PC and `jump-vm` so you can access the `mgmt`, `dmz`, and `public` segment subnets.

To set up a VPN tunnel:

1. Get your Linux username:

   ```bash
   whoami
   ```

1. [Install](https://download.wireguard.com/windows-client/wireguard-installer.exe) WireGuard on your PC.
1. Open WireGuard and click **Add Tunnel**.
1. In the dialog that opens, select the `jump-vm-wg.conf` file in the `yc-network-segmentation-with-checkpoint` directory.
   To find a Linux, e.g., Ubuntu, directory, type the file path in the dialog address bar:

   ```bash
   \\wsl$\Ubuntu\home\<Ubuntu_user_name>\yc-network-segmentation-with-checkpoint
   ```
   
   Where `<Ubuntu_user_name>` is your Linux username you got in the previous step.

1. Click **Activate** to activate the tunnel.
1. Check whether you can connect to the management server through the VPN tunnel by running this command in the terminal:
   
   ```bash
   ping 192.168.1.100
   ```

   {% note warning %}

   If `ping` fails, make sure the `mgmt-jump-vm-sg` [security group](../../vpc/concepts/security-groups.md) inbound rules include your PC external IP address.

   {% endnote %}

### Run SmartConsole {#setup-smartconsole}

To set up and manage [Check Point](https://en.wikipedia.org/wiki/Check_Point), install and run the SmartConsole GUI client: 

1. Connect to the NGFW management server by opening `https://192.168.1.100` in your browser. 
1. Sign in using `admin` as both username and password. 
1. You will enter Gaia Portal where you can download the SmartConsole GUI client by clicking **Manage Software Blades using SmartConsole. Download Now!**.
1. Install SmartConsole on your PC.
1. Get the SmartConsole password:
   
   ```bash
   terraform output fw_smartconsole_mgmt-server_password
   ```

1. Open SmartConsole and sign in as `admin` with the password you got in the previous step, specifying, `192.168.1.100` as your management server IP address.

### Add the firewall gateway {#add-gateway}

Use the wizard to add the `FW` firewall gateway to the management server:

1. In the **Objects** top left drop-down list, select **More object types → Network Object → Gateways and Servers → New Gateway...**.
1. Click **Wizard Mode**.
1. In the dialog that opens, specify the following settings:
   * **Gateway name:** `FW`
   * **Gateway platform:** `CloudGuard IaaS`
   * **IPv4:** `192.168.1.10`
1. Click **Next**.
1. Get the firewall password:
   
   ```bash
   terraform output fw_sic-password
   ```

1. Enter the password in the **One-time password** field.
1. Click **Next**, and then **Finish**.

### Configure the firewall gateway network interfaces {#setup-gateways-fw}

Configure the `eth0` network interface:

1. In the **Gateways & Servers** tab, open the firewall gateway setup dialog. by double-clicking `FW`.
1. In the **Topology** table on the **Network Management** tab, select the `eth0` interface, click **Edit**, and then in the window that opens, click **Modify...**.
1. Under **Security Zone**, activate **Specify Security Zone** and select **InternalZone**.

In the same way, configure the `eth1` and `eth2` network interfaces:

1. For the `eth1` interface, specify **ExternalZone** under **Security Zone**.
1. For the `eth2` interface, select **Override** in the **Leads To** section and enable **Interface leads to DMZ**. Under **Security Zone**, specify **DMZZone**.

| Interface | IPv4 address/mask | Leads To | Security Zone | Anti Spoofing |
| ----------- | ----------- | ----------- | ----------- | ----------- |
| eth0 | 192.168.1.10/24 | This network (Internal) | InternalZone | Prevent and Log |
| eth1 | 172.16.1.10/24 | Internet (External) | ExternalZone | Prevent and Log |
| eth2 | 10.160.1.10/24 | This network, DMZ (Internal) | DMZZone | Prevent and Log |

### Create network objects {#create-network-objects}

1. In the **Objects** top left drop-down list, select **New Network...** and create `mgmt`, `public`, and `dmz` networks with the following settings:

   | Name | Network address | Net mask |
   | ----------- | ----------- | ----------- |
   | mgmt | 192.168.1.0 | 255.255.255.0 |
   | public | 172.16.1.0 | 255.255.255.0 |
   | dmz | 10.160.1.0 | 255.255.255.0 |

   For the DMZ network, configure Automatic Hide NAT rules to hide the addresses of DMZ-hosted internet-facing VMs behind the firewall public IP address. To do this:
      1. In the `dmz` network editing dialog, navigate to the **NAT** tab.
      1. Activate **Add automatic address translation rules**, select **Hide** from the drop-down list, and enable **Hide behind the gateway**.

1. In the **Objects** top left drop-down list, select **New Host...** and create `dmz-web-server` and `FW-public-IP` hosts with the following settings:

   | Name | IPv4 address |
   | ----------- | ----------- |
   | dmz-web-server | 10.160.1.100 |
   | FW-public-IP | 172.16.1.10 |

1. Select **More object types → Service → New TCP...** and create a TCP service named `TCP_8080` at port `8080` for the DMZ-hosted application.

### Define security policy rules {#define-policies}

To add a security rule:

1. In the **Security policies** tab, under **Access Control**, select **Policy**.
1. Right-click the rule table area and, in the context menu that opens, select **Above** or **Below** next to the **New Rule**.
1. In the new line that appears:
   * In the **Name** column, specify `Web-server port forwarding on FW`.
   * In the **Destination** column, select `FW-public-IP`.
   * In the **Services & Applications** column, select `http`.
   * In the **Action** column, select `Accept`.
   * In the **Track** column, select `Log`.

In the same way using the table below, add other rules allowing you to test firewall policies, run NLB health checks, publish a DMZ-hosted test application, and test its fault tolerance.

| No | Name | Source | Destination | VPN | Services & Applications | Action | Track | Install On |
| ----------- | ----------- | ----------- | ----------- | ----------- | ----------- | ----------- | ----------- | ----------- |
| 1 | Web-server port forwarding on FW | Any | FW-public-IP | Any | http | Accept | Log | Policy Targets (All gateways) |
| 2 | FW management | mgmt | FW, mgmt-server | Any | https, ssh | Accept | Log | Policy Targets (All gateways)  |
| 3 | Stealth | Any | FW, mgmt-server | Any | Any | Drop | Log | Policy Targets (All gateways) |
| 4 | mgmt to DMZ | mgmt | dmz | Any | Any | Accept | Log | Policy Targets (All gateways) |
| 5 | mgmt to public | mgmt | public | Any | Any | Accept | Log | Policy Targets (All gateways) |
| 6 | ping from dmz to internet | dmz | ExternalZone | Any | icmp-reguests (Group) | Accept | Log | Policy Targets (All gateways) |
| 7 | Cleanup rule | Any | Any | Any | Any | Drop | Log | Policy Targets (All gateways) |

{% cut "Access management policy rule description" %}

| Number | Name | Description |
| ----------- | ----------- | ----------- |
| 1 | Web-server port forwarding on FW | Allows internet access to the firewall TCP port 80 | 
| 2 | FW management | Allows access to the firewall and the firewall management server from the `mgmt` segment |
| 3 | Stealth | Blocks access to the firewall and the firewall management server from other segments |
| 4 | mgmt to DMZ | Allows access to DMZ from the `mgmt` segment |
| 5 | mgmt to public | Allows access from the `mgmt` segment to the `public` segment |
| 6 | ping from dmz to internet | Allows outbound ICMP packets from the DMZ segment to the internet; the rule is used for performance testing |
| 7 | Cleanup rule | Blocks other network traffic |

{% endcut %}

### Create a static NAT table {#setup-static-nat}

The destination NAT will route internet user requests to the DMZ-hosted web server.

It will translate packet headers, replacing the destination IP address and port number with the web server IP address and TCP port 8080, respectively.

To set up the firewall gateway NAT table:

1. Navigate to the **NAT** section under **Access Control**.
1. In the rule table menu, select **Add rule to top**.
1. In the new line that appears:
   * In the **Original Destination** column, select `FW-public-IP`.
   * In the **Original Services** column, select `http`.
   * In the **Translated Destination** column, select `dmz-web-server`.
   * In the **Translated Services** column, select `TCP_8080`.

   The new rule will appear in the NAT rule table:

   | No | Original Source | Original Destination | Original Services | Translated Source | Translated Destination | Translated Services | Install On |
   | ----------- | ----------- | ----------- | ----------- | ----------- | ----------- | ----------- | ----------- | 
   | 1 | Any | FW-public-IP | http | Original | dmz-web-server | TCP_8080 | Policy Targets (All gateways) |

###  Apply the security policy rules {#apply-policies}

1. Click **Install Policy** at the top left of the screen.
1. In the dialog that opens, click **Publish & Install**.
1. In the next dialog, click **Install** and wait for the process to complete.

## Test the solution {#test-functionality}

1. To get the firewall public IP address, run this command in the terminal:

   ```bash
   terraform output fw_public_ip_address
   ```

1. Make sure you can access your network infrastructure from the internet by opening the following address in your browser:

   ```bash
   http://<FW_public_IP_address>
   ```
   If your system is accessible from the internet, you will see the `Welcome to nginx!` page.

1. Make sure the firewall rules allowing traffic are active by navigating to the `yc-network-segmentation-with-checkpoint` directory on your PC and connecting to the DMZ-hosted VM over SSH:

   ```bash
   cd ~/yc-network-segmentation-with-checkpoint
   ssh -i pt_key.pem admin@<internal_IP_address_of_VM_in_DMZ_segment>
   ```

1. To check whether the DMZ-hosted VM has internet access, run this command:    

   ```bash
   ping ya.ru
   ```

   The `ping from dmz to internet` rule should allow the command to run.

1. Make sure the firewall traffic-blocking rules are active.
   To check that the `jump` VM in the `mgmt` segment is not accessible from DMZ, run this command: 

   ```bash
   ping 192.168.1.101
   ```

   The `Cleanup rule` should block the command.

1. In SmartConsole, navigate to the `Logs` tab of the `LOGS & MONITOR` section, find the entries made while you tested the firewall rules, and see which rules were applied.

## Production deployment requirements {#deployment-requirements}

* To ensure NGFW fault tolerance and applicatoin high availability, use [this recommended solution](../../tutorials/routing/high-accessible-dmz.md).
* Make sure to change the passwords transferred through the metadata service in `check-init...yaml` files:
   * SIC password for connecting the firewall and the firewall management server.
   * Check Point SmartConsole password.
   * Firewall management server admin password. You can change this password in Gaia Portal.
* Save the `pt_key.pem` private SSH key to a secure location or recreate it without using {{ TF }}.
* If you do not plan on using the `jump` VM further, delete its public IP address.
* If you plan to connect to the `mgmt` segment through the `jump` VM WireGuard VPN, change the WireGuard keys on the `jump` VM and your remote PC, e.g., admin workstation.
* Set up access control and NAT policies for your Check Point NGFW configuration.
* Set up security group rules for applications deployed in different segments.
* Do not assign public IP addresses to the VMs in the segments protected by the Check Point NGFW rules and routing, with the exception of the `mgmt` segment where routing tables do not use the `0.0.0.0/0` default route. 
* Select your preferred Check Point CloudGuard IaaS license and image (see [Next-Generation Firewall](#next-generation-firewall)).

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created, run this command:

   ```bash
   terraform destroy
   ```
   {{ TF }} will **permanently** delete all resources you created, including networks, subnets, VMs, folders, etc.

You can delete your resources faster by deleting all folders in {{ yandex-cloud }} console and then deleting the `terraform.tfstate` file from the `yc-network-segmentation-with-checkpoint` folder on your PC.