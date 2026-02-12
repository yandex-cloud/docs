---
subcategory: Cloud Desktop
sourcePath: en/terraform/tf-ref/yandex-cloud/data-sources/cloud_desktops_desktop_group.md
---

# yandex_cloud_desktops_desktop_group (DataSource)

Manages a Cloud Desktops Desktop Group. For more information see [the official documentation](https://yandex.cloud/ru/docs/cloud-desktop/concepts/desktops-and-groups)

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

- `description` (String). The description of the desktop group.
- `desktop_group_id` (*Read-Only*) (String). The id of the desktop group.
- `desktop_template` [Block]. The configuration template for the desktop group.
  - `boot_disk` [Block]. The boot disk configuration for each desktop in the group.
    - `initialize_params` [Block]. General data disk configuration
      - `size` (Number). The size of disk in gigabytes.
      - `type` (**Required**)(String). The type of disk. Allowed values: TYPE_UNSPECIFIED, HDD or SDD
  - `data_disk` [Block]. The data disk configuration for each desktop in the group.
    - `initialize_params` [Block]. General data disk configuration
      - `size` (Number). The size of disk in gigabytes.
      - `type` (**Required**)(String). The type of disk. Allowed values: TYPE_UNSPECIFIED, HDD or SDD
  - `network_interface` [Block]. The base network interface configuration for each desktop in the group.
    - `network_id` (**Required**)(String). The id of the network desktops from the group would use.
    - `subnet_ids` (List Of String). The ids of the subnet networks desktops from the group would use.
  - `resources` [Block]. The base resource configuration for each desktop in the group.
    - `core_fraction` (Number). The baseline level of CPU performance each desktop in this group would have.
    - `cores` (Number). The number of cores each desktop in this group would have.
    - `memory` (Number). The number of gigabytes of RAM each desktop in this group would have.
- `folder_id` (String). The folder the dekstop group is in.
- `group_config` [Block]. The group configuration.
  - `desktop_type` (String). The type of the desktop group. Allowed: DESKTOP_TYPE_UNSPECIFIED, PERSISTENT, NON_PERSISTENT
  - `max_desktops_amount` (Number). Maximum number of desktops.
  - `members` [Block]. List of members in this desktop group.
    - `id` (**Required**)(String). The id of the member. More info in [the official documentation](https://yandex.cloud/ru/docs/cloud-desktop/api-ref/grpc/DesktopGroup/create#yandex.cloud.access.Subject).
    - `type` (**Required**)(String). The type of the member. More info in [the official documentation](https://yandex.cloud/ru/docs/cloud-desktop/api-ref/grpc/DesktopGroup/create#yandex.cloud.access.Subject).
  - `min_ready_desktops` (Number). Minimum number of ready desktops.
- `id` (*Read-Only*) (String). The resource identifier.
- `labels` (Map Of String). A set of key/value label pairs which assigned to resource.
- `name` (**Required**)(String). The name of the desktop group.


