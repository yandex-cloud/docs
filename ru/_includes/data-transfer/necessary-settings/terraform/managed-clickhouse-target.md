* {% include [Field Terraform Cluster ID](../../fields/clickhouse/terraform/cluster-id.md) %}
* `clickhouse_cluster_name` — группа шардов, в которую будут передаваться данные. Если параметр не указан, данные будут размещены во всех шардах.
* {% include [Field Terraform Subnet ID](../../fields/clickhouse/terraform/subnet-id.md) %}
* {% include [Field Terraform Security Group](../../fields/common/terraform/security-group-cluster-mdb.md) %}

   Убедитесь, что указанные группы безопасности [настроены](../../../../managed-clickhouse/operations/connect/index.md#configuring-security-groups).

* {% include [Field Terraform Database](../../fields/clickhouse/terraform/database.md) %}
* {% include [Field Terraform User](../../fields/clickhouse/terraform/username.md) %}
* {% include [Field Terraform Raw Password](../../fields/clickhouse/terraform/raw-password.md) %}
