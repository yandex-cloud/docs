# Making a VM preemptible

You can [create a preemptible](#create-preemptible) instance or [change the type](#preemptible-to-regular) of an existing one.

## Creating a preemptible VM {#create-preemptible}

To create a [preemptible](../../concepts/preemptible-vm.md) VM:

{% list tabs %}

- Management console

   To create a VM:
   1. In the [management console]({{ link-console-main }}), select the folder to create the virtual machine in.
   1. In the list of services, select **{{ compute-name }}**.
   1. Click **Create VM**.
   1. Under **Basic parameters**:
      * Enter a name and description for the VM. Naming requirements:

         {% include [name-format](../../../_includes/name-format.md) %}

         {% include [name-fqdn](../../../_includes/compute/name-fqdn.md) %}

      * Select an [availability zone](../../../overview/concepts/geo-scope.md) to put your virtual machine in.

   1. Under **Image/boot disk selection**, select one of the [images](../../operations/images-with-pre-installed-software/get-list.md).

   1. (optional) Under **Disk{% if product == "yandex-cloud" %} and file storage{% endif %}**, click the **Disks** tab and configure a boot disk:
      * Select the [disk type](../../concepts/disk.md#disks_types).
      * Specify the necessary disk size.

         If you wish to create a virtual machine from an existing disk, under **Disks{% if product == "yandex-cloud" %} and file storage{% endif %}**, [add a disk](./create-from-disks.md):
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
      * Enter a subnet ID or select a [cloud network](../../../vpc/concepts/network.md#network) from the list.
         If you don't have a network, click **Create network** to create one:
         * In the window that opens, enter the network name and folder to host the network.
         * (optional) To automatically create subnets, select the **Create subnets** option.
         * Click **Create**.
            Each network must have at least one [subnet](../../../vpc/concepts/network.md#subnet). If there is no subnet, create one by selecting **Add subnet**.
      * In the **Public IP** field, choose a method for assigning an IP address:
         * **Auto**: Assign a random IP address from the {{ yandex-cloud }} IP pool. {% if product == "yandex-cloud" %}With this, you can enable [DDoS protection](../../../vpc/ddos-protection/index.md) using the option below.{% endif %}
         * **List**: Select a public IP address from the list of previously reserved static addresses. For more information, see [{#T}](../../../vpc/operations/set-static-ip.md).
         * **No address**: Don't assign a public IP address.
      * In the **Internal address** field, select the method for assigning internal addresses: **Auto** or **Manual**.
      * (optional) Create a record for the VM in the [DNS zone](../../../dns/concepts/dns-zone.md). Expand the **DNS settings for internal addresses** section, click **Add record** and specify the zone, FQDN and TTL for the record. For more information, see [Cloud DNS integration with Compute Cloud](../../../dns/concepts/compute-integration.md).
      * Select [appropriate security groups](../../../vpc/concepts/security-groups.md) (if there is no corresponding field, the virtual machine will be enabled for all incoming and outgoing traffic).

   1. Under **Access**, specify the data required to access the VM:
      * (optional) Select or create a [service account](../../../iam/concepts/users/service-accounts.md). By using a service account, you can flexibly configure access rights for your resources.
      * Enter the username in the **Login** field.

         {% note alert %}

         Don't use the username `root` or other names reserved by the operating system. To perform operations that require superuser permissions, use the command `sudo`.

         {% endnote %}

      * In the **SSH key** field, paste the contents of the [public key](../../operations/vm-connect/ssh.md#creating-ssh-keys) file.
      * If required, grant access to the [serial console](../../operations/serial-console/index.md).

   1. Click **Create VM**.

   The virtual machine appears in the list.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. View the description of the CLI command for creating a VM:

      ```
      yc compute instance create --help
      ```

   1. Prepare the key pair (public and private keys) for SSH access to the VM.
   1. Select a public [image](../images-with-pre-installed-software/get-list.md) from {{ marketplace-name }} based on a Linux OS (for example, [CentOS 7](/marketplace/products/yc/centos-7)).

      {% include [standard-images](../../../_includes/standard-images.md) %}

   1. Create a VM in the default folder:

      ```
      yc compute instance create \
        --name first-preemptible-instance \
        --zone {{ region-id }}-a \
        --network-interface subnet-name=default-a,nat-ip-version=ipv4 \
        --preemptible \
        --create-boot-disk image-folder-id=standard-images,image-family=centos-7 \
        --ssh-key ~/.ssh/id_rsa.pub
      ```

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

   Use the [Create](../../api-ref/Instance/create.md) method for the `Instance` resource.

- {{ TF }}

   If you don't have {{ TF }}, [install it and configure the {{ yandex-cloud }} provider](../../../tutorials/infrastructure-management/terraform-quickstart.md#install-terraform).

   1. In the configuration file, describe the parameters of resources that you want to create:

      ```
      resource "yandex_compute_instance" "vm-1" {
      
        name        = "preemptible-vm"
        platform_id = "standard-v3"
      
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
         * `resources`: The number of vCPU cores and the amount of RAM available to the VM. The values must match the selected [platform](../../concepts/vm-platforms.md).
         * `boot_disk`: Boot disk settings. Specify the ID of the selected image. You can get the image ID from the [list of public images](../images-with-pre-installed-software/get-list.md).
         * `network_interface`: Network settings. Specify the ID of the selected subnet. To automatically assign a public IP address to the VM, set `nat = true`.
         * `metadata`: In the metadata, pass the public key for accessing the VM via SSH. For more information, see [{#T}](../../concepts/vm-metadata.md).
         * `scheduling_policy`: Scheduling policy. To create a preemptible VM, set `preemptible = true`.
      * `yandex_vpc_network`: Description of the [cloud network](../../../vpc/concepts/network.md#network).
      * `yandex_vpc_subnet`: Description of [subnet](../../../vpc/concepts/network.md#network) your virtual machine will connect to.

      {% note info %}

      If you already have suitable resources, such as a cloud network and subnet, you don't need to describe them again. Use their names and IDs in the appropriate parameters.

      {% endnote %}

      For more information about resources that you can create with {{ TF }}, please see the [provider documentation]({{ tf-provider-link }}/).

   1. Make sure that the configuration files are correct.

      1. In the command line, go to the directory where you created the configuration file.
      1. Run the check using the command:

         ```
         terraform plan
         ```

      If the configuration is described correctly, the terminal displays a list of created resources and their parameters. If there are errors in the configuration, {{ TF }} points them out.

   1. Deploy the cloud resources.

      1. If the configuration doesn't contain any errors, run the command:

         ```
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
   1. Confirm the action. The VM status changes to `Stopped`.
   1. Click ![image](../../../_assets/options.svg) next to the VM name and select **Edit**.
   1. Under **Computing resources**, enable the **Preemptible** option.
   1. Click **Save changes**.
   1. Click ![image](../../../_assets/compute/run-vm.svg) **Start**.

- CLI

   {% include [cli-install](../../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

   1. See the description of the CLI's stop VM command:

      ```
      yc compute instance stop --help
      ```

   1. Get a list of all VMs in the default folder:

      {% include [compute-instance-list](../../_includes_service/compute-instance-list.md) %}

   1. Select the VM `ID` or `NAME` (for example, `first-instance`).

   1. Stop the VM:

      ```
      yc compute instance stop <instance ID or name>
      ```

      Result:

      ```
      done (15s)
      ```

   1. Change the VM's parameters:

      ```
      yc compute instance update <instance ID or name> \
        --preemptible=false
      ```

      Result:

      ```
      done (1s)
      id: fhm0b28lgfp4tkoa3jl6
      folder_id: b1ghgf288nvg541tgu73
      created_at: "2022-04-12T08:40:09Z"
      name: first-instance
      zone_id: {{ region-id }}-b
      platform_id: standard-v1
      resources:
        memory: "1073741824"
        cores: "2"
        core_fraction: "5"
      status: STOPPED
      boot_disk:
        mode: READ_WRITE
        device_name: epd8gvafrf37dmp5ofg7
        auto_delete: true
        disk_id: epd8gvafrf37dmp5ofg7
      network_interfaces:
      - index: "0"
        mac_address: d0:0d:1e:78:30:77
        subnet_id: e2lu3b6tbdj1cq3oa8ao
        primary_v4_address:
          address: 10.2.0.14
          one_to_one_nat:
            ip_version: IPV4
      fqdn: example-instance.{{ region-id }}.internal
      scheduling_policy: {}
      network_settings:
        type: STANDARD
      placement_policy: {}
      ```

   1. Restart the VM:

      ```
      yc compute instance start <instance ID or name>
      ```

      Result:

      ```
      done (11s)
      id: fhm0b28lgfp4tkoa3jl6
      folder_id: b1ghgf288nvg541tgu73
      created_at: "2022-04-12T08:40:09Z"
      name: first-instance
      zone_id: {{ region-id }}-b
      platform_id: standard-v1
      resources:
        memory: "1073741824"
        cores: "2"
        core_fraction: "5"
      status: RUNNING
      boot_disk:
        mode: READ_WRITE
        device_name: epd8gvafrf37dmp5ofg7
        auto_delete: true
        disk_id: epd8gvafrf37dmp5ofg7
      network_interfaces:
      - index: "0"
        mac_address: d0:0d:1e:78:30:77
        subnet_id: e2lu3b6tbdj1cq3oa8ao
        primary_v4_address:
          address: 10.2.0.14
          one_to_one_nat:
            address: 51.250.97.205
            ip_version: IPV4
      fqdn: example-instance.{{ region-id }}.internal
      scheduling_policy: {}
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

      For more information about resources that you can create with {{ TF }}, please see the [provider documentation]({{ tf-provider-link }}/).

   1. Make sure that the configuration files are correct.

      1. In the command line, go to the directory where you created the configuration file.
      1. Run the check using the command:

         ```
         terraform plan
         ```

      If the configuration is described correctly, the terminal displays a list of created resources and their parameters. If there are errors in the configuration, {{ TF }} points them out.

   1. Deploy the cloud resources.

      1. If the configuration doesn't contain any errors, run the command:

         ```
         terraform apply
         ```

      1. Confirm that you want to create the resources.

      Afterwards, all the necessary resources are created in the specified folder. You can check that the resources are there with the correct settings using the [management console]({{ link-console-main }}).

{% endlist %}

This will change pricing for the VM instance. Learn more about [VM pricing](../../pricing.md#prices-instance-resources).

#### See also {#see-also}

* [{#T}](../vm-connect/ssh.md)
