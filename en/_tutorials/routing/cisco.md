# Installing a Cisco CSR 1000v virtual router

In {{ yandex-cloud }}, you can deploy a virtual Cisco Cloud Services Router (CSR) 1000v from a VM image. To install the CSR 1000v and configure SSH access to it:

1. [Before you start](#before-you-begin).
1. [Create a VM with a Cisco Cloud Services Router](#create-router).
1. [Set the host name for the router](#hostname).
1. [Create a user with administrator rights](#create-user).
1. [Configure authentication using SSH keys](#enable-ssh).
1. [Check the connection to the router](#test-ssh).

If you no longer need the created resources, [delete them](#clear-out).

## Before you start {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}


### Required paid resources {#paid-resources}

{% note alert %}

When you use a Cisco CSR 1000v image without a license, the router throughput is limited to 100 Kbps. To remove the limit, [install a license](https://www.cisco.com/c/en/us/td/docs/routers/csr1000/software/configuration/b_CSR1000v_Configuration_Guide/b_CSR1000v_Configuration_Guide_chapter_01000.html).

{% endnote %}

The cost of using a virtual router includes:

* A fee for a disk and continuously running VM (see [pricing{{ compute-full-name }}](../../compute/pricing.md)).
* A fee for using a public IP address (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md)).


## Create a VM with a Cisco Cloud Services Router {#create-router}

1. Open your folder and click **Create resource**. Select **Virtual machine**.
1. Enter a name for the VM, like `cisco-router`.
1. Select the [availability zone](../../overview/concepts/geo-scope.md) with a subnet. If you don't know which availability zone you need, leave the default.
1. Under **Image/boot disk selection**, click the **{{ marketplace-name }}** tab, and select the [Cisco CSR](/marketplace/products/yc/cisco-csr) image.
1. Under **Computing resources**:
    - Choose a [platform](../../compute/concepts/vm-platforms.md) for the VM.

    - Specify the number of vCPUs and amount of RAM:
      - **Platform**: Intel Ice Lake.
      - **Guaranteed vCPU share**: 100%.
      - **vCPU**: 2.
      - **RAM**: 4 GB.
1. In the **Network settings** section, choose the required network and subnet and assign a public IP to the VM either by selecting it from the list or automatically. If you don't have a network or subnet, create them on the VM creation screen.
1. In the **Access** field, enter the login and SSH key.
1. Set the **Grant access to serial console** flag.
1. Click **Create VM**.

Creating the VM may take several minutes. When the VM status changes to `RUNNING`, you can use the serial console.

## Set the host name for the router {#hostname}

1. Open the page of the `cisco-router` VM in the [management console]({{ link-console-main }}).

1. Open **Serial console** and click **Connect**.

1. Wait until the OS fully loads.

1. Run the `enable` command to switch to privileged mode:

   ```
   cisco-router.{{ region-id }}.internal>enable
   ```

1. Enter configuration mode and set the host name for the router:

   ```
   cisco-router.{{ region-id }}.internal#configure terminal
   Enter configuration commands, one per line.  End with CNTL/Z.
   cisco-router.ru-cent(config)#hostname cisco-router
   ```

Make sure that the router name in the command line prompt changes to `cisco-router`.

## Create a user with administrator rights {#create-user}

Create a user with administrator rights and password authentication disabled:

```
cisco-router(config)#username test-user privilege 15 
```

## Configure authentication using SSH keys {#enable-ssh}

1. Enable SSH access to the VM and pass your public key in parts of 32 characters or less, starting with `ssh-rsa` and ending with the login.

   ```
   cisco-router(config)#aaa new-model
   cisco-router(config)#ip ssh server authenticate user publickey
   cisco-router(config)#ip ssh pubkey-chain
   cisco-router(conf-ssh-pubkey)#username test-user
   cisco-router(conf-ssh-pubkey-user)#key-string
   cisco-router(conf-ssh-pubkey-data)#<public key string>
   ...
   cisco-router(conf-ssh-pubkey-data)#<public key string>
   exit
   exit
   exit
   exit
   ```

1. Make sure that the key is added:

   ```
   cisco-router#show run | beg ip ssh
   ip ssh pubkey-chain
     username test-user
      key-hash ssh-rsa <key hash> <login associated with this key>
   !
   !
   ...
   ```

   You can compare the key hash on the router with the key hash on your computer:

   ```
   ssh-keygen -E md5 -lf <path to the file with public key>.pub
   ```

1. Set a password for privileged mode:

   ```
   cisco-router#configure terminal
   cisco-router(config)#enable secret <password>
   ```

## Check the SSH connection to the router {#test-ssh}

1. Run the following command on your computer:

   ```
   ssh -i <path to the file with the private key> test-user@<public IP address of the router> 
   ```

   If everything is configured correctly, you will log in to the router under `test-user`. If the connection is not established, make sure that the router is configured correctly in the serial console: the `aaa new-model` command was run, the key hashes are the same on your computer and the router, and password authorization for the test user is disabled. If you can't find the problem, repeat the previous steps.

1. Enter the `enable` command and password. If everything is configured correctly, you can configure the router.

## Delete the created resources {#clear-out}

To stop paying for the deployed resources, [delete](../../compute/operations/vm-control/vm-delete.md) the `cisco-router` virtual machine.

If you reserved a public static IP address, [delete it](../../vpc/operations/address-delete.md).

