# Using a service account with an OS Login profile for VM management via Ansible

To manage [virtual machines](../../compute/concepts/vm.md) via [Ansible](https://www.ansible.com/), you can use a [service account](../../iam/concepts/users/service-accounts.md) with an [OS Login](../../organization/concepts/os-login.md) profile with an SSH key. This configuration will allow you to have a separate account for VM management via Ansible with scheduled or manual SSH key revocation.

In addition, with this configuration you can temporarily elevate the privileges of this account by assigning additional [roles](../../iam/concepts/access-control/roles.md) to the service account. For example, to use the `become` directive in Ansible tasks you will have to temporarily assign the `compute.osAdminLogin` [role](../../compute/security/index.md#compute-osadminlogin) to the service account.

To configure a service account for VM management via Ansible:
1. [Prepare your cloud](#before-you-begin).
1. [Create a service account with an SSH key in the OS Login profile](#create-ssh-key).
1. [Configure Ansible to run on behalf of a service account](#configure-ansible).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Prepare the environment {#prepare}

1. {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

1. [Create](../../compute/operations/vm-create/create-linux-vm.md) a virtual machine from a public image with OS Login access enabled, e.g., [Ubuntu 22.04 LTS OS Login](/marketplace/products/yc/ubuntu-2204-lts-oslogin).
1. In your organization settings, [enable](../../organization/operations/os-login-access.md) OS Login access using SSH keys.
1. [Install](https://docs.ansible.com/ansible/latest/installation_guide/installation_distros.html) Ansible.

### Required paid resources {#paid-resources}

The cost of supporting the infrastructure created in the guide includes:
* Fee for a continuously running VM (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* Fee for using a public IP address (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).

## Create a service account with an SSH key in the OS Login profile {#create-ssh-key}

1. [Create](../../iam/operations/sa/create.md) the `my-ansible-sa` service account and [assign](../../iam/operations/sa/assign-role-for-sa.md) the `compute.osLogin` [role](../../compute/security/index.md#compute-oslogin) to it.
1. Create a pair of `ed25519` type SSH keys the service account will use to connect to virtual machines:

   ```bash
   ssh-keygen \
     -t ed25519 \
     -f <path>/id_yc-sa-my-ansible-sa
   ```

   Where `-f` is the name of the SSH key to be created and the path to the directory where the files with the private and public parts of the key will be saved. For example, `-f /home/user/ansible-key/id_yc-sa-my-ansible-sa`.

   As a result, two SSH key files will be created in the specified directory: `id_yc-sa-my-ansible-sa` and `id_yc-sa-my-ansible-sa.pub`.

1. Add the new SSH key to the OS Login profile of the `my-ansible-sa` service account:

   {% list tabs group=instructions %}

   - CLI {#cli}

      ```bash
      yc organization-manager oslogin user-ssh-key create \
        --name <key_name> \
        --organization-id <organization_ID> \
        --subject-id <service_account_ID> \
        --data "<public_SSH_key>" \
        --expires-at <key_expiration_date>

      ```

      Where:
      * `--name`: Name of the key you are uploading, e.g., `ssh-my-ansible-sa`.
      * `--organization-id`: `my-ansible-sa` service account's [organization](../../organization/quickstart.md) ID. To get a list of available organizations and their IDs, run the `yc organization-manager organizations list` command.
      * `--subject-id`: [ID](../../iam/operations/sa/get-id.md) of the service account to whose profile you are adding the SSH key.
      * `--data`: Contents of the file with the public part of the SSH key (`id_yc-sa-my-ansible-sa.pub`).
      * `--expires-at`: Uploaded key expiration date. This is an optional parameter. If the parameter is not set, the key will have no expiration date.

         You can specify the value in two formats:
         * Key expiration date in [ISO 8601](https://ru.wikipedia.org/wiki/ISO_8601) format, e.g., `YYYY-MM-DDT00:00:00Z`.
         * Key validity period in hours and minutes, e.g., `1h` or `3h30m`.

      Result:

      ```bash
      id: bpfejaidgt9u********
      subject_id: ajeqdl8mdv12********
      data: ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOra4Rg9OpwS5cozMHDGpdp6ug/jYUnWtTFD********
      name: ssh-my-ansible-sa
      fingerprint: SHA256:gkEtFdaTmT7PK4/fCrZqnSjFDBsvLeNfkAR********
      organization_id: bpfaidqca8vd********
      created_at: "2024-06-21T10:10:11.946355750Z"
      expires_at: "2024-06-21T20:10:11.380653492Z"
      ```

      For more information about the `yc organization-manager oslogin user-ssh-key create` command, see the [CLI reference](../../cli/cli-ref/managed-services/organization-manager/oslogin/user-ssh-key/create.md).

   {% endlist %}

   {% note tip %}

   For security purposes, it is recommended to rotate SSH keys from time to time. It is not safe to use an SSH key with unlimited validity period.

   {% endnote %}

1. Check if you can log in to the VM using the service account's OS Login profile:

   ```bash
   ssh yc-sa-my-ansible-sa@<VM_IP_address> -i <path_to_private_SSH_key>
   ```

   Where:
   * `<VM_IP_address>`: [Public IP address](../../vpc/concepts/address.md#public-addresses) of the virtual machine with enabled OS Login access.
   * `<path_to_private_SSH_key>`: Path to the file containing the private part of the previously created SSH key. For example, `/home/user/ansible-key/id_yc-sa-my-ansible-sa`.

## Configure Ansible to run on behalf of a service account {#configure-ansible}

Make sure Ansible can connect to the virtual machine on behalf of the new service account. To do this, create an Inventory file and test it with the help of the `ansible.builtin.ping` Ansible module:

1. Create a file named `inventory.ini` with the `yc` group:

   ```ini
   [yc:vars]
   ansible_connection=ssh
   ansible_user=yc-sa-my-ansible-sa
   ansible_ssh_private_key_file=<path_to_private_SSH_key>

   [yc]
   <VM_IP_address>
   ```

   Where:
   * `<path_to_private_SSH_key>`: Path to the file containing the private part of the previously created SSH key. For example, `/home/user/ansible-key/id_yc-sa-my-ansible-sa`.
   * `<VM_IP_address>`: Public IP address of the virtual machine with enabled OS Login access.

1. Run Ansible with the `ansible.builtin.ping` module:

   ```bash
   ansible -i inventory.ini -m ping yc
   ```

   Result:
   ```bash
   158.160.**.*** | SUCCESS => {
   "ansible_facts": {
       "discovered_interpreter_python": "/usr/bin/python3"
   },
   "changed": false,
   "ping": "pong"
   }
   ```

Connection to the VM has been established. You can now manage virtual machines via Ansible on behalf of a service account with an OS Login profile and an SSH key with a limited validity period.

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:
1. [Delete](../../compute/operations/vm-control/vm-delete.md) the virtual machine.
1. [Delete](../../iam/operations/sa/delete.md) the service account if you need to.
