# Deploying a multiplayer server for GTA V in {{ yandex-cloud }}

To enable multiplayer mode in [Grand Theft Auto V](https://en.wikipedia.org/wiki/Grand_Theft_Auto_V) from Rockstar Games, you can deploy a multiplayer server on a [virtual machine](../../compute/concepts/vm.md) in {{ yandex-cloud }}.

To deploy a GTA V multiplayer server in {{ yandex-cloud }}:

1. [Prepare your cloud](#prepare-cloud).
1. [Create a security group](#create-sg).
1. [Create a VM for the GTA V server](#vm-gta-v).
1. [Install the required utilities and packages](#install-tools).
1. [Start the GTA V server](#launch-server).
1. [Test the solution](#test-functionality).

If you no longer need the resources you created, [delete them](#clear-out).

## Prepare your cloud {#prepare-cloud}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

The infrastructure support cost includes:

* Fee for continuously running VMs (see [{{ compute-full-name }}](../../compute/pricing.md) pricing).
* Fee for using public IP addresses and outgoing traffic (see [{{ vpc-full-name }}](../../vpc/pricing.md) pricing).


## Create a security group {#create-sg}

Create a [security group](../../vpc/concepts/security-groups.md) with a rule that allows traffic to ports `22005` and `22006`. These are the default ports in the GTA V server configuration file.

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select your folder.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
   1. In the left-hand panel, select ![image](../../_assets/vpc/security-group.svg) **{{ ui-key.yacloud.vpc.switch_security-groups }}**. 
   1. Click **{{ ui-key.yacloud.vpc.network.security-groups.button_create }}**.
   1. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-name }}** field, specify the name: `gta-v-sg`.
   1. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-network }}** field, select `default`.
   1. Under **{{ ui-key.yacloud.vpc.network.security-groups.forms.label_section-rules }}**, [create](../../vpc/operations/security-group-add-rule.md) the following traffic management rules:

      | Traffic<br/>direction | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} /<br/>{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} |
      | --- | --- | --- | --- | --- | --- |
      | Incoming | `sessions-u` | `22005` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` | | Incoming | `server-http` | `22006` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |

   1. Click **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

## Create a VM for the GTA V multiplayer server {#vm-gta-v}

1. Create an SSH key pair:
   ```bash
   ssh-keygen -t ed25519
   ```
   We recommend leaving the key file name unchanged.

1. Create a VM with a public IP address:

   {% list tabs group=instructions %}

   - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) to create your VM in.
      1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
      1. In the left-hand panel, select ![image](../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.switch_instances }}**.
      1. Click **{{ ui-key.yacloud.compute.instances.button_create }}**.      
      1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, in the **{{ ui-key.yacloud.compute.instances.create.placeholder_search_marketplace-product }}** field, enter `Ubuntu 22.04 LTS` and select a public [Ubuntu 22.04 LTS](/marketplace/products/yc/ubuntu-22-04-lts) image.
      1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}**, select an [availability zone](../../overview/concepts/geo-scope.md) to place your VM in.
      1. Under **{{ ui-key.yacloud.compute.instances.create.section_storages }}**, select the `{{ ui-key.yacloud.compute.value_disk-type-network-hdd }}` [disk type](../../compute/concepts/disk.md#disks_types) and specify the size: `20 {{ ui-key.yacloud.common.units.label_gigabyte }}`.
      1. Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**, navigate to the `{{ ui-key.yacloud.component.compute.resources.label_tab-custom }}` tab and specify the required [platform](../../compute/concepts/vm-platforms.md), number of vCPUs, and the amount of RAM:

          * **{{ ui-key.yacloud.component.compute.resources.field_platform }}**: `Intel Ice Lake`.
          * **{{ ui-key.yacloud.component.compute.resources.field_cores }}**: `2`.
          * **{{ ui-key.yacloud.component.compute.resources.field_core-fraction }}**: `100%`.
          * **{{ ui-key.yacloud.component.compute.resources.field_memory }}**: `2 {{ ui-key.yacloud.common.units.label_gigabyte }}`.

      1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

          * In the **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** field, select the network and subnet to connect your VM to. If the required [network](../../vpc/concepts/network.md#network) or [subnet](../../vpc/concepts/network.md#subnet) is not listed, [create it](../../vpc/operations/subnet-create.md).
          * Under **{{ ui-key.yacloud.component.compute.network-select.field_external }}**, keep `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}` to assign your VM a random external IP address from the {{ yandex-cloud }} pool or select a static address from the list if you reserved one in advance.
          * In the **{{ ui-key.yacloud.component.compute.network-select.field_security-groups }}** field, select the `gta-v-sg` security group you created earlier.

      1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, select **{{ ui-key.yacloud.compute.instance.access-method.label_oslogin-control-ssh-option-title }}** and specify the VM access data:

          * In the **{{ ui-key.yacloud.compute.instances.create.field_user }}** field, enter a username, e.g., `ubuntu`. Do not use `root` or other names reserved by the OS. To perform operations requiring superuser permissions, use the `sudo` command.
          * {% include [access-ssh-key](../../_includes/compute/create/access-ssh-key.md) %}

      1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**, specify the VM name: `gta-v-server`.
      1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

   {% endlist %}

## Install the required utilities and packages {#install-tools}

1. [Use SSH to connect](../../compute/operations/vm-connect/ssh.md#vm-connect) to the created VM.
1. Install the required `toolchain` packages from the Ubuntu-Toolchain repository, `libstdc++6`, `libatomic1`, and the `screen` utility to run the terminal session in background mode:

   ```bash
   sudo add-apt-repository -y ppa:ubuntu-toolchain-r/test
   sudo apt update -y && sudo apt install libstdc++6 libatomic1 screen
   ```

1. Download the server distribution to the current directory:

   ```bash
   wget https://cdn.rage.mp/updater/prerelease/server-files/linux_x64.tar.gz
   ```

1. Unpack the archive:

   ```bash
   tar -xzf linux_x64.tar.gz
   ```

1. Go to the directory with the server and make the `ragemp-server` file executable:

   ```bash
   cd ragemp-srv
   chmod +x ragemp-server
   ```

1. If you want, you can install the RAGE.MP Freeroam package. RAGE.MP Freeroam is a simple modification that gives multiplayer users access to all skins, weapons, and vehicles. Players can also restore health and defense. To install the package:

   1. Go to the directory with the installed server:

   ```bash
   cd ~/ragemp-srv
   ```

   1. Download the mod distribution from the GitHub developer page:

   ```bash
   git clone https://github.com/n-n1ks/rage.mp-freeroam.git
   ```

   1. Go to the `rage.mp-freeroam` repository directory and copy the required folders:

   ```bash
   cd rage.mp-freeroam
   cp -r ./client_packages/* ../client_packages/
   cp -r ./packages/* ../packages/
   ```

## Start the GTA V server {#launch-server}

1. Run the background screen session:

   ```bash
   screen
   ```

1. In the background session, run the server:

   ```bash
   ./ragemp-server
   ```

   Make sure you get _The server is ready to accept connections_ in the output:

   ```bash
   [INFO] Starting RAGE Multiplayer server...

   [============================================================]
   ||
   ||      MaxPlayers              100
   ||      Sync rate               40ms
   ||      Name                    RAGE:MP Unofficial server
   ||      Gamemode                freeroam
   ||      Streaming distance      300
   ||      Announcement            disabled
   ||      Voice chat              disabled
   ||      Address                 127.0.0.1:22005
   ||      Connection limits       disabled
   ||      Encryption              enabled
   ||      NodeJS                  enabled
   ||      C#                      disabled
   ||
   [============================================================]


   [INFO] Loading NodeJS packages...
   [INFO] Starting packages...
   [DONE] Server packages have been started.
   [DONE] Started resource transfer server at 22006 port.
   [DONE] Client-side packages weight: 0.000000 MB (uncompressed: 0.000000 MB).
   [INFO] Initializing networking...
   [DONE] Networking has been started: (IPv4-only) at 127.0.0.1:22005
   [DONE] The server is ready to accept connections.
   ```

## Test the solution {#test-functionality}

1. Download and install [RageMP](https://rage.mp/ru) on the computer with GTA 5:

   ```url
   https://cdn.rage.mp/public/files/RAGEMultiplayer_Setup.exe
   ```

1. Run Grand Theft Auto V via RageMP. 
1. In the multiplayer window, click the direct server connection icon.
1. In the dialog box that opens, specify your VM’s public IP address and port `22005`.
1. Connect to the server by clicking **Connect**. 
1. If you have configured RAGE.MP Freeroam, press F2 to reveal the additional options menu.

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:
1. In {{ compute-name }}, [delete](../../compute/operations/vm-control/vm-delete.md) the VM you created.
1. In {{ vpc-name }}, [delete](../../vpc/operations/security-group-delete.md) the created security group.