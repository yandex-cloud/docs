# Questions and answers

#### What is [!KEYREF vpc-short-name]?

[!KEYREF vpc-short-name] ([!KEYREF vpc-full-name]) is a way to connect and organize cloud resources using virtual networks.

#### Which network technologies are available to Yandex.Cloud users?

[!KEYREF vpc-short-name] allows you to assign internal and external IP addresses to VM instances and create cloud networks and subnets.

#### How do I create a cloud network?

When you create a folder through the management console, the service will automatically create a network in it. You can also create a cloud network manually using the management console.

#### How do I create a subnet?

When creating a folder through the management console, subnets will be created automatically in all availability zones.

#### What resources can be assigned IP addresses?

Addresses can be assigned to [VM instances](../../compute/concepts/vm.md) and to hosts in database clusters.

#### How are IP addresses assigned to cloud resources?

Internal and external IP addresses are assigned to cloud resources automatically. Internal addresses are always assigned, and external addresses are assigned on request.

#### What limitations apply when creating subnets?

Subnets can only use private addresses from IPv4 ranges defined by [RFC 1918](https://tools.ietf.org/html/rfc1918).

