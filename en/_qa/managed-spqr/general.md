### How to fix the `failed to get connection to any shard host within` error when connecting to cluster hosts? {#failed-to-get-connection}

Error example:

```bash
failed to get connection to any shard host within: host {rc1d-cofs7cre********.mdb.yandexcloud.net:6432 rc1d}: dial tcp 10.151.25.35:6432: i/o timeout, host {rc1b-49796b52********.mdb.yandexcloud.net:6432 rc1b}: dial tcp 10.149.25.23:6432: i/o timeout, host {rc1a-kdm7v4qm********.mdb.yandexcloud.net:6432 rc1a}: dial tcp 10.148.25.15:6432: i/o timeout
```

This error occurs if the [router](../../managed-spqr/concepts/index.md#router) cannot connect to the [shard](../../managed-spqr/concepts/index.md#shard) hosts.

**Solution:**

1. Make sure that the {{ mspqr-name }} cluster and shards are in the same network and [security group](../../vpc/concepts/security-groups.md).
1. [Add](../../vpc/operations/security-group-add-rule.md) to the security group the inbound and outbound traffic rules allowing TCP connection to port `6432`:
  
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-port-range }}**: `6432`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-protocol }}**: `{{ ui-key.yacloud.common.label_tcp }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-destination }}**: `{{ ui-key.yacloud.vpc.network.security-groups.forms.value_sg-rule-destination-cidr }}`.
    * **{{ ui-key.yacloud.vpc.network.security-groups.forms.field_sg-rule-cidr-blocks }}**: Specify the cluster CIDR, e.g., `10.96.0.0/16`.    