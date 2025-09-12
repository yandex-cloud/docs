{% list tabs group=instructions %}

- Management console {#console}

  1. In the [management console]({{ link-console-main }}), select the folder where you want to create your desktop group.
  1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_cloud-desktop }}**.
  1. Click **{{ ui-key.yacloud.vdi.button_empty-create-desktop-group }}**.
  1. Specify the desktop group name and description.
  1. Select **{{ ui-key.yacloud.vdi.section_type }}**:

      * **{{ ui-key.yacloud.vdi.value_type-personal }}**: Desktops are assigned to users on their first sign-in and remain reserved for them.
      * **{{ ui-key.yacloud.vdi.value_type-session }}**: Desktops are automatically assigned to users with each new login and released upon logout (feature coming soon).
  1. Under **{{ ui-key.yacloud.vdi.section_desktop }}**, specify:
     1. **{{ ui-key.yacloud.vdi.field_max-desktops-amount }}**: Maximum number of desktops per group.
     1. **{{ ui-key.yacloud.vdi.field_min-ready-desktops }}**: Number of desktops always kept ready for quick user access.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_platform }}**:
     * To select a standard configuration, navigate to the **{{ ui-key.yacloud.component.compute.resources.label_tab-standard }}** tab and click:
        * **Basic**: 2 vCPUs, 4 GB RAM. You can use it for tasks involving office apps, simple documents, and web browsing.
        * **Standard**: 4 vCPUs, 8 GB RAM. It is well-suited for most office work with support for multitasking and moderately resource-intensive apps.
        * **Advanced**: 8 vCPUs, 16 GB RAM. It is ideal for developers, designers, and users running resource-intensive apps, e.g., multimedia editors.
        * **Professional**: 8 vCPUs, 32 GB RAM. It works best for engineers using CAD tools and big data analysts. This configuration provides maximum computing power and memory for complex and high-load applications. 
     * To set a custom desktop configuration, navigate to the **{{ ui-key.yacloud.component.compute.resources.label_tab-custom }}** tab and specify the following:
       * Number of vCPUs.
       * [Guaranteed vCPU share](../../compute/concepts/performance-levels.md).
       * Amount of RAM.
  1. Select a preinstalled or custom OS [image](../../cloud-desktop/concepts/images.md).
  1. Under **{{ ui-key.yacloud.vdi.section_disks }}**:
      * Select the boot and data [disk](../../cloud-desktop/concepts/disks.md) [types](../../compute/concepts/disk.md#disks-types).
      * Specify the boot and data disk size.
  1. Under **{{ ui-key.yacloud.compute.instances.create.section_network }}**, select the [cloud network](../../vpc/concepts/network.md#network) and [subnets](../../vpc/concepts/network.md#subnet) where your desktops will reside.
   
      {% note info %}

      To enable internet access for your desktops, [set up a NAT gateway](../../vpc/operations/create-nat-gateway.md) in the relevant subnet.

      {% endnote %}
    
  1. Under **Desktop users**, click **Add users** and specify the following:
     * [User groups](../../iam/concepts/access-control/public-group.md).
     * [Individual users](../../iam/concepts/users/accounts.md).
     * Any user's email address. The user will get an invitation to your organization and a role for desktop access.

      You can update the user list at any time after creating the desktop group.

      {% note warning %}

      Users from the list will see the desktops of this group in their [showcase](../../cloud-desktop/concepts/showcase.md). To enable users to connect to desktops, [assign](../../iam/operations/roles/grant.md) them the `vdi.desktopGroups.user` or `vdi.desktopGroups.maintainer` role.

      {% endnote %}
  
  1. Click **{{ ui-key.yacloud.common.create }}**.

- {{ yandex-cloud }} CLI {#cli}

  {% include [cli-install](../cli-install.md) %}

  1. See the description of the [CLI](../../cli/index.yaml) command for creating a [desktop group](../../cloud-desktop/concepts/desktops-and-groups.md):

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

  1. Select the desktop boot [disk](../../cloud-desktop/concepts/disks.md) [image](../../cloud-desktop/concepts/images.md). You can find the image ID in the [management console]({{ link-console-main }}).
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
      * `--name`: Desktop group name.
      * `--resource-spec`: Desktop group resource description:

          * `memory`: Amount of RAM.
          * `cores`: Number of vCPUs.
          * `core-fraction`: [Guaranteed vCPU share](../../compute/concepts/performance-levels.md).

      * `--network-interface-spec`: Desktop group network interface description:

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
