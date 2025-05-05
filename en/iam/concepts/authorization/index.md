---
title: How to choose the appropriate authentication method in {{ yandex-cloud }}
description: In this article, you will learn how to choose the appropriate authentication method in {{ yandex-cloud }}.
---

# How to choose the appropriate authentication method in {{ yandex-cloud }}

Users and [service accounts](../users/service-accounts.md) get permissions to perform actions with {{ yandex-cloud }} resources along with [roles](../../roles-reference.md) for these resources. {{ iam-name }} verifies the required permissions when a user or service account runs an operation on a {{ yandex-cloud }} resource.

For more information about assigning roles and verifying the list of permissions, see [{#T}](../access-control/index.md).

Use the appropriate credential type for authentication:

* [IAM token](iam-token.md) is the recommended and most secure type. It is suitable for most operations, such as [creating a VM](../../../compute/operations/vm-create/create-linux-vm.md). It is not suitable for services with AWS-compatible APIs.

    For federated users, you can set up automatic IAM token renewal using [refresh tokens](./refresh-token.md). This allows your organization's federated users to access [{{ yandex-cloud }} CLI](../../../cli/index.yaml) without re-authenticating in the browser when their IAM token expires.
* [API key](api-key.md) is used for [services](api-key.md#supported-services) that do not support authentication with IAM tokens. You can limit the API key by [validity period and scope](api-key.md#scoped-api-keys).
* [Static access key](access-key.md) is suitable for authentication in services with an AWS-compatible API, such as [{{ objstorage-full-name }}](../../../storage/index.yaml) and [{{ ydb-full-name }}](../../../ydb/index.yaml). From a static key, you can create a [temporary access key](sts.md) for {{ objstorage-name }} buckets.
* [Authorized key](key.md) is used in cases where you need to control all stages of issuing an IAM token. You may need it when obtaining an IAM token for a [service account](../../operations/iam-token/create-for-sa#via-jwt). Authorized keys are used for authentication only by applications form [{{ marketplace-full-name }}]({{ link-cloud-marketplace }}).
* [OAuth token](oauth-token.md) is used to obtain an IAM token on behalf of a user with a [Yandex account](../users/accounts.md#passport).
* [ID token](id-token.md) is used to for {{ yandex-cloud }} service account authentication in third-party systems with [OIDC](https://en.wikipedia.org/wiki/OpenID#OpenID_Connect_(OIDC)) support. It is not suitable for authentication within {{ yandex-cloud }}.
* [Cookie](cookie.md) is only used for service purposes.


#### See also {#see-also}

[{#T}](../users/accounts.md)