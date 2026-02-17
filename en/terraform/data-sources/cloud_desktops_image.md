---
subcategory: Cloud Desktop
---

# yandex_cloud_desktops_image (DataSource)

A desktop image resource.

## Example usage

```terraform
data "yandex_cloud_desktops_image" "desktop_image_by_id" {
	id = "fdvtmm38i0rp795kkkpa"
}

data "yandex_cloud_desktops_image" "desktop_image_by_folder_and_name" {
	folder_id = "<your folder id (optional)>"
	name 	  = "Ubuntu 20.04 LTS (2024-12-03)"
}
```

## Arguments & Attributes Reference

- `folder_id` (String). ID of the folder that the image belongs to.
- `id` (String). ID of the image to get.
- `labels` (*Read-Only*) (Map Of String). Description of the image.
- `name` (String). Name of the image.


