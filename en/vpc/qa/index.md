# Questions and answers about {{ vpc-name }}

#### What is {{ vpc-short-name }}?

{{ vpc-short-name }} ({{ vpc-full-name }}) is a way to connect and organize cloud resources using virtual networks.

#### Which network technologies are available to Yandex.Cloud users?

{{ vpc-short-name }} allows you to assign internal and external IP addresses to VMs and create cloud networks and subnets.

#### How do I create a cloud network?

When you create a folder through the management console, the service will automatically create a network in it. You can also create a cloud network manually using the management console.

#### How do I create a subnet?

Subnets in the default folder will be created automatically. You can create additional subnets using the [management console or CLI](../operations/subnet-create.md).

#### What resources can be assigned IP addresses?

Addresses can be assigned to [VMs](../../compute/concepts/vm.md) and [ClickHouse](../../managed-clickhouse/concepts/index.md), [MongoDB](../../managed-mongodb/concepts/index.md), and [PostgreSQL](../../managed-postgresql/concepts/index.md) database clusters.

#### How are IP addresses assigned to cloud resources?

Public IP addresses are assigned to cloud resources automatically. You can assign internal addresses automatically or manually when creating a VM.

#### How do I make a public IP address static?

You can[make a public IP address static](../operations/set-static-ip.md) using the **IP addresses** tab of the VPC service in the [management console](https://console.cloud.yandex.ru).

#### What limitations apply when creating subnets?

Subnets can only use private addresses from IPv4 ranges defined by [RFC 1918](https://tools.ietf.org/html/rfc1918):

