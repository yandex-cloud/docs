---
title: Authorized keys
description: In this article, you will learn what authorized keys are, why we need them, and what services support this authentication method.
---

# Authorized keys


_Authorized keys_ are keys with the RSA-2048 or RSA-4096 encryption algorithm and unlimited validity. These keys are used when [requesting an IAM token](../../operations/iam-token/create-for-sa.md#via-cli) for a service account. Some {{ yandex-cloud }} services, such as [{{ ydb-full-name }}](../../../ydb/operations/connection.md#auth), use authorized keys for authentication.

After you [request an authorized key](../../operations/authorized-key/create.md), you will get a JSON file with public and private key parts. Save this file. You only get it once and cannot download it later.

You can request the public part of the key using the [get](../../api-ref/Key/get) REST API method for the [Key](../../api-ref/Key/) resource or the [KeyService/Get](api-ref/grpc/key_service#Get) gRPC API call. You cannot request the private part of the key, as it is stored on the user side. If you need the private part of the key but cannot access the previously saved file, create a new authorized key.

{% include [key-has-last-used-data](../../../_includes/iam/key-has-last-used-data.md) %}

{% note warning %}

The private part of the key is confidential information that allows you to perform operations in {{ yandex-cloud }}. It is important to store it securely.

{% endnote %}

The private part of an authorized {{ yandex-cloud }} key starts with `PLEASE DO NOT REMOVE THIS LINE! Yandex.Cloud SA Key ID…` according to the [RFC 7468](https://datatracker.ietf.org/doc/html/rfc7468#section-2) standard. This string makes it easy to [locate secrets](../../../security/operations/search-secrets.md) in case of a leak.

## Services that support this authentication method {#supported-services}

The following services support authentication based on authorized keys:



* [{{ kms-full-name }}](../../../kms/tutorials/index.md)
* [{{ maf-full-name }}](../../../managed-airflow/tutorials/data-proc-automation.md)
* [{{ managed-k8s-full-name }}](../../../managed-kubernetes/tutorials/index.md)
* [{{ ydb-full-name }}](../../../ydb/operations/connection.md#auth)
* [{{ monitoring-full-name }}](../../../monitoring/operations/unified-agent/non-yc.md#example)

