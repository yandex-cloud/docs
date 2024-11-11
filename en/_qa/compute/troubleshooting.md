# Troubleshooting in {{ compute-name }}

This section describes typical problems that may arise when using {{ compute-name }} and the relevant solutions.

#### You cannot connect to a new VM with multiple network interfaces over SSH {#unable-to-connect-to-new-multi-interface-vm}

When creating a Linux VM with multiple [network interfaces](../../compute/concepts/network.md), the additional network interfaces may not work correctly in the OS. In some cases, this issue can hinder network connectivity and prevent you from [connecting](../../compute/operations/vm-connect/ssh.md) to the VM over SSH.

To fix the issue, delete the VM and [create](../../compute/operations/vm-create/create-linux-vm.md) a new one by providing additional [cloud-init](https://cloud-init.io) parameters in the new VM [metadata](../../compute/concepts/vm-metadata.md#keys-processed-in-public-images):

{% list tabs group=instructions %}

- Management console {#console}

  Expand the **{{ ui-key.yacloud.common.metadata }}** section and add the `user-data` key with the following configuration:

  {% cut "For Ubuntu" %}

  {% include [multiinterfaced-vm-cloudinit-ubuntu](../../_includes/compute/multiinterfaced-vm-cloudinit-ubuntu.md) %}

  {% endcut %}

  {% cut "For Debian" %}

  {% include [multiinterfaced-vm-cloudinit-debian](../../_includes/compute/multiinterfaced-vm-cloudinit-debian.md) %}

  {% endcut %}

  Where:
  * `name:`: Username for [connecting](../../compute/operations/vm-connect/ssh.md) to the VM over SSH.
  * `ssh_authorized_keys:`: List of public SSH keys to connect the user to the VM over SSH. You need to specify at least one public SSH key.

- CLI {#cli}

  1. Create a file with the cloud-init configuration, e.g., `vm-init.tpl`:

      {% cut "For Ubuntu" %}

      {% include [multiinterfaced-vm-cloudinit-ubuntu](../../_includes/compute/multiinterfaced-vm-cloudinit-ubuntu.md) %}

      {% endcut %}

      {% cut "For Debian" %}

      {% include [multiinterfaced-vm-cloudinit-debian](../../_includes/compute/multiinterfaced-vm-cloudinit-debian.md) %}

      {% endcut %}

  1. When creating a VM, provide the created configuration file to it in the `--metadata-from-file` parameter, e.g.:

      ```bash
      yc compute instance create --name=multi-net-vm --hostname=multi-net-vm \
        --zone {{ region-id }}-a \
        --create-boot-disk image-folder-id=standard-images,image-id=fd8bi0vgcf8vco49q3bm \
        --cores=2 --memory=4G --core-fraction=100 \
        --network-interface subnet-name=subnet1,ipv4-address=auto,nat-ip-version=ipv4 \
        --network-interface subnet-name=subnet2,ipv4-address=auto \
        --network-interface subnet-name=subnet3,ipv4-address=auto \
        --metadata-from-file user-data=vm-init.tpl
      ```

- {{ TF }} {#tf}

  1. Create a file with the cloud-init configuration, e.g., `vm-init.tpl`:

      {% cut "For Ubuntu" %}

      {% include [multiinterfaced-vm-cloudinit-ubuntu](../../_includes/compute/multiinterfaced-vm-cloudinit-ubuntu.md) %}

      {% endcut %}

      {% cut "For Debian" %}

      {% include [multiinterfaced-vm-cloudinit-debian](../../_includes/compute/multiinterfaced-vm-cloudinit-debian.md) %}

      {% endcut %}

  1. When creating a VM, provide the created metadata file to it in the `yandex_compute_instance.metadata` section, e.g.:

      ```hcl
      resource "yandex_compute_instance" "multi-net-vm" {
        name        = "multi-net-vm"
        platform_id = "standard-v2"
        zone        = "{{ region-id }}-a"

        resources {
          cores  = "2"
          memory = "2"
        }

        boot_disk {
          initialize_params {
            image_id = "fd8bi0vgcf8vco49q3bm"
          }
        }

        network_interface {
          subnet_id          = "e2lrucutusnd********"
          nat                = true
        }

        network_interface {
          subnet_id          = "e2lpp96bvvgp********"
          nat                = false
        }

        network_interface {
          subnet_id          = "e2lv9c6aek1d********"
          nat                = false
        }

        metadata = {
          user-data = "${file("./vm-init.tpl")}"
        }
      }
      ```

{% endlist %}

#### Additional network interfaces do not work after you attach them to the existing VM {#added-net-interfaces-down}

After you attach additional [network interfaces](../../compute/concepts/network.md) to a Linux VM, they may fail to work correctly in the operating system. In some cases, this issue can hinder network connectivity and prevent you from connecting to the VM over SSH.

To fix this issue, try upgrading the VM's operating system to its latest version.

If upgrading the OS is not possible or does not help:

1. [Connect](../../compute/operations/vm-connect/ssh.md) to the VM over SSH.

    If the SSH connection fails due to network connectivity issues, [remove](../../compute/operations/vm-control/detach-network-interface.md) all the additional network interfaces and [reboot](../../compute/operations/vm-control/vm-stop-and-start.md#restart) the VM.

1. Update the OS network configuration:

    {% list tabs %}

    - Ubuntu

      1. Add the configuration of the new network interfaces to the `/etc/netplan/01-netcfg.yaml` file:
      
          ```bash
          sudo nano /etc/netplan/01-netcfg.yaml
          ```

          In the `write_files.content.network.ethernets` configuration section, specify the settings for the required number of existing or new VM network interfaces, as shown below. Interfaces are numbered starting from zero. This example shows how to set up three interfaces. You can add up to eight network interfaces to a single VM.

          ```
          # This file describes the network interfaces available on your system
          # For more information, see netplan(5).
          network:
            version: 2
            renderer: networkd
            ethernets:
              eth0:
                dhcp4: yes
              eth1:
                dhcp4: yes
                dhcp4-overrides:
                  use-dns: false
                  use-routes: false
                dhcp6: no
              eth2:
                dhcp4: yes
                dhcp4-overrides:
                  use-dns: false
                  use-routes: false
                dhcp6: no
          ```

      1. Assign the required permissions to the `/etc/netplan/01-netcfg.yaml` file:

          ```bash
          sudo chmod 0644 /etc/netplan/01-netcfg.yaml
          ```

      1. Apply the configuration changes:

          ```bash
          sudo netplan apply
          ```

    - Debian

      1. Add the configuration of the new network interfaces to the `/etc/network/interfaces` file:
      
          ```bash
          sudo nano /etc/network/interfaces
          ```
      
          In the `Primary network interface` and `Other network interfaces` configuration sections, specify the settings for the required number of existing or new VM network interfaces, as shown below. Interfaces are numbered starting from zero. This example shows how to set up three interfaces. You can add up to eight network interfaces to a single VM.

          ```txt
          # This file describes the network interfaces available on your system
          # and how to activate them. For more information, see interfaces(5).

          source /etc/network/interfaces.d/*

          # Loopback network interface
          auto lo
          iface lo inet loopback

          # Primary network interface
          allow-hotplug eth0
          iface eth0 inet dhcp

          # Other network interfaces
          auto eth1
          allow-hotplug eth1
          iface eth1 inet dhcp

          auto eth2
          allow-hotplug eth2
          iface eth2 inet dhcp
          post-up ip route del default
          ```

      1. Restart the network service:

          ```bash
          sudo systemctl restart networking
          ```

    {% endlist %}

1. If you previously had to remove additional network interfaces, [attach](../../compute/operations/vm-control/attach-network-interface.md) them again.