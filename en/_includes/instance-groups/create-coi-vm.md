To run multiple instances of the service in Docker containers, you can create an instance group from a [{{ coi }}](../../cos/concepts/index.md). In such groups, you can update Docker containers with VM metadata using the [COI or Docker Compose specification](../../cos/concepts/coi-specifications.md).

{% include [warning.md](warning.md) %}

{% include [sa.md](sa.md) %}

To be able to create, update, and delete VMs in the group, [assign](../../iam/operations/sa/assign-role-for-sa.md) the [compute.editor](../../compute/security/index.md#compute-editor) role to the service account.

To create an instance group based on a {{ coi }}:

1. {% include [cli-install.md](../cli-install.md) %}

1. {% include [default-catalogue.md](../default-catalogue.md) %}

1. View a description of the CLI command to create an instance group:

   {% list tabs group=instructions %}

   - CLI {#cli}

     ```bash
     {{ yc-compute-ig }} create --help
     ```

   {% endlist %}

1. Check whether the folder contains any networks:

   {% list tabs group=instructions %}

   - CLI {#cli}

     ```bash
     yc vpc network list
     ```

   {% endlist %}

   If there are not any, [create one](../../vpc/operations/network-create.md).

1. Create a YAML file and give it a name, e.g., `specification.yaml`.

1. {% include [get-latest-coi](../container-registry/get-latest-coi.md) %}

1. In the `specification.yaml` file you created, specify the following:

   * General information about the group:

     ```yaml
     name: container-optimized-group
     service_account_id: <service_account_ID>
     description: "This instance group was created from YAML config."
     ```

     Where:

     * `name`: Instance group name. The name must be unique within the folder. It may contain lowercase Latin letters, numbers, and hyphens. The first character must be a letter. The last character cannot be a hyphen. The name may be up to 63 characters long.
     * `service_account_id`: Service account ID.

        To be able to create, update, and delete VMs in the group, [assign](../../iam/operations/sa/assign-role-for-sa.md) the [compute.editor](../../compute/security/index.md#compute-editor) role to the service account.

       {% include [sa-dependence-brief](../../_includes/instance-groups/sa-dependence-brief.md) %}

     * `description`: Instance group description.

   * [Instance template](../../compute/concepts/instance-groups/instance-template.md):

     ```yaml
     instance_template:
       platform_id: standard-v3
       resources_spec:
         memory: 2G
         cores: 2
       boot_disk_spec:
         mode: READ_WRITE
         disk_spec:
           image_id: <latest_COI_version_ID>
           type_id: network-hdd
           size: 32G
       network_interface_specs:
         - network_id: c64mknqgnd8a********
           primary_v4_address_spec: {}
           security_group_ids:
             - enps0ar5s3ti********
       placement_policy:
        placement_group_id: rmppvhrgm77g********
       metadata:
         docker-container-declaration: |-
           spec:
             containers:
               - name: nginx
                 image: {{ registry }}/mirror/nginx:1.17.4-alpine
                 securityContext:
                   privileged: false
                 tty: false
                 stdin: false
     ```

     {% include [default-unit-size](default-unit-size.md) %}

     Where:

     * `platform_id`: Platform ID.
     * `memory`: Amount of memory (RAM).
     * `cores`: Number of processor cores (vCPUs).
     * `mode`: Disk access mode:
         * `READ_ONLY`: Read-only access.
         * `READ_WRITE`: Read/write access.
     * `image_id`: {{ coi }} public image ID.
     * `type_id`: Disk type.
     * `size`: Disk size. It must be at least 30 GB.
     * `network_id`: `default-net` network ID.
     * `primary_v4_address_spec`: IPv4 specification. Only IPv4 is currently available. You can [allow public access to the group instances](../../compute/concepts/instance-groups/instance-template.md#instance-template) by specifying the IP version for the public IP address.
     * `security_group_ids`: List of [security group](../../vpc/concepts/security-groups.md) IDs.
     * `metadata`: Values to write to the VM metadata.
     * `docker-container-declaration`: Key in the VM metadata that is used with the [COI specification of the Docker container](../../cos/concepts/coi-specifications.md). In the metadata, you can use the [Docker Compose specification](../../cos/concepts/coi-specifications.md#compose-spec). To do this, specify the `docker-compose` key instead of the `docker-container-declaration` key.
     * `placement_policy`: (Optional) [Instance placement group](../../compute/concepts/placement-groups.md) parameters:
       * `placement_group_id`: Placement group ID.
   * [Policies](../../compute/concepts/instance-groups/policies/index.md):

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

     * `deploy_policy`: Instance deployment policy for the group.
     * `scale_policy`: Instance scaling policy for the group.
     * `allocation_policy`: Policy for allocating VM instances across [availability zones](../../overview/concepts/geo-scope.md).

     Full code for the `specification.yaml` file:

     ```yaml
     name: container-optimized-group
     service_account_id: <service_account_ID>
     description: "This instance group was created from YAML config."
     instance_template:
       service_account_id: <service_account_ID> # ID of the service account to access private Docker images.
       platform_id: standard-v3
       resources_spec:
         memory: 2G
         cores: 2
       boot_disk_spec:
         mode: READ_WRITE
         disk_spec:
           image_id: <latest_COI_version_ID>
           type_id: network-hdd
           size: 32G
       network_interface_specs:
         - network_id: c64mknqgnd8a********
           primary_v4_address_spec: {}
           security_group_ids:
             - enps0ar5s3ti********
       placement_policy:
         placement_group_id: rmppvhrgm77g********
       metadata:
         docker-container-declaration: |-
           spec:
             containers:
               - name: nginx
                 image: {{ registry }}/mirror/nginx:1.17.4-alpine
                 securityContext:
                   privileged: false
                 tty: false
                 stdin: false
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

     {% note info %}

     To use the [Docker Compose specification](../../cos/concepts/coi-specifications.md#compose-spec) in `specification.yaml`, specify the `docker-compose` key instead of the `docker-container-declaration` key.

     {% endnote %}

1. Create an instance group in the default folder:

   {% list tabs group=instructions %}

   - CLI {#cli}

     ```bash
     {{ yc-compute-ig }} create --file specification.yaml
     ```

     This command creates a group of three similar instances with the following characteristics:
     * Name: `container-optimized-group`.
     * Based on the latest version of the public {{ coi }}.
     * With a running Docker container based on `{{ registry }}/mirror/nginx:1.17.4-alpine`.
     * Network: `default-net`.
     * Availability zone: `{{ region-id }}-a`.
     * vCPUs: 2; RAM: 2 GB.
     * Network HDD: 32 GB.

   {% endlist %}