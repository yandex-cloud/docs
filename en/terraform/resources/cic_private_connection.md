---
subcategory: Cloud Interconnect
---

# yandex_cic_private_connection (Resource)

A PrivateConnection resource.

## Example usage

```terraform
// Create a private connection on an existing trunk with an allocated VLAN.
// ipv4_static_routes manages the full route set; use [] to remove all routes.
// Omitted routes retain their current values during updates.
// After import, configure peer_bgp_md5_key again if BGP authentication is used.
//
resource "yandex_cic_private_connection" "example" {
  name                = "my-private-connection"
  trunk_connection_id = data.yandex_cic_trunk_connection.example.id
  vlan_id             = 101

  ipv4_peering = {
    peering_subnet = "192.168.0.0/30"
    cloud_ip       = "192.168.0.1"
    peer_ip        = "192.168.0.2"
    peer_bgp_asn   = 65001
  }

  ipv4_static_routes = [
    { prefix = "10.10.0.0/24" },
  ]
}

data "yandex_cic_trunk_connection" "example" {
  trunk_connection_id = "trunk-connection-id"
}
```

## Arguments & Attributes Reference

- `created_at` (*Read-Only*) (String). Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format.
- `description` (String). Description of the privateConnection. 0-256 characters long.
- `folder_id` (String). ID of the folder that the privateConnection belongs to.
- `id` (*Read-Only*) (String). ID of the PrivateConnection resource to return.
 To get the privateConnection ID use a [PrivateConnectionService.List] request.
- `ipv4_peering` [Block]. IPv4 peering config of connection
  - `cloud_bgp_asn` (*Read-Only*) (Number). CloudBgpAsn.
  - `cloud_ip` (String). CloudIp.
 It's an ip with just an ipAddress format without mask.
  - `peer_bgp_asn` (Number). PeerBgpAsn.
 PeerAsn excluding rfc5398 (excluding 64496 - 64511 and 65536 - 65551).
  - `peer_bgp_md5_key` (String). PeerBgpMd5Key.
 Optional.
  - `peer_ip` (String). PeerIp.
 It's an ip with just an ipAddress format without mask.
  - `peering_subnet` (String). PeeringSubnet.
 It's an ip with format ipPrefix/length where address part of ipPrefix is 0.
- `ipv4_static_routes` [Block]. IPv4 StaticRoute config of connection
  - `prefix` (String). Prefix.
 It's an ip with format ipPrefix/length where address part of ipPrefix is 0.
- `labels` (Map Of String). Resource labels, `key:value` pairs.
 No more than 64 per resource.
 The maximum string length in characters for each value is 63.
 Each value must match the regular expression `[-_0-9a-z]*`.
 The string length in characters for each key must be 1-63.
 Each key must match the regular expression `[a-z][-_0-9a-z]*`.
- `name` (String). Name of the privateConnection.
 The name must be unique within the folder.
 Value must match the regular expression `\|[a-zA-Z]([-_a-zA-Z0-9]{0,61}[a-zA-Z0-9])?`.
- `private_connection_id` (*Read-Only*) (String). ID of the PrivateConnection resource to return.
 To get the privateConnection ID use a [PrivateConnectionService.List] request.
- `status` (*Read-Only*) (String). Status of the privateConnection.
- `timeouts` [Block]. 
  - `create` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).
  - `delete` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Setting a timeout for a Delete operation is only applicable if changes are saved into state before the destroy operation occurs.
  - `read` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Read operations occur during any refresh or planning operation when refresh is enabled.
  - `update` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).
- `trunk_connection_id` (String). ID of the trunk_connection that the privateConnection belongs to.
- `vlan_id` (Number). VLAN_ID that the privateConnection uses in multiplexing.
 Not used in connections over partners-II
 Value range: [1, 4095]

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_cic_private_connection.<resource Name> <resource Id>
terraform import yandex_cic_private_connection.example private-connection-id
```
