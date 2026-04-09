---
subcategory: Identity and Access Management
---

# yandex_iam_oauth_client (DataSource)

An OauthClient resource.


## Arguments & Attributes Reference

- `folder_id` (String). ID of the folder oauth client belongs to.
- `id` (String). ID of the OAuthClient resource to return.
 To get the oauth client ID, use a [OAuthClientService.List] request.
- `name` (**Required**)(String). Name for the oauth client.
- `oauth_client_id` (String). ID of the OAuthClient resource to return.
 To get the oauth client ID, use a [OAuthClientService.List] request.
- `redirect_uris` (Set Of String). List of redirect uries allowed for the oauth client.
- `scopes` (Set Of String). List of oauth scopes requested by the oauth client.
- `status` (*Read-Only*) (String). Current status of the oauth client.
- `timeouts` [Block]. 
  - `create` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).
  - `delete` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Setting a timeout for a Delete operation is only applicable if changes are saved into state before the destroy operation occurs.
  - `read` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours). Read operations occur during any refresh or planning operation when refresh is enabled.
  - `update` (String). A string that can be [parsed as a duration](https://pkg.go.dev/time#ParseDuration) consisting of numbers and unit suffixes, such as "30s" or "2h45m". Valid time units are "s" (seconds), "m" (minutes), "h" (hours).


