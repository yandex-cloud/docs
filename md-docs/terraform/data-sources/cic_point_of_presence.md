[Документация Yandex Cloud](../../index.md) > [Terraform в Yandex Cloud](../index.md) > Справочник Terraform > Ресурсы (англ.) > Cloud Interconnect > Data Sources > cic_point_of_presence

# yandex_cic_point_of_presence (DataSource)

A PointOfPresence resource.

## Example usage

```terraform
//
// Read an Interconnect point of presence.
//
data "yandex_cic_point_of_presence" "example" {
  point_of_presence_id = "point-of-presence-id"
}
```

## Arguments & Attributes Reference

- `connection_points` (*Read-Only*) (List Of String). Links to info about the connection points.
- `id` (String). ID of the PointOfPresence resource to return.
 To get the pointOfPresence ID use a [PointOfPresenceService.List] request.
- `location_address` (*Read-Only*) (String). Location address of the pointOfPresence.
- `name` (*Read-Only*) (String). Name of the pointOfPresence.
- `point_of_presence_id` (String). ID of the PointOfPresence resource to return.
 To get the pointOfPresence ID use a [PointOfPresenceService.List] request.
- `timeouts` [Block]. 
  - `create` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).
  - `delete` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Setting a timeout for a Delete operation is only applicable if changes are saved into state before the destroy operation occurs.
  - `read` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Read operations occur during any refresh or planning operation when refresh is enabled.
  - `update` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).