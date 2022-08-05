# OAuth token

In {{ yandex-cloud }}, an OAuth token is used in the authentication process [to get an IAM token](../../operations/iam-token/create.md).

You can get an OAuth token to work with {{ yandex-cloud }} using a [request]({{ link-cloud-oauth }}) to the Yandex.OAuth service.

## Lifetime {#lifetime}

{% include [oauth-token-lifetime](../../../_includes/oauth-token-lifetime.md) %}

{% note alert %}

If someone could have learned your OAuth token, revoke it and get a new one by following the [instructions](../../operations/compromised-credentials.md#oauth-reissue).

{% endnote %}

## Services and utilities that support OAuth token authentication {#supported-services}

These services and utilities can request an IAM token automatically, so you can only specify an OAuth token for authentication:

* [CLI](../../../cli/quickstart.md#initialize)
* [Container Registry](../../../container-registry/operations/authentication.md#oauth)
* [{{ TF }}](../../../tutorials/infrastructure-management/terraform-quickstart.md)
* [Packer](../../../tutorials/infrastructure-management/packer-quickstart.md)
* [GitLab CI](../../../tutorials/testing/ci-for-snapshots.md)

#### See also {#see-also}

* [Learn more about Yandex.OAuth](https://yandex.com/dev/id/doc/dg/oauth/concepts/about.html).