# Making a VM preemptible

You can [create a preemptible](#create-preemptible) VM or [change the type](#preemptible-to-regular) of an existing one.

## Creating a preemptible VM {#create-preemptible}

To create a [preemptible](../../concepts/preemptible-vm.md) VM:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder to create your VM in.
   1. In the list of services, select **{{ compute-name }}**.
   1. Click **Create VM**.
   1. Under **Basic parameters**:
      * Enter a name and description for the VM. Naming requirements:

         {% include [name-format](../../../_includes/name-format.md) %}

         {% include [name-fqdn](../../../_includes/compute/name-fqdn.md) %}

      * Select an [availability zone](../../../overview/concepts/geo-scope.md) to place the VM in.
   1. Under **Image/boot disk selection**, select one of the [images](../../operations/images-with-pre-installed-software/get-list.md).
   1. (optional) Under **Disk{% if product == "yandex-cloud" %} and file storage{% endif %}**, click the **Disks** tab and configure a boot disk:
      * Select the [disk type](../../concepts/disk.md#disks_types).
      * Specify the necessary disk size.

         If you wish to create a VM from an existing disk, under **Disks{% if product == "yandex-cloud" %} and file storage{% endif %}**, [add a disk](./create-from-disks.md):
         * Click **Add disk**.
         * Enter the disk name.
         * Select the [disk type](../../concepts/disk.md#disks_types).
         * Specify the desired block size.
         * Specify the necessary disk size.
         * (optional) Enable the **Delete with the VM** option if you need to automatically delete the disk when deleting the VM it will be attached to.
         * Select `Disk` as content.
         * Click **Add**.

   {% if product == "yandex-cloud" %}

   1. (optional) Under **Disks and file storage**, click the **File storage tab** and connect a [file store](../../concepts/filesystem.md):
      * Click **Connect file storage**.
      * In the resulting window, select a file store.
      * Enter a device name.
      * Click **Connect file storage**.

   {% endif %}

   1. Under **Computing resources**:
      * Choose a [platform](../../concepts/vm-platforms.md).
      * Specify the [guaranteed share](../../../compute/concepts/performance-levels.md) and the required number of vCPUs, as well as the amount of RAM.
      * Enable the **Preemptible** option.
      * (optional) Enable a [software-accelerated network](../../concepts/software-accelerated-network.md).
   1. Under **Network settings**:

      {% include [network-settings](../../../_includes/compute/network-settings.md) %}

   1. Under **Access**, specify the information required to access the instance:
      * (optional) Select or create a [service account](../../../iam/concepts/users/service-accounts.md). By using a service account, you can flexibly configure access rights for your resources.
      * Enter the username in the **Login** field.

         {% note alert %}

         Don't use the username `root` or other names reserved by the operating system. To perform operations that require superuser permissions, use the command `sudo`.

         {% endnote %}

      * In the **SSH key** field, paste the contents of the [public key](../../operations/vm-connect/ssh.md#creating-ssh-keys) file.
      * If required, grant access to the [serial console](../../operations/serial-console/index.md).
   1. Click **Create VM**.

   The VM appears in the list.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View a description of the CLI create VM command:

      ```bash
      yc compute instance create --help
      ```

   1. Prepare the key pair (public and private keys) for SSH access to the VM.
   1. Select a public [image](../images-with-pre-installed-software/get-list.md) {{ marketplace-full-name }} based on a Linux OS (for example, [CentOS 7](/marketplace/products/yc/centos-7)).

      {% include [standard-images](../../../_includes/standard-images.md) %}

   1. Create a VM in the default folder:

      ```bash
      yc compute instance create \
        --name first-preemptible-instance \
        --zone {{ region-id }}-a \
        --network-interface subnet-name=default-a,nat-ip-version=ipv4 \
        --preemptible \
        --create-boot-disk image-folder-id=standard-images,image-family=centos-7 \
        --ssh-key ~/.ssh/id_ed25519.pub
      ```

      {% if product == "cloud-il" %}

      {% include [vm-platform-cli](../../../_includes/compute/vm-platform-cli.md) %}

      {% endif %}

      This command creates a preemptible VM with the following characteristics:
      * Named `first-preemptible-instance`.
      * Running CentOS 7.
      * In the `{{ region-id }}-a` availability zone.
      * In the `default-a` subnet.
      * With a public IP address.

      To create a VM without a public IP address, disable the `nat-ip-version=ipv4` option.

      VM naming requirements:

      {% include [name-format](../../../_includes/name-format.md) %}

      {% include [name-fqdn](../../../_includes/compute/name-fqdn.md) %}

- API

   Use the [create](../../api-ref/Instance/create.md) method for the `Instance` resource.

- {{ TF }}

   If you don't have {{ TF }}, [install it and configure the {{ yandex-cloud }} provider](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
   1. In the configuration file, describe the parameters of resources that you want to create:

      ```
      resource "yandex_compute_instance" "vm-1" {

        name        = "preemptible-vm"
        platform_id = "standard-v3"
        zone        = "<availability zone>"

        resources {
          cores  = <number of vCPU cores>
          memory = <RAM amount, GB>
        }

        boot_disk {
          initialize_params {
            image_id = "<image ID>"
          }
        }

        network_interface {
          subnet_id = "${yandex_vpc_subnet.subnet-1.id}"
          nat       = true
        }

        metadata = {
          ssh-keys = "<username>:<SSH key contents>}"
        }

        scheduling_policy {
          preemptible = true
        }
      }

      resource "yandex_vpc_network" "network-1" {
        name = "network1"
      }

      resource "yandex_vpc_subnet" "subnet-1" {
        name       = "subnet1"
        zone       = "<availability zone>"
        network_id = "${yandex_vpc_network.network-1.id}"
      }
      ```

      Where:
      * `yandex_compute_instance`: Description of the [VM](../../concepts/vm.md):
         * `name`: VM name.
         * `platform_id`: The [platform](../../concepts/vm-platforms.md).
         * `zone`: ID of the [availability zone](../../../overview/concepts/geo-scope.md) that will host your VM.
         * `resources`: The number of vCPU cores and the amount of RAM available to the VM. The values must match the selected [platform](../../concepts/vm-platforms.md).
         * `boot_disk`: Boot disk settings. Specify the ID of the selected image. You can get the image ID from the [list of public images](../images-with-pre-installed-software/get-list.md).
         * `network_interface`: Network settings. Specify the ID of the selected subnet. To automatically assign a public IP address to the VM, set `nat = true`.
         * `metadata`: In the metadata, pass the public key for VM access via SSH. For more information, see [{#T}](../../concepts/vm-metadata.md).
         * `scheduling_policy`: Scheduling policy. To create a preemptible VM, set `preemptible = true`.
      * `yandex_vpc_network`: Description of the [cloud network](../../../vpc/concepts/network.md#network).
      * `yandex_vpc_subnet`: Description of the [subnet](../../../vpc/concepts/network.md#network) your VM will connect to.

      {% note info %}

      If you already have suitable resources, such as a cloud network and subnet, you don't need to describe them again. Use their names and IDs in the appropriate parameters.

      {% endnote %}

      For more information on resources that you can create with {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/).
   1. Make sure that the configuration files are correct.
      1. In the command line, go to the directory where you created the configuration file.
      1. Run the check using the command:

         ```bash
         terraform plan
         ```

      If the configuration is described correctly, the terminal displays a list of created resources and their parameters. If the configuration contain errors, {{ TF }} will point them out.
   1. Deploy the cloud resources.
      1. If the configuration doesn't contain any errors, run the command:

         ```bash
         terraform apply
         ```

      1. Confirm that you want to create the resources.

      Afterwards, all the necessary resources are created in the specified folder. You can check that the resources are there with the correct settings using the [management console]({{ link-console-main }}).

{% endlist %}

{% include [ip-fqdn-connection](../../../_includes/ip-fqdn-connection.md) %}

## Changing a VM's type {#preemptible-to-regular}

To change the type of a VM, for example, make it preemptible:

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where the VM is located.
   1. In the list of services, select **{{ compute-name }}**.
   1. Click ![image](../../../_assets/options.svg) next to the VM name and select **Stop**.
   1. In the window that opens, click **Stop**. The VM status changes to `Stopped`.
   1. Click ![image](../../../_assets/options.svg) next to the VM name and select **Edit**.
   1. Under **Computing resources**, enable the **Preemptible** option.
   1. Click **Save changes**.
   1. Click ![image](../../../_assets/compute/run-vm.svg) **Start**.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View a description of the CLI command to stop a VM:

      ```bash
      yc compute instance stop --help
      ```

   1. Get a list of all VMs in the default folder:

      {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}

   1. Select the VM `ID` or `NAME` (for example, `first-instance`).
   1. Stop the VM:

      ```bash
      yc compute instance stop <VM ID or name>
      ```

      Result:

      ```text
      done (15s)
      ```

   1. Edit the VM parameters:

      ```bash
      yc compute instance update <VM ID or name> \
        --preemptible=false
      ```

      Result:

      ```text
      done (1s)
      id: fhm0b28lgfp4tkoa3jl6
      folder_id: b1ghgf288nvg541tgu73
      ...
      network_settings:
        type: STANDARD
      placement_policy: {}
      ```

   1. Start the VM again:

      ```bash
      yc compute instance start <VM ID or name>
      ```

      Result:

      ```text
      done (11s)
      id: fhm0b28lgfp4tkoa3jl6
      folder_id: b1ghgf288nvg541tgu73
      ...
      network_settings:
        type: STANDARD
      placement_policy: {}
      ```

- API

   Use the [update](../../api-ref/Instance/update.md) method for the [Instance](../../api-ref/Instance/) resource. In the request body, set `"preemptible": false` in `schedulingPolicy`.

- {{ TF }}

   If you don't have {{ TF }}, [install it and configure the {{ yandex-cloud }} provider](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).
   1. In the configuration file, find a description of the scheduling policy of the VM you want to make preemptible:

      ```
      scheduling_policy {
        preemptible = true
      }
      ```

   1. Delete the `scheduling_policy` field set to `preemptible = true`:

      For more information on resources that you can create with {{ TF }}, see the [provider documentation]({{ tf-provider-link }}/).
   1. Make sure that the configuration files are correct.
      1. In the command line, go to the directory where you created the configuration file.
      1. Run the check using the command:

         ```bash
         terraform plan
         ```

      If the configuration is described correctly, the terminal displays a list of created resources and their parameters. If the configuration contain errors, {{ TF }} will point them out.
   1. Deploy the cloud resources.
      1. If the configuration doesn't contain any errors, run the command:

         ```bash
         terraform apply
         ```

      1. Confirm that you want to create the resources.

      Afterwards, all the necessary resources are created in the specified folder. You can check that the resources are there with the correct settings using the [management console]({{ link-console-main }}).

{% endlist %}

This will affect your bill for the VM usage. More about [VM pricing](../../pricing.md#prices-instance-resources).

#### See also {#see-also}

* [{#T}](../vm-connect/ssh.md)