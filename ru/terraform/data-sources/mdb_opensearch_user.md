---
subcategory: Managed Service for OpenSearch
---

# yandex_mdb_opensearch_user (DataSource)

An OpenSearch user.

## Example usage

```terraform
//
// Get information about an existing Managed OpenSearch user.
//
data "yandex_mdb_opensearch_user" "read_only" {
  cluster_id = "some_cluster_id"
  name       = "read_only"
}

output "connection_id" {
  value = data.yandex_mdb_opensearch_user.read_only.connection_manager.connection_id
}
```

## Arguments & Attributes Reference

- `cluster_id` (**Required**)(String). Required. ID of the OpenSearch cluster.
- `connection_manager` [Block]. Connection Manager connection associated with the user. Read only field.
  - `connection_id` (*Read-Only*) (String). ID of the Connection Manager connection.
- `name` (**Required**)(String). Required. Name of the user to return.
- `timeouts` [Block]. 
  - `create` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).
  - `delete` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Setting a timeout for a Delete operation is only applicable if changes are saved into state before the destroy operation occurs.
  - `read` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Read operations occur during any refresh or planning operation when refresh is enabled.
  - `update` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).


