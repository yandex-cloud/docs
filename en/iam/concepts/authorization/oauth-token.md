# OAuth token

In {{ yandex-cloud }}, an OAuth token is used to authenticate users with a Yandex account: the user exchanges an OAuth token for an [{{ iam-name }} token](iam-token.md).

You can get an OAuth token to work with {{ yandex-cloud }} by sending a [request]({{ link-cloud-oauth }}) to Yandex OAuth.

OAuth tokens are not available for federated users and service accounts.

## Lifetime {#lifetime}

{% include [oauth-token-lifetime](../../../_includes/oauth-token-lifetime.md) %}

{% note alert %}

If someone could have learned your OAuth token, revoke it and get a new one by following the [instructions](../../operations/compromised-credentials.md#oauth-reissue).

{% endnote %}

## Services and utilities that support OAuth token authentication {#supported-services}

These services and utilities can request an IAM token automatically, so you can only specify an OAuth token for authentication:
* [{{ yandex-cloud }} CLI](../../../cli/quickstart.md#initialize)
* [{{ container-registry-full-name }}](../../../container-registry/operations/authentication.md#user-oauth)
* [{{ TF }}](../../../tutorials/infrastructure-management/terraform-quickstart.md)
* [Packer](../../../tutorials/infrastructure-management/packer-quickstart.md)
* [{{ GL }} CI](../../../tutorials/testing/ci-for-snapshots.md)


#### See also {#see-also}

* [Learn more about Yandex OAuth](https://yandex.com/dev/id/doc/dg/oauth/concepts/about.html).
