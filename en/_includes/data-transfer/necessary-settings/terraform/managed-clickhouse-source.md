* {% include [Field Terraform Cluster ID](../../fields/clickhouse/terraform/cluster-id.md) %}
* `clickhouse_cluster_name`: Shard group to transfer the data from. If this parameter is not set, data from all shards will be transferred.
* {% include [Field Terraform Subnet ID](../../fields/clickhouse/terraform/subnet-id.md) %}
* {% include [Field Terraform Security Group](../../fields/common/terraform/security-group-cluster-mdb.md) %}

   Make sure the specified security groups are [configured](../../../../managed-clickhouse/operations/connect/index.md#configuring-security-groups).

* {% include [Field Terraform Database](../../fields/clickhouse/terraform/database.md) %}
* {% include [Field Terraform User](../../fields/clickhouse/terraform/username.md) %}
* {% include [Field Terraform Raw Password](../../fields/clickhouse/terraform/raw-password.md) %}
