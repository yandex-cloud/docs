---
subcategory: Cloud Interconnect
---

# yandex_cic_private_connection (DataSource)

A PrivateConnection resource.

## Example usage

```terraform
//
// Read an existing private connection.
//
data "yandex_cic_private_connection" "example" {
  private_connection_id = "private-connection-id"
}
```

## Arguments & Attributes Reference

- `created_at` (*Read-Only*) (String). Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format.
- `description` (*Read-Only*) (String). Description of the privateConnection. 0-256 characters long.
- `folder_id` (String). ID of the folder that the privateConnection belongs to.
- `id` (String). ID of the PrivateConnection resource to return.
 To get the privateConnection ID use a [PrivateConnectionService.List] request.
- `ipv4_peering` [Block]. IPv4 peering config of connection
  - `cloud_bgp_asn` (*Read-Only*) (Number). CloudBgpAsn.
  - `cloud_ip` (*Read-Only*) (String). CloudIp.
 It's an ip with just an ipAddress format without mask.
  - `peer_bgp_asn` (*Read-Only*) (Number). PeerBgpAsn.
 PeerAsn excluding rfc5398 (excluding 64496 - 64511 and 65536 - 65551).
  - `peer_bgp_md5_key` (*Read-Only*) (String). PeerBgpMd5Key.
 Optional.
  - `peer_ip` (*Read-Only*) (String). PeerIp.
 It's an ip with just an ipAddress format without mask.
  - `peering_subnet` (*Read-Only*) (String). PeeringSubnet.
 It's an ip with format ipPrefix/length where address part of ipPrefix is 0.
- `ipv4_static_routes` [Block]. IPv4 StaticRoute config of connection
  - `prefix` (*Read-Only*) (String). Prefix.
 It's an ip with format ipPrefix/length where address part of ipPrefix is 0.
- `labels` (*Read-Only*) (Map Of String). Resource labels, `key:value` pairs.
 No more than 64 per resource.
 The maximum string length in characters for each value is 63.
 Each value must match the regular expression `[-_0-9a-z]*`.
 The string length in characters for each key must be 1-63.
 Each key must match the regular expression `[a-z][-_0-9a-z]*`.
- `name` (*Read-Only*) (String). Name of the privateConnection.
 The name must be unique within the folder.
 Value must match the regular expression `\|[a-zA-Z]([-_a-zA-Z0-9]{0,61}[a-zA-Z0-9])?`.
- `private_connection_id` (String). ID of the PrivateConnection resource to return.
 To get the privateConnection ID use a [PrivateConnectionService.List] request.
- `status` (*Read-Only*) (String). Status of the privateConnection.
- `timeouts` [Block]. 
  - `create` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).
  - `delete` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Setting a timeout for a Delete operation is only applicable if changes are saved into state before the destroy operation occurs.
  - `read` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Read operations occur during any refresh or planning operation when refresh is enabled.
  - `update` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).
- `trunk_connection_id` (*Read-Only*) (String). ID of the trunk_connection that the privateConnection belongs to.
- `vlan_id` (*Read-Only*) (Number). VLAN_ID that the privateConnection uses in multiplexing.
 Not used in connections over partners-II
 Value range: [1, 4095]


