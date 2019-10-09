# Creating a fixed-size instance group with a network load balancer

You can create a group of fixed-size instances along with a network load balancer that will evenly distribute the load across cloud resources. For more information, see [{#T}](../../../load-balancer/concepts/index.md) in the {{ load-balancer-full-name }} documentation.

{% include [warning.md](../../../_includes/instance-groups/warning.md) %}

{% include [sa.md](../../../_includes/instance-groups/sa.md) %}

To create an instance group with a load balancer:

{% list tabs %}

- Management console

  1. In the management console, select the folder where you want to create an instance group.

  1. Select **{{ compute-full-name }}**.

  1. On the **Virtual machines** page, go to the **Instance groups** tab.

  1. Click **Create group**.

  1. In the **Basic parameters** section:

      - Enter the name and description of the group.

          {% include [name-format](../../../_includes/name-format.md) %}

      - Select a service account from the list or create a new one. Service accounts must have the `{{ roles-editor }}` role to create, update, and delete instances in a group.

  1. In the **Allocation** section, select the desired availability zones. Group instances may reside in different availability zones and regions. [Learn more about Yandex.Cloud geography](../../../overview/concepts/geo-scope.md).

  1. In the **Instance template** section, click **Set** to set the basic instance configuration:

      - Select a public [image](../images-with-pre-installed-software/get-list.md).

      - In the **Disks** section:

          - Select the [disk type](../../concepts/disk.md#disks_types).

          - Specify the disk size.

              To add more disks, click **Add disk**.

      - Under **Computing resources**:

          - Choose the [platform](../../concepts/vm-platforms.md).

          - Specify the [guaranteed share](../../concepts/performance-levels.md), the necessary number of vCPUs, and the amount of RAM.

      - Under **Network settings**:

          - Select the [cloud network](../../concepts/vm.md#network) and the subnet. If the necessary subnet is not in the list, [create it](../../../vpc/operations/subnet-create.md).

          - Specify if a public IP address is required.

      - In the **Access** section, specify the data required to access the VM:

          - Enter the username in the **Login** field.

          - Under **SSH key**, paste the contents of the public key file. [Create](../vm-connect/ssh.md#creating-ssh-keys) a key pair for connecting to an instance over SSH on your own.

      - Click **Add**.

  1. In the **During creation and update, it is allowed** section, specify:

      - The number of instances that can be additionally allocated in order to expand the group size.

      - The number of instances the group size can be reduced by.

      - The number of instances that can be created simultaneously.

      - The number of instances that can be deleted simultaneously.

          For more information, see [{#T}](../../concepts/instance-groups/policies.md#deploy-policy).

  1. In the **Scalability** section:

      - Select the [scaling type](../../concepts/instance-groups/scale.md). Currently, you can only create fixed-size groups.

      - Specify the group size.

  1. Under **Integration with {{ load-balancer-name }}**, toggle the switch to the right of the **Create target group** field.

  1. Enter a custom name and description of the target group.

  1. Click **Create**.

- CLI

  {% include [cli-install.md](../../../_includes/cli-install.md) %}

  {% include [default-catalogue.md](../../../_includes/default-catalogue.md) %}

  1. See the description of the CLI's create instance group command:

      ```
      $ {{ yc-compute-ig }} create --help
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
                  memory: 4294967296
                  cores: 1
              boot_disk_spec:
                  mode: READ_WRITE
                  disk_spec:
                      image_id: fdvk34al8k5nltb58shr
                      type_id: network-hdd
                      size: 34359738368
              network_interface_specs:
                  - network_id: c64mknqgnd8avp6edhbt
                    primary_v4_address_spec: {}
          ```

          {% include [default-unit-size](../../../_includes/instance-groups/default-unit-size.md) %}

          Keys (the table contains the keys that directly define the instance parameters):

          | Key | Value |
          | ----- | ----- |
          | `platform_id` | ID of the [platform](../../concepts/vm-platforms.md). |
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

      - {{ load-balancer-name }} target group:

          ```
          load_balancer_spec:
              target_group_spec:
                  name: first-target-group
          ```

          Keys:

          | Key | Value |
          | ----- | ----- |
          | `target_group_spec` | Specification of the {{ load-balancer-name }} target group associated with the instance group. |
          | `name` | A name for the {{ load-balancer-name }} target group. The name must be unique within the folder. The name may contain lowercase Latin letters, numbers, and hyphens. The first character must be a letter. The last character can't be a hyphen. The maximum length of the name is 63 characters. |

          Full code for the `specification.yaml` file:

          ```
          name: first-fixed-group-with-balancer
          service_account_id: <ID>
          description: "This instance group was created from YAML config"
          instance_template:
              platform_id: standard-v1
              resources_spec:
                  memory: 4294967296
                  cores: 1
              boot_disk_spec:
                  mode: READ_WRITE
                  disk_spec:
                      image_id: fdvk34al8k5nltb58shr
                      type_id: network-hdd
                      size: 34359738368
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
          load_balancer_spec:
              target_group_spec:
                  name: first-target-group
          ```

  1. Create an instance group in the default folder:

      ```
      $ {{ yc-compute-ig }} create --file specification.yaml
      ```

      This command creates a group of three similar instances with the following characteristics:
      - Named `first-fixed-group-with-balancer`.
      - Running CentOS 7.
      - In the `default-net` network.
      - In the `ru-central1-a` availability zone.
      - With a single core and 4 GB RAM.
      - With a 32 GB network HDD.
      - With a target group named `first-target-group`.

  1. Create a [load balancer](../../../load-balancer/operations/load-balancer-create.md) and add the `first-target-group` target group to it .

- API

  Use the [create](../../api-ref/InstanceGroup/create.md) API method.

{% endlist %}

