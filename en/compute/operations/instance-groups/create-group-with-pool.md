---
title: Creating an instance group attached to a reserved instance pool
description: In this article, you will learn how to create a {{ compute-full-name }} instance group attached to a reserved instance pool.
---

# Creating an instance group from a {{ compute-full-name }} reserved instance pool.


{% include [reserved-pools-pricing-warning](../../../_includes/compute/reserved-pools-pricing-warning.md) %}

{% include [reserved-pools-preview-notice](../../../_includes/compute/reserved-pools-preview-notice.md) %}

{% include [reserved-pools-intro](../../../_includes/compute/reserved-pools-intro.md) %}

You can use reserved pools for [instance groups](../../concepts/instance-groups/index.md). This guarantees the availability of resources for the instance group.

{% include [pool-restrictions](../../_includes_service/pool-restrictions.md) %}

Reserved instance pools are created in specific availability zones. To automate the distribution of multi-zone group instances across reserved instance pools of a specific availability zone, use the [instance template variables](../../concepts/instance-groups/variables-in-the-template.md).

For more information, see [{#T}](../../concepts/reserved-pools.md).

## Creating a group in a single availability zone with instances from a reserved instance pool in that zone {#single-zone}

1. [Create](../../../iam/operations/sa/create.md) a service account with the [compute.admin](../../security/index.md#compute-admin) role which the group will use to manage instances.
1. [Create](../../operations/reserved-pools/create-reserved-pool.md) a reserved instance pool with a configuration you want to use for the instance group.

    {% include [reserved-pools-configuration-for-groups](../../../_includes/compute/reserved-pools-configuration-for-groups.md) %}

1. Create an instance group:

    {% list tabs group=instructions %}

    - CLI {#cli}

      {% include [cli-install](../../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

      1. Create the `specification.yaml` file containing the instance group specification, for example:

          ```yaml
          name: first-fixed-group
          service_account_id: <service_account_ID>
          instance_template:
            platform_id: standard-v4a
            resources_spec:
              memory: 2g
              cores: 2
            boot_disk_spec:
              mode: READ_WRITE
              disk_spec:
                image_id: fd83esfomhq25p2ono90
                type_id: network-hdd
                size: 20g
            network_interface_specs:
              - network_id: <network_ID>
                primary_v4_address_spec: {}
                subnet_ids:
                  - <subnet_ID>
                security_group_ids:
                  - <security_group_ID>
            reserved_instance_pool_id: <reserved_instance_pool_ID>
          deploy_policy:
            max_unavailable: 1
            max_expansion: 0
          scale_policy:
            fixed_scale:
              size: 3
          allocation_policy:
            zones:
              - zone_id: {{ region-id }}-a
          ```

          Where:
          * `service_account_id`: [ID of the service account](../../../iam/operations/sa/get-id.md) you created earlier.
          * `network_id`: [Network ID](../../../vpc/operations/network-get-info.md).
          * `subnet_ids`: [Subnet ID](../../../vpc/operations/subnet-get-info.md).
          * `security_group_ids`: [Security group ID](../../../vpc/operations/security-group-get-info.md).
          * `reserved_instance_pool_id`: Reserved instance pool [ID](../../cli-ref/reserved-instance-pool/list.md) you created earlier.
          * `zone_id`: Availability zone.

          For more information about the instance group parameters, see [{#T}](../../concepts/instance-groups/specification.md).

      1. Apply the specification by running this command in the terminal:

          ```bash
          yc compute instance-group create \
            --file specification.yaml
          ```

          For more information about this command, see the [CLI reference](../../cli-ref/instance-group/create.md).

    - {{ TF }} {#tf}

      {% include [terraform-install](../../../_includes/terraform-install.md) %}

      1. In the configuration file, describe the instance group parameters:

          ```hcl
          resource "yandex_compute_instance_group" "first-fixed-group" {
            name                = "first-fixed-group"
            service_account_id  = "<service_account_ID>"

            instance_template {
              platform_id = "standard-v4a"
              resources {
                memory = 2
                cores  = 2
              }

              boot_disk {
                mode = "READ_WRITE"
                initialize_params {
                  image_id = "fd83esfomhq25p2ono90"
                }
              }

              network_interface {
                network_id         = "<network_ID>"
                subnet_ids         = ["<subnet_ID>"]
                security_group_ids = ["<security_group_ID>"]
              }

              reserved_instance_pool_id = "<reserved_instance_pool_ID>"
            }

            scale_policy {
              fixed_scale {
                size = 3
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
          ```

          Where:
          * `service_account_id`: [ID of the service account](../../../iam/operations/sa/get-id.md) you created earlier.
          * `network_id`: [Network ID](../../../vpc/operations/network-get-info.md).
          * `subnet_ids`: [Subnet ID](../../../vpc/operations/subnet-get-info.md).
          * `security_group_ids`: [Security group ID](../../../vpc/operations/security-group-get-info.md).
          * `reserved_instance_pool_id`: Reserved instance pool [ID](../../cli-ref/reserved-instance-pool/list.md) you created earlier.
          * `zones`: Availability zone.

          For more information about the instance group parameters, see [{#T}](../../concepts/instance-groups/specification.md).

      1. Create an instance group:

          {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      For more information about `yandex_compute_instance_group`, see [this {{ TF }} reference](../../../terraform/resources/compute_instance_group.md).

    - API {#api}

      Use the [create](../../instancegroup/api-ref/InstanceGroup/create.md) REST API method for the [InstanceGroup](../../instancegroup/api-ref/InstanceGroup/index.md) resource or the [InstanceGroupService/Create](../../instancegroup/api-ref/grpc/InstanceGroup/create.md) gRPC API call.

      To specify the reserved pool, use the `instanceTemplate.reservedInstancePoolId` (`instance_template.reserved_instance_pool_id`) parameter.

    {% endlist %}

## Creating a group in three availability zones with VMs from the reserve pools of each zone {#multi-zone}

1. [Create](../../../iam/operations/sa/create.md) a service account with the [compute.admin](../../security/index.md#compute-admin) role which the group will use to manage instances.
1. [Create](../../operations/reserved-pools/create-reserved-pool.md) reserved instance pools in three availability zones using a configuration you want to use for the instance group.

    {% include [reserved-pools-configuration-for-groups](../../../_includes/compute/reserved-pools-configuration-for-groups.md) %}

1. Create an instance group:

    {% list tabs group=instructions %}

    - CLI {#cli}

      {% include [cli-install](../../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../../_includes/default-catalogue.md) %}

      1. Create the `specification.yaml` file containing the instance group specification, for example:

          ```yaml
          name: first-fixed-group
          service_account_id: <service_account_ID>
          variables:
            - key: pool_{{ region-id }}-a
              value: <reserved_instance_pool_ID_in_zone_a>
            - key: pool_{{ region-id }}-b
              value: <reserved_instance_pool_ID_in_zone_b>
            - key: pool_{{ region-id }}-d
              value: <reserved_instance_pool_ID_in_zone_d>
          instance_template:
            platform_id: standard-v4a
            resources_spec:
              memory: 2g
              cores: 2
            boot_disk_spec:
              mode: READ_WRITE
              disk_spec:
                image_id: fd83esfomhq25p2ono90
                type_id: network-hdd
                size: 20g
            network_interface_specs:
              - network_id: <network_ID>
                primary_v4_address_spec: {}
                subnet_ids:
                  - <subnet_ID_in_zone_a>
                  - <subnet_ID_in_zone_b>
                  - <subnet_ID_in_zone_d>
                security_group_ids:
                  - <security_group_ID>
            reserved_instance_pool_id: "{pool_{instance.zone_id}}"
          deploy_policy:
            max_unavailable: 1
            max_expansion: 0
          scale_policy:
            fixed_scale:
              size: 3
          allocation_policy:
            zones:
              - zone_id: {{ region-id }}-a
              - zone_id: {{ region-id }}-b
              - zone_id: {{ region-id }}-d
          ```

          Where:
          * `service_account_id`: [ID of the service account](../../../iam/operations/sa/get-id.md) you created earlier.
          * `network_id`: [Network ID](../../../vpc/operations/network-get-info.md).
          * `subnet_ids`: [Subnet IDs](../../../vpc/operations/subnet-get-info.md).
          * `security_group_ids`: [Security group ID](../../../vpc/operations/security-group-get-info.md).
          * `variables`: User-defined variables with [IDs of reserved instance pools](../../cli-ref/reserved-instance-pool/list.md) in different availability zones.
          * `reserved_instance_pool_id`: Reserved instance pool IDs you will get as a result of substituting the `instance.zone_id` [system variable](../../concepts/instance-groups/variables-in-the-template.md#first-stage) (availability zone of a specific instance) and the [user-defined variables](../../concepts/instance-groups/variables-in-the-template.md#second-stage) specified in the `variables` parameter.
          * `zone_id`: Availability zone.

          For more information about the instance group parameters, see [{#T}](../../concepts/instance-groups/specification.md).

      1. Apply the specification by running this command in the terminal:

          ```bash
          yc compute instance-group create \
            --file specification.yaml
          ```

          For more information about this command, see the [CLI reference](../../cli-ref/instance-group/create.md).

    - {{ TF }} {#tf}

      {% include [terraform-install](../../../_includes/terraform-install.md) %}

      1. In the configuration file, describe the instance group parameters:

          ```hcl
          resource "yandex_compute_instance_group" "ig-1" {
            name                = "fixed-group"
            service_account_id  = "<service_account_ID>"

            # Variables for reserved instance pools
            variables = {
              pool_{{ region-id }}-a = "<reserved_instance_pool_ID_in_zone_a>"
              pool_{{ region-id }}-b = "<reserved_instance_pool_ID_in_zone_b>"
              pool_{{ region-id }}-d = "<reserved_instance_pool_ID_in_zone_d>"
            }

            instance_template {
              platform_id = "standard-v4a"
              resources {
                memory = 2
                cores  = 2
              }

              boot_disk {
                mode = "READ_WRITE"
                initialize_params {
                  image_id = "fd83esfomhq25p2ono90"
                }
              }

              network_interface {
                network_id         = "<network_ID>"
                subnet_ids         = ["<subnet_ID_in_zone_a>", "<subnet_ID_in_zone_b", "<subnet_ID_in_zone_d>"]
                security_group_ids = ["<security_group_ID>"]
              }

              # instance.zone_id: System variable with the zone ID
              reserved_instance_pool_id = "{pool_{instance.zone_id}}"
            }

            scale_policy {
              fixed_scale {
                size = 3
              }
            }

            allocation_policy {
              zones = ["{{ region-id }}-a", "{{ region-id }}-b", "{{ region-id }}-d"]
            }

            deploy_policy {
              max_unavailable = 1
              max_expansion   = 0
            }
          }
          ```

          Where:
          * `service_account_id`: [ID of the service account](../../../iam/operations/sa/get-id.md) you created earlier.
          * `network_id`: [Network ID](../../../vpc/operations/network-get-info.md).
          * `subnet_ids`: [Subnet IDs](../../../vpc/operations/subnet-get-info.md).
          * `security_group_ids`: [Security group ID](../../../vpc/operations/security-group-get-info.md).
          * `variables`: User-defined variables with [IDs of reserved instance pools](../../cli-ref/reserved-instance-pool/list.md) in different availability zones.
          * `reserved_instance_pool_id`: Reserved instance pool IDs you will get as a result of substituting the `instance.zone_id` [system variable](../../concepts/instance-groups/variables-in-the-template.md#first-stage) (availability zone of a specific instance) and the [user-defined variables](../../concepts/instance-groups/variables-in-the-template.md#second-stage) specified in the `variables` parameter.
          * `zones`: Availability zones.

          For more information about the instance group parameters, see [{#T}](../../concepts/instance-groups/specification.md).

      1. Create an instance group:

          {% include [terraform-validate-plan-apply](../../../_tutorials/_tutorials_includes/terraform-validate-plan-apply.md) %}

      For more information about `yandex_compute_instance_group`, see [this {{ TF }} reference](../../../terraform/resources/compute_instance_group.md).

    - API {#api}

      Use the [create](../../instancegroup/api-ref/InstanceGroup/create.md) REST API method for the [InstanceGroup](../../instancegroup/api-ref/InstanceGroup/index.md) resource or the [InstanceGroupService/Create](../../instancegroup/api-ref/grpc/InstanceGroup/create.md) gRPC API call.

      To specify the reserved pool, use the `instanceTemplate.reservedInstancePoolId` (`instance_template.reserved_instance_pool_id`) parameter.

      Variables are set in the `variables` parameter.

    {% endlist %}

### See also {#see-also}

* [{#T}](../../concepts/instance-groups/index.md)
* [{#T}](../../concepts/reserved-pools.md)
* [{#T}](../../concepts/instance-groups/variables-in-the-template.md)
