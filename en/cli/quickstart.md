# Getting started with the command-line interface

{% if audience != "internal" %}

_The {{ yandex-cloud }} command-line interface (CLI)_ provides downloadable software for managing your cloud resources from the command line.

{% else %}

Inside Yandex, the {{ yandex-cloud }} command-line interface (CLI) lets you use:

- [{{mch-name}}](../managed-clickhouse/)
- [{{mes-name}}](../managed-elasticsearch/)
- [{{mkf-name}}](../managed-kafka/)
- [{{mmg-name}}](../managed-mongodb/)
- [{{mmy-name}}](../managed-mysql/)
- [{{mpg-name}}](../managed-postgresql/)
- [{{mrd-name}}](../managed-redis/)

{% endif %}

## Installing the CLI {#install}

{% include [install-cli](../_includes/cli/install-cli.md) %}

## Creating a profile {#initialize}

{% if audience == "internal" %}

{% note warning %}

Follow the instructions below if you install the internal CLI build (from s3.mds.yandex.net) rather than its external build (from storage.yandexcloud.net). If you use the external CLI build, follow [these instructions](../mdb/cli.md).

If you already have a CLI installed, you can figure out which build you have using the `yc version` command. If the version contains `+yandex`, the build is internal. Otherwise, the build is external.

{% endnote %}

{% endif %}

  1. Log in to the [management console]({{ link-console-main }}) and accept the user agreement by clicking **Log in**. If you're already connected to the console, skip this step.

  1. Get an OAuth token from Yandex.OAuth. To do this, go to the [link]({{ link-cloud-oauth }}) and click **Allow**.

  1. To configure your CLI profile, run the command `yc init`.

  1. Enter your OAuth token when prompted by the command.

     ```
     Please go to {{ link-cloud-oauth }}
      in order to obtain OAuth token.
     
     Please enter OAuth token: AaAaBbBbCcCcDdDdEeEeFfFfGgGg
     ```

  1. At the command prompt, select one of the clouds from the list of those you have access to:

     ```
     Please select cloud to use:
      [1] cloud1 (id = aoe2bmdcvatao4frg22b)
      [2] cloud2 (id = dcvatao4faoe2bmrg22b)
     Please enter your numeric choice: 2
     ```

     If only one cloud is available, it's selected automatically.

  1. Select the default folder:

     ```
     Please choose a folder to use:
      [1] folder1 (id = cvatao4faoe2bmdrg22b)
      [2] folder2 (id = tao4faoe2cvabmdrg22b)
      [3] Create a new folder
     Please enter your numeric choice: 1
     ```

{% if audience == "internal" %}

  1. Disable the default availability zone selection for {{ compute-full-name }}:

     ```
     Do you want to configure a default {{ compute-full-name }} availability zone? [Y/n] N
     ```

{% else %}

  1. Select the default availability zone for {{ compute-full-name }}:

     ```
     Do you want to configure a default {{ compute-full-name }} availability zone? [Y/n] Y
     Which zone do you want to use as a profile default?
      [1] ru-central1-a
      [2] ru-central1-b
      [3] ru-central1-c
      [4] Don't set default zone
     Please enter your numeric choice: 2
     ```

{% endif %}

  1. View your CLI profile settings:

     ```
     $ yc config list
     ```

{% if audience != "internal" %}

## Examples of commands {#example}

The following steps describe how to create a cloud network, subnet, and virtual machine that is connected to this subnet.

1. View the description of the CLI commands for working with cloud networks:

   ```
   $ yc vpc network --help
   ```
1. Create a cloud network in the folder specified in your CLI profile:

   ```
   $ yc vpc network create \
       --name my-yc-network \
       --labels my-label=my-value \
       --description "my first network via yc"
   ```
1. Create a subnet in the cloud network `my-yc-network`:

   ```
   $ yc vpc subnet create \
       --name my-yc-subnet-b \
       --zone ru-central1-b \
       --range 10.1.2.0/24 \
       --network-name my-yc-network \
       --description "my first subnet via yc"
   ```
1. Get a list of all cloud networks in the directory specified in your CLI profile:

   ```
   $ yc vpc network list
   
   +----------------------+------------------+-------------------------+
   |          ID          |       NAME       |       DESCRIPTION       |
   +----------------------+------------------+-------------------------+
   | skesdqhkc6449hbqqar1 | my-ui-network    | my first network via ui |
   | c6449hbqqar1skesdqhk | my-yc-network    | my first network via yc |
   +----------------------+------------------+-------------------------+
   ```

   Get the same list with more details in YAML format:

   ```
   $ yc vpc network list --format yaml
   
   - id: skesdqhkc6449hbqqar1
     folder_id: ijkl9012
     created_at: "2018-09-05T09:51:16Z"
     name: my-ui-network
     description: "my first network via ui"
     labels: {}
   - id: c6449hbqqar1skesdqhk
     folder_id: ijkl9012
     created_at: "2018-09-05T09:55:36Z"
     name: my-yc-network
     description: "my first network via yc"
     labels:
       my-label: my-value
   ```
1. Create a virtual machine and connect it to the subnet `my-yc-subnet-b`:
   1. Prepare the key pair (public and private keys) for SSH access to the VM.
   1. Create a virtual machine:

      ```
      $ yc compute instance create \
          --name my-yc-instance \
          --network-interface subnet-name=my-yc-subnet-b,nat-ip-version=ipv4 \
          --zone ru-central1-b \
		  --ssh-key ~/.ssh/id_rsa.pub
      ```

      Pass the path to the public key for SSH access in the `ssh-key` parameter. The `yc-user` user will be automatically created in the virtual machine OS with the specified public key.
1. Connect to the virtual machine over SSH:
   1. Find out the public IP address of the virtual machine. To do this, view detailed information about your virtual machine:

      ```
      $ yc compute instance get my-yc-instance
      ```

      In the command output, find the address of the VM in the `one_to_one_nat` section:

      ```
      one_to_one_nat:
          address: 130.193.32.90
          ip_version: IPV4
      ```
   2. Connect to the virtual machine over SHH on behalf of the `yc-user` user, using the private key:

      ```
      $ ssh yc-user@130.193.32.90
      ```
1. Delete the `my-yc-instance` virtual machine, the `my-yc-subnet-b` subnet and the `my-yc-network` network:

   ```
   $ yc compute instance delete my-yc-instance
   $ yc vpc subnet delete my-yc-subnet-b
   $ yc vpc network delete my-yc-network
   ```

{% endif %}

