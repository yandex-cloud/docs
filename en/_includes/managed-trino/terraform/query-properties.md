```hcl
resource "yandex_trino_cluster" "<cluster_name>" {
  ...
  query_properties = {
    <list_of_query_execution_settings>
    <list_of_cluster_resource_allocation_for_queries_settings>
  }
  ...
}
```

Where:

* `query_properties`: Settings of query execution and cluster resource allocation for queries in `"<key>" = "<value>"` format.

    Learn more about the [settings of cluster resource allocation for queries]({{ tr.docs}}/admin/properties-resource-management.html) and [query execution settings]({{ tr.docs}}/admin/properties-query-management.html).
