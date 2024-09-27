* {% include [Field CLI Cluster ID](../../fields/common/cli/cluster-id.md) %}
* `--cluster-name`: Shard group to transfer the data from. If this parameter is not set, data from all shards will be transferred.
* {% include [Field CLI Database](../../fields/common/cli/database.md) %}
* {% include [Field CLI User](../../fields/common/cli/username.md) %}
* {% include [Field CLI Security Group](../../fields/common/cli/security-group.md) %}

    Make sure the specified security groups are [configured](../../../../managed-clickhouse/operations/connect/index.md#configuring-security-groups).


* To set a user password to access the DB, use one of the following parameters:

    * {% include [Field CLI Raw Password](../../fields/common/cli/raw-password.md) %}
    * {% include [Field CLI Password File](../../fields/common/cli/password-file.md) %}
