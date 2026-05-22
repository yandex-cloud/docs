{% include [default-connstring](../../../_includes/mdb/mos/default-connstring.md) %}

FQDN хоста можно получить со [списком хостов в кластере](../../../managed-opensearch/operations/host-groups.md#list-hosts).

При успешном подключении будет выведено сообщение вида:

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
