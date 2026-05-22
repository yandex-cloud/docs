{% include [default-connstring](../../../_includes/mdb/mos/default-connstring.md) %}

You can get the host FQDN with the [list of hosts in the cluster](../../../managed-opensearch/operations/host-groups.md#list-hosts).

If the connection is successful, you will see a message like this:

```bash
{
  "name" : "....{{ dns-zone }}",
  "cluster_name" : "...",
  "cluster_uuid" : "...",
  "version" : {
  "distribution" : "opensearch",
  ...
  },
  "tagline" : "The OpenSearch Project: https://opensearch.org/"
}
```
