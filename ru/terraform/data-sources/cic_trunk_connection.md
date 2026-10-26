---
subcategory: Cloud Interconnect
---

# yandex_cic_trunk_connection (DataSource)

A TrunkConnection resource.

## Example usage

```terraform
//
// Read an existing trunk connection.
//
data "yandex_cic_trunk_connection" "example" {
  trunk_connection_id = "trunk-connection-id"
}
```

## Arguments & Attributes Reference

- `capacity` (*Read-Only*) (String). Capacity of the trunkConnection
- `created_at` (*Read-Only*) (String). Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format.
- `deletion_protection` (*Read-Only*) (Bool). Deletion protection flag.
- `description` (*Read-Only*) (String). Optional description of the trunkConnection. 0-256 characters long.
- `folder_id` (String). ID of the folder that the trunkConnection belongs to.
- `id` (String). ID of the TrunkConnection resource to return.
 To get the trunkConnection ID use a [TrunkConnectionService.List] request.
- `labels` (*Read-Only*) (Map Of String). Resource labels, `key:value` pairs.
 No more than 64 per resource.
 The maximum string length in characters for each value is 63.
 Each value must match the regular expression `[-_0-9a-z]*`.
 The string length in characters for each key must be 1-63.
 Each key must match the regular expression `[a-z][-_0-9a-z]*`.
- `lag_direct_joint` [Block]. package: yandex.cloud.cic.v1
filename: yandex/cloud/cic/v1/trunk_connection.proto

  - `access_device_name` (*Read-Only*) (String). Device name which is set in LLDP message.
  - `lag_allocation_settings` [Block]. LAG allocation settings that the trunkConnection is deployed on.
    - `lag_info` [Block]. LagInfo
      - `port_names` (*Read-Only*) (List Of String). List of port names that the LAG is deployed on.
  - `transceiver_type` (*Read-Only*) (String). Type of transceiver that the trunkConnection is deployed on.
- `name` (*Read-Only*) (String). Name of the trunkConnection.
 The name must be unique within the folder.
 Value must match the regular expression `\|[a-zA-Z]([-_a-zA-Z0-9]{0,61}[a-zA-Z0-9])?`.
- `partner_joint_info` [Block]. package: yandex.cloud.cic.v1
filename: yandex/cloud/cic/v1/trunk_connection.proto

  - `partner_id` (*Read-Only*) (String). ID of partner that the trunkConnection is deployed on.
  - `service_key` (*Read-Only*) (String). Reserved for future using;
- `point_of_presence_id` (*Read-Only*) (String). ID of pointOfPresence that the trunkConnection is deployed on.
- `single_port_direct_joint` [Block]. package: yandex.cloud.cic.v1
filename: yandex/cloud/cic/v1/trunk_connection.proto

  - `access_device_name` (*Read-Only*) (String). Device name which is set in LLDP message.
  - `port_name` (*Read-Only*) (String). Name of port that the trunkConnection is deployed on.
  - `transceiver_type` (*Read-Only*) (String). Type of transceiver that the trunkConnection is deployed on.
- `status` (*Read-Only*) (String). Status of the trunkConnection.
- `timeouts` [Block]. 
  - `create` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).
  - `delete` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Setting a timeout for a Delete operation is only applicable if changes are saved into state before the destroy operation occurs.
  - `read` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Read operations occur during any refresh or planning operation when refresh is enabled.
  - `update` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).
- `trunk_connection_id` (String). ID of the TrunkConnection resource to return.
 To get the trunkConnection ID use a [TrunkConnectionService.List] request.


