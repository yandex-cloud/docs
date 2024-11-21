# Creating a group of instances with fixed IP addresses


You can use [tags](../../concepts/instance-groups/policies/allocation-policy.md#tags) and [variables](../../concepts/instance-groups/variables-in-the-template.md) to create a group of VM instances with predefined [internal](../../../vpc/concepts/address.md#internal-addresses) and [public](../../../vpc/concepts/address.md#public-addresses) IP addresses.

To create an instance group with fixed IP addresses:

{% list tabs group=instructions %}

- CLI {#cli}

  1. {% include [sa.md](../../../_includes/instance-groups/sa.md) %}
  1. Create a cloud [network](../../../vpc/operations/network-create.md) and [subnets](../../../vpc/operations/subnet-create.md), for example, in two [availability zones](../../../overview/concepts/geo-scope.md), if you do not have them.
  1. To make VMs in the group accessible from the internet, [reserve](../../../vpc/operations/get-static-ip.md) the required number of static public IP addresses. For the example below, four IP addresses are enough.
  1. {% include [cli-install.md](../../../_includes/cli-install.md) %}

      {% include [default-catalogue.md](../../../_includes/default-catalogue.md) %}

  1. View the description of the [CLI](../../../cli/) command to create an instance group:

     ```bash
     {{ yc-compute-ig }} create --help
     ```

  1. Select one of the {{ marketplace-full-name }} public images, e.g., [Ubuntu 22.04 LTS](/marketplace/products/yc/ubuntu-22-04-lts).

     {% include [standard-images.md](../../../_includes/standard-images.md) %}

  1. Prepare a file with the [YAML specification](../../concepts/instance-groups/specification.md) of the instance group and give it a name, e.g., `specification.yaml`.

      To assign fixed IP addresses to the VMs of the group, add the following sections and parameters to the specification:

      * In the `allocation_policy` field, a nested `zones` field with paired `zone_id` and `instance_tags_pool` parameters for each of the [availability zones](../../../overview/concepts/geo-scope.md) in which you will create VM instances. For example, if the VMs of the group will be located in the `{{ region-id }}-a` and `{{ region-id }}-b` availability zones, the `allocation_policy` field will look like this:

          ```yml
          allocation_policy:
            zones:
              - zone_id: {{ region-id }}-a
                instance_tags_pool:
                - <tag1_of_{{ region-id }}-a_zone>
                - <tag2_of_{{ region-id }}-a_zone>
              - zone_id: {{ region-id }}-b
                instance_tags_pool:
                - <tag1_of_{{ region-id }}-b_zone>
                - <tag2_of_{{ region-id }}-b_zone>
          ```

          Where:

          * `zone_id`: Availability zone ID.
          * `instance_tags_pool`: List of unique [tags](../../concepts/instance-groups/policies/allocation-policy.md#tags) for binding IP addresses to the VMs of the group. The tag value is used to generate VM names and variables containing IP addresses of the VMs. For each availability zone, the number of tags should match the number of VMs created in it. Examples of possible tag values: `ru1-a1`, `ru1-b2`, etc.
          
      * The `variables` field containing variables used in templates to provide IP addresses of the VMs you are creating to the VM group:

          ```yml
          variables:
            - key: ip_<tag1_of_{{ region-id }}-a_zone>
              value: <internal_IP_address1>
            - key: external_ip_<tag1_of_{{ region-id }}-a_zone>
              value: <public_IP_address1>
            ...
            - key: ip_<tag2_of_{{ region-id }}-b_zone>
              value: <internal_IP_address4>
            - key: external_ip_<tag2_of_{{ region-id }}-b_zone>
              value: <public_IP_address4>
          ```

          Where:

          * `key`: Variable name in `<prefix>_<tag>` format:
              * `<prefix>` defines the IP address type. For example, you can use the `ip` prefix for internal addresses and `external_ip` for public ones.

              * `<tag>` value must fully match the value of the relevant tag specified for this VM in the `allocation_policy` field, e.g., `ru1-a1`.

          * `value`: Variable value, an in internal or public IP address of the new VM.

              Internal IP addresses must belong to the IP address range allocated to the specified subnet in the respective availability zone.

              If you are not going to assign public IP addresses to the group instances, do not specify variables with the `external_ip` prefix.

          For more information about using variables in a VM template, see [{#T}](../../concepts/instance-groups/variables-in-the-template.md).

      * In the `instance_template.name` field, the VM name containing the tag template, e.g., `sample-vm-{instance.tag}`. After inserting tag values into this template, the VM names will look like this: `sample-vm-ru1-a1`, `sample-vm-ru1-b2`, etc.

      * In the `instance_template.network_interface_specs` field, subnet IDs and IP address templates:

          ```yml
          instance_template:
            ...
            network_interface_specs:
              - subnet_ids:
                  - <{{ region-id }}-a_subnet_ID>
                  - <{{ region-id }}-b_subnet_ID>
                primary_v4_address_spec:
                  address: "{ip_{instance.tag}}"
                  one_to_one_nat_spec:
                    ip_version: IPV4
                    address: "{<external_ip_{instance.tag}}"
          ```

          Where:
          * `subnet_ids`: List of IDs for the [subnets](../../../vpc/concepts/network.md#subnet) to host the VMs. You must specify one subnet in each availability zone where a group VM will be created.
          * `primary_v4_address_spec.address`: Internal IP address template. It will use the variable value specified for this VM in the `variables` field.
          * `primary_v4_address_spec.one_to_one_nat_spec.address`: Public IP address template. It will use the variable value specified for this VM in the `variables` field.

          If you are not going to assign public IP addresses to the group instances, do not add the `primary_v4_address_spec.one_to_one_nat_spec` field to the specification.

      YAML specification example:

      ```yml
      service_account_id: ajegtlf2q28a********
      name: my-vm-group-with-fixed-ips
      description: Example of using tags for managing ips. Created with CLI
      scale_policy:
        fixed_scale:
          size: 4
      deploy_policy:
        max_unavailable: 2
      allocation_policy:
        zones:
          - zone_id: {{ region-id }}-a
            instance_tags_pool:
            - ru1-a1
            - ru1-a2
          - zone_id: {{ region-id }}-b
            instance_tags_pool:
            - ru1-b1
            - ru1-b2
      variables:
        - key: ip_ru1-a1
          value: 192.168.2.5
        - key: external_ip_ru1-a1
          value: 84.201.***.**
        - key: ip_ru1-a2
          value: 192.168.2.15
        - key: external_ip_ru1-a2
          value: 130.193.**.**
        - key: ip_ru1-b1
          value: 192.168.1.5
        - key: external_ip_ru1-b1
          value: 84.201.***.**
        - key: ip_ru1-b2
          value: 192.168.1.15
        - key: external_ip_ru1-b2
          value: 84.201.***.*
      instance_template:
        name: sample-vm-{instance.tag}
        platform_id: standard-v2
        resources_spec:
          memory: 2G
          cores: 2
        boot_disk_spec:
          mode: READ_WRITE
          disk_spec:
            image_id: fd8dlvgiatiqd8tt2qke
            type_id: network-hdd
            size: 20g
        network_interface_specs:
          - subnet_ids:
              - e2l3qffk0h6t********
              - e9bijtoprmcu********
            primary_v4_address_spec:
              address: "{ip_{instance.tag}}"
              one_to_one_nat_spec:
                address: "{external_ip_{instance.tag}}"
      ```

      This example shows a specification for [creating a fixed-size instance group](./create-fixed-group.md) with fixed internal and public IP addresses.

      For more information about the instance group specification parameters, see [{#T}](../../concepts/instance-groups/specification.md).

  1. Create an instance group in the default folder:

      ```bash
      {{ yc-compute-ig }} create --file specification.yaml
      ```

      This command creates an instance group with the following characteristics:
      * Name: `my-vm-group-with-fixed-ips`
      * OS: `Ubuntu 22.04 LTS`
      * Number of VMs: four, in the `{{ region-id }}-a` and `{{ region-id }}-b` availability zones, two per zone
      * vCPUs: 2; RAM: 2 GB
      * Network [HDD](../../concepts/disk.md#disks-types): 20 GB
      * Fixed internal and public [IP addresses](../../../vpc/concepts/address.md) assigned to each VM of the group

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. In the configuration file, describe the parameters of the resources you want to create:

      ```hcl
      resource "yandex_compute_instance_group" "ig-1" {
        name                = "fixed-ig"
        folder_id           = "<folder_ID>"
        service_account_id  = "${yandex_iam_service_account.ig-sa.id}"
        deletion_protection = false
        depends_on          = [yandex_resourcemanager_folder_iam_member.editor]
        instance_template {
          name = "sample-vm-{instance.tag}"
          platform_id = "standard-v3"
          resources {
            memory = 2
            cores  = 2
          }

          boot_disk {
            mode = "READ_WRITE"
            initialize_params {
              image_id = "fd8dlvgiatiqd8tt2qke"
            }
          }

          network_interface {
            network_id         = "${yandex_vpc_network.ig-network.id}"
            subnet_ids         = ["${yandex_vpc_subnet.ig-subnet-a.id}", "${yandex_vpc_subnet.ig-subnet-b.id}"]
            nat                = true
            ip_address         = "{ip_{instance.tag}}"
            nat_ip_address     = "{external_ip_{instance.tag}}"
          }

          metadata = {
            user-data = "#cloud-config\n      datasource:\n       Ec2:\n        strict_id: false\n      ssh_pwauth: no\n      users:\n      - name: <VM_user_name>\n        sudo: ALL=(ALL) NOPASSWD:ALL\n        shell: /bin/bash\n        ssh_authorized_keys:\n        - <public_SSH_key>\n      runcmd: []"
          }
        }

        variables = {
          ip_ru1-a1 = "192.168.2.5"
          external_ip_ru1-a1 = "${yandex_vpc_address.external-address-a1.external_ipv4_address[0].address}"
          ip_ru1-a2 = "192.168.2.15"
          external_ip_ru1-a2 = "${yandex_vpc_address.external-address-a2.external_ipv4_address[0].address}"
          ip_ru1-b1 = "192.168.1.5"
          external_ip_ru1-b1 = "${yandex_vpc_address.external-address-b1.external_ipv4_address[0].address}"
          ip_ru1-b2 = "192.168.1.15"
          external_ip_ru1-b2 = "${yandex_vpc_address.external-address-b2.external_ipv4_address[0].address}"
        }

        scale_policy {
          fixed_scale {
            size = 4
          }
        }

        allocation_policy {
          zones = ["{{ region-id }}-a","{{ region-id }}-b"]
          instance_tags_pool {
            zone = "{{ region-id }}-a"
            tags = ["ru1-a1","ru1-a2"]
          }
          instance_tags_pool {
            zone = "{{ region-id }}-b"
            tags = ["ru1-b1","ru1-b2"]
          }
        }

        deploy_policy {
          max_unavailable = 1
          max_expansion   = 0
        }
      }

      resource "yandex_iam_service_account" "ig-sa" {
        name        = "instance-group-sa"
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

      resource "yandex_vpc_network" "ig-network" {
        name = "ig-network"
      }

      resource "yandex_vpc_subnet" "ig-subnet-a" {
        name           = "ig-subnet-a"
        zone           = "{{ region-id }}-a"
        network_id     = "${yandex_vpc_network.ig-network.id}"
        v4_cidr_blocks = ["192.168.2.0/24"]
      }

      resource "yandex_vpc_subnet" "ig-subnet-b" {
        name           = "ig-subnet-b"
        zone           = "{{ region-id }}-b"
        network_id     = "${yandex_vpc_network.ig-network.id}"
        v4_cidr_blocks = ["192.168.1.0/24"]
      }

      resource "yandex_vpc_address" "external-address-a1" {
        name = "external-address-a1"

        external_ipv4_address {
          zone_id = "{{ region-id }}-a"
        }
      }

      resource "yandex_vpc_address" "external-address-a2" {
        name = "external-address-a2"

        external_ipv4_address {
          zone_id = "{{ region-id }}-a"
        }
      }

      resource "yandex_vpc_address" "external-address-b1" {
        name = "external-address-b1"

        external_ipv4_address {
          zone_id = "{{ region-id }}-b"
        }
      }

      resource "yandex_vpc_address" "external-address-b2" {
        name = "external-address-b2"

        external_ipv4_address {
          zone_id = "{{ region-id }}-b"
        }
      }
      ```

      Where:
      * `yandex_compute_instance_group`: Description of the instance group.
        * General information about the VM group:
          * `name`: VM group name.
          * `folder_id`: [Folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) ID.
          * `service_account_id`: [Service account](../../../iam/concepts/users/service-accounts.md) ID.
          * `deletion_protection`: Instance group protection against deletion, `true` or `false`. You cannot delete an instance group with this option enabled. The default value is `false`.
        * `instance_template`: [VM template](../../concepts/instance-groups/instance-template.md):
          * `name`: VM name containing the [tag](../../concepts/instance-groups/policies/allocation-policy.md#tags) template, e.g., `sample-vm-{instance.tag}`. After inserting tag values into this template, the VM names will look like this: `sample-vm-ru1-a1`, `sample-vm-ru1-b2`, etc.
          * `platform_id`: [Platform](../../concepts/vm-platforms.md).
          * `resources`: Number of vCPU cores and RAM available to the VM. The values must match the selected [platform](../../concepts/vm-platforms.md).
          * `boot_disk`: Boot [disk](../../concepts/disk.md) settings.
            * `mode`: Disk access mode, `READ_ONLY` or `READ_WRITE`.
            * `image_id`: ID of the selected image. You can get the image ID from the [list of public images](../images-with-pre-installed-software/get-list.md).
          * `network_interface`: [Network](../../../vpc/concepts/network.md#network) settings:
            * `subnet_ids`: List of IDs for the [subnets](../../../vpc/concepts/network.md#subnet) to host the VMs. You must specify one subnet in each availability zone where a group VM will be created.
            * `nat`: Specifies if a VM will have an assigned public IP address. The possible values are `true` and `false`.
            * `ip_address`: VM internal IP address. This is a template that will use the value from a variable specified for this VM in the `variables` section.
            * `nat_ip_address`: VM public IP address. This is a template that will use the value from a variable specified for this VM in the `variables` field.
          * `metadata`: In [metadata](../../concepts/vm-metadata.md), provide the VM user name and the public key to enable this user to access the VM via SSH.

            For more information, see [{#T}](../../concepts/vm-metadata.md).

        * `variables`: [Variables](../../concepts/instance-groups/variables-in-the-template.md) assigned to the instance group. This section contains a list of variables in `<name> = <value>` format to use in templates to provide IP addresses of the VMs you are creating to the instance group:
          * Variable name: Specify the name in `<prefix>_<tag>` format:

            * `<prefix>` defines the IP address type. For example, you can use the `ip` prefix for internal IP addresses and `external_ip` for public ones.

            * `<tag>` value must fully match the value of the relevant tag specified for this VM in the `allocation_policy` field, e.g., `ru1-a1`.

          * Variable value: This is either an internal or public IP address of the new VM.

              Internal IP addresses must belong to the IP address range allocated to the specified subnet in the respective availability zone.

              If you are not going to assign public IP addresses to the group instances, do not specify variables with the `external_ip` prefix.

          For more information about using variables in a VM template, see [{#T}](../../concepts/instance-groups/variables-in-the-template.md).

        * [Policies](../../concepts/instance-groups/policies/index.md):
          * `deploy_policy`: [Deployment policy](../../concepts/instance-groups/policies/deploy-policy.md) for instances in the group.
          * `scale_policy`: [Scaling policy](../../concepts/instance-groups/policies/scale-policy.md) for instances in the group.
          * `allocation_policy`: [Policy for allocating](../../concepts/instance-groups/policies/allocation-policy.md) VM instances across [availability zones](../../../overview/concepts/geo-scope.md) and regions:
            * `zones`: Array containing the IDs of availability zones in which the VMs of the group will be created.
            * `instance_tags_pool`: List of unique tags for binding IP addresses to the VMs of the group. You need to specify it separately for each availability zone which will host your group instances.

              The values of tags specified in the `tags` array are used to generate VM names and variables containing IP addresses of the VMs. The number of tags specified in the `tags` array for an availability zone should match the number of VMs created in it. Examples of possible tag values: `ru1-a1`, `ru1-b2`, etc.

      * `yandex_iam_service_account`: [Service account](../../../iam/concepts/users/service-accounts.md) description. All operations in {{ ig-name }} are performed on behalf of the service account.

        {% include [sa-dependence-brief](../../../_includes/instance-groups/sa-dependence-brief.md) %}

      * `yandex_resourcemanager_folder_iam_member`: Description of access permissions to the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) the service account belongs to. To be able to create, update, and delete VM instances in the instance group, assign the `editor` [role](../../../iam/concepts/access-control/roles.md) to the service account.
      * `yandex_vpc_network`: Description of the [cloud network](../../../vpc/concepts/network.md#network).
      * `yandex_vpc_subnet`: Description of the [subnets](../../../vpc/concepts/network.md#subnet) to connect the VMs of the group to.
      * `yandex_vpc_address`: Description of the reserved static [public IP address](../../../vpc/concepts/address.md#public-addresses).

        {% note info %}

        If you already have suitable resources, such as a service account, cloud network, subnets, and reserved static IP addresses, you do not need to describe them again. Use their names and IDs in the appropriate parameters.

        {% endnote %}

      For more information about the resources you can create with {{ TF }}, see the [provider documentation]({{ tf-provider-link }}).

  1. Create resources:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      All the resources you need will then be created in the specified folder. You can check the new resources and their settings using the [management console]({{ link-console-main }}).

- API {#api}

  Use the [create](../../instancegroup/api-ref/InstanceGroup/create.md) REST API method for the [InstanceGroup](../../instancegroup/api-ref/InstanceGroup/index.md) resource or the [InstanceGroupService/Create](../../instancegroup/api-ref/grpc/InstanceGroup/create.md) gRPC API call.

{% endlist %}