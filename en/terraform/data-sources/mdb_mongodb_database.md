---
subcategory: Managed Service for MongoDB
page_title: 'Yandex: yandex_mdb_mongodb_database'
description: Get information about a Yandex Managed MongoDB database.
sourcePath: en/terraform/tf-ref/yandex-cloud/data-sources/mdb_mongodb_database.md
---

# yandex_mdb_mongodb_database (Data Source)

Get information about a Yandex Managed MongoDB database. For more information, see [the official documentation](https://yandex.cloud/docs/managed-mongodb/).

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

## Argument Reference

The following arguments are supported:

* `cluster_id` - (Required) The ID of the MongoDB cluster.

* `name` - (Required) The name of the MongoDB cluster.
