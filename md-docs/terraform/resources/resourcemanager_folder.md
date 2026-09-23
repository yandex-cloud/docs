[Документация Yandex Cloud](../../index.md) > [Terraform в Yandex Cloud](../index.md) > Справочник Terraform > Ресурсы (англ.) > Resource Manager > Resources > resourcemanager_folder

# yandex_resourcemanager_folder (Resource)

A Folder resource. For more information, see [Folder](../../resource-manager/concepts/resources-hierarchy.md#folder).

## Example usage

```terraform
//
// Create a new Folder.
//
resource "yandex_resourcemanager_folder" "folder1" {
  cloud_id = "my_cloud_id"
}
```

## Arguments & Attributes Reference

- `cloud_id` (String). ID of the cloud that the folder belongs to.
- `created_at` (*Read-Only*) (String). Creation timestamp.
- `description` (String). Description of the folder. 0-256 characters long.
- `folder_id` (String). ID of the Folder resource to return.
 To get the folder ID, use a [FolderService.List] request.
- `id` (String). ID of the Folder resource to return.
 To get the folder ID, use a [FolderService.List] request.
- `labels` (Map Of String). Resource labels as `` key:value `` pairs. Maximum of 64 per resource.
- `name` (**Required**)(String). Name of the folder.
 The name is unique within the cloud. 3-63 characters long.
- `status` (*Read-Only*) (String). Status of the folder.
- `timeouts` [Block]. 
  - `create` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).
  - `delete` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Setting a timeout for a Delete operation is only applicable if changes are saved into state before the destroy operation occurs.
  - `read` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Read operations occur during any refresh or planning operation when refresh is enabled.
  - `update` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](../../cli/quickstart.md).

```shell
# terraform import yandex_resourcemanager_folder.<resource Name> <resource Id>
terraform import yandex_resourcemanager_folder.my_foldeer b1g5r**********dqmsp
```