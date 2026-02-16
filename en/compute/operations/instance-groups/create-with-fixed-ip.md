---
title: Creating a group of instances with fixed IP addresses
description: Follow this guide to create a group of instances with fixed IP addresses.
---

# Creating a group of instances with fixed IP addresses


You can use [tags](../../concepts/instance-groups/policies/allocation-policy.md#tags) and [variables](../../concepts/instance-groups/variables-in-the-template.md) to create a group of VM instances with predefined [internal](../../../vpc/concepts/address.md#internal-addresses) and [public](../../../vpc/concepts/address.md#public-addresses) IP addresses.

{% include [sa.md](../../../_includes/instance-groups/sa.md) %}

To be able to create, update, and delete VMs in the group, [assign](../../../iam/operations/sa/assign-role-for-sa.md) the [compute.editor](../../security/index.md#compute-editor) role to the service account.

To create a group of instances with fixed IP addresses:

{% list tabs group=instructions %}

- CLI {#cli}

  1. {% include [sa.md](../../../_includes/instance-groups/sa.md) %}
  1. Create a cloud [network](../../../vpc/operations/network-create.md) and [subnets](../../../vpc/operations/subnet-create.md), e.g., in two [availability zones](../../../overview/concepts/geo-scope.md), unless you already have them.
  1. To make VM instances in the group accessible from the internet, [reserve](../../../vpc/operations/get-static-ip.md) the required number of static public IP addresses. For the example below, four IP addresses are enough.
  1. {% include [cli-install.md](../../../_includes/cli-install.md) %}

      {% include [default-catalogue.md](../../../_includes/default-catalogue.md) %}

  1. See the description of the [CLI](../../../cli/) command for creating an instance group:

     ```bash
     {{ yc-compute-ig }} create --help
     ```

  1. Select one of the {{ marketplace-full-name }} public images, e.g., [Ubuntu 22.04 LTS](/marketplace/products/yc/ubuntu-22-04-lts).

     {% include [standard-images.md](../../../_includes/standard-images.md) %}

  1. Prepare a file with the [YAML specification](../../concepts/instance-groups/specification.md) of the instance group and give it a name, e.g., `specification.yaml`.

      To assign fixed IP addresses to the instances in the group, add the following to the specification:

      * In the `allocation_policy` field, a nested `zones` field with paired `zone_id` and `instance_tags_pool` parameters for each of the [availability zones](../../../overview/concepts/geo-scope.md) where you will create VM instances. For example, if the VM instances of the group will be located in the `{{ region-id }}-a` and `{{ region-id }}-b` availability zones, the `allocation_policy` field will look like this:

          ```yml
          allocation_policy:
            zones:
              - zone_id: {{ region-id }}-a
                instance_tags_pool:
                - <{{ region-id }}-a_zone_tag_1>
                - <{{ region-id }}-a_zone_tag_2>
              - zone_id: {{ region-id }}-b
                instance_tags_pool:
                - <{{ region-id }}-b_zone_tag_1>
                - <{{ region-id }}-b_zone_tag_2>
          ```

          Where:

          * `zone_id`: Availability zone ID.
          * `instance_tags_pool`: List of unique [tags](../../concepts/instance-groups/policies/allocation-policy.md#tags) for assigning IP addresses to the instances of the group. The tag value is used to generate instance names and variables with instance IP addresses. Make sure the number of tags for each availability zone matches the number of instances created in this zone. Examples of possible tag values: `ru1-a1`, `ru1-b2`, etc.
          
      * The `variables` field which lists variables used in templates to provide the IP addresses of the new instances to the instance group:

          ```yml
          variables:
            - key: ip_<{{ region-id }}-a_zone_tag_1>
              value: <internal_IP_address_1>
            - key: external_ip_<{{ region-id }}-a_zone_tag_1>
              value: <public_IP_address_1>
            ...
            - key: ip_<{{ region-id }}-b_zone_tag_2>
              value: <internal_IP_address_4>
            - key: external_ip_<{{ region-id }}-b_zone_tag_2>
              value: <public_IP_address_4>
          ```

          Where:

          * `key`: Variable name in `<prefix>_<tag>` format:
              * `<prefix>` indicates the IP address type. For example, you can use the `ip` prefix for internal addresses and `external_ip` for public ones.

              * `<tag>` value must fully match the value of the tag specified for this VM instance in the `allocation_policy` field, e.g., `ru1-a1`.

          * `value`: Variable value, an internal or public IP address of the new VM instance.

              Internal IP addresses must fall within the IP address range allocated to the specified subnet in the respective availability zone.

              If you are not going to assign public IP addresses to the group instances, do not specify variables with the `external_ip` prefix.

          For more information about using variables in an instance template, see [{#T}](../../concepts/instance-groups/variables-in-the-template.md).

      * In the `instance_template.name` field, the instance name with the tag template, e.g., `sample-vm-{instance.tag}`. After inserting tag values into this template, the instance names will look like this: `sample-vm-ru1-a1`, `sample-vm-ru1-b2`, etc.

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
          * `subnet_ids`: List of IDs for the [subnets](../../../vpc/concepts/network.md#subnet) to host the instances. You must specify one subnet in each availability zone where group instances will be created.
          * `primary_v4_address_spec.address`: Template for internal IP addresses. It will use the variable value specified for this VM instance in the `variables` field.
          * `primary_v4_address_spec.one_to_one_nat_spec.address`: Template for public IP addresses. It will use the variable value specified for this VM instance in the `variables` field.

          If you are not going to assign public IP addresses to the group instances, do not add the `primary_v4_address_spec.one_to_one_nat_spec` field to the specification.

      Here is a YAML specification example:

      ```yml
      service_account_id: <service_account_ID>
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

      This example shows a specification for [creating a group of fixed-size instances](./create-fixed-group.md) with fixed internal and public IP addresses.

      For more information about the instance group specification parameters, see [{#T}](../../concepts/instance-groups/specification.md).

  1. Create an instance group in the default folder:

      ```bash
      {{ yc-compute-ig }} create --file specification.yaml
      ```

      This command will create an instance group with the following configuration:
      * Name: `my-vm-group-with-fixed-ips`.
      * OS: `Ubuntu 22.04 LTS`.
      * VMs: Four, in the `{{ region-id }}-a` and `{{ region-id }}-b` availability zones, two per zone.
      * vCPUs: 2; RAM: 2 GB.
      * Network [HDD](../../concepts/disk.md#disks-types): 20 GB.
      * Fixed internal and public [IP addresses](../../../vpc/concepts/address.md) assigned to each VM instance in the group.

- {{ TF }} {#tf}

  {% include [terraform-install](../../../_includes/terraform-install.md) %}

  1. In the configuration file, define the parameters of the resources you want to create:

      ```hcl
      resource "yandex_compute_instance_group" "ig-1" {
        name                = "fixed-ig"
        folder_id           = "<folder_ID>"
        service_account_id  = "${yandex_iam_service_account.ig-sa.id}"
        deletion_protection = false
        depends_on          = [yandex_resourcemanager_folder_iam_member.compute_editor]
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
            user-data = "#cloud-config\n      datasource:\n       Ec2:\n        strict_id: false\n      ssh_pwauth: no\n      users:\n      - name: <instance_username>\n        sudo: ALL=(ALL) NOPASSWD:ALL\n        shell: /bin/bash\n        ssh_authorized_keys:\n        - <public_SSH_key>\n      runcmd: []"
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
        description = "Service account for managing the instance group."
      }

      resource "yandex_resourcemanager_folder_iam_member" "compute_editor" {
        folder_id  = "<folder_ID>"
        role       = "compute.editor"
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
      * `yandex_compute_instance_group`: Instance group description:
        * General information about the instance group:
          * `name`: Instance group name.
          * `folder_id`: [Folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) ID.
          * `service_account_id`: [Service account](../../../iam/concepts/users/service-accounts.md) ID.

            To be able to create, update, and delete VMs in the group, [assign](../../../iam/operations/sa/assign-role-for-sa.md) the [compute.editor](../../security/index.md#compute-editor) role to the service account.

          * `deletion_protection`: Instance group protection against deletion, `true` or `false`. You cannot delete an instance group with this option enabled. The default value is `false`.
        * `instance_template`: [Instance template](../../concepts/instance-groups/instance-template.md):
          * `name`: Instance name with the [tag](../../concepts/instance-groups/policies/allocation-policy.md#tags) template, e.g., `sample-vm-{instance.tag}`. After inserting tag values into this template, the instance names will look like this: `sample-vm-ru1-a1`, `sample-vm-ru1-b2`, etc.
          * `platform_id`: [Platform](../../concepts/vm-platforms.md).
          * `resources`: Number of vCPUs and amount of RAM available to the VM instance. The values must match the selected [platform](../../concepts/vm-platforms.md).
          * `boot_disk`: Boot [disk](../../concepts/disk.md) settings.
            * `mode`: Disk access mode, `READ_ONLY` or `READ_WRITE`.
            * `image_id`: ID of the selected image. You can get the image ID from the [list of public images](../images-with-pre-installed-software/get-list.md).
          * `network_interface`: [Network](../../../vpc/concepts/network.md#network) settings:
            * `subnet_ids`: List of IDs for the [subnets](../../../vpc/concepts/network.md#subnet) to host the instances. You must specify one subnet in each availability zone where group instances will be created.
            * `nat`: Specifies if an instance will have an assigned public IP address. The possible values are `true` and `false`.
            * `ip_address`: Instance internal IP address. This is a template that will use the value from a variable specified for this VM instance in the `variables` section.
            * `nat_ip_address`: Instance public IP address. This is a template that will use the value from a variable specified for this VM instance in the `variables` field.
          * `metadata`: In [metadata](../../concepts/vm-metadata.md), provide the instance username and public key to enable this user to access the instance via SSH.

            For more information, see [{#T}](../../concepts/vm-metadata.md).

        * `variables`: [Variables](../../concepts/instance-groups/variables-in-the-template.md) assigned to the instance group. This section contains a list of variables in `<name> = <value>` format to use in templates to provide IP addresses of the new instances to the instance group:
          * Variable name: Specify the name in `<prefix>_<tag>` format:

            * `<prefix>` indicates the IP address type. For example, you can use the `ip` prefix for internal IP addresses and `external_ip` for public ones.

            * `<tag>` value must fully match the value of the tag specified for this VM instance in the `allocation_policy` field, e.g., `ru1-a1`.

          * Variable value: This is either an internal or public IP address of the new instance.

              Internal IP addresses must fall within the IP address range allocated to the specified subnet in the respective availability zone.

              If you are not going to assign public IP addresses to the group instances, do not specify variables with the `external_ip` prefix.

          For more information about using variables in an instance template, see [{#T}](../../concepts/instance-groups/variables-in-the-template.md).

        * [Policies](../../concepts/instance-groups/policies/index.md):
          * `deploy_policy`: Instance [deployment policy](../../concepts/instance-groups/policies/deploy-policy.md) for the group.
          * `scale_policy`: Instance [scaling policy](../../concepts/instance-groups/policies/scale-policy.md) for the group.
          * `allocation_policy`: [Policy for allocating](../../concepts/instance-groups/policies/allocation-policy.md) VM instances across [availability zones](../../../overview/concepts/geo-scope.md) and regions:
            * `zones`: Array containing the IDs of availability zones in which the group instances will be created.
            * `instance_tags_pool`: List of unique tags required for assigning IP addresses to the group instances. You need to specify a list of tags separately for each availability zone which will host your group instances.

              The values of tags from the `tags` array are used to generate instance names and variables with instance IP addresses. Make sure the number of tags specified in the `tags` array for each availability zone matches the number of instances created in this zone. Examples of possible tag values: `ru1-a1`, `ru1-b2`, etc.

      * `yandex_iam_service_account`: [Service account](../../../iam/concepts/users/service-accounts.md) description. All operations in {{ ig-name }} are performed on behalf of the service account.

        {% include [sa-dependence-brief](../../../_includes/instance-groups/sa-dependence-brief.md) %}

      * `yandex_resourcemanager_folder_iam_member`: Description of access permissions for the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder) the service account belongs to. To be able to create, update, and delete VM instances in the instance group, assign the `compute.editor` [role](../../security/index.md#compute-editor) to the service account.
      * `yandex_vpc_network`: [Cloud network](../../../vpc/concepts/network.md#network) description.
      * `yandex_vpc_subnet`: Description of the [subnets](../../../vpc/concepts/network.md#subnet) to connect the group instances to.
      * `yandex_vpc_address`: Description of the reserved static [public IP address](../../../vpc/concepts/address.md#public-addresses).

        {% note info %}

        If you already have suitable resources, such as a service account, cloud network, subnets, and reserved static IP addresses, you do not need to redefine them. Specify their names and IDs in the appropriate parameters.

        {% endnote %}

      For more information about the resources you can create with {{ TF }}, see the [relevant provider documentation]({{ tf-provider-link }}).

  1. Create the resources:

      {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      All the resources you need will then be created in the specified folder. You can check the new resources and their settings using the [management console]({{ link-console-main }}).

- API {#api}

  Use the [create](../../instancegroup/api-ref/InstanceGroup/create.md) REST API method for the [InstanceGroup](../../instancegroup/api-ref/InstanceGroup/index.md) resource or the [InstanceGroupService/Create](../../instancegroup/api-ref/grpc/InstanceGroup/create.md) gRPC API call.

{% endlist %}