---
title: What are {{ lockbox-full-name }} secrets
description: In this tutorial, you will learn about {{ lockbox-full-name }} secrets and their components.
---

# Secrets in {{ lockbox-full-name }}

## Secret {#secret}

A secret is a set of versions that store your data, such as API keys, passwords, or tokens. A version contains sets of keys and values. A key is a non-secret name that identifies a value. The value is your secret data.

You can set up access to secrets using [{{ iam-full-name }}](../../iam/index.yaml). The roles available for different use cases are described in the [{#T}](../security/index.md) section.

A secret can be either active or deactivated. When a secret is active, it enables access to both its metadata and content (key-value pairs). When deactivated, it allows access only to its metadata, with the secret content being inaccessible.

## Secret type {#secret-type}

{{ lockbox-full-name }} allows creating two types of secrets: generated secrets and user secrets.

* A _generated secret_ is an automatically generated sequence of random characters. You can configure generation parameters, such as length and character set. Generated secrets are good for passwords you do not have to set manually as well as for passwords with frequent rotation, e.g., for database access, microservice level authentication, in CI/CD systems, and for other program interactions.

    You can also use generated secrets to store data on connections to {{ PG }}, {{ MY }}, and {{ CH }} databases via [{{ connection-manager-full-name }}](../../metadata-hub/concepts/connection-manager.md). In which case the secret is created in {{ connection-manager-full-name }} and stored in {{ lockbox-full-name }}.

* A _user secret_ is created manually. It is suitable for externally generated secrets. You can specify not only a string but also a file for your user secret's confidential value.

    {% include [secret-content-base64](../../_includes/lockbox/secret-content-base64.md) %}

## Version {#version}

{{ lockbox-full-name }} stores secrets as versions. Each version contains metadata and one or more key-value pairs, which allows you to track changes and manage a secret's lifecycle.

Once created, a version cannot be changed. If you need to change key-value pairs, you will need to [create a new version](../operations/secret-version-manage.md#create-version). Apart from creating a new version of a secret, you can create a version [based on an existing one](../operations/secret-version-manage.md#create-version-based-on-other) with new values.

Only one version of a secret can be valid at a time. You can manage a valid version of a secret by adding new versions or [rolling back to previous ones](../operations/secret-version-manage.md#backup).

You can set up access to versions of a secret in addition to access to the secret itself. To do this, you need to assign the `{{ roles-lockbox-admin }}` or `{{ roles-lockbox-payloadviewer }}` role. For more information about managing access, see [{{ lockbox-full-name }} access management: What roles do I need](../security/index.md#choosing-roles).

## Secret encryption using {{ kms-full-name }} {#encryption}

With [{{ kms-full-name }}](../../kms/index.yaml), you can create and manage encryption keys that are used to secure secrets in {{ lockbox-full-name }}.

By default, all secrets are encrypted with a common key. However, when [creating a secret](../operations/secret-create.md), you can specify your own {{ kms-full-name }} [key](../../kms/concepts/key.md) for encrypting the secret. Using your own key has the following benefits:

* It mitigates the risk of the common key being compromised.
* You can [rotate](../../kms/operations/key.md#rotate) your key on your own and manage its versions.
* You can delete your key, if needed, to block access to your encrypted data.
* You can get audit logs of events connected to encryption key usage. To do this, use [{{ at-full-name }}](../../audit-trails/concepts/index.md).

{% include [lockbox-and-kms-roles](../../_includes/lockbox/lockbox-and-kms-roles.md) %}

{% note warning %}

Using a {{ kms-full-name }} key each time you access the secret it is encrypted with is charged as a single cryptographic operation. To learn more about the cost of cryptographic operations with keys, see the [{{ kms-full-name }} pricing policy](../../kms/pricing.md).

{% endnote %}

## See also

* [{#T}](../security/index.md)
* [{#T}](../pricing.md)

## Use cases {#examples}

* [{#T}](../tutorials/gitlab-lockbox-integration.md)
* [{#T}](../tutorials/static-key-in-lockbox/console.md)
* [{#T}](../tutorials/lockbox-and-airflow.md)
* [{#T}](../tutorials/websocket-app.md)
* [{#T}](../tutorials/bucket-to-bucket-copying.md)
* [{#T}](../tutorials/nodejs-cron-restart-vm.md)
* [{#T}](../tutorials/secure-password-script.md)
