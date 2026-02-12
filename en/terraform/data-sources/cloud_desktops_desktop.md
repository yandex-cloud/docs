---
subcategory: Cloud Desktop
sourcePath: en/terraform/tf-ref/yandex-cloud/data-sources/cloud_desktops_desktop.md
---

# yandex_cloud_desktops_desktop (DataSource)

Manages a Cloud Desktops Desktop. For more information see [the official documentation](https://yandex.cloud/ru/docs/cloud-desktop/concepts/desktops-and-groups)

## Example usage

```terraform
data "yandex_cloud_desktops_desktop" "data_desktop_by_name" {
	name = "desktop-group-name"
	folder_id = "<your folder id (optional)>"
}

data "yandex_cloud_desktops_desktop" "data_desktop_by_name" {
	desktop_id = "<your desktop id>"
}
```

## Arguments & Attributes Reference

- `desktop_group_id` (**Required**)(String). The id of the Desktop Group to which the Desktop belongs
- `desktop_id` (*Read-Only*) (String). The id of the Desktop
- `folder_id` (String). The folder containing the Desktop
- `labels` (Map Of String). A set of key/value label pairs which assigned to resource.
- `members` [Block]. The list of members which can use the Desktop
  - `subject_id` (**Required**)(String). Identity of the access binding. See [the official documentation](https://yandex.cloud/ru/docs/cloud-desktop/api-ref/grpc/Desktop/create#yandex.cloud.clouddesktop.v1.api.User)
  - `subject_type` (**Required**)(String). Type of the access binding. See [the official documentation](https://yandex.cloud/ru/docs/cloud-desktop/api-ref/grpc/Desktop/create#yandex.cloud.clouddesktop.v1.api.User)
- `name` (String). The name of the Desktop


