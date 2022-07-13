To set up the maintenance window (for example, for disabled clusters), add the `maintenance_window` section to the cluster description:

```hcl
resource "yandex_mdb_elasticsearch_cluster" "<cluster name>" {
  ...
  maintenance_window {
    type = <maintenance type: ANYTIME or WEEKLY>
    day  = <day of the week for the WEEKLY type>
    hour = <hour of the day for the WEEKLY type>
  }
  ...
}
```

{% include [maintenance-window-description](../../terraform/maintenance-window-description.md) %}
