# Secrets in {{ lockbox-full-name }}

## Secret {#secret}

A secret is a set of versions that store your data, such as API keys, passwords, or tokens. A version contains sets of keys and values. A key is a non-secret name that identifies a value. The value is your secret data.

You can set up access to secrets using [{{ iam-full-name }}](../../iam/). The roles available for different use cases are described in the [{#T}](../security/index.md) section.

## Version {#version}

{{ lockbox-full-name }} stores secrets as versions. Each version contains metadata and one or more key-value pairs, which allows you to track changes and manage a secret's lifecycle.

Once created, a version cannot be changed. If you need to change key-value pairs, you will need to [create a new version](../operations/secret-version-manage#create-version). Apart from creating a new version of a secret, you can create a version [based on an existing one](../operations/secret-version-manage#create-version-based-on-other) with new values.

Only one version of a secret can be active at a time. You can manage the active version of a secret by adding new versions or [rolling back to previous ones](../operations/secret-version-manage#backup).

You can set up access to versions of a secret in addition to access to the secret itself. This requires you to assign the `{{ roles-lockbox-admin }}` or `{{ roles-lockbox-payloadviewer }}` role. For more information about managing access, see [{{ lockbox-full-name }} access management: What roles I need](../security/index.md#choosing-roles).

## Secret encryption using {{ kms-full-name }} {#encryption}

With [{{ kms-full-name }}](../../kms/index.yaml), you can create and manage encryption keys that are used to secure secrets in {{ lockbox-full-name }}.

By default, all secrets are encrypted with a common key. However, when [creating a secret](../operations/secret-create.md), you can specify your own {{ kms-full-name }} [key](../../kms/concepts/key.md) for encrypting the secret. Using your own key has the following benefits:

* It mitigates the risk of the common key being compromised.
* You can [rotate](../../kms/operations/key.md#rotate) your key on your own and manage its versions.
* You can delete your key, if needed, to block access to your encrypted data.
* You can get audit logs of events connected to encryption key usage. To do this, use [{{ at-full-name }}](../../audit-trails/concepts/index.md).

{% include [lockbox-and-kms-roles](../../_includes/lockbox/lockbox-and-kms-roles.md) %}

{% note warning %}

Using a {{ kms-full-name }} key each time you access the secret it is encrypted with is charged as a single cryptographic operation. To learn more about the cost of cryptographic operations with keys, see the [Pricing policy for {{ kms-full-name }}](../../kms/pricing.md).

{% endnote %}

## See also

* [{#T}](../security/index.md)
* [{#T}](../tutorials/index.md)
