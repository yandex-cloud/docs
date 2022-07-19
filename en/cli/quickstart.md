# Getting started with the command-line interface


The _{{ yandex-cloud }} command-line interface (CLI)_ provides downloadable software for managing your cloud resources from the command line.


## Installation {#install}

{% include [install-cli](../_includes/cli/install-cli.md) %}

## Creating a profile {#initialize}


If you aren't connected to the management console yet, log in to the [console]({{ link-console-main }}) and accept the user agreement by clicking **Log in**.

{% list tabs %}

- As a user

   
   To authenticate as a user:
   1. Get an OAuth token from Yandex.OAuth. To do this, follow the [link]({{ link-cloud-oauth }}) and click **Allow**.
   1. To configure your CLI profile, run the command `yc init`.
   1. Enter your OAuth token when prompted by the command.
      ```
      Please go to {{ link-cloud-oauth }}
       in order to obtain OAuth token.

      Please enter OAuth token: AaAaBbBbCcCcDdDdEeEeFfFfGgGg
      ```
   1. At the command prompt, select one of the clouds from the list of those you have access to:

      {% include [include](../_includes/cli/choose-cloud.md) %}

      If only one cloud is available, it's selected automatically.
   1. Select the default folder:

      {% include [include](../_includes/cli/choose-folder.md) %}

      1. Select the default availability zone for {{ compute-full-name }}:

      {% include [include](../_includes/cli/choose-zone.md) %}

   1. View your CLI profile settings:
      ```
      yc config list
      ```




- As a service account

   Before you start, get your service account ready:
   1. [Authenticate in the CLI as a user](operations/authentication/user.md).
   1. If you don't have a service account yet, [create one](../iam/operations/sa/create.md) and [configure access rights for it](../iam/operations/sa/assign-role-for-sa.md).

   {% include [auth-as-sa](../_includes/cli/auth-as-sa.md) %}

- As a federated user

   {% include [include](../_includes/cli/auth-federated-user.md) %}

{% endlist %}

## Examples of commands {#example}

The following steps describe how to create a cloud network, subnet, and virtual machine that is connected to this subnet.

1. View the description of the CLI commands for working with cloud networks:
   ```
   yc vpc network --help
   ```
1. Create a cloud network in the folder specified in your CLI profile:
   ```
   yc vpc network create \
       --name my-yc-network \
       --labels my-label=my-value \
       --description "my first network via yc"
   ```
1. Create a subnet in the cloud network `my-yc-network`:
   ```
   yc vpc subnet create \
       --name my-yc-subnet-a \
       --zone {{ region-id }}-a \
       --range 10.1.2.0/24 \
       --network-name my-yc-network \
       --description "my first subnet via yc"
   ```
1. Get a list of all cloud networks in the directory specified in your CLI profile:
   ```
   yc vpc network list
   ```

   Result:

   ```
   +----------------------+------------------+-------------------------+
   |          ID          |       NAME       |       DESCRIPTION       |
   +----------------------+------------------+-------------------------+
   | skesdqhkc6449hbqqar1 | my-ui-network    | my first network via ui |
   | c6449hbqqar1skesdqhk | my-yc-network    | my first network via yc |
   +----------------------+------------------+-------------------------+
   ```
   Get the same list with more details in YAML format:
   ```
   yc vpc network list --format yaml
   ```

   Result:

   ```
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
1. Create a VM and connect it to the subnet `my-yc-subnet-a`:
   1. Prepare the key pair (public and private keys) for SSH access to the VM.
   1. Create a Linux VM instance:
      ```
      yc compute instance create \
          --name my-yc-instance \
          --network-interface subnet-name=my-yc-subnet-a,nat-ip-version=ipv4 \
          --zone {{ region-id }}-a \
          --ssh-key ~/.ssh/id_rsa.pub
      ```
      Where `ssh-key` is the path to the public key for SSH access. A user named `yc-user` will be automatically created in the VM's OS with the specified public key.
1. Connect to the virtual machine over SSH:
   1. Find out the public IP address of the virtual machine. To do this, view detailed information about your virtual machine:
      ```
      yc compute instance get my-yc-instance
      ```
      In the command output, find the address of the VM in the `one_to_one_nat` section:
      ```
      one_to_one_nat:
          address: 130.193.32.90
          ip_version: IPV4
      ```
   1. Connect to the virtual machine over SSH on behalf of the `yc-user` user, using the private key:
      ```
      ssh yc-user@130.193.32.90
      ```
1. Delete the `my-yc-instance` VM, the `my-yc-subnet-a` subnet, and the `my-yc-network` network:
   ```
   yc compute instance delete my-yc-instance
   yc vpc subnet delete my-yc-subnet-a
   yc vpc network delete my-yc-network
   ```
