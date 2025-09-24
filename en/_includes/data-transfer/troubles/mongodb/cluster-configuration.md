### Unable to recognize an external cluster IP address or FQDN {#cluster-config-issue}

The transfer fails with the error message:

```text
server selection error: server selection timeout, current topology: { Type: ReplicaSetNoPrimary, Servers: [{ Addr: <unresolved_FQDN>, Type: Unknown, Last error: connection() error occurred during connection handshake: dial tcp: lookup <unresolved_FQDN> on <IP_address>: no such host }, ] }"
```

The transfer error is due to the configuration of the {{ MG }} (Managed Service for MongoDB) cluster. For example, when unresolved internal names are used in shard descriptions.

**Solution**:

{% include [mondodb cluster requirement](../../../data-transfer/mongodb-cluster-requirement.md) %}

