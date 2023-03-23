To run multiple instances of the service in Docker containers, you can create an instance group from a [{{ coi }}](../../cos/concepts/index.md). In such groups, you can update Docker containers with VM metadata using the [COI or Docker Compose specification](../../cos/concepts/coi-specifications.md).

{% include [warning.md](warning.md) %}

{% include [sa.md](sa.md) %}

To create an instance group based on a {{ coi }}:

1. {% include [cli-install.md](../cli-install.md) %}

1. {% include [default-catalogue.md](../default-catalogue.md) %}

1. View a description of the CLI command to create an instance group:

   {% list tabs %}

   - CLI

     ```bash
     {{ yc-compute-ig }} create --help
     ```

   {% endlist %}

1. Check whether there are networks in the folder:

   {% list tabs %}

   - CLI

     ```bash
     yc vpc network list
     ```

   {% endlist %}

   If there aren't any, [create one](../../vpc/operations/network-create.md).

1. Create a YAML file with a name like `specification.yaml`.

1. {% include [get-latest-coi](../container-registry/get-latest-coi.md) %}

1. In the `specification.yaml` file you created, specify the following:

   * General information about the group:

     ```yaml
     name: container-optimized-group
     service_account_id: aje3932acd8avp6edhbt
     description: "This instance group was created from YAML config."
     ```

     Where:

     * `name`: An arbitrary name of the instance group. The name must be unique within the folder. The name may contain lowercase Latin letters, numbers, and hyphens. The first character must be a letter. The last character can't be a hyphen. The maximum length of the name is 63 characters.
     * `service_account_id`: Service account ID.
     * `description`: A description of the instance group.

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
           image_id: <ID of latest COI version>
           type_id: network-hdd
           size: 32G
       network_interface_specs:
         - network_id: c64mknqgnd8avp6edhbt
           primary_v4_address_spec: {}
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
     * `memory`: Amount of RAM.
     * `cores`: Number of processor cores (vCPUs).
     * `mode`: Disk access mode:
        * `READ_ONLY`: Read-only access.
        * `READ_WRITE`: Read/write access.
     * `image_id`: ID of the public {{ coi }}.
     * `type_id`: Disk type.
     * `size`: Disk size.
     * `network_id`: ID of `default-net`.
     * `primary_v4_address_spec`: IPv4 specification. Only IPv4 is currently available. You can [allow public access to group instances](../../compute/concepts/instance-groups/instance-template.md#instance-template) by specifying the IP version for the public IP address.
     * `metadata`: Values to pass to the VM metadata.
     * `docker-container-declaration`: Key in the VM metadata that is used with the [COI specification of the Docker container](../../cos/concepts/coi-specifications.md). In the metadata, you can use the [Docker Compose specification](../../cos/concepts/coi-specifications.md#compose-spec). To do this, specify the `docker-compose` key instead of the `docker-container-declaration` key.

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
     ```

     Where:

     * `deploy_policy`: Deployment policy for instances in the group.
     * `scale_policy`: Scaling policy for instances in the group.
     * `allocation_policy`: Allocation policy of the instances by zone and region.

     Full code for the `specification.yaml` file:

     ```yaml
     name: container-optimized-group
     service_account_id: aje3932acd8avp6edhbt
     description: "This instance group was created from YAML config."
     instance_template:
       service_account_id: aje3932acd8avp6edhbt # ID of the service account to access private Docker images.
       platform_id: standard-v3
       resources_spec:
         memory: 2G
         cores: 2
       boot_disk_spec:
         mode: READ_WRITE
         disk_spec:
           image_id: <ID of latest COI version>
           type_id: network-hdd
           size: 32G
       network_interface_specs:
         - network_id: c64mknqgnd8avp6edhbt
           primary_v4_address_spec: {}
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
     ```

     {% note info %}

     To use the [Docker Compose specification](../../cos/concepts/coi-specifications.md#compose-spec) in `specification.yaml`, specify the `docker-compose` key instead of the `docker-container-declaration` key.

     {% endnote %}

1. Create an instance group in the default folder:

   {% list tabs %}

   - CLI

     ```bash
     {{ yc-compute-ig }} create --file specification.yaml
     ```

     This command creates a group of three similar instances with the following characteristics:
     * Named `container-optimized-group`.
     * From the latest version of the public {{ coi }}.
     * With a running Docker container based on `{{ registry }}/mirror/nginx:1.17.4-alpine`.
     * In the `default-net` network.
     * In the `{{ region-id }}-a` availability zone.
     * With 2 vCPUs and 2 GB of RAM.
     * With a 32 GB network HDD.

   {% endlist %}