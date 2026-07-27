# Deploying a Minecraft server in {{ yandex-cloud }}

Follow this tutorial to deploy the current version of a [Minecraft](https://www.minecraft.net/) ([Java Edition](https://www.minecraft.net/en-us/download/server) or [Bedrock Edition](https://www.minecraft.net/en-us/download/server/bedrock)) server in {{ yandex-cloud }} on an Ubuntu 24.04 [VM](../../compute/concepts/vm.md).

To deploy a Minecraft server in {{ yandex-cloud }}:

1. [Get your cloud ready](#prepare-cloud).
1. [Create a security group](#create-sg).
1. [Create a VM for the Minecraft server](#vm-minecraft).
1. [Install the utilities and start the server](#install-and-launch-server).
1. [Test the server](#test-functionality).

If you no longer need the resources you created, [delete them](#clear-out).


## Get your cloud ready {#prepare-cloud}

{% include [before-you-begin](../../_tutorials/_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

The infrastructure support cost includes:
* Fee for a continuously running [VM](../../compute/concepts/vm.md) (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* Fee for a public IP address and outgoing traffic (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).

## Create a security group {#create-sg}

Create a [security group](../../vpc/concepts/security-groups.md) with a rule allowing incoming traffic on port `25565` for Java Edition or `19132` for Bedrock Edition. These are the default ports for client access in the Minecraft server configuration file. Also, rules allowing SSH access to the VM to configure the server and VM access to the internet to download software will be added to the security group.

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select your folder.
   1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_vpc }}**.
   1. In the left-hand panel, select ![image](../../_assets/vpc/security-group.svg) **{{ ui-key.yacloud.vpc.label_security-groups }}**. 
   1. Click **{{ ui-key.yacloud.vpc.network.security-groups.button_create }}**.
   1. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-name }}** field, specify the name: `minecraft-sg`.
   1. In the **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-network }}** field, select `default`.
   1. Under **{{ ui-key.yacloud.vpc.network.security-groups.label_section-rules }}**, [create](../../vpc/operations/security-group-add-rule.md) the following traffic management rules:

      #|
      || **Traffic**
      **direction**
      | **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-description }}**
      | **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**
      | **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**
      | **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-source }}** /
      **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}**
      | **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}** ||
      || Inbound
      | `Client access to the Minecraft server`
      | `25565`/`19132`
      | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}`
      | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`
      | `0.0.0.0/0` ||
      || Inbound
      | `SSH access to the VM`
      | `22`
      | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}`
      | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`
      | `0.0.0.0/0` ||
      || Outbound
      | `VM internet access`
      | `0-65535`
      | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_any }}`
      | `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`
      | `0.0.0.0/0` ||
      |#

   1. Click **{{ ui-key.yacloud.common.save }}**.

{% endlist %}


## Create a VM for the Minecraft server {#vm-minecraft}

1. [Create](../../compute/operations/vm-connect/ssh.md#creating-ssh-keys) an SSH key pair:
   ```bash
   ssh-keygen -t ed25519
   ```
   We recommend sticking with the default key file name.

1. Create a VM with a public IP address:

   {% list tabs group=instructions %}

   - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) where you want to create your VM.
      1. Navigate to **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
      1. In the left-hand panel, select ![image](../../_assets/console-icons/server.svg) **{{ ui-key.yacloud.compute.instances_jsoza }}**.
      1. Click **{{ ui-key.yacloud.compute.instances.button_create }}**.
      1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, select [Ubuntu 24.04 LTS](/marketplace/products/yc/ubuntu-24-04-lts).
      1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}**, select an [availability zone](../../overview/concepts/geo-scope.md) where your VM will reside.
      1. Under **{{ ui-key.yacloud.compute.instances.create.section_storages }}**, configure the boot [disk](../../compute/concepts/disk.md):

          * **{{ ui-key.yacloud.compute.disk-form.field_type }}**: `{{ ui-key.yacloud.compute.value_disk-type-network-hdd_cw9XD }}`.
          * **{{ ui-key.yacloud.compute.disk-form.field_size }}**: `18 {{ ui-key.yacloud.common.units.label_gigabyte }}`.

      1. Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**, navigate to the **{{ ui-key.yacloud.component.compute.resources.label_tab-custom }}** tab and specify the Minecraft server recommended parameters:

          * **{{ ui-key.yacloud.component.compute.resources.field_platform }}**: `Intel Ice Lake`
          * **{{ ui-key.yacloud.component.compute.resources.field_cores }}**: `2`
          * **{{ ui-key.yacloud.component.compute.resources.field_core-fraction }}**: `100%`.
          * **{{ ui-key.yacloud.component.compute.resources.field_memory }}**: `2 {{ ui-key.yacloud.common.units.label_gigabyte }}` for Java Edition or `4 {{ ui-key.yacloud.common.units.label_gigabyte }}` for Bedrock Edition.

      1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

          * In the **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** field, enter the ID of a subnet in the new VM’s availability zone. Alternatively, select a [cloud network](../../vpc/concepts/network.md#network) from the list.

              * Each network must have at least one [subnet](../../vpc/concepts/network.md#subnet). If there is no subnet, create one by selecting **{{ ui-key.yacloud.component.vpc.network-select.button_create-subnetwork }}**.
              * If there are no networks in the list, click **{{ ui-key.yacloud.component.vpc.network-select.button_create-network }}** to create one:

                  * In the window that opens, specify the network name and select the folder where it will be created.
                  * Optionally, enable the **{{ ui-key.yacloud.vpc.networks.create.field_is-default }}** setting to automatically create subnets in all availability zones.
                  * Click **{{ ui-key.yacloud.vpc.networks.create.button_create }}**.

          * In the **{{ ui-key.yacloud.component.compute.network-select.field_external }}** field, select `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}` to assign the VM a random external IP address from the {{ yandex-cloud }} pool. Alternatively, select a static address from the list if you reserved one.
          * In the **{{ ui-key.yacloud.component.compute.network-select.field_security-groups }}** field, select the `minecraft-sg` security group you created earlier.

      1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, select **{{ ui-key.yacloud.compute.instance.access-method.label_oslogin-control-ssh-option-title }}** and specify the VM access credentials:

          * In the **{{ ui-key.yacloud.compute.instances.create.field_user }}** field, enter a name for the user you want to create on the VM, e.g., `ubuntu`.

            {% note alert %}

            Do not use `root` or other OS-reserved usernames. For operations requiring root privileges, use the `sudo` command.

            {% endnote %}

          * {% include [access-ssh-key](../../_includes/compute/create/access-ssh-key.md) %}

      1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**, specify the VM name: `minecraft-server`.
      1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

   {% endlist %}

   Recommended virtual machine configuration for Java Edition:

   | Configuration     |   Number of players  |   vCPU  |   RAM  |   Disk size        |
   |------------------|-----------------------|---------|--------|----------------------|
   |   Minimum    |   1-4                 |   2     |   1GB  |   150MB HDD or more  |
   |   Recommended  |   5-10                |   2     |   2GB  |   200MB HDD or more  |
   |   Ideal         |   10+                 |   4     |   4GB  |   200MB SSD or more  |

   {% note warning %}

   Note that this configuration table is in line with the default settings defined in `server.properties`. The bigger the game world grows, the higher the requirements, especially for RAM. In addition, larger rendered areas, villages, and other dynamic objects will result in higher virtual server requirements.

   {% endnote %}


## Install the utilities and start the server {#install-and-launch-server}

{% list tabs group=edition %}

- Java Edition {#java}

   1. [Use SSH to connect](../../compute/operations/vm-connect/ssh.md#vm-connect) to the VM you created.

   1. Install the required Java packages from the repository and the `screen` utility to run the terminal session in background mode:

      {% note info %}

      The command below installs JRE version `25`. To start the current Minecraft server version, you may need a newer JRE version. Therefore, check the suitable JRE version on [Minecraft Wiki](https://minecraft.wiki/w/Tutorial:Setting_up_a_Java_Edition_server#Version_requirements) before you install this package.

      {% endnote %}

      ```bash
      sudo apt update -y \
         && sudo apt install -y openjdk-25-jre-headless screen
      ```

   1. Create a separate system user named `minecraft` to start the server:

      ```bash
      sudo useradd -r -m -d /opt/minecraft-server -s /bin/bash minecraft
      ```

      Where:
      * `-r`: Creating a system user.
      * `-m -d /opt/minecraft-server`: Creating the user’s home directory at `/opt/minecraft-server`. It will contain the server files.
      * `-s /bin/bash`: Assigning the `bash` shell for the user.

   1. Follow [this link](https://www.minecraft.net/en-us/download/server/) and copy the URL to download the distribution of the current server version.

   1. Download the current distribution to the server directory using `wget`:

      ```bash
      sudo wget -O /opt/minecraft-server/minecraft_server.jar <download_link>
      ```

      Where `<download_link>` is the distribution download link you got in the previous step. Here is an example: `https://piston-data.mojang.com/v1/objects/97ccd4c0ed3f81bbb7bfacddd1090b0c56f9bc51/server.jar`

   1. Create the `eula.txt` file to automatically accept the [EULA](https://aka.ms/MinecraftEULA) terms:

      ```bash
      echo "eula=true" | sudo tee /opt/minecraft-server/eula.txt
      ```

   1. Grant the `minecraft` user the following permissions for the server directory and all its contents:

      ```bash
      sudo chown -R minecraft:minecraft /opt/minecraft-server
      ```

   1. In the server directory, run the `screen` background session on behalf of the `minecraft` user:

      ```bash
      sudo -u minecraft bash -c 'cd /opt/minecraft-server && screen -S minecraft'
      ```

   1. In the background session, run the server:

      ```bash
      java -Xms1024M -Xmx1024M -jar minecraft_server.jar nogui
      ```

      Wait for the game world to be created.

      ```text
      [14:16:47] [Server thread/INFO]: Preparing level "world"
      [14:16:48] [Server thread/INFO]: Selecting global world spawn...
      [14:17:05] [Server thread/INFO]: Loading 0 persistent chunks...
      ...
      [14:17:05] [Server thread/INFO]: Preparing spawn area: 100%
      [14:17:05] [Server thread/INFO]: Time elapsed: 17317 ms
      [14:17:05] [Server thread/INFO]: Done (17.788s)! For help, type "help"
      ```

   1. Optionally, you can leave the `screen` session running in the background by pressing **Ctrl + A + D** and return to the VM main terminal.

      If there is only one such background session with the server running and you want to return to it, run the following command:

      ```bash
      sudo -u minecraft screen -r
      ```

      If there are multiple background sessions, get their list by running the following command:

      ```bash
      sudo -u minecraft screen -list
      ```

      Result:

      ```text
      There is a screen on:
         35154.minecraft (06/12/26 14:15:56)     (Detached)
      1 Socket in /run/screen/S-minecraft.
      ```

      Then, enter the session using its ID from the list:

      ```bash
      sudo -u minecraft screen -r 35154
      ```

      {% note info %}

      The `minecraft` user does not have a password or SSH key, so you cannot connect to the VM directly on their behalf. To perform operations under this user, connect to the VM over SSH with your credentials and switch to `minecraft` using the following command:

      ```bash
      sudo -iu minecraft
      ```

      This will start a login session, and `/opt/minecraft-server` will instantly become the current directory. To return to your session, run the `exit` command or press **Ctrl + D**.

      {% endnote %}

   1. After running the server, in the directory, you will see new directories and the files required for server operation and configuration, including the logs:

      ```text
          4096 Jun 12 14:16 .
          4096 Jun 12 14:07 ..
           220 Mar 31  2024 .bash_logout
          3771 Mar 31  2024 .bashrc
          4096 Jun 12 14:16 .cache
           807 Mar 31  2024 .profile
             2 Jun 12 14:16 banned-ips.json
             2 Jun 12 14:16 banned-players.json
            10 Jun 12 14:10 eula.txt
          4096 Jun 12 14:16 libraries
          4096 Jun 12 14:16 logs
      60417480 Apr  9 10:20 minecraft_server.jar
             2 Jun 12 14:16 ops.json
          1676 Jun 12 14:16 server.properties
             2 Jun 12 14:16 usercache.json
          4096 Jun 12 14:16 versions
             2 Jun 12 14:16 whitelist.json
          4096 Jun 12 14:18 world
      ```

- Bedrock Edition {#bedrock}

   1. [Use SSH to connect](../../compute/operations/vm-connect/ssh.md#vm-connect) to the VM you created.

   1. Install the `screen` utility to run the terminal session in background mode and the `unzip` utility to unpack the distribution:

      ```bash
      sudo apt update -y \
         && sudo apt install -y screen unzip
      ```

   1. Create a separate system user named `minecraft` to start the server:

      ```bash
      sudo useradd -r -m -d /opt/minecraft-server -s /bin/bash minecraft
      ```

      Where:
      * `-r`: Creating a system user.
      * `-m -d /opt/minecraft-server`: Creating the user’s home directory at `/opt/minecraft-server`. It will contain the server files.
      * `-s /bin/bash`: Assigning the `bash` shell for the user.

   1. Follow [this link](https://www.minecraft.net/en-us/download/server/bedrock) and copy the URL to download the distribution of the current server version.

   1. Download the current distribution to the server directory using `wget`:

      ```bash
      sudo wget -O /opt/minecraft-server/bedrock-server.zip <download_link>
      ```

      Where `<download_link>` is the distribution download link you got in the previous step. Here is an example: `https://www.minecraft.net/bedrockdedicatedserver/bin-linux/bedrock-server-1.26.23.1.zip`

   1. Unpack the distribution archive to the server directory, then delete the archive:

      ```bash
      sudo unzip /opt/minecraft-server/bedrock-server.zip -d /opt/minecraft-server \
         && sudo rm /opt/minecraft-server/bedrock-server.zip
      ```

   1. Grant the `minecraft` user the following permissions for the unpacked files:

      ```bash
      sudo chown -R minecraft:minecraft /opt/minecraft-server
      ```

   1. In the server directory, run the `screen` background session on behalf of the `minecraft` user:

      ```bash
      sudo -u minecraft bash -c 'cd /opt/minecraft-server && screen -S minecraft'
      ```

   1. In the background session, run the server. The Bedrock Edition server requires libraries from the server directory, so make sure to specify it in the `LD_LIBRARY_PATH` variable:

      ```bash
      LD_LIBRARY_PATH=. ./bedrock_server
      ```

      Wait until you see the message confirming that the server is ready:

      ```text
      [2026-06-14 13:36:44:060 INFO] Starting Server
      [2026-06-14 13:36:44:060 INFO] Version: 1.26.23.1
      [2026-06-14 13:36:44:060 INFO] Session ID: 4a018b28-5121-4abe-a814-e4ee70455c37
      [2026-06-14 13:36:44:060 INFO] Build ID: 45295249
      [2026-06-14 13:36:44:060 INFO] Branch: r/26_u2
      [2026-06-14 13:36:44:060 INFO] Commit ID: 49b09b8167bf5f877690429d12747f30342d1db6
      [2026-06-14 13:36:44:060 INFO] Configuration: Publish
      [2026-06-14 13:36:44:060 INFO] Level Name: Bedrock level
      [2026-06-14 13:36:44:061 INFO] No CDN config file found at: cdn_config.json for dedicated server
      [2026-06-14 13:36:44:061 INFO] Game mode: 0 Survival
      [2026-06-14 13:36:44:061 INFO] Difficulty: 1 EASY
      [2026-06-14 13:36:44:063 WARN] Content logging to console is disabled.  Enable it with content-log-console-output-enabled=true in server.properties
      [2026-06-14 13:36:44:608 INFO] Opening level 'worlds/Bedrock level/db'
      [2026-06-14 13:36:44:626 INFO] Pack Stack - None
      [2026-06-14 13:36:45:565 INFO] IPv4 supported, port: 19132: Used for gameplay and LAN discovery
      [2026-06-14 13:36:45:565 INFO] IPv6 supported, port: 19133: Used for gameplay
      [2026-06-14 13:36:45:605 INFO] Waiting for Minecraft services...
      [2026-06-14 13:36:45:806 INFO] Server started.
      ```

   1. Optionally, you can leave the `screen` session running in the background by pressing **Ctrl + A + D** and return to the VM main terminal.

      If there is only one such background session with the server running and you want to return to it, run the following command:

      ```bash
      sudo -u minecraft screen -r
      ```

      If there are multiple background sessions, get their list by running the following command:

      ```bash
      sudo -u minecraft screen -list
      ```

      Result:

      ```text
      There is a screen on:
         30989.minecraft (06/17/26 12:23:18)     (Detached)
      1 Socket in /run/screen/S-minecraft.
      ```

      Then, enter the session using its ID from the list:

      ```bash
      sudo -u minecraft screen -r 30989
      ```

      {% note info %}

      The `minecraft` user does not have a password or SSH key, so you cannot connect to the VM directly on their behalf. To perform operations under this user, connect to the VM over SSH with your credentials and switch to `minecraft` using the following command:

      ```bash
      sudo -iu minecraft
      ```

      This will start a login session, and `/opt/minecraft-server` will instantly become the current directory. To return to your session, run the `exit` command or press **Ctrl + D**.

      {% endnote %}

   1. After running the server, in the directory, you will see new directories and the files required for server operation and configuration:

      ```text
           4096 Jun 14 13:49 .
           4096 Jun 14 12:43 ..
             36 Jun 14 13:49 .bash_history
            220 Mar 31  2024 .bash_logout
           3771 Mar 31  2024 .bashrc
            807 Mar 31  2024 .profile
              0 Jun 15 12:56 Dedicated_Server.txt
              3 May 20 23:35 allowlist.json
      222788240 May 20 23:36 bedrock_server
          31241 May 20 23:35 bedrock_server_how_to.html
           4096 May 20 23:36 behavior_packs
           4096 May 20 23:36 config
           4096 May 20 23:36 data
           4096 May 20 23:36 definitions
           4096 Jun 14 13:36 development_behavior_packs
           4096 Jun 14 13:36 development_resource_packs
           4096 Jun 14 13:36 development_skin_packs
           4096 Jun 14 13:36 minecraftpe
            484 May 20 23:35 packetlimitconfig.json
              3 May 20 23:35 permissions.json
           4096 Jun 14 13:36 premium_cache
           8548 May 20 23:17 profanity_filter.wlist
            398 May 20 23:35 release-notes.txt
           4096 May 20 23:36 resource_packs
          11650 May 20 23:35 server.properties
           4096 Jun 14 13:36 treatments
           4096 Jun 14 13:36 world_templates
           4096 Jun 14 13:36 worlds
      ```

{% endlist %}

## Test the server {#test-functionality}

{% list tabs group=edition %}

- Java Edition {#java}

   1. Download and install the [Minecraft client](https://www.minecraft.net/en-us/download).

   1. Run Minecraft Java Edition.

   1. Click **Multiplayer**.


   1. Select **Direct Connection**.


   1. In the **Server address** field, specify the [public IP address](../../vpc/concepts/address.md#public-addresses) of the `minecraft-server` VM and click **Join Server**.



- Bedrock Edition {#bedrock}

   1. Download and install the [Minecraft client](https://www.minecraft.net/en-us/download).

   1. Run Minecraft Bedrock Edition.

   1. Click **Start**.


   1. Select **Server**, then click **+ Add server**.


   1. Give the server a name of your choice. In the **Server address** field, specify the [public IP address](../../vpc/concepts/address.md#public-addresses) of your `minecraft-server` VM. Leave the default port. Click **Add and play**.



{% endlist %}

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:
1. [Delete](../../compute/operations/vm-control/vm-delete.md) the `minecraft-server` VM.
1. [Delete](../../vpc/operations/security-group-delete.md) the `minecraft-sg` security group.
