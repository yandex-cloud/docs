---
subcategory: Managed Service for ClickHouse
---

# yandex_mdb_clickhouse_database (DataSource)

Get information about a Yandex Managed ClickHouse database.

## Example usage

```terraform
data "yandex_mdb_clickhouse_database" "foo" {
  cluster_id = "some_cluster_id"
  name       = "dbname"
}

output "dbname" {
  value = data.yandex_mdb_clickhouse_database.foo.id
}
```

## Arguments & Attributes Reference

- `cluster_id` (**Required**)(String). ID of the ClickHouse cluster. Provided by the client when the database is created.
- `engine` (String). Database engine, possible values are: atomic,replicated.
- `id` (*Read-Only*) (String). The resource identifier.
- `name` (**Required**)(String). The name of the database.


