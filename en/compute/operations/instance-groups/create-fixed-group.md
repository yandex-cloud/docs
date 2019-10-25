# Create a fixed-size instance group

You can create a group with a fixed number of instances. The group size is set manually. For more information, see [{#T}](../../concepts/instance-groups/scale.md#fixed-scale).

{% include [warning.md](../../../_includes/instance-groups/warning.md) %}

{% include [sa.md](../../../_includes/instance-groups/sa.md) %}

To create a fixed-size instance group:

{% list tabs %}

- Management console

  {% include [create-fixed-group-via-concole.md](../../../_includes/instance-groups/create-fixed-group-via-concole.md) %}

- CLI

  {% include [cli-install.md](../../../_includes/cli-install.md) %}

  {% include [default-catalogue.md](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI's create instance group command:

      ```
      $ yc compute instance-group create --help
      ```

  1. Check whether there are networks in the folder:

      ```
      $ yc vpc network list
      ```

      If there aren't any, [create the necessary networks](../../../vpc/operations/subnet-create.md) in {{ vpc-short-name }}.

  1. Select one of the [public images](../images-with-pre-installed-software/get-list.md) (for example, CentOS 7).

      {% include [standard-images.md](../../../_includes/standard-images.md) %}

  1. Create a YAML file with any name (for example, `specification.yaml`).

  1. In the created file, indicate the following:

      - General information about the group:

          ```
          name: first-fixed-group
          service_account_id: <ID>
          description: "This instance group was created from YAML config"
          ```

          Keys:

          | Key | Value |
          | ----- | ----- |
          | `name` | A name for the instance group. The name must be unique within the folder. The name may contain lowercase Latin letters, numbers, and hyphens. The first character must be a letter. The last character can't be a hyphen. The maximum length of the name is 63 characters. |
          | `service_account_id` | ID of the service account. |
          | `description` | A description of the instance group. |

      - [Instance template](../../concepts/instance-groups/instance-template.md):

          ```
          instance_template:
              platform_id: standard-v1
              resources_spec:
                  memory: 4g
                  cores: 1
              boot_disk_spec:
                  mode: READ_WRITE
                  disk_spec:
                      image_id: fdvk34al8k5nltb58shr
                      type_id: network-hdd
                      size: 32g
              network_interface_specs:
                  - network_id: c64mknqgnd8avp6edhbt
                    primary_v4_address_spec: {}
          ```

          {% include [default-unit-size](../../../_includes/instance-groups/default-unit-size.md) %}

          Keys (the table contains the keys that directly define the instance parameters):

          | Key | Value |
          | ----- | ----- |
          | `platform_id` | Platform ID. |
          | `memory` | Amount of memory (RAM). |
          | `cores` | Number of processor cores (vCPUs). |
          | `mode` | Disk access mode. </br> - `READ_ONLY`: read-only access. </br>- `READ_WRITE`: read/write access. |
          | `image_id` | CentOS 7 public image ID. |
          | `type_id` | Disk type. |
          | `size` | Disk size. |
          | `network_id` | The `default-net` ID. |
          | `primary_v4_address_spec` | IPv4 specification. Only IPv4 is currently available. You can allow public access to group instances by specifying the IP version for the public IP address. For more information, see [{#T}](../../concepts/instance-groups/instance-template.md#instance-template). |

      - [The policies](../../concepts/instance-groups/policies.md):

          ```
          deploy_policy:
              max_unavailable: 1
              max_expansion: 0
          scale_policy:
              fixed_scale:
                  size: 3
          allocation_policy:
              zones:
                  - zone_id: ru-central1-a
          ```

          Keys:

          | Key | Value |
          | ----- | ----- |
          | `deploy_policy` | Deployment policy for instances in the group. |
          | `scale_policy` | Scaling policy for instances in the group. |
          | `allocation_policy` | Policy for allocating instances across zones and regions. |

          Full code for the `specification.yaml` file:

          ```
          name: first-fixed-group
          service_account_id: ajed6ilf11qg839dcl1e
          description: "This instance group was created from YAML config"
          instance_template:
              platform_id: standard-v1
              resources_spec:
                  memory: 4g
                  cores: 1
              boot_disk_spec:
                  mode: READ_WRITE
                  disk_spec:
                      image_id: fdvk34al8k5nltb58shr
                      type_id: network-hdd
                      size: 32g
              network_interface_specs:
                  - network_id: c64mknqgnd8avp6edhbt
                    primary_v4_address_spec: {}
          deploy_policy:
              max_unavailable: 1
              max_expansion: 0
          scale_policy:
              fixed_scale:
                  size: 3
          allocation_policy:
              zones:
                  - zone_id: ru-central1-a
          ```

  1. Create an instance group in the default folder:

      ```
      $ yc compute instance-group create --file specification.yaml
      ```

      This command creates a group of three similar instances with the following characteristics:
      - Named `first-fixed-group`.
      - Running CentOS 7.
      - In the `default-net` network.
      - In the `ru-central1-a` availability zone.
      - With a single core and 4 GB RAM.
      - With a 32 GB network HDD.

- API

  Use the [create](../../api-ref/InstanceGroup/create.md) API method.

{% endlist %}

