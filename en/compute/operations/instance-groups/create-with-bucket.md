---
title: Creating an instance group connected to {{ objstorage-full-name }}
description: Follow this guide to create an instance group connected to {{ objstorage-name }}.
---

# Creating an instance group connected to {{ objstorage-full-name }}


One of the ways to handle [stateful workloads](../../concepts/instance-groups/stateful-workload.md) is to store the application state in an [{{ objstorage-name }}](../../../storage/concepts/bucket.md) bucket independent of the instance group.

To create an instance group that will automatically connect a common {{ objstorage-name }} bucket to each of its instances:

1. {% include [sa.md](../../../_includes/instance-groups/sa.md) %}
1. To be able to create, update, and delete VMs in the group, [assign](../../../iam/operations/sa/assign-role-for-sa.md) the [compute.editor](../../security/index.md#compute-editor) role to the service account.
1. If you do not have an {{ objstorage-name }} bucket, [create one](../../../storage/operations/buckets/create.md).
1. Bucket operations are performed under the service account created in the same [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) with the bucket. If there is no such service account, create one. To work with the bucket, assign the [storage.editor role](../../../storage/security/index.md#storage-editor) to the service account.

    You can use either a single service account or two separate service accounts for working with the instance group and the bucket.

1. Create an instance group:

    {% list tabs group=instructions %}

    - CLI {#cli}

      {% include [cli-install.md](../../../_includes/cli-install.md) %}

      {% include [default-catalogue.md](../../../_includes/default-catalogue.md) %}

      1. See the description of the [CLI](../../../cli/) command for creating an instance group:

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

          To connect a bucket to instances in the instance group, add the following to the specification:

          * In the `instance_template` field, a nested `service_account_id` field containing the [ID](../../../iam/operations/sa/get-id.md) of the service account with the `storage.editor` role assigned to it:

              ```yml
              instance_template:
                ...
                service_account_id: <service_account_ID>
              ```

              For more granular access management, link different service accounts with different permissions to the instance group and individual instances within that group.

          * In the `#cloud-config` section of the `instance_template.metadata.user-data` field, commands for mounting the bucket to the instance:

              ```yml
              instance_template:
                ...
                metadata:
                  user-data: |-
                    #cloud-config
                    ...
                    runcmd:
                      - apt-get install fuse
                      - wget https://github.com/yandex-cloud/geesefs/releases/latest/download/geesefs-linux-amd64
                      - chmod a+x geesefs-linux-amd64
                      - cp geesefs-linux-amd64 /usr/bin/geesefs
                      - mkdir <instance_mount_point>
                      - echo "user_allow_other" | tee -a /etc/fuse.conf
                      - echo "<bucket_name>    <instance_mount_point>    fuse.geesefs    _netdev,allow_other,--iam    0   0" | tee -a /etc/fstab
                      - mount -a
              ```

              Where:
              * `- apt-get install fuse`: Command for installing [FUSE](https://en.wikipedia.org/wiki/Filesystem_in_Userspace). This command can run on Ubuntu and Debian. For operating systems based on Red Hat (such as CentOS and Fedora), use the `- yum install fuse` command, for OpenSUSE, `- zypper install fuse`, etc.
              * `<instance_mount_point>`: Instance directory to mount the connected bucket to. Example: `/mnt/gfs0`.
              * `<bucket_name>`: [Name of the bucket](../../../storage/concepts/bucket.md#naming) to connect to the instance.

          Here is a YAML specification example:

          ```yml
          name: vm-group-with-object-storage
          service_account_id: <service_account_ID> // service account with the compute.editor role.
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
            service_account_id: <service_account_ID> // service account with the storage.editor role.
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
                - apt-get install fuse
                - wget https://github.com/yandex-cloud/geesefs/releases/latest/download/geesefs-linux-amd64
                - chmod a+x geesefs-linux-amd64
                - cp geesefs-linux-amd64 /usr/bin/geesefs
                - mkdir /mnt/gfs0
                - echo "user_allow_other" | tee -a /etc/fuse.conf
                - echo "my-bucket-for-vm-group    /mnt/gfs0    fuse.geesefs    _netdev,allow_other,--iam    0   0" | tee -a /etc/fstab
                - mount -a
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

          This example shows a specification for [creating a fixed-size instance group](./create-fixed-group.md) with an {{ objstorage-name }} bucket connected to the instances.

          For more information about the instance group specification parameters, see [{#T}](../../concepts/instance-groups/specification.md).

      1. Create an instance group in the default folder:

          ```bash
          {{ yc-compute-ig }} create --file specification.yaml
          ```

         This command will create a group of two same-type instances with the following configuration:
         * Name: `my-vm-group-with-object-storage`.
         * OS: `Ubuntu 22.04 LTS`.
         * Availability zone: `{{ region-id }}-a`.
         * vCPU: 2, RAM: 2 GB.
         * Network [HDD](../../concepts/disk.md#disks-types): 32 GB.
         * Connected to an {{ objstorage-name }} bucket. The bucket will be mounted to the `/mnt/gfs0` directory of the group instances.
         * {% include [ssh-connection-internal-ip](../../../_includes/instance-groups/ssh-connection-internal-ip.md) %}

    - {{ TF }} {#tf}

      {% include [terraform-install](../../../_includes/terraform-install.md) %}

      1. In the configuration file, define the parameters of the resources you want to create:

          ```hcl
          resource "yandex_iam_service_account" "ig-sa" {
            name        = "ig-sa"
            description = "Service account for managing the instance group."
          }

          resource "yandex_iam_service_account" "storage-sa" {
            name        = "storage-sa"
            description = "Service account for managing the bucket."
          }

          resource "yandex_resourcemanager_folder_iam_member" "compute_editor" {
            folder_id  = "<folder_ID>"
            role       = "compute.editor"
            member     = "serviceAccount:${yandex_iam_service_account.ig-sa.id}"
            depends_on = [
              yandex_iam_service_account.ig-sa,
            ]
          }

          resource "yandex_resourcemanager_folder_iam_member" "storage_editor" {
            folder_id  = "<folder_ID>"
            role       = "storage.editor"
            member     = "serviceAccount:${yandex_iam_service_account.storage-sa.id}"
            depends_on = [
              yandex_iam_service_account.storage-sa,
            ]
          }

          resource "yandex_compute_instance_group" "ig-1" {
            name                = "fixed-ig"
            folder_id           = "<folder_ID>"
            service_account_id  = "${yandex_iam_service_account.ig-sa.id}"
            deletion_protection = "<deletion_protection>"
            depends_on          = [yandex_resourcemanager_folder_iam_member.compute_editor]
            instance_template {
              platform_id = "standard-v3"
              resources {
                memory = <RAM_in_GB>
                cores  = <number_of_vCPUs>
              }

              boot_disk {
                mode = "READ_WRITE"
                initialize_params {
                  image_id = "<image_ID>"
                }
              }

              service_account_id = "${yandex_iam_service_account.storage-sa.id}"

              network_interface {
                network_id         = "${yandex_vpc_network.network-1.id}"
                subnet_ids         = ["${yandex_vpc_subnet.subnet-1.id}"]
                security_group_ids = ["<list_of_security_group_IDs>"]
                nat                = true
              }

              metadata = {
                user-data = "#cloud-config\n      datasource:\n       Ec2:\n        strict_id: false\n      ssh_pwauth: no\n      users:\n      - name: <instance_username>\n        sudo: ALL=(ALL) NOPASSWD:ALL\n        shell: /bin/bash\n        ssh_authorized_keys:\n        - <public_SSH_key>\n      runcmd:\n      - apt-get install fuse\n      - wget https://github.com/yandex-cloud/geesefs/releases/latest/download/geesefs-linux-amd64\n      - chmod a+x geesefs-linux-amd64\n      - cp geesefs-linux-amd64 /usr/bin/geesefs\n      - mkdir <instance_mount_point>\n      - echo \"user_allow_other\" | tee -a /etc/fuse.conf\n      - echo \"<bucket_name>    <instance_mount_point>    fuse.geesefs    _netdev,allow_other,--iam    0   0\" | tee -a /etc/fstab\n      - mount -a"
              }
            }

            scale_policy {
              fixed_scale {
                size = <number_of_instances_in_group>
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
          * `yandex_iam_service_account`: [Service account](../../../iam/concepts/users/service-accounts.md) description. All operations in {{ ig-name }} are performed on behalf of the service account. For more granular access management, link different service accounts with different permissions to the instance group and individual instances within that group.

            {% include [sa-dependence-brief](../../../_includes/instance-groups/sa-dependence-brief.md) %}

          * `yandex_resourcemanager_folder_iam_member`: Description of access permissions for the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) the service account belongs to. To be able to create, update, and delete VMs in the group, assign the [compute.editor](../../security/index.md#compute-editor) role to the service account.
          * `yandex_compute_instance_group`: Instance group description:
            * General information about the instance group:
              * `name`: Instance group name.
              * `folder_id`: Folder ID.
              * `service_account_id`: ID of the service account for the instance group. This service account must have the `compute.editor` role.
              * `deletion_protection`: Instance group protection against deletion, `true` or `false`. You cannot delete an instance group with this option enabled. The default value is `false`.
            * [Instance template](../../concepts/instance-groups/instance-template.md):
              * `platform_id`: [Platform](../../concepts/vm-platforms.md).
              * `resources`: Number of vCPUs and amount of RAM available to the VM instance. The values must match the selected [platform](../../concepts/vm-platforms.md).
              * `boot_disk`: Boot [disk](../../concepts/disk.md) settings.
                * `mode`: Disk access mode, `READ_ONLY` or `READ_WRITE`.
                * `image_id`: ID of the selected image. You can get the image ID from the [list of public images](../images-with-pre-installed-software/get-list.md).
              * `service_account_id`: ID of the service account for the bucket. This service account must have the `storage.editor` role.
              * `network_interface`: [Network](../../../vpc/concepts/network.md#network) settings. Specify the IDs of your network, [subnet](../../../vpc/concepts/network.md#subnet), and [security groups](../../../vpc/concepts/security-groups.md).
              * `metadata`: In [metadata](../../concepts/vm-metadata.md), provide the following:
                * Instance username and public key to enable this user to access the instance via SSH. 
                * `- apt-get install fuse`: Command for installing [FUSE](https://en.wikipedia.org/wiki/Filesystem_in_Userspace). This command can run on Ubuntu and Debian. For operating systems based on Red Hat (such as CentOS and Fedora), use the `- yum install fuse` command, for OpenSUSE, `- zypper install fuse`, etc.
                * `<instance_mount_point>`: Instance directory to mount the connected bucket to. Example: `/mnt/gfs0`.
                * `<bucket_name>`: [Name of the bucket](../../../storage/concepts/bucket.md#naming) to connect to the instance.

                For more information, see [{#T}](../../concepts/vm-metadata.md).
            * [Policies](../../concepts/instance-groups/policies/index.md):
              * `deploy_policy`: Instance [deployment policy](../../concepts/instance-groups/policies/deploy-policy.md) for the group.
              * `scale_policy`: Instance [scaling policy](../../concepts/instance-groups/policies/scale-policy.md) for the group.
              * `allocation_policy`: [Policy for allocating](../../concepts/instance-groups/policies/allocation-policy.md) instances across [availability zones](../../../overview/concepts/geo-scope.md) and regions.
          * `yandex_vpc_network`: Cloud network description.
          * `yandex_vpc_subnet`: Description of the subnet to connect the instance group to.

            {% note info %}

            If you already have suitable resources, such as service accounts, a cloud network, and a subnet, you do not need to redefine them. Use their names and IDs in the appropriate parameters.

            {% endnote %}

          For more information about the resources you can create with {{ TF }}, see the [relevant provider documentation]({{ tf-provider-link }}).

      1. Create resources:

          {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

          All the resources you need will then be created in the specified folder. You can check the new resources and their settings using the [management console]({{ link-console-main }}).

          {% include [ssh-connection-internal-ip](../../../_includes/instance-groups/ssh-connection-internal-ip.md) %}

    - API {#api}

      Use the [create](../../instancegroup/api-ref/InstanceGroup/create.md) REST API method for the [InstanceGroup](../../instancegroup/api-ref/InstanceGroup/index.md) resource or the [InstanceGroupService/Create](../../instancegroup/api-ref/grpc/InstanceGroup/create.md) gRPC API call.

    {% endlist %}

Make sure the bucket is connected to the group instances. For this, [connect](../vm-connect/ssh.md#vm-connect) to the instances via SSH and navigate to the directory you specified as the mount point.