# Create a fixed-size group with a load balancer

You can create a fixed-size group along with a network load balancer that will evenly distribute the load across cloud resources. For more information, see [#T](../../../load-balancer/concepts/index.md) in the Yandex Load Balancer documentation.

{% include [warning.md](../../../_includes/instance-groups/warning.md) %}

To create an instance group with a load balancer:

{% list tabs %}

- Management console
  
  1. In the management console, select the folder where you want to create an instance group.
  1. Select **Yandex Compute Cloud**.
  1. On the **Virtual machines** page, go to the **Instance groups** tab.
  1. Click **Create group**.
  1. In the **Basic parameters** section, enter:
      - A group name in the **Name** field. The group name must be unique within the cloud.
  
          {% include [name-format](../../../_includes/name-format.md) %}
  
      - A group description in the **Description** field.
  1. In the **Allocation** section, select availability zones. Cluster VMs may reside in different availability zones and regions. [Learn more about the Cloud geography](../../../overview/concepts/geo-scope.md).
  1. In the **Instance template** section, click **Add**:
      - Select the required public [image](../images-with-pre-installed-software/get-list.md).
      - In the **Disks** section:
          - Select the [disk type](../../concepts/disk.md#disks_types) (HDD or NVME).
  
          - Specify the disk size.
  
              To add more disks, click **Add disk**.
      - In the **Computing resources** section:
          - Select the platform.
          - Specify the necessary number of vCPUs and amount of RAM.
      - In the **Network settings** section:
          - Select the [cloud network](../../concepts/vm.md#network).
          - Specify if a public IP address is required.
      - In the **Access** section, specify data required for accessing the VM:
          - Enter the username in the **Login** field.
  
          - In the **SSH key** field, paste the contents of the public key file.
  
              You need to create a key pair for SSH connection yourself. To generate keys, use third-party tools, such as `ssh-keygen` utilities on Linux and macOS or [PuTTygen](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html) on Windows.
      - Click **Add**.
  1. In the **Deployment** section, specify:
      - Expansion of group size for scaling up.
  
      - Reduction of group size for scaling down.
  
      - Maximum number of instances when creating a group.
  
      - Maximum number of instances when deleting a group.
  
          For more information, see [#T](../../concepts/instance-groups/policies.md#deploy-policy).
  1. In the **Scalability** section:
      - Select the [scale type](../../concepts/instance-groups/scale.md).
      - Specify the required number of instances.
  1. In the **Integration with Load Balancer** section, switch the **Create target group** option to the right.
  1. Click **Create**.
  
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
  
      If there aren't any, [create the necessary networks](../../../vpc/operations/subnet-create.md) in the VPC service.
  
  1. Select one of the [public images](../images-with-pre-installed-software/get-list.md) (for example, CentOS 7).
  
      {% include [standard-images.md](../../../_includes/standard-images.md) %}
  
  1. Create a YAML file with any name (for example, `template.yaml`).
  
  1. In the created file, specify:
  
      - General information about the group:
  
          ```
          name: first-instance-group-with-balancer
          description: "This instance group was created from yaml config"
          ```
  
          Keys:
  
          | Key | Value |
          | ----- | ----- |
          | `name` | A name for the instance group. The name must be unique within the folder. The name may contain lowercase Latin letters, numbers, and hyphens. The first character must be a letter. The last character can't be a hyphen. The maximum length of the name is 63 characters. |
          | `description` | A description of the instance group. |
  
      - [The instance template](../../concepts/instance-groups/instance-template.md):
  
          ```
          instance_template:
              platform_id: standard-v1
              resources_spec:
                  memory: 4294967296
                  cores: 1
              boot_disk_spec:
                  mode: READ_WRITE
                  disk_spec:
                      image_id: fdvcl0b1no2hjb423igi
                      type_id: network-hdd
                      size: 34359738368
              network_interface_specs:
                  - network_id: c64mknqgnd8avp6edhbt
                      primary_v4_address_spec: {}
          ```
  
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
          | `primary_v4_address_spec` | IPv4 specification. Only IPv4 is currently available. You can allow public access to group instances by specifying the IP version for the public IP address. For more information, see [#T](../../concepts/instance-groups/instance-template.md#instance-template). |
  
      - [Policies](../../concepts/instance-groups/policies.md):
  
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
  
      - Target group Load Balancer:
  
          ```
          load_balancer_spec:
              target_group_spec:
                  name: first-target-group
          ```
  
          Keys:
  
          | Key | Value |
          | ----- | ----- |
          | `target_group_spec` | Specification of the Load Balancer target group associated with the instance group. |
          | `name` | A name for the Load Balancer target group. The name must be unique within the folder. The name may contain lowercase Latin letters, numbers, and hyphens. The first character must be a letter. The last character can't be a hyphen. The maximum length of the name is 63 characters. |
  
          Full code for the `template.yaml` file:
  
          ```
          name: first-instance-group-with-balancer
          description: "This instance group was created from yaml config"
          instance_template:
              platform_id: standard-v1
              resources_spec:
                  memory: 4294967296
                  cores: 1
              boot_disk_spec:
                  mode: READ_WRITE
                  disk_spec:
                      image_id: fdvcl0b1no2hjb423igi
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
      $ yc compute instance-group create --file template.yaml
      ```
  
      This command creates a group of three similar instances with the following characteristics:
      - Named `first-instance-group-with-balancer`.
      - Running on CentOS 7.
      - In the `default-net` network.
      - In the `ru-central1-a` availability zone.
      - With a single core and 4 GB RAM.
      - With a 32 GB network HDD.
      - With a target group named `first-target-group`.
  
  1. Create a [load balancer](../../../load-balancer/operations/load-balancer-create.md) and add the `first-target-group` target group to it .
  
- API
  
  Use the [create](../../../_api-ref/compute/api-ref/InstanceGroup/create.md) API method.
  
{% endlist %}

