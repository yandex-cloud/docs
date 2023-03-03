# Installing a Cisco CSR 1000v virtual router

In {{ yandex-cloud }}, you can deploy the virtual router Cisco Cloud Services Router (CSR) 1000v based on a ready-to-use VM image.

To install the CSR 1000v and configure SSH access to it:

1. [Before you start](#before-you-begin).
1. [Create an SSH key pair](#create-ssh-keys).
1. [Create a VM with a Cisco Cloud Services Router](#create-router).
1. [Set the host name for the router](#hostname).
1. [Create a user with the administrative rights](#create-user).
1. [Configure authentication using SSH keys](#enable-ssh).
1. [Check the SSH connection to the router](#test-ssh).

If you no longer need these resources, [delete them](#clear-out).

## Before you begin {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

{% note alert %}

When you use a Cisco CSR 1000v image without a license, the router throughput is limited to 100 Kbps. To remove the limit, [install a license](https://www.cisco.com/c/en/us/td/docs/routers/csr1000/software/configuration/b_CSR1000v_Configuration_Guide/b_CSR1000v_Configuration_Guide_chapter_01000.html).

{% endnote %}

The cost of using a virtual router includes:

* A fee for a disk and continuously running VM (see [pricing{{ compute-full-name }}](../../compute/pricing.md)).
* A fee for using a public IP address (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).


## Create an SSH key pair {#create-ssh-keys}

{% include [vm-ssh-rsa-key](../../_includes/vm-ssh-rsa-key.md) %}

{% note warning %}

Save the private key in a secure location: you won't be able to connect to the VM without it.

{% endnote %}

## Create a VM with a Cisco Cloud Services Router {#create-router}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select a folder where you want to create a VM with Cisco Cloud Services Router.
   1. Click **Create resource** and select **Virtual machine**.
   1. Enter a name for the VM, like `cisco-router`.
   1. Select an [availability zone](../../overview/concepts/geo-scope.md) to place the VM in. If you don't know which availability zone you need, leave the default.
   1. Under **Image/boot disk selection**, go to the **{{ marketplace-name }}** tab and select the [Cisco CSR](/marketplace/products/yc/cisco-csr) image.
   1. Under **Computing resources**:
      * Choose a VM [platform](../../compute/concepts/vm-platforms.md).
      * Specify the number of vCPUs and amount of RAM:
         * **Platform**: Intel Ice Lake.
         * **Guaranteed vCPU share**: 100%
         * **vCPU**: 2.
         * **RAM**: 4 GB.
   1. Under **Network settings**, select the network and subnet to connect the VM to. If there aren't any networks, create one:
      1. Select ![image](../../_assets/plus-sign.svg) **Create network**.
      1. In the resulting window, enter a network name and folder to host the VM.
      1. (optional) To automatically create subnets, select the **Create subnets** option.
      1. Click **Create**.

         Each network must have at least one subnet. If there is no subnet, create one by selecting ![image](../../_assets/plus-sign.svg)**Add subnet**.
   1. Under **Public address**, keep **Auto** to assign your VM a random external IP address from the {{ yandex-cloud }} pool, or select a static address from the list if you reserved one in advance.
   1. Enter the VM access information:
      * Enter the username in the **Login** field.
      * In the **SSH key** field, paste the contents of the [previously generated](#create-ssh-keys) public key file.
   1. Select **Grant access to serial console**.
   1. Click **Create VM**.

   The VM may take several minutes to create. When the VM status changes to `RUNNING`, you can use the serial console.

{% endlist %}

## Set the host name for the router {#hostname}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder containing your VM.
   1. Select **{{ compute-name }}**.
   1. Select `cisco-router` from the VM list.
   1. Go to the ![image](../../_assets/compute/serial-console.svg) **Serial console** tab and click **Connect**.
   1. Wait for the operating system to start up completely.
   1. Run the `enable` command to switch to privileged mode:

      ```text
      cisco-router.{{ region-id }}.internal>enable
      ```

   1. Enter the configuration mode and set the host name for the router:

      ```text
      cisco-router.{{ region-id }}.internal#configure terminal
      Enter configuration commands, one per line.  End with CNTL/Z.
      cisco-router.ru-cent(config)#hostname cisco-router
      ```

      Make sure that the router name in the command line prompt changes to `cisco-router`.

{% endlist %}

## Create a user with the administrative rights {#create-user}

Create a user with the administrative rights and password authentication disabled:

{% list tabs %}

- Management console

   In the serial console, run the command:

   ```text
   cisco-router(config)#username test-user privilege 15
   ```

{% endlist %}

## Configure authentication using SSH keys {#enable-ssh}

1. If your public SSH key is longer than 72 characters, split the key into chunks 72 characters each. For this, in your computer terminal, run the command:

   ```bash
   fold -bw 72 <path_to_file_with_public key>
   ```

   This will output your public SSH key split into chunks, 72 characters in each.

1. In the serial console, enable access to the VM over SSH:

   ```text
   cisco-router(config)#aaa new-model
   cisco-router(config)#ip ssh server algorithm authentication publickey 
   cisco-router(config)#ip ssh pubkey-chain
   ```

1. Create a user named `test-user` and transmit, in the `conf-ssh-pubkey-data` mode, your public SSH key in chunks no longer than 72 characters, beginning with `ssh-rsa` and ending with the username:

   ```text
   cisco-router(conf-ssh-pubkey)#username test-user
   cisco-router(conf-ssh-pubkey-user)#key-string
   cisco-router(conf-ssh-pubkey-data)#<public_key_string>
   ...
   cisco-router(conf-ssh-pubkey-data)#<public_key_string>
   cisco-router(conf-ssh-pubkey-data)#exit
   cisco-router(conf-ssh-pubkey-user)#exit
   cisco-router(conf-ssh-pubkey)#exit
   cisco-router(config)#exit
   ```

1. Make sure that the key is added:

   ```text
   cisco-router#show run | beg ip ssh
   ip ssh pubkey-chain
     username test-user
      key-hash ssh-rsa <key_hash> <username_assigned_this_key>
   !
   !
   ...
   ```

1. Compare the SSH key hash on the router with the key hash on your computer:

   ```bash
   ssh-keygen -E md5 -lf <path_to_file_with_public_key>
   ```

1. In the serial console, enter the password that enables the privileged mode:

   ```text
   cisco-router#configure terminal
   cisco-router(config)#enable secret <password>
   ```

## Check the SSH connection to the router {#test-ssh}

1. Log in to the router via SSH. For this, in your computer terminal, run the command:

   ```bash
   ssh -i <path_to_file_with_private_key> test-user@<public_IP_of_router> 
   ```

   If everything is configured correctly, you will log in to the router under `test-user`. If the connection is not established, make sure that the router is configured correctly in the serial console: the `aaa new-model` command was run, the key hashes are the same on your computer and the router, and password authorization for the test user is disabled. If you can't find the problem, repeat the previous steps.
1. Enter the `enable` command and password. If everything is configured correctly, you can configure the router.

## How to delete created resources {#clear-out}

To stop paying for the resources created:
* [Delete](../../compute/operations/vm-control/vm-delete.md) the VM.
* [Delete](../../vpc/operations/address-delete.md) the static public IP if you reserved one.
