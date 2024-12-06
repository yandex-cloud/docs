# Deploying a Minecraft server in {{ yandex-cloud }}

Follow this tutorial to deploy the current version of [Minecraft](https://www.minecraft.net/) ([Java Edition](https://www.minecraft.net/en-us/store/minecraft-java-edition/)) server in {{ yandex-cloud }} on a [virtual machine](../../compute/concepts/vm.md) running Ubuntu 22.04.

To deploy a Minecraft server of the current version in {{ yandex-cloud }}:

1. [Prepare your cloud](#prepare-cloud).
1. [Create a security group](#create-sg).
1. [Create a VM for the Minecraft server](#vm-minecraft).
1. [Install the required utilities](#install-tools).
1. [Download and run the Minecraft server](#get-and-launch-server).
1. [Test the solution](#test-functionality).

If you no longer need the resources you created, [delete them](#clear-out).

## Prepare your cloud {#prepare-cloud}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

The infrastructure support cost includes:

* Fee for continuously running VMs (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* Fee for using public IP addresses and outgoing traffic (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).


## Create a security group {#create-sg}

Create a [security group](../../vpc/concepts/security-groups.md) with a rule allowing traffic to port `25565`. This port is set by default in the server configuration file.

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select your folder.
   1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
   1. In the left-hand panel, select ![image](../../_assets/vpc/security-group.svg) **{{ ui-key.yacloud.vpc.switch_security-groups }}**. 
   1. Click **{{ ui-key.yacloud.vpc.network.security-groups.button_create }}**.
   1. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-name }}** field, specify the name: `minecraft-sg`.
   1. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-network }}** field, select `default`.
   1. Under **{{ ui-key.yacloud.vpc.network.security-groups.forms.label_section-rules }}**, [create](../../vpc/operations/security-group-add-rule.md) the following traffic management rules:

      | Traffic<br/>direction | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }} /<br/>{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }} | {{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }} |
      | --- | --- | --- | --- | --- | --- |
      | Incoming | `any`           | `25565` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
      | Incoming | `any`           | `22`    | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |
      | Outgoing | `any`           | `25565` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}` | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}` | `0.0.0.0/0` |

   1. Click **{{ ui-key.yacloud.common.save }}**.

{% endlist %}

## Create a VM for the Minecraft server {#vm-minecraft}

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
      1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, select the [Ubuntu 22.04 LTS](/marketplace/products/yc/ubuntu-22-04-lts) image.
      1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}**, select an [availability zone](../../overview/concepts/geo-scope.md) to place your VM in.
      1. Under **{{ ui-key.yacloud.compute.instances.create.section_storages }}**, configure the boot [disk](../../compute/concepts/disk.md):

          * **{{ ui-key.yacloud.compute.disk-form.field_type }}**: `{{ ui-key.yacloud.compute.value_disk-type-network-hdd }}`.
          * **{{ ui-key.yacloud.compute.disk-form.field_size }}**: `18 {{ ui-key.yacloud.common.units.label_gigabyte }}`.

      1. Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**, navigate to the **{{ ui-key.yacloud.component.compute.resources.label_tab-custom }}** tab and specify the Minecraft server recommended parameters:

          * **{{ ui-key.yacloud.component.compute.resources.field_platform }}**: `Intel Ice Lake`.
          * **{{ ui-key.yacloud.component.compute.resources.field_cores }}**: `2`.
          * **{{ ui-key.yacloud.component.compute.resources.field_core-fraction }}**: `100%`.
          * **{{ ui-key.yacloud.component.compute.resources.field_memory }}**: `2 {{ ui-key.yacloud.common.units.label_gigabyte }}`.

      1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

          * In the **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** field, enter the ID of a subnet in the new VM’s availability zone. Alternatively, you can select a [cloud network](../../vpc/concepts/network.md#network) from the list.

              * Each network must have at least one [subnet](../../vpc/concepts/network.md#subnet). If there is no subnet, create one by selecting **{{ ui-key.yacloud.component.vpc.network-select.button_create-subnetwork }}**.
              * If you do not have a network, click **{{ ui-key.yacloud.component.vpc.network-select.button_create-network }}** to create one:

                  * In the window that opens, enter the network name and select the folder to host the network.
                  * (Optional) Select the **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}** option to automatically create subnets in all availability zones.
                  * Click **{{ ui-key.yacloud.vpc.networks.create.button_create }}**.

          * In the **{{ ui-key.yacloud.component.compute.network-select.field_external }}** field, select `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}` to assign the VM a random external IP address from the {{ yandex-cloud }} pool or select a static address from the list if you reserved one in advance.
          * In the **{{ ui-key.yacloud.component.compute.network-select.field_security-groups }}** field, select the `minecraft-sg` security group you created earlier.

      1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, select **{{ ui-key.yacloud.compute.instance.access-method.label_oslogin-control-ssh-option-title }}** and specify the information required to access the VM:

          * In the **{{ ui-key.yacloud.compute.instances.create.field_user }}** field, enter a name for the user you want to create on the VM, e.g., `ubuntu`.

            {% note alert %}

            Do not use `root` or other usernames reserved by the operating system. To perform operations requiring superuser permissions, use the `sudo` command.

            {% endnote %}

          * {% include [access-ssh-key](../../_includes/compute/create/access-ssh-key.md) %}

      1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**, specify the VM name: `minecraft-server`.
      1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

   {% endlist %}

   Recommended virtual machine configuration:

   | Configuration     |   Number of players  |   vCPU  |   RAM  |   Disk size        |
   |------------------|-----------------------|---------|--------|----------------------|
   |   Minimum    |   1-4                 |   2     |   1GB  |   minimum 150MB HDD  |
   |   Recommended  |   5-10                |   2     |   2GB  |   minimum 200MB HDD  |
   |   Ideal         |   10+                 |   4     |   4GB  |   minimum 200MB SSD  |

   {% note warning %}

   Note that this configuration table reflects the default settings defined in `server.properties`. The bigger the world grows, the higher the requirements, especially for RAM. The larger the rendered areas of the game world, villages, and other dynamic objects, the higher the virtual server requirements.

   {% endnote %}

## Install the required utilities {#install-tools}

1. [Use SSH to connect](../../compute/operations/vm-connect/ssh.md#vm-connect) to the created VM.
1. Install the necessary Java packages from the repository and the `screen` utility to run the terminal session in background mode:

   ```bash
   sudo add-apt-repository -y ppa:openjdk-r/ppa && sudo apt update -y && sudo apt install -y openjdk-17-jre-headless screen
   ```

## Download and run the Minecraft server {#get-and-launch-server}

1. Create a separate directory and navigate to it:
   ```bash
   mkdir minecraft-server && cd minecraft-server
   ```

1. Follow the [link](https://www.minecraft.net/en-us/download/server/) and copy the URL to download the distribution of the current server version.
1. Download the distribution to the current directory using `wget`:
   ```bash
   wget -O minecraft_server_1.20.4.jar https://piston-data.mojang.com/v1/objects/8dd1a28015f51b1803213892b50b7b4fc76e594d/server.jar
   ```

1. Create the `eula.txt` file to automatically accept the terms of the [EULA](https://aka.ms/MinecraftEULA):

   ```bash
   cat << EOF > eula.txt
   eula=true
   EOF
   ```

1. Run the background `screen` session:

   ```bash
   screen
   ```

1. In the background session, run the server:

   ```bash
   java -Xms1024M -Xmx1024M -jar minecraft_server_1.20.4.jar nogui
   ```

   Wait for the game world to be successfully completed.

   ```text
   [09:18:58] [Worker-Main-2/INFO]: Preparing spawn area: 81%
   [09:18:59] [Worker-Main-2/INFO]: Preparing spawn area: 82%
   [09:19:00] [Worker-Main-2/INFO]: Preparing spawn area: 83%
   ...
   [09:19:08] [Worker-Main-2/INFO]: Preparing spawn area: 97%
   [09:19:09] [Server thread/INFO]: Time elapsed: 75917 ms
   [09:19:09] [Server thread/INFO]: Done (92.666s)! For help, type "help"
   ```

   
1. (Optional) You can leave the `screen` session running in the background using the `control + a + d` hotkeys and return to the main terminal of the VM.

   To return to the background session with the server running, if there is only one such background session, run the following command:

   ```bash
   screen -r
   ```

   If there are multiple background sessions, get a list of them by running the following command:

   ```bash
   screen -list
   ```

   Result:

   ```text
   There is a screen on:
      24257.pts-0.mcft-test	(02/28/2024 09:17:15 AM)	(Detached)
   1 Socket in /run/screen/S-username.
   ```

   Then enter the session using its ID from the list:
   
   ```bash
   screen -r 24257
   ```

1. After running the server, new directories and the necessary files for server operation and configuration will be created in the directory, including the logs:

   ```text
       4096 Mar 16 09:50 .
       4096 Mar 16 09:52 ..
          2 Mar 16 09:16 banned-ips.json
          2 Mar 16 09:16 banned-players.json
         10 Mar 16 09:48 eula.txt
       4096 Mar 16 09:50 libraries
       4096 Mar 16 09:16 logs
   49150256 Dec  7 09:04 minecraft_server_1.20.4.jar
          2 Mar 16 09:16 ops.json
       1303 Mar 16 09:16 server.properties
          2 Mar 16 09:16 usercache.json
       4096 Mar 16 09:50 versions
          2 Mar 16 09:50 whitelist.json
       4096 Mar 16 09:13 world
   ```

## Test the solution {#test-functionality}

1. Add the server to the list of servers in the Minecraft client. Give the server a name of your choice. In the **Server address** field, specify the [public IP address](../../vpc/concepts/address#public-addresses) assigned to our virtual machine when it was created.

   ![add-server-address](../../_assets/tutorials/infrastructure/minecraft-add-server-address.png =750x447)

1. In the list of servers, select the server you added and click `Connect`.

   ![server-list](../../_assets/tutorials/infrastructure/minecraft-server-list.png =750x449)

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:
1. In {{ compute-name }}, [delete](../../compute/operations/vm-control/vm-delete.md) the VM you created.
1. In {{ vpc-name }}, [delete](../../vpc/operations/security-group-delete.md) the created security group.
