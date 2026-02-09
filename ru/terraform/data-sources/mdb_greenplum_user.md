---
subcategory: Managed Service for Greenplum®
sourcePath: en/terraform/tf-ref/yandex-cloud/data-sources/mdb_greenplum_user.md
---

# yandex_mdb_greenplum_user (DataSource)

Get information about a greenplum user.

## Example usage

```terraform
//
// Get information about existing MDB Greenplum database user.
//
data "yandex_mdb_greenplum_user" "my_user" {
  cluster_id = "some_cluster_id"
  name       = "test"
}

output "resource_group" {
  value = data.yandex_mdb_greenplum_user.my_user.resource_group
}
```

## Arguments & Attributes Reference

- `cluster_id` (**Required**)(String). The ID of the cluster to which user belongs to.
- `id` (*Read-Only*) (String). The resource identifier.
- `name` (**Required**)(String). The name of the user.
- `password` (String). The password of the user.
- `resource_group` (String). The resource group of the user.


