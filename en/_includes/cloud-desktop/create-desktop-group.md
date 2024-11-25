{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder to create your desktop group in.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-desktop }}**.
  1. Click **{{ ui-key.yacloud.vdi.button_empty-create-desktop-group }}**.
  1. Enter a name and description of the desktop group.
  1. Select an OS [image](../../cloud-desktop/concepts/images.md).
  1. Under **{{ ui-key.yacloud.vdi.section_disks }}**:
      * Select the boot and working [disk](../../cloud-desktop/concepts/disks.md) [types](../../compute/concepts/disk.md#disks-types).
      * Specify the boot and working disk size.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**:
      * Specify the number of vCPU cores.
      * Choose [guaranteed vCPU share](../../compute/concepts/performance-levels.md).
      * Specify the amount of RAM.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**, select the [cloud network](../../vpc/concepts/network.md#network) and [subnets](../../vpc/concepts/network.md#subnet) to host desktops.
  1. Click **{{ ui-key.yacloud.common.create }}**.

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../cli-install.md) %}

  1. View the description of the [CLI](../../cli/index.yaml) command to create a [desktop group](../../cloud-desktop/concepts/desktops-and-groups.md):

      ```bash
      yc desktops group create --help
      ```

  1. Select a [folder](../../resource-manager/concepts/resources-hierarchy.md#folder):

      ```bash
      yc resource-manager folder list
      ```

      Result:

      ```text
      +----------------------+------------+--------+----------+
      |          ID          |    NAME    | LABELS |  STATUS  |
      +----------------------+------------+--------+----------+
      | b1g681qpemb4******** | my-folder  |        | ACTIVE   |
      | b1ggmp8es27t******** | new-folder |        | ACTIVE   |
      +----------------------+------------+--------+----------+
      ```

  1. Select an [image](../../cloud-desktop/concepts/images.md) to create a boot [disk](../../cloud-desktop/concepts/disks.md) for the desktop. You can look up the image ID in the [management console]({{ link-console-main }}).
  1. Select a [cloud network](../../vpc/concepts/network.md#network) and [subnets](../../vpc/concepts/network.md#subnet):

      ```bash
      yc vpc subnet list
      ```

      Result:

      ```text
      +----------------------+-------------+----------------------+----------------------+---------------+------------------+
      |          ID          |    NAME     |      NETWORK ID      |    ROUTE TABLE ID    |     ZONE      |      RANGE       |
      +----------------------+-------------+----------------------+----------------------+---------------+------------------+
      | e2lb1da2dd9v******** | my-subnet-b | enp0asmd9pr9******** |                      | {{ region-id }}-b | [10.129.0.0/24]  |
      | e9bhhpeo3vmk******** | my-subnet-a | enp0asmd9pr9******** |                      | {{ region-id }}-a | [10.128.0.0/24]  |
      | fl8rnqg0nb99******** | my-subnet-d | enp0asmd9pr9******** | enpajmdvphs7******** | {{ region-id }}-d | [10.131.0.0/24]  |
      +----------------------+-------------+----------------------+----------------------+---------------+------------------+
      ```

      Where:

      * `ID`: Subnet ID.
      * `NETWORK ID`: Cloud network ID.

  1. Create a desktop group:

      ```bash
      yc desktops group create \
        --folder-id <folder_ID> \
        --image-id <image_ID> \
        --name <group_name> \
        --resource-spec memory=4G,cores=2,core-fraction=100 \
        --network-interface-spec \
          network-id=<network_ID>,subnet-id=<subnet_1_ID>,...,network-id=<network_ID>,subnet-id=<subnet_n_ID>
      ```

      Where:

      * `--folder-id`: Folder ID.
      * `--image-id`: Disk image ID.
      * `--name`: Desktop groups name.
      * `--resource-spec`: Description of the desktop group computing resources:

          * `memory`: Amount of RAM.
          * `cores`: Number of vCPUs.
          * `core-fraction`: [Guaranteed vCPU share](../../compute/concepts/performance-levels.md).

      * `--network-interface-spec`: Description of the desktop group network interface:

          * `network-id`: Cloud network ID.
          * `subnet-id`: Subnet ID.

          You can specify one or more subnets from the same cloud network.

      Result:

      ```text
      id: e3v80f10pc01********
      folder_id: b1g681qpemb4********
      created_at: "2024-10-09T18:58:17.357Z"
      status: ACTIVE
      name: my-desktop-group
      resources_spec:
        memory: "4294967296"
        cores: "2"
        core_fraction: "100"
      network_interface_spec:
        network_id: enp0asmd9pr9********
        subnet_ids:
          - e2lb1da2dd9v********
      ```

- API {#api}

  Use the [create](../../cloud-desktop/api-ref/DesktopGroup/create.md) REST API method for the [DesktopGroup](../../cloud-desktop/api-ref/DesktopGroup/index.md) resource or the [DesktopGroupService/Create](../../cloud-desktop/api-ref/grpc/DesktopGroup/create.md) gRPC API call.

{% endlist %}
