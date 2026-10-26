---
subcategory: Cloud Interconnect
---

# yandex_cic_partner (DataSource)

A Partner resource.

## Example usage

```terraform
//
// Read an Interconnect partner.
//
data "yandex_cic_partner" "example" {
  partner_id = "partner-id"
}
```

## Arguments & Attributes Reference

- `id` (String). ID of the Partner resource to return.
 To get the partner ID use a [PartnerService.List] request.
- `name` (*Read-Only*) (String). Name of the partner.
- `partner_id` (String). ID of the Partner resource to return.
 To get the partner ID use a [PartnerService.List] request.
- `pop_ids` (*Read-Only*) (List Of String). List of pointOfPresence IDs that the partner is connected to.
- `status` (*Read-Only*) (String). Status of the partner.
- `timeouts` [Block]. 
  - `create` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).
  - `delete` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Setting a timeout for a Delete operation is only applicable if changes are saved into state before the destroy operation occurs.
  - `read` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Read operations occur during any refresh or planning operation when refresh is enabled.
  - `update` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).
- `url` (*Read-Only*) (String). Link to info about the partner.


