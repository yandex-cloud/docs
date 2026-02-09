---
subcategory: Identity and Access Management
sourcePath: en/terraform/tf-ref/yandex-cloud/data-sources/iam_user.md
---

# yandex_iam_user (DataSource)

Get information about a Yandex IAM user account. For more information about accounts, see [Yandex Cloud IAM accounts](https://yandex.cloud/docs/iam/concepts/#accounts).

This data source is used to define [IAM User](https://yandex.cloud/docs/iam/concepts/#passport) that can be used by other resources.

{% note warning %}

Either `login` or `user_id` must be specified.

{% endnote %}


## Example usage

```terraform
//
// Get information about existing IAM User.
//
data "yandex_iam_user" "admin" {
  login = "my-yandex-login"
}
```

## Arguments & Attributes Reference

- `default_email` (*Read-Only*) (String). Email address of user account.
- `id` (String). 
- `login` (String). Login name used to sign in to Yandex Passport.
- `user_id` (String). User ID used to manage IAM access bindings.


