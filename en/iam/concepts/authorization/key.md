---
title: Authorized keys
description: In this article, you will learn what authorized keys are, why we need them, and what services support this authentication method.
---

# Authorized keys


_Authorized keys_ are keys with the RSA-2048 or RSA-4096 encryption algorithm and unlimited validity. These keys are used when [requesting](../../operations/iam-token/create-for-sa.md#via-cli) an [IAM token](./iam-token.md) for a service account. At the same time, you cannot use authorized keys directly for authentication in the [{{ yandex-cloud }} API](../../../api-design-guide/index.yaml).

The [request](../../operations/authentication/manage-authorized-keys.md#create-authorized-key) for an authorized key will provide you with a JSON file containing the public and private parts of the key. Save this file, as you will not be able to get it again.

{% note warning %}

The private part of the key is confidential information that allows you to perform operations in {{ yandex-cloud }}. It is important to store it securely.

{% endnote %}

You can get the public part of the key again using the [get](../../api-ref/Key/get.md) REST API method for the [Key](../../api-ref/Key/index.md) resource or the [KeyService/Get](../../api-ref/grpc/Key/get.md) gRPC API call. The private part of the authorized key is stored on the user end only, so you cannot request it again. In case the private part of the key is lost, create a new authorized key.

{% include [key-has-last-used-data](../../../_includes/iam/key-has-last-used-data.md) %}

The private part of an authorized {{ yandex-cloud }} key starts with `PLEASE DO NOT REMOVE THIS LINE! Yandex.Cloud SA Key ID…` according to the [RFC 7468](https://datatracker.ietf.org/doc/html/rfc7468#section-2) standard. This string makes it easy to [locate secrets](../../../security/operations/search-secrets.md) in case of a leak.

## Use cases {#examples}

* [{#T}](../../../tutorials/infrastructure-management/autoscale-monitoring.md)

#### See also {#see-also}

* [{#T}](../../operations/authentication/manage-authorized-keys.md#create-authorized-key)
* [{#T}](../../operations/authentication/manage-authorized-keys.md#delete-authorized-key)
* [{#T}](../../../cli/operations/authentication/service-account.md)
* [{#T}](../../operations/iam-token/create-for-sa.md)