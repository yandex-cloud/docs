# OAuth token

In Yandex.Cloud, an OAuth token is used to authenticate when [getting an IAM token](../../operations/iam-token/create.md).

You can get an OAuth token to work with Yandex.Cloud by sending a [request]({{ link-cloud-oauth }}) to the Yandex.OAuth service.

## Lifetime {#lifetime}

{% include [oauth-token-lifetime](../../../_includes/oauth-token-lifetime.md) %}

## Services and utilities that support OAuth token authentication {#supported-services}

These services and utilities can request an IAM token automatically, so you can only specify an OAuth token for authentication:

* [CLI](../../../cli/quickstart.md#initialize)
* [Container Registry](../../../container-registry/operations/authentication.md#oauth)
* [Terraform](../../../solutions/infrastructure-management/terraform-quickstart.md)
* [Packer](../../../solutions/infrastructure-management/packer-quickstart.md)
* [GitLab CI](../../../solutions/testing/ci-for-snapshots.md)

#### See also

* [Learn more about Yandex.OAuth ](https://yandex.ru/dev/oauth/).

