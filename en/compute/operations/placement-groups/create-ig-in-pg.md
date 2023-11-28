# Creating an instance group in a placement group

You can create an [instance group](../../concepts/instance-groups/index.md) in a placement group.

{% list tabs %}

- CLI

   {% include [cli-install.md](../../../_includes/cli-install.md) %}

   {% include [default-catalogue.md](../../../_includes/default-catalogue.md) %}

   1. View a description of the CLI command to create a placement group:

      ```bash
      yc compute placement-group create --help
      ```

   1. Create a placement group:

      ```bash
      yc compute placement-group create --spread-strategy --name my-group
      ```

      Result:

      ```bash
      id: fdvte50kv3nc********
      folder_id: aoeieef3k7pp********
      created_at: "2019-12-20T08:59:44Z"
      name: my-group
      spread_placement_strategy: {}
      ```

      This command creates a placement group with the following characteristics:

      * Name: `my-group`
      * Placement strategy: `spread`

   1. View a description of the CLI command to create an instance group:

      ```bash
      {{ yc-compute-ig }} create --help
      ```

   1. Check whether there are [networks](../../../vpc/concepts/network.md#network) in the [folder](../../../resource-manager/concepts/resources-hierarchy.md#folder):

      ```bash
      yc vpc network list
      ```

      If there are not any, [create one](../../../vpc/operations/network-create.md).

   1. Select one of the {{ marketplace-full-name }} public images, e.g., [CentOS 7](/marketplace/products/yc/centos-7).

      {% include [standard-images.md](../../../_includes/standard-images.md) %}

   1. Create a YAML file with any name, e.g., `specification.yaml`.

   1. In the created file, indicate the following:

      * General information about the instance group:

         ```yaml
         name: first-fixed-group
         service_account_id: <service_account_ID>
         description: "This instance group was created from YAML config."
         ```

         Where:

         * `name`: Name of the instance group. The name must be unique within the folder. The name may contain lowercase Latin letters, numbers, and hyphens. The first character must be a letter. The last character cannot be a hyphen. The name may be up to 63 characters long.
         * `service_account_id`: Service account ID.

            {% include [sa-dependence-brief](../../../_includes/instance-groups/sa-dependence-brief.md) %}

         * `description`: Description of the instance group.

      * [Instance template](../../concepts/instance-groups/instance-template.md), such as:

         ```yaml
         instance_template:
           platform_id: standard-v3
           resources_spec:
             memory: 2g
             cores: 2
           boot_disk_spec:
             mode: READ_WRITE
             disk_spec:
               image_id: fdvk34al8k5n********
               type_id: network-hdd
               size: 32g
           network_interface_specs:
             - network_id: c64mknqgnd8a********
               primary_v4_address_spec: {}
           scheduling_policy:
             preemptible: false
           placement_policy:
             placement_group_id: fdvte50kv3nc********
         ```

         {% include [default-unit-size](../../../_includes/instance-groups/default-unit-size.md) %}

         Where:

         * `platform_id`: [Platform](../../concepts/vm-platforms.md) ID.
         * `memory`: Amount of RAM.
         * `cores`: Number of processor cores (vCPUs).
         * `mode`: [Disk](../../concepts/disk.md) access mode.
            * `READ_ONLY`: Read-only access.
            * `READ_WRITE`: Read/write access.
         * `image_id`: ID of the public image. You can view image IDs in the [management console]({{ link-console-main }}) when creating a VM or in [{{ marketplace-name }}](/marketplace) on the image page under **Product IDs**.
         * `type_id`: Disk type.
         * `size`: Disk size.
         * `network_id`: ID of the `default-net` network.
         * `primary_v4_address_spec`: IPv4 specification. You can allow public access to the group's instances by specifying the IP version for the [public IP address](../../../vpc/concepts/address.md#public-addresses). For more information, see [{#T}](../../concepts/instance-groups/instance-template.md#instance-template).
         * `scheduling_policy`: Scheduling policy configuration.
         * `preemptible`: Flag indicating whether [preemptible VMs](../../concepts/preemptible-vm.md) are created.
            * `true`: Create a preemptible VM.
            * `false` (default): Create a regular VM.

            When creating a preemptible instance group, keep in mind that the VM instances will terminate after 24 hours of continuous operation or earlier. {{ ig-name }} may not be able to restart them immediately due to insufficient resources. This may occur in the event of a sharp increase in the use of {{ yandex-cloud }} computing resources.

         * `placement_policy`: [VM placement group](../../concepts/placement-groups.md) parameters:
            * `placement_group_id`: Placement group ID.
      * [Policies](../../concepts/instance-groups/policies/index.md):

         ```yaml
         deploy_policy:
           max_unavailable: 1
           max_expansion: 0
         scale_policy:
           fixed_scale:
             size: 3
         allocation_policy:
           zones:
             - zone_id: {{ region-id }}-a
               instance_tags_pool:
               - first
               - second
               - third
         ```

         Where:

         * `deploy_policy`: [Deployment policy](../../concepts/instance-groups/policies/deploy-policy.md) for instances in the group.
         * `scale_policy`: [Scaling policy](../../concepts/instance-groups/policies/scale-policy.md) for instances in the group.
         * `allocation_policy`: [Policy for allocating](../../concepts/instance-groups/policies/allocation-policy.md) VM instances by [availability zone](../../../overview/concepts/geo-scope.md) and region.

      Full code for the `specification.yaml` file:

      ```yaml
      name: first-fixed-group
      service_account_id: ajed6ilf11qg********
      description: "This instance group was created from YAML config."
      instance_template:
        platform_id: standard-v3
        resources_spec:
          memory: 2g
          cores: 2
        boot_disk_spec:
          mode: READ_WRITE
          disk_spec:
            image_id: fdvk34al8k5n********
            type_id: network-hdd
            size: 32g
        network_interface_specs:
          - network_id: c64mknqgnd8a********
            primary_v4_address_spec: {}
         scheduling_policy:
           preemptible: false
         placement_policy:
           placement_group_id: fdvte50kv3nc********
      deploy_policy:
        max_unavailable: 1
        max_expansion: 0
      scale_policy:
        fixed_scale:
          size: 3
      allocation_policy:
        zones:
          - zone_id: {{ region-id }}-a
            instance_tags_pool:
            - first
            - second
            - third
      ```

   1. Create an instance group in the default folder:

      ```bash
      {{ yc-compute-ig }} create --file specification.yaml
      ```

      This command creates a group of three similar instances with the following configuration:
      * Name: `first-fixed-group`.
      * OS: CentOS 7.
      * Network: `default-net`.
      * Placement group: `my-group`.
      * Availability zone: `{{ region-id }}-a`.
      * vCPUs: 2; RAM: 2 GB.
      * Network HDD: 32 GB.

- API

   Use the [create](../../api-ref/InstanceGroup/create.md) REST API method for the [InstanceGroup](../../api-ref/InstanceGroup/index.md) resource or the [InstanceGroupService/Create](../../api-ref/grpc/instance_group_service.md#Create) gRPC API call.

{% endlist %}
