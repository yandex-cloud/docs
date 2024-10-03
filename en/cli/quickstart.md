# Getting started with the command-line interface


The _{{ yandex-cloud }} command-line interface (CLI)_ provides downloadable software for managing your cloud resources from the command line.


## Installation {#install}

{% include [install-cli](../_includes/cli/install-cli.md) %}

## Creating a profile {#initialize}

{% list tabs group=authentication %}

- Yandex account {#yandex-account}

  {% include [include](../_includes/cli/create-profile.md) %}

- Federated account {#federated-account}

  {% include [include](../_includes/cli/auth-federated-user.md) %}

{% endlist %}


## Examples of commands {#example}

The following steps describe how to create a [cloud network](../vpc/concepts/network.md#network), [subnet](../vpc/concepts/network.md#subnet), and [virtual machine](../compute/concepts/vm.md) that is connected to this subnet.
1. View the description of the CLI commands for working with cloud networks:

   ```bash
   yc vpc network --help
   ```

1. Create a cloud network in the [folder](../resource-manager/concepts/resources-hierarchy.md#folder) specified in your CLI profile:

   ```bash
   yc vpc network create \
     --name my-yc-network \
     --labels my-label=my-value \
     --description "my first network via yc"
   ```

1. In the `my-yc-network` cloud network, create a subnet:


   ```bash
   yc vpc subnet create \
     --name my-yc-subnet-a \
     --zone {{ region-id }}-a \
     --range 10.1.2.0/24 \
     --network-name my-yc-network \
     --description "my first subnet via yc"
   ```



1. Get a list of all cloud networks in the directory specified in your CLI profile:

   ```bash
   yc vpc network list
   ```

   Result:

   ```text
   +----------------------+------------------+-------------------------+
   |          ID          |       NAME       |       DESCRIPTION       |
   +----------------------+------------------+-------------------------+
   | skesdqhkc644******** | my-ui-network    | my first network via ui |
   | c6449hbqqar1******** | my-yc-network    | my first network via yc |
   +----------------------+------------------+-------------------------+
   ```

   Get the same list with more details in YAML format:

   ```bash
   yc vpc network list --format yaml
   ```

   Result:

   ```text
   - id: skesdqhkc644********
     folder_id: ijkl9012
     created_at: "2018-09-05T09:51:16Z"
     name: my-ui-network
     description: "my first network via ui"
     labels: {}
   - id: c6449hbqqar1********
     folder_id: ijkl9012
     created_at: "2018-09-05T09:55:36Z"
     name: my-yc-network
     description: "my first network via yc"
     labels:
       my-label: my-value
   ```

1. Create a VM and connect it to `my-yc-subnet-a`:
   1. [Prepare](../compute/operations/vm-connect/ssh.md#creating-ssh-keys) a key pair (public and private keys) for SSH access to the VM.
   1. Create a Linux VM:


      ```bash
      yc compute instance create \
        --name my-yc-instance \
        --network-interface subnet-name=my-yc-subnet-a,nat-ip-version=ipv4 \
        --zone {{ region-id }}-a \
        --ssh-key ~/.ssh/id_ed25519.pub
      ```



      Where `ssh-key` is the path to a public key for SSH access. The VM will automatically create the `yc-user` user with the specified public key.
1. Connect to the VM over SSH:
   1. Find out the VM's [public IP address](../vpc/concepts/address.md#public-addresses). To do this, view detailed information about your VM:

      ```bash
      yc compute instance get my-yc-instance
      ```

      In the command output, find the address of the VM in the `one_to_one_nat` section:

      ```yaml
      one_to_one_nat:
        address: 130.193.32.90
        ip_version: IPV4
      ```

   1. Connect to the VM over SSH as `yc-user`, using the private key:


      ```bash
      ssh yc-user@130.193.32.90
      ```

1. Delete the `my-yc-instance` VM, `my-yc-subnet-a` subnet, and `my-yc-network` network:

   ```bash
   yc compute instance delete my-yc-instance
   yc vpc subnet delete my-yc-subnet-a
   yc vpc network delete my-yc-network
   ```
