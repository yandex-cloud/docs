[Документация Yandex Cloud](../../index.md) > [Terraform в Yandex Cloud](../index.md) > Справочник Terraform > Ресурсы (англ.) > Cloud Desktop > Data Sources > cloud_desktops_desktop_group

# yandex_cloud_desktops_desktop_group (DataSource)

Manages a Cloud Desktops Desktop Group. For more information see [the official documentation](../../cloud-desktop/concepts/desktops-and-groups.md)

## Example usage

```terraform
data "yandex_cloud_desktops_desktop_group" "data_desktop_group_by_name_and_folder" {
	name 		= "desktop-group-name"
	folder_id 	= "<your folder id (optional)>"
}

data "yandex_cloud_desktops_desktop_group" "data_desktop_group_by_id" {
	desktop_group_id 	= "<your desktop group id>"
}
```

## Arguments & Attributes Reference

- `description` (*Read-Only*) (String). The description of the desktop group.
- `desktop_group_id` (String). The id of the desktop group.
- `desktop_template` [Block]. The configuration template for the desktop group.
  - `boot_disk` [Block]. The boot disk configuration for each desktop in the group.
    - `initialize_params` [Block]. General data disk configuration
      - `size` (*Read-Only*) (Number). The size of disk in gigabytes.
      - `type` (*Read-Only*) (String). The type of disk. Allowed values: TYPE_UNSPECIFIED, HDD or SDD
  - `data_disk` [Block]. The data disk configuration for each desktop in the group.
    - `initialize_params` [Block]. General data disk configuration
      - `size` (*Read-Only*) (Number). The size of disk in gigabytes.
      - `type` (*Read-Only*) (String). The type of disk. Allowed values: TYPE_UNSPECIFIED, HDD or SDD
  - `network_interface` [Block]. The base network interface configuration for each desktop in the group.
    - `network_id` (*Read-Only*) (String). The id of the network desktops from the group would use.
    - `subnet_ids` (*Read-Only*) (List Of String). The ids of the subnet networks desktops from the group would use.
  - `resources` [Block]. The base resource configuration for each desktop in the group.
    - `core_fraction` (*Read-Only*) (Number). The baseline level of CPU performance each desktop in this group would have.
    - `cores` (*Read-Only*) (Number). The number of cores each desktop in this group would have.
    - `memory` (*Read-Only*) (Number). The number of gigabytes of RAM each desktop in this group would have.
- `folder_id` (String). The folder the dekstop group is in.
- `group_config` [Block]. The group configuration.
  - `desktop_type` (*Read-Only*) (String). The type of the desktop group. Allowed: DESKTOP_TYPE_UNSPECIFIED, PERSISTENT, NON_PERSISTENT
  - `max_desktops_amount` (*Read-Only*) (Number). Maximum number of desktops.
  - `members` [Block]. List of members in this desktop group.
    - `id` (*Read-Only*) (String). The id of the member. More info in [the official documentation](../../cloud-desktop/api-ref/grpc/DesktopGroup/create.md#yandex.cloud.access.Subject).
    - `type` (*Read-Only*) (String). The type of the member. More info in [the official documentation](../../cloud-desktop/api-ref/grpc/DesktopGroup/create.md#yandex.cloud.access.Subject).
  - `min_ready_desktops` (*Read-Only*) (Number). Minimum number of ready desktops.
- `id` (*Read-Only*) (String). The resource identifier.
- `labels` (*Read-Only*) (Map Of String). A set of key/value label pairs which assigned to resource.
- `name` (String). The name of the desktop group.