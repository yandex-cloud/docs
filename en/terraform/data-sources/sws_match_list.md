---
subcategory: Smart Web Security
---

# yandex_sws_match_list (DataSource)

A match list resource.


## Arguments & Attributes Reference

- `cloud_id` (String). ID of the cloud that the match list belongs to.
- `created_at` (*Read-Only*) (String). Creation timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format.
- `description` (String). Description of the match list.
- `folder_id` (String). ID of the folder that the match list belongs to.
- `id` (String). ID of the match list resource to return.
- `item` [Block]. Match list items.
  - `description` (String). Description of the item.
  - `value` (**Required**)(String). Value of the item.
- `item_type` (**Required**)(String). Match list item type.
- `labels` (Map Of String). Labels as `` key:value `` pairs. Maximum of 64 per resource.
- `list_type` (**Required**)(String). Match list type.
- `match_list_id` (String). ID of the match list resource to return.
- `name` (**Required**)(String). Name of the match list.
- `timeouts` [Block]. 
  - `create` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).
  - `delete` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Setting a timeout for a Delete operation is only applicable if changes are saved into state before the destroy operation occurs.
  - `read` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Read operations occur during any refresh or planning operation when refresh is enabled.
  - `update` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).
- `updated_at` (*Read-Only*) (String). Update timestamp in [RFC3339](https://www.ietf.org/rfc/rfc3339.txt) text format.


