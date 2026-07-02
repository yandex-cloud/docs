[Документация Yandex Cloud](../../index.md) > [Terraform в Yandex Cloud](../index.md) > Справочник Terraform > Ресурсы (англ.) > Cloud DNS > Resources > dns_inbound_endpoint_iam_binding

# yandex_dns_inbound_endpoint_iam_binding (Resource)

Allows creation and management of a single binding within IAM policy for an existing `dns_inbound_endpoint`.

## Example usage

```terraform
//
// Create a new DNS Inbound Endpoint and new IAM Binding for it.
//
resource "yandex_vpc_network" "network1" {
  name = "my-network"
}

resource "yandex_vpc_subnet" "subnet1" {
  name           = "my-subnet"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network1.id
  v4_cidr_blocks = ["192.168.0.0/24"]
}

resource "yandex_vpc_address" "addr1" {
  name        = "my-addr"
  description = "internal address for DNS inbound endpoint"

  internal_ipv4_address {
    subnet_id = yandex_vpc_subnet.subnet1.id
  }
  deletion_protection = false
}

resource "yandex_dns_inbound_endpoint" "endpoint1" {
  name       = "my-inbound-endpoint"
  network_id = yandex_vpc_network.network1.id
  address_id = yandex_vpc_address.addr1.id
}

resource "yandex_dns_inbound_endpoint_iam_binding" "endpoint-editor" {
  dns_inbound_endpoint_id = yandex_dns_inbound_endpoint.endpoint1.id
  role                    = "dns.endpointEditor"
  members                 = ["userAccount:foo_user_id"]
}
```

## Arguments & Attributes Reference

- `dns_inbound_endpoint_id` (**Required**)(String). The ID of the `dns_inbound_endpoint` to attach the policy to.
- `id` (String). The ID of this resource.
- `members` (**Required**)(Set Of String). An array of identities that will be granted the privilege in the `role`. Each entry can have one of the following values:
 * **userAccount:{user_id}**: A unique user ID that represents a specific Yandex account.
 * **serviceAccount:{service_account_id}**: A unique service account ID.
 * **federatedUser:{federated_user_id}**: A unique federated user ID.
 * **federatedUser:{federated_user_id}:**: A unique SAML federation user account ID.
 * **group:{group_id}**: A unique group ID.
 * **system:group:federation:{federation_id}:users**: All users in federation.
 * **system:group:organization:{organization_id}:users**: All users in organization.
 * **system:allAuthenticatedUsers**: All authenticated users.
 * **system:allUsers**: All users, including unauthenticated ones.

{% note warning %}

for more information about system groups, see [Cloud Documentation](../../iam/concepts/access-control/system-group.md).

{% endnote %}



- `role` (**Required**)(String). The role that should be assigned. Only one yandex_dns_inbound_endpoint_iam_binding can be used per role.
- `sleep_after` (Number). For test purposes, to compensate IAM operations delay

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](../../cli/quickstart.md).

```shell
# terraform import yandex_dns_inbound_endpoint_iam_binding.<resource Name> "dns_inbound_endpoint_id,dns.endpointEditor"
terraform import yandex_dns_inbound_endpoint_iam_binding.endpoint-editor "dns7ie**********dkhh6,dns.endpointEditor"
```