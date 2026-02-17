---
subcategory: Cloud Desktop
---

# yandex_cloud_desktops_desktop (Resource)

Manages a Cloud Desktops Desktop. For more information see [the official documentation](https://yandex.cloud/ru/docs/cloud-desktop/concepts/desktops-and-groups)

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
		group_config = {
			initialize_params = {
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
		}
	}
		
	labels = {
    	label1 = "label1-value"
    	label2 = "label2-value"
  	}
}

// desktop
resource "yandex_cloud_desktops_desktop" "desktop" {
	name 				= "desktop-name"
	desktop_group_id 	= yandex_cloud_desktops_desktop_group.desktop_group.desktop_group_id
	
	network_interface = {
		subnet_id = yandex_vpc_subnet.subnet.id
	}

	members = [
		{
			subject_id 		= "bfblmuiaug62t0cki3dq"
			subject_type 	= "userAccount"
		},
	]

	labels = {
		label1 = "label1-value"
		label2 = "label2-value"
	}
}
```

## Arguments & Attributes Reference

- `desktop_group_id` (**Required**)(String). The id of the Desktop Group to which the Desktop belongs
- `desktop_id` (*Read-Only*) (String). The id of the Desktop
- `id` (*Read-Only*) (String). Import ID
- `labels` (Map Of String). A set of key/value label pairs which assigned to resource.
- `members` [Block]. The list of members which can use the Desktop
  - `subject_id` (**Required**)(String). Identity of the access binding. See [the official documentation](https://yandex.cloud/ru/docs/cloud-desktop/api-ref/grpc/Desktop/create#yandex.cloud.clouddesktop.v1.api.User)
  - `subject_type` (**Required**)(String). Type of the access binding. See [the official documentation](https://yandex.cloud/ru/docs/cloud-desktop/api-ref/grpc/Desktop/create#yandex.cloud.clouddesktop.v1.api.User)
- `name` (String). The name of the Desktop
- `network_interface` [Block]. The specification of the Desktop network interface
  - `subnet_id` (String). ID of the subnet for desktop

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_cloud_desktops_desktop.<resource Name> "desktopID,subnetID"
terraform import yandex_cloud_desktops_desktop.my_desktop "fd8go**********trjsd,fd8go**********trjsd"
```
