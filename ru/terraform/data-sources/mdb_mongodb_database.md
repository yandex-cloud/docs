---
subcategory: Managed Service for MongoDB
---

# yandex_mdb_mongodb_database (DataSource)

Manages a MongoDB Database within the Yandex Cloud. For more information, see [the official documentation](https://yandex.cloud/docs/managed-mongodb/).

## Example usage

```terraform
//
// Get information about existing MDB MongoDB Database.
//
data "yandex_mdb_mongodb_database" "my_db" {
  cluster_id = "some_cluster_id"
  name       = "test"
}

output "owner" {
  value = data.yandex_mdb_mongodb_database.my_db.name
}
```

## Arguments & Attributes Reference

- `cluster_id` (**Required**)(String). The ID of MongoDB Cluster.
- `id` (*Read-Only*) (String). The resource identifier.
- `name` (**Required**)(String). The name of the database.


