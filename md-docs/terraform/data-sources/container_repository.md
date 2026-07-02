[Документация Yandex Cloud](../../index.md) > [Terraform в Yandex Cloud](../index.md) > Справочник Terraform > Ресурсы (англ.) > Container Registry > Data Sources > container_repository

# yandex_container_repository (DataSource)

Get information about a Yandex Container Repository. For more information, see [the official documentation](../../container-registry/concepts/repository.md).

## Example usage

```terraform
//
// Get information about existing Container Repository
//
data "yandex_container_repository" "repo-1" {
  name = "some_repository_name"
}

data "yandex_container_repository" "repo-2" {
  repository_id = "some_repository_id"
}
```

## Arguments & Attributes Reference

- `id` (String). 
- `name` (String). A name of the repository. The name of the repository should start with id of a container registry and match the name of the images that will be pushed in the repository.
- `repository_id` (String). The ID of a specific repository.