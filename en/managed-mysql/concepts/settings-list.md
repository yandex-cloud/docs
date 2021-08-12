---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# {{ MY }} settings

For {{ mmy-name }} clusters, you can configure settings that relate to {{ MY }}. Some settings are set [at the cluster level](#dbms-cluster-settings) and others [at the user level](#dbms-user-settings).

The label next to the setting name helps determine which interface is used to set the value of this setting: the management console, CLI, API, or Terraform. The {{ tag-all }} label indicates that all of the above interfaces are supported.

Depending on the selected interface, the same setting is represented differently. For example, **Innodb buffer pool size** in the management console matches:

- `innodb_buffer_pool_size` in gRPC, CLI, and Terraform.
- `innodbBufferPoolSize` in the REST API.

## Cluster settings {#dbms-cluster-settings}

{% include [mmy-dbms-settings](../../_includes/mdb/mmy-dbms-settings.md) %}

## Custom settings {#dbms-user-settings}

These settings apply at the individual user level.

{% include [mmy-dbms-user-settings](../../_includes/mdb/mmy-dbms-user-settings.md) %}

