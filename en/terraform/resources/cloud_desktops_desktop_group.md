---
subcategory: Cloud Desktop
sourcePath: en/terraform/tf-ref/yandex-cloud/resources/cloud_desktops_desktop_group.md
---

# yandex_cloud_desktops_desktop_group (Resource)

Manages a Cloud Desktops Desktop Group. For more information see [the official documentation](https://yandex.cloud/ru/docs/cloud-desktop/concepts/desktops-and-groups)

## Example usage

```terraform
// network to function
resource "yandex_vpc_network" "network" {}

resource "yandex_vpc_subnet" "subnet" {
	zone 			= "ru-central1-a"
	network_id 		= yandex_vpc_network.network.id
	v4_cidr_blocks 	= ["10.1.0.0/24"]
}

data "yandex_cloud_desktops_image" "desktop_image_by_folder_and_name" {
	name 	  = "Ubuntu 20.04 LTS (2024-12-03)"
}

// desktop group
resource "yandex_cloud_desktops_desktop_group" "desktop_group" {
	name 		= "desktop-group-name"
	folder_id 	= "<your folder id (optional)>"
	image_id 	= data.yandex_cloud_desktops_image.image.id
	description = "Sample description"
	
	desktop_template = {
		resources = {
			cores 			= 4
			memory 			= 8
			core_fraction 	= 100
		}
		boot_disk = {
			initialize_params = {
				size = 24
				type = "SSD"
			}
		}
		data_disk = {
			initialize_params = {
				size = 16
				type = "HDD"
			}
		}
		network_interface = {
			network_id = yandex_vpc_network.network.id
			subnet_ids = ["${yandex_vpc_subnet.subnet.id}"]
		}
	}
	group_config = {
		min_ready_desktops 	= 1
		max_desktops_amount = 5
		desktop_type 		= "PERSISTENT"
		members				= [
			{
				id 		= "<your id>"
				type 	= "userAccount"
			}
		]
	}
		
	labels = {
    	label1 = "label1-value"
    	label2 = "label2-value"
  	}
}
```

## Arguments & Attributes Reference

- `description` (String). The description of the desktop group.
- `desktop_group_id` (*Read-Only*) (String). The id of the desktop group.
- `desktop_template` [FW-Block]. The configuration template for the desktop group.
  - `boot_disk` [FW-Block]. The boot disk configuration for each desktop in the group.
    - `initialize_params` [FW-Block]. General data disk configuration
      - `size` (Number). The size of disk in gigabytes.
      - `type` (**Required**)(String). The type of disk. Allowed values: TYPE_UNSPECIFIED, HDD or SDD
  - `data_disk` [FW-Block]. The data disk configuration for each desktop in the group.
    - `initialize_params` [FW-Block]. General data disk configuration
      - `size` (Number). The size of disk in gigabytes.
      - `type` (**Required**)(String). The type of disk. Allowed values: TYPE_UNSPECIFIED, HDD or SDD
  - `network_interface` [FW-Block]. The base network interface configuration for each desktop in the group.
    - `network_id` (**Required**)(String). The id of the network desktops from the group would use.
    - `subnet_ids` (List Of String). The ids of the subnet networks desktops from the group would use.
  - `resources` [FW-Block]. The base resource configuration for each desktop in the group.
    - `core_fraction` (Number). The baseline level of CPU performance each desktop in this group would have.
    - `cores` (Number). The number of cores each desktop in this group would have.
    - `memory` (Number). The number of gigabytes of RAM each desktop in this group would have.
- `folder_id` (String). The folder the dekstop group is in.
- `group_config` [FW-Block]. The group configuration.
  - `desktop_type` (String). The type of the desktop group. Allowed: DESKTOP_TYPE_UNSPECIFIED, PERSISTENT, NON_PERSISTENT
  - `max_desktops_amount` (Number). Maximum number of desktops.
  - `members` [FW-Block]. List of members in this desktop group.
    - `id` (**Required**)(String). The id of the member. More info in [the official documentation](https://yandex.cloud/ru/docs/cloud-desktop/api-ref/grpc/DesktopGroup/create#yandex.cloud.access.Subject).
    - `type` (**Required**)(String). The type of the member. More info in [the official documentation](https://yandex.cloud/ru/docs/cloud-desktop/api-ref/grpc/DesktopGroup/create#yandex.cloud.access.Subject).
  - `min_ready_desktops` (Number). Minimum number of ready desktops.
- `id` (*Read-Only*) (String). The resource identifier.
- `image_id` (**Required**)(String). The id of the desktop image the group is based on.
- `labels` (Map Of String). A set of key/value label pairs which assigned to resource.
- `name` (**Required**)(String). The name of the desktop group.

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_cloud_desktops_desktop_group.<resource Name> "name,folderID,desktopImageID"
terraform import yandex_cloud_desktops_desktop_group.my_desktop_group "group,fd8go**********trjsd,fd8go**********trjsd"
```
