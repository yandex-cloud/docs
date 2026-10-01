[Документация Yandex Cloud](../../index.md) > [Terraform в Yandex Cloud](../index.md) > Справочник Terraform > Ресурсы (англ.) > Container Registry > Data Sources > container_repository_lifecycle_policy

# yandex_container_repository_lifecycle_policy (DataSource)

Get information about a Yandex Container Repository. For more information, see [the official documentation](../../container-registry/concepts/lifecycle-policy.md).

{% note warning %}

Either `lifecycle_policy_id` or `name` and `repository_id` must be specified.

{% endnote %}


## Example usage

```terraform
//
// Get information about existing Container Repository Lifecycle Policy.
//
data "yandex_container_repository_lifecycle_policy" "my_lifecycle_policy_by_id" {
  lifecycle_policy_id = yandex_container_repository_lifecycle_policy.my_lifecycle_policy.id
}
```

## Arguments & Attributes Reference

- `created_at` (*Read-Only*) (String). The creation timestamp of the resource.
- `description` (*Read-Only*) (String). The resource description.
- `id` (String). 
- `lifecycle_policy_id` (String). The ID of a specific Lifecycle Policy.
- `name` (String). The resource name.
- `repository_id` (String). The ID of the repository that the resource belongs to.
- `rule` (*Read-Only*) (List Of Object). 
  - `description` . 
  - `expire_period` . 
  - `retained_top` . 
  - `tag_regexp` . 
  - `untagged` . 
- `status` (*Read-Only*) (String). The status of lifecycle policy. Must be `active` or `disabled`.
- `timeouts` [Block]. 
  - `default` (String).