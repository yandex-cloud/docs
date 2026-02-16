---
subcategory: Identity and Access Management
sourcePath: en/terraform/tf-ref/yandex-cloud/resources/iam_oauth_client.md
---

# yandex_iam_oauth_client (Resource)

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

## Import

The resource can be imported by using their `resource ID`. For getting it you can use Yandex Cloud [Web Console](https://console.yandex.cloud) or Yandex Cloud [CLI](https://yandex.cloud/docs/cli/quickstart).

```shell
# terraform import yandex_iam_oauth_client.<resource Name> <resource Id>
terraform import yandex_iam_oauth_client.my-oauth-client ...
```
