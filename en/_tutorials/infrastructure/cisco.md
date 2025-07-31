# Installing the Cisco CSR 1000v virtual router


In {{ yandex-cloud }}, you can deploy the Cisco Cloud Services Router (CSR) 1000v on a ready-made VM image. 

To install the CSR 1000v and configure SSH access to it:

1. [Get your cloud ready](#before-you-begin).
1. [Create an SSH key pair](#create-ssh-keys).
1. [Create a VM with the Cisco Cloud Services Router](#create-router).
1. [Set the host name for the router](#hostname).
1. [Create a user with administrator privileges](#create-user).
1. [Configure authentication using SSH keys](#enable-ssh).
1. [Check the SSH connection to the router](#test-ssh).

If you no longer need the resources you created, [delete them](#clear-out).

## Getting started {#before-you-begin}

{% include [before-you-begin](../_tutorials_includes/before-you-begin.md) %}

### Required paid resources {#paid-resources}

{% note alert %}

When using a Cisco CSR 1000v image without a license, the router throughput is limited to 100 Kbps. To remove this limitation, [install a license](https://www.cisco.com/c/en/us/td/docs/routers/csr1000/software/configuration/b_CSR1000v_Configuration_Guide/b_CSR1000v_Configuration_Guide_chapter_01000.html).

{% endnote %}

The cost of using a virtual router includes:

* Fee for a disk and a continuously running VM (see [{{ compute-full-name }} pricing](../../compute/pricing.md)).
* Fee for using a dynamic or static external IP address (see [{{ vpc-full-name }} pricing](../../vpc/pricing.md#prices-public-ip)).


## Create an SSH key pair {#create-ssh-keys}

{% include [vm-ssh-rsa-key](../../_includes/vm-ssh-rsa-key.md) %}

{% note warning %}

Save the private key in a secure location, as you will not be able to connect to the VM without it.

{% endnote %}

## Create a VM with the Cisco Cloud Services Router {#create-router}

{% list tabs group=instructions %}

- Management console {#console}

  1. On the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) dashboard of the [management console]({{ link-console-main }}), click **{{ ui-key.yacloud.iam.folder.dashboard.button_add }}** and select `{{ ui-key.yacloud.iam.folder.dashboard.value_compute }}`.
  1. Select **{{ ui-key.yacloud.compute.instances.create.option_create-form-extended-title }}**.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_image }}**, in the **{{ ui-key.yacloud.compute.instances.create.placeholder_search_marketplace-product }}** field, enter `Cisco CSR` and select a [Cisco CSR](/marketplace/products/yc/cisco-csr) public image.
  1. Under **{{ ui-key.yacloud.k8s.node-groups.create.section_allocation-policy }}**, select an [availability zone](../../overview/concepts/geo-scope.md) for your VM. If you do not know which availability zone you need, leave the default one.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**, navigate to the `{{ ui-key.yacloud.component.compute.resources.label_tab-custom }}` tab and specify the required [platform](../../compute/concepts/vm-platforms.md), number of vCPUs, and the amount of RAM:

      * **{{ ui-key.yacloud.component.compute.resources.field_platform }}**: `Intel Ice Lake`
      * **{{ ui-key.yacloud.component.compute.resources.field_cores }}**: `2`
      * **{{ ui-key.yacloud.component.compute.resources.field_core-fraction }}**: `100%`
      * **{{ ui-key.yacloud.component.compute.resources.field_memory }}**: `4 {{ ui-key.yacloud.common.units.label_gigabyte }}`

  1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**:

      * In the **{{ ui-key.yacloud.component.compute.network-select.field_subnetwork }}** field, select the network and subnet to connect your VM to. If the required [network](../../vpc/concepts/network.md#network) or [subnet](../../vpc/concepts/network.md#subnet) is not there, [create it](../../vpc/operations/subnet-create.md).
      * Under **{{ ui-key.yacloud.component.compute.network-select.field_external }}**, leave `{{ ui-key.yacloud.component.compute.network-select.switch_auto }}` to assign a random external IP address to your VM from the {{ yandex-cloud }} pool. Alternatively, select a static address from the list if you reserved one.

  1. Under **{{ ui-key.yacloud.compute.instances.create.section_access }}**, select **{{ ui-key.yacloud.compute.instance.access-method.label_oslogin-control-ssh-option-title }}** and specify the VM access credentials:

      * Under **{{ ui-key.yacloud.compute.instances.create.field_user }}**, enter the username. Do not use `root` or other reserved usernames. To perform operations requiring superuser privileges, use the `sudo` command.
      * {% include [access-ssh-key](../../_includes/compute/create/access-ssh-key.md) %}

  1. Under **{{ ui-key.yacloud.compute.instances.create.section_base }}**, specify the VM name: `cisco-router`.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_additional }}**, disable `{{ ui-key.yacloud.compute.instance.overview.field_serial-port-enable }}`.
  1. Click **{{ ui-key.yacloud.compute.instances.create.button_create }}**.

  It may take a few minutes to create your VM. When the VM status changes to `RUNNING`, you can use the serial console.

{% endlist %}

## Set the host name for the router {#hostname}

{% list tabs group=instructions %}

- Management console {#console}
  
  1. In the [management console]({{ link-console-main }}), select the folder containing your VM.
  1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_compute }}**.
  1. In the VM list, select `cisco-router`.
  1. Go to the ![image](../../_assets/console-icons/terminal.svg) **{{ ui-key.yacloud.compute.instance.switch_console }}** tab and click **{{ ui-key.yacloud.compute.instance.console.connect }}**.
  1. Wait for the operating system to start up completely.
  1. To switch to privileged mode, run the `enable` command in the serial console:

      ```text
      cisco-router.{{ region-id }}.internal>enable
      ```

  1. Enter configuration mode and set the host name for the router:

      ```text
      cisco-router.{{ region-id }}.internal#configure terminal
      Enter configuration commands, one per line. End with CNTL/Z.
      cisco-router.ru-cent(config)#hostname cisco-router
      ```

      The router name at the beginning of the command line should change to `cisco-router`.

{% endlist %}

## Create a user with administrator privileges {#create-user}

Create a user with administrator privileges and password authentication disabled:

{% list tabs group=instructions %}

- Management console {#console}

  In the serial console, run this command:

  ```text
  cisco-router(config)#username test-user privilege 15
  ```

{% endlist %}

## Configure authentication using SSH keys {#enable-ssh}

1. If your public SSH key is longer than 72 characters, split it into chunks of 72 characters each by running this command in your computer terminal:

   ```bash
   fold -bw 72 <public_key_file_path>
   ```

   This will output your public SSH key split into chunks, 72 characters in each.

1. In the serial console, enable access to the VM over SSH:

   ```text
   cisco-router(config)#aaa new-model
   cisco-router(config)#ip ssh server algorithm authentication publickey 
   cisco-router(config)#ip ssh pubkey-chain
   ```

1. Create a user named `test-user` and, in `conf-ssh-pubkey-data` mode, provide your public SSH key in chunks no longer than 72 characters, beginning with `ssh-rsa` and ending with the username:

   ```text
   cisco-router(conf-ssh-pubkey)#username test-user
   cisco-router(conf-ssh-pubkey-user)#key-string
   cisco-router(conf-ssh-pubkey-data)#<public_key_row>
   ...
   cisco-router(conf-ssh-pubkey-data)#<public_key_row>
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
      key-hash ssh-rsa <key_hash> <username_associated_with_this_key>
   !
   !
   ...
   ```

1. Compare the SSH key hash on the router with the key hash on your computer:

   ```bash
   ssh-keygen -E md5 -lf <public_key_file_path>
   ```

1. In the serial console, enter the password that enables the privileged mode:

   ```text
   cisco-router#configure terminal
   cisco-router(config)#enable secret <password>
   ```

## Check the SSH connection to the router {#test-ssh}

1. Log in to the router via SSH by running this command in your computer terminal:

   ```bash
   ssh -i <private_key_file_path> test-user@<router_public_IP_address> 
   ```

   If the configuration is correct, you will log in to the router as `test-user`. If these actions produce no connection, make sure the router configuration is correct in the serial console, i.e., check whether you ran the `aaa new-model` command, the key hashes are identical on your computer and the router, and password authorization is disabled for the test user. If still unable to locate the issue, repeat the previous steps. 
1. Enter the `enable` command and password. If the configuration is correct, you can proceed to configuring the router.

## How to delete the resources you created {#clear-out}

To stop paying for the resources you created:
* [Delete](../../compute/operations/vm-control/vm-delete.md) the VM.
* [Delete](../../vpc/operations/address-delete.md) the static public IP if you reserved one.
