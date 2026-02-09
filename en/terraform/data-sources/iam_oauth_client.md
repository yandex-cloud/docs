---
subcategory: Identity and Access Management
sourcePath: en/terraform/tf-ref/yandex-cloud/data-sources/iam_oauth_client.md
---

# yandex_iam_oauth_client (DataSource)

An OauthClient resource.


## Arguments & Attributes Reference

- `folder_id` (String). ID of the folder oauth client belongs to.
- `id` (String). ID of the OAuthClient resource to return. To get the oauth client ID, use a [OAuthClientService.List] request.
- `name` (**Required**)(String). Name for the oauth client.
- `oauth_client_id` (String). ID of the OAuthClient resource to return. To get the oauth client ID, use a [OAuthClientService.List] request.
- `redirect_uris` (Set Of String). List of redirect uries allowed for the oauth client.
- `scopes` (Set Of String). List of oauth scopes requested by the oauth client.
- `status` (*Read-Only*) (String). Current status of the oauth client.


