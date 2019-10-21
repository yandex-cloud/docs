# Getting started with the command-line interface

_The Yandex.Cloud command-line interface (CLI)_ provides downloadable software for managing your cloud resources from the command line.

## Installation {#install}

{% list tabs %}

- Linux

  1. Run at a command prompt:

     ```
     $ curl https://{{ s3-storage-host }}{{ yc-install-path }} | bash
     ```

     The script will install the CLI and add the executable file path to the environment variable `PATH`.

     {% note info %}

     The script will update `PATH` only if you run it in `bash` or `zsh` shell.

     If you run the script in a different shell, add the path to the CLI to the variable `PATH` yourself.

     {% endnote %}

  1. After installation is complete, restart your terminal.

- macOS

  1. Run at a command prompt:

      ```
      $ curl https://{{ s3-storage-host }}{{ yc-install-path }} | bash
      ```

      The script will install the CLI and add the executable file path to the environment variable `PATH`.
  1. Restart your terminal for the changes to take effect.

  The CLI supports command completion for the  `bash` shell. For command completion to work:

  1. Install the [Homebrew](https://brew.sh) package manager.
  1. Install the `bash-completion` package:

     ```
     $ brew install bash-completion
     ```
  1. After installation is complete, add the following lines to the ` ~/.bash_profile` file:

     ```
     if [ -f $(brew --prefix)/etc/bash_completion ]; then
     . $(brew --prefix)/etc/bash_completion
     fi
     ```
  1. Restart your terminal.

- Windows

  For Windows, the CLI can be installed using PowerShell and `cmd`:

  - To install using PowerShell:

      1. Run the command:

          ```
          iex (New-Object System.Net.WebClient).DownloadString('https://{{ s3-storage-host }}{{ yc-windows-path }}')
          ```

      1. The installation script will ask whether to add the path to `yc` to the PATH variable:

          ```
          Add yc installation dir to your PATH? [Y/n]
          ```

      1. Enter `Y`. After this, you can use the Yandex.Cloud CLI without restarting the command shell.

  - To install using `cmd`:

      1. Run the command:

          ```
          @"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://{{ s3-storage-host }}{{ yc-windows-path }}'))" && SET "PATH=%PATH%;%USERPROFILE%\yandex-cloud\bin"
          ```

      1. The installation script will ask whether to add the path to `yc` to the PATH variable:

          ```
          Add yc installation dir to your PATH? [Y/n]
          ```

      1. Enter `Y`.

      1. Restart your terminal for the changes to take effect.

{% endlist %}

## Initialization {#initialize}

  1. Get an OAuth token from Yandex OAuth. To do this, follow the [link](https://oauth.yandex.com/authorize?response_type=token&client_id=1a6990aa636648e9b2ef855fa7bec2fb) and click **Allow**.
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
  1. Select the default folder:

     ```
     Please choose a folder to use:
      [1] folder1 (id = cvatao4faoe2bmdrg22b)
      [2] folder2 (id = tao4faoe2cvabmdrg22b)
      [3] Create a new folder
     Please enter your numeric choice: 1
     ```
  1. Select the default availability zone for the {{ compute-full-name }} service:

     ```
     Do you want to configure a default {{ compute-full-name }} availability zone? [Y/n] Y
     Which zone do you want to use as a profile default?
      [1] ru-central1-a
      [2] ru-central1-b
      [3] ru-central1-c
      [4] Don't set default zone
     Please enter your numeric choice: 2
     ```
  1. View your CLI profile settings:

     ```
     $ yc config list
     ```

## Command examples {#example}

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
   1. Prepare the key pair (public and private) for SSH access to the VM.
   1. Create a virtual machine:

      ```
      $ yc compute instance create \
          --name my-yc-instance \
          --network-interface subnet-name=my-yc-subnet-b,nat-ip-version=ipv4 \
          --ssh-key ~/.ssh/id_rsa.pub
      ```

      Pass the path to the public key for SSH access in the `ssh-key` parameter. The `yc-user` user will be automatically created in the virtual machine OS with the specified public key.
1. Connect to the virtual machine over SSH:
   1. Find out the public IP address of the virtual machine. To do this, view detailed information about your virtual machine:

      ```
      $ yc compute instance get my-yc-instance
      ```

      In the command output, find the address of the virtual machine in the `one_to_one_nat` section:

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

