---

__system: {"dislikeVariants":["No answer to my question","Recomendations didn't help","The content doesn't match title","Other"]}
---
# Questions and answers about {{ vpc-name }}

#### What is {{ vpc-short-name }}? {#what-is-vpc}

{{ vpc-short-name }} ({{ vpc-full-name }}) is a way to connect and organize cloud resources using virtual networks.

#### Which network technologies are available to Yandex.Cloud users? {#available-network-techs}

{{ vpc-short-name }} allows you to assign internal and external IP addresses to VMs and create cloud networks and subnets.

#### How do I create a cloud network? {#create-cloud-network}

When you create a folder through the management console, the service will automatically create a network in it. You can also create a cloud network manually using the management console.

#### How do I create a subnet? {#create-subnet}

Subnets in the default folder will be created automatically. You can create additional subnets using the [management console or CLI](../operations/subnet-create.md).

#### What resources can be assigned IP addresses? {#assing-ip-resources}

Addresses can be assigned to [VMs](../../compute/concepts/vm.md) and [ClickHouse](../../managed-clickhouse/concepts/index.md), [MongoDB](../../managed-mongodb/concepts/index.md), and [PostgreSQL](../../managed-postgresql/concepts/index.md) database clusters.

#### How are IP addresses assigned to cloud resources? {#assign-ip}

Public IP addresses are assigned to cloud resources automatically. You can assign internal addresses automatically or manually when creating a VM.

#### How do I make a public IP address static? {#make-ip-static}

You can [make a public IP address static](../operations/set-static-ip.md) using the **IP addresses** tab of the VPC service in the [management console]({{ link-console-main }}).

#### What limitations apply when creating subnets? {#create-subnet-limits}

Subnets can only use private addresses from IPv4 ranges defined by [RFC 1918](https://tools.ietf.org/html/rfc1918).

{% include [qa-fz-152.md](../../_includes/qa-fz-152.md) %}

{% include [qa-logs.md](../../_includes/qa-logs.md) %}