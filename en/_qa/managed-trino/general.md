#### Why do I get the `changing private access is not supported yet` error when editing a cluster? {#changing-private-access}

When you modify a {{ mtr-name }} cluster, you may get this error:

```text
changing private access is not supported yet
```

The error speaks of an attempt to enable or disable [private access](../../managed-trino/concepts/network.md#private-endpoint) for an existing cluster.

{% include [unchangeable-private-access](../../_includes/managed-trino/unchangeable-private-access.md) %}

The limitation applies to all interfaces: the management console, {{ yandex-cloud }} CLI, {{ TF }}, and API. In the API, the `privateAccess.enabled` parameter is available in the cluster modification method; however, an attempt to set a new value will result in an error.

Solution: Create a new {{ mtr-name }} cluster with a proper private access parameter value. For more information, see [{#T}](../../managed-trino/operations/cluster-create.md).

{% include [logs](../logs.md) %}