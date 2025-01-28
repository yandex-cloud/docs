---
title: OAuth token
description: In this article, you will learn what an OAuth token is, about its purpose, format, and TTL, and about the services supporting the OAuth token authentication method.
---

# OAuth_token


In {{ yandex-cloud }}, an OAuth token is used to authenticate users with a Yandex account: the user exchanges an OAuth token for an [{{ iam-name }} token](iam-token.md).

You can get an OAuth token for {{ yandex-cloud }} by submitting a [request]({{ link-cloud-oauth }}) to Yandex OAuth.

OAuth tokens are not available for federated users and service accounts.

## OAuth token format {#oauth-token-format}

The token always starts with a `y`, a random number in the `0-3` range, and an underscore (`_`). Other characters may include:

* Latin letters.
* Numbers.
* Underscores (`_`) and hyphens (`-`).

For example, an OAuth token may look like this: `y3_Vdheub7w9bIut67GHeL345gfb5GAnd3dZnf08FRbvjeUFvetYiohGvc`.

## Lifetime {#lifetime}

{% include [oauth-token-lifetime](../../../_includes/oauth-token-lifetime.md) %}

{% note alert %}

If someone could have learned your OAuth token, revoke it and get a new one by following the [instructions](../../operations/compromised-credentials.md#oauth-reissue).

{% endnote %}

## Services and utilities that support OAuth token authentication {#supported-services}

These services and utilities can request an IAM token automatically, so you can only specify an OAuth token for authentication:
* [{{ yandex-cloud }} CLI](../../../cli/quickstart.md#initialize)
* [{{ container-registry-full-name }}](../../../container-registry/operations/authentication.md#user)
* [{{ TF }}](../../../tutorials/infrastructure-management/terraform-quickstart.md)
* [Packer](../../../tutorials/infrastructure-management/packer-quickstart.md)
* [{{ GL }} CI](../../../tutorials/testing/ci-for-snapshots.md)


#### See also {#see-also}

* Learn more about Yandex OAuth [here](https://yandex.com/dev/id/doc/dg/oauth/concepts/about.html).

