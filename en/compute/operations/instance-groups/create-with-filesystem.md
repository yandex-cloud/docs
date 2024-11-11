# Creating an instance group connected to a file storage


One of the ways to handle [stateful workloads](../../concepts/instance-groups/stateful-workload.md) is saving the application state to a [file storage](../../concepts/filesystem.md) independent of the instance group.

To create an instance group that will automatically connect a common file storage to each of its instances:

1. {% include [sa.md](../../../_includes/instance-groups/sa.md) %}
1. If you do not have a file storage, [create one](../filesystem/create.md).
1. Create an instance group:

    {% list tabs group=instructions %}

    - CLI {#cli}

      {% include [cli-install.md](../../../_includes/cli-install.md) %}

      {% include [default-catalogue.md](../../../_includes/default-catalogue.md) %}

      1. View the description of the [CLI](../../../cli/) command to create an instance group:

         ```bash
         {{ yc-compute-ig }} create --help
         ```

      1. Check whether the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) contains any [networks](../../../vpc/concepts/network.md#network):

         ```bash
         yc vpc network list
         ```

         If there are none, [create a network](../../../vpc/operations/network-create.md).
      1. Select one of the {{ marketplace-full-name }} public images, e.g., [Ubuntu 22.04 LTS](/marketplace/products/yc/ubuntu-22-04-lts).

         {% include [standard-images.md](../../../_includes/standard-images.md) %}

      1. Prepare a file with the [YAML specification](../../concepts/instance-groups/specification.md) of the instance group and give it a name, e.g., `specification.yaml`.

          To connect the file storage to VMs in the instance group, add the following to the specification:

          * In the `instance_template` field, a nested `filesystem_specs` field with the file storage description:

              ```yml
              instance_template:
                ...
                filesystem_specs:
                  - mode: READ_WRITE
                    device_name: <VM_device_name>
                    filesystem_id: <file_storage_ID>
              ```

              Where:
              * `mode`: File storage access mode, which must be `READ_WRITE` to allow both reading and writing.
              * `device_name`: Device name for attaching the [file storage](../../concepts/filesystem.md) to the VM, e.g., `sample-fs`. The name may contain lowercase Latin letters, numbers, and hyphens. The first character must be a letter. The last character cannot be a hyphen. The name may be up to 63 characters long.
              * `filesystem_id`: File storage ID. You can view the ID in the [management console]({{ link-console-main }}) or using the `yc compute filesystem list` CLI command.

          * In the `#cloud-config` section of the `instance_template.metadata.user-data` field, commands for mounting the file storage to the VM:

              ```yml
              instance_template:
                ...
                metadata:
                  user-data: |-
                    #cloud-config
                    ...
                    runcmd:
                      - mkdir <mount_point_on_VM>
                      - mount -t virtiofs <VM_device_name> <mount_point_on_VM>
                      - echo "test-fs <VM_mount_point> virtiofs    rw    0   0" | tee -a /etc/fstab
              ```

              Where:
              * `<VM_mount_point>`: VM directory to mount the connected file storage to, e.g., `/mnt/vfs0`.
              * `<VM_device_name>`: Device name for attaching the file storage to the VM. The value must match the one specified earlier in the `instance_template.filesystem_specs.device_name` field.

          YAML specification example:

          ```yml
          name: my-vm-group-with-fs
          service_account_id: ajegtlf2q28a********
          description: "This instance group was created using a YAML configuration file."
          instance_template:
            platform_id: standard-v3
            resources_spec:
              memory: 2g
              cores: 2
            boot_disk_spec:
              mode: READ_WRITE
              disk_spec:
                image_id: fd8dlvgiatiqd8tt2qke
                type_id: network-hdd
                size: 32g
            network_interface_specs:
              - network_id: enp9mji1m7b3********
                primary_v4_address_spec: {
                  one_to_one_nat_spec: {
                    ip_version: IPV4
                  }
                }
                security_group_ids:
                  - enpuatgvejtn********
            filesystem_specs:
              - mode: READ_WRITE
                device_name: sample-fs
                filesystem_id: epdccsrlalon********
            metadata:
              user-data: |-
                #cloud-config
                datasource:
                 Ec2:
                  strict_id: false
                ssh_pwauth: no
                users:
                - name: my-user
                  sudo: ALL=(ALL) NOPASSWD:ALL
                  shell: /bin/bash
                  ssh_authorized_keys:
                  - <public_SSH_key>
                runcmd:
                - mkdir /mnt/vfs0
                - mount -t virtiofs sample-fs /mnt/vfs0
                - echo "sample-fs /mnt/vfs0 virtiofs    rw    0   0" | tee -a /etc/fstab
          deploy_policy:
            max_unavailable: 1
            max_expansion: 0
          scale_policy:
            fixed_scale:
              size: 2
          allocation_policy:
            zones:
              - zone_id: {{ region-id }}-a
                instance_tags_pool:
                - first
                - second
          ```

          This example shows a specification for [creating a fixed-size instance group](./create-fixed-group.md) with a file storage connected to the instances.

          For more information about the instance group specification parameters, see [{#T}](../../concepts/instance-groups/specification.md).

      1. Create an instance group in the default folder:

          ```bash
          {{ yc-compute-ig }} create --file specification.yaml
          ```

         This command creates a group of two similar instances with the following configuration:
         * Name: `my-vm-group-with-fs`.
         * OS: `Ubuntu 22.04 LTS`.
         * Availability zone: `{{ region-id }}-a`.
         * vCPUs: 2; RAM: 2 GB.
         * Network [HDD](../../concepts/disk.md#disks-types): 32 GB.
         * Connected to a file storage. The file storage will be mounted to the `/mnt/vfs0` directory of the group VMs.
         * {% include [ssh-connection-internal-ip](../../../_includes/instance-groups/ssh-connection-internal-ip.md) %}

    - {{ TF }} {#tf}

      {% include [terraform-install](../../../_includes/terraform-install.md) %}

      1. In the configuration file, describe the parameters of the resources you want to create:

          ```hcl
          resource "yandex_iam_service_account" "ig-sa" {
            name        = "ig-sa"
            description = "Service account for managing an instance group."
          }

          resource "yandex_resourcemanager_folder_iam_member" "editor" {
            folder_id  = "<folder_ID>"
            role       = "editor"
            member     = "serviceAccount:${yandex_iam_service_account.ig-sa.id}"
            depends_on = [
              yandex_iam_service_account.ig-sa,
            ]
          }

          resource "yandex_compute_instance_group" "ig-1" {
            name                = "fixed-ig"
            folder_id           = "<folder_ID>"
            service_account_id  = "${yandex_iam_service_account.ig-sa.id}"
            deletion_protection = "<deletion_protection>"
            depends_on          = [yandex_resourcemanager_folder_iam_member.editor]
            instance_template {
              platform_id = "standard-v3"
              resources {
                memory = <RAM_GB>
                cores  = <number_of_vCPU_cores>
              }

              boot_disk {
                mode = "READ_WRITE"
                initialize_params {
                  image_id = "<image_ID>"
                }
              }

              filesystem {
                mode = "READ_WRITE"
                device_name = "<VM_device_name>"
                filesystem_id = "<file_storage_ID>"
              }

              network_interface {
                network_id         = "${yandex_vpc_network.network-1.id}"
                subnet_ids         = ["${yandex_vpc_subnet.subnet-1.id}"]
                security_group_ids = ["<list_of_security_group_IDs>"]
                nat                = true
              }

              metadata = {
                user-data = "#cloud-config\n  datasource:\n   Ec2:\n    strict_id: false\n  ssh_pwauth: no\n  users:\n  - name: <VM_user_name>\n    sudo: ALL=(ALL) NOPASSWD:ALL\n    shell: /bin/bash\n    ssh_authorized_keys:\n    - <public_SSH_key>\n  runcmd:\n    - mkdir <VM_mount_point>\n    - mount -t virtiofs <VM_device_name> <VM_mount_point>\n    - echo \"sample-fs <VM_mount_point> virtiofs    rw    0   0\" | tee -a /etc/fstab"
              }
            }

            scale_policy {
              fixed_scale {
                size = <number_of_VMs_in_group>
              }
            }

            allocation_policy {
              zones = ["{{ region-id }}-a"]
            }

            deploy_policy {
              max_unavailable = 1
              max_expansion   = 0
            }
          }

          resource "yandex_vpc_network" "network-1" {
            name = "network1"
          }

          resource "yandex_vpc_subnet" "subnet-1" {
            name           = "subnet1"
            zone           = "{{ region-id }}-a"
            network_id     = "${yandex_vpc_network.network-1.id}"
            v4_cidr_blocks = ["192.168.10.0/24"]
          }
          ```

          Where:
          * `yandex_iam_service_account`: [Service account](../../../iam/concepts/users/service-accounts.md) description. All operations in {{ ig-name }} are performed on behalf of the service account.

            {% include [sa-dependence-brief](../../../_includes/instance-groups/sa-dependence-brief.md) %}

          * `yandex_resourcemanager_folder_iam_member`: Description of access permissions to the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) the service account belongs to. To be able to create, update, and delete VM instances in the instance group, assign the `editor` [role](../../../iam/concepts/access-control/roles.md) to the service account.
          * `yandex_compute_instance_group`: Description of the instance group.
            * General information about the instance group:
              * `name`: Instance group name.
              * `folder_id`: Folder ID.
              * `service_account_id`: Service account ID.
              * `deletion_protection`: Instance group protection against deletion, `true` or `false`. You cannot delete an instance group with this option enabled. The default value is `false`.
            * [VM template](../../concepts/instance-groups/instance-template.md):
              * `platform_id`: [Platform](../../concepts/vm-platforms.md).
              * `resources`: Number of vCPU cores and RAM available to the VM. The values must match the selected [platform](../../concepts/vm-platforms.md).
              * `boot_disk`: Boot [disk](../../concepts/disk.md) settings.
                * `mode`: Disk access mode, `READ_ONLY` or `READ_WRITE`.
                * `image_id`: ID of the selected image. You can get the image ID from the [list of public images](../images-with-pre-installed-software/get-list.md).
              * `filesystem`: [File storage](../../concepts/filesystem.md) settings.
                * `mode`: File storage access mode, which must be `READ_WRITE` to allow both reading and writing.
                * `device_name`: Device name for attaching the file storage to the VM, e.g., `sample-fs`. The name may contain lowercase Latin letters, numbers, and hyphens. The first character must be a letter. The last character cannot be a hyphen. The name may be up to 63 characters long.
                * `filesystem_id`: File storage ID. You can view the ID in the [management console]({{ link-console-main }}) or using the `yc compute filesystem list` CLI command.
              * `network_interface`: [Network](../../../vpc/concepts/network.md#network) configurations. Specify the IDs of your network, [subnet](../../../vpc/concepts/network.md#subnet), and [security groups](../../../vpc/concepts/security-groups.md).
              * `metadata`: In [metadata](../../concepts/vm-metadata.md), provide the following:
                * VM user name and public key to enable this user to access the VM via SSH. 
                * VM mount point for the file storage, i.e., a directory on the VM to mount the connected file storage to, e.g., `/mnt/vfs0`.
                * VM device name, i.e., a device name for attaching the file storage to the VM. The value must match the one specified earlier in the `device_name` field under `filesystem`.

                For more information, see [{#T}](../../concepts/vm-metadata.md).
            * [Policies](../../concepts/instance-groups/policies/index.md):
              * `deploy_policy`: [Deployment policy](../../concepts/instance-groups/policies/deploy-policy.md) for instances in the group.
              * `scale_policy`: [Scaling policy](../../concepts/instance-groups/policies/scale-policy.md) for instances in the group.
              * `allocation_policy`: [Policy for allocating](../../concepts/instance-groups/policies/allocation-policy.md) VM instances across [availability zones](../../../overview/concepts/geo-scope.md) and regions.
          * `yandex_vpc_network`: Description of the cloud network.
          * `yandex_vpc_subnet`: Description of the subnet the instance group will connect to.

            {% note info %}

            If you already have suitable resources, such as a service account, cloud network, and subnet, you do not need to describe them again. Use their names and IDs in the appropriate parameters.

            {% endnote %}

          For more information about the resources you can create with {{ TF }}, see the [provider documentation]({{ tf-provider-link }}).

      1. Create resources:

          {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

          All the resources you need will then be created in the specified folder. You can check the new resources and their configuration using the [management console]({{ link-console-main }}).

          {% include [ssh-connection-internal-ip](../../../_includes/instance-groups/ssh-connection-internal-ip.md) %}

    - API {#api}

      Use the [create](../../instancegroup/api-ref/InstanceGroup/create.md) REST API method for the [InstanceGroup](../../instancegroup/api-ref/InstanceGroup/index.md) resource or the [InstanceGroupService/Create](../../instancegroup/api-ref/grpc/InstanceGroup/create.md) gRPC API call.

    {% endlist %}

Make sure the file storage is connected to VMs in the instance group. To do so, [connect](../vm-connect/ssh.md#vm-connect) to a VM via SSH and navigate to the directory that you specified as the mount point.