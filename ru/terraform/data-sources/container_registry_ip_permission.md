---
subcategory: Container Registry
---

# yandex_container_registry_ip_permission (DataSource)

Get information about a Yandex Container Registry IP Permission. For more information, see [the official documentation](https://yandex.cloud/docs/container-registry/operations/registry/registry-access).

{% note warning %}

Either `registry_id` or `registry_name` must be specified.

{% endnote %}


## Example usage

```terraform
//
// Get information about existing IP Permission of specific Container Registry.
//
data "yandex_container_registry_ip_permission" "my_ip_permission_by_id" {
  registry_id = yandex_container_registry.my_registry.id
}
```

## Arguments & Attributes Reference

- `id` (String). 
- `pull` (Set Of String). List of configured CIDRs, from which `pull` is allowed.
- `push` (Set Of String). List of configured CIDRs, from which `push` is allowed.
- `registry_id` (**Required**)(String). The ID of the registry that ip restrictions applied to.
- `registry_name` (String). The Name of specific Container Registry.


