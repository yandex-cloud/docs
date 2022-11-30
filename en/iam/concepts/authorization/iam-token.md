# IAM token

An IAM token is a unique sequence of characters issued to a user after authentication. The user needs this token for authorization in the {{ yandex-cloud }} API and access to resources.

## Using the token {#use}

{% include [iam-token-usage](../../../_includes/iam-token-usage.md) %}

In the management console and the command line interface (CLI), the token is obtained and used without the user needing to do anything.

## The lifetime {#lifetime}

IAM tokens are valid for a maximum of {{ iam-token-lifetime }}. A token's lifetime is specified in a response from the service that returns the token. For example, the [VM metadata service](../../../compute/operations/vm-connect/auth-inside-vm.md).

To avoid a situation when your token has expired and you don't have a new token yet, request it beforehand.

If you generate a new {{ iam-short-name }} token, the previous one continues to be valid until its lifetime expires.

If a token is created using cookies (for example, under [federated authentication](../../../cli/operations/authentication/federated-user.md)), its lifetime is limited to that of the cookies. If the cookies are revoked (for example, when the user logs out), all the tokens generated for the cookies are canceled.

Recommendations for managing the lifetime of a token:

* Don't use a token for more than 10% of its lifetime. For instance, if your token is valid for {{ iam-token-lifetime }}, request a new one in about an hour.
* It is not a good practice to request a new token too often. Don't request a new token for each operation.

The {{ iam-short-name }} API may return the same token in response to different requests if it's still a long time before it expires.

## Services that support this authentication method {#supported-services}

This authentication method is supported by all services, except for those with AWS-compatible APIs (they only need an IAM token for managing [access keys](access-key.md) and [service accounts](../users/service-accounts.md)).

## Token representation {#iam-token-format}

The following regular expression describes a token:

```javascript
t1\.[A-Z0-9a-z_-]+[=]{0,2}\.[A-Z0-9a-z_-]{86}[=]{0,2}
```

Use regular expressions carefully because the service may update the token format in the future. The update might appear in the documentation with a delay.

{% note tip %}

Updating the token format involves changing its prefix to a value different from `t1.`.

{% endnote %}

Sample token:

```text
t1.7euelSbPyceKx87JqpuRl1qZiY-Ryi3rnpWaksrKaZqUppnLncmDnpeajZvl8_dZNAFl-e8ENXMH_t3z9xljfmT57wQ1cwf-.-LErty1vRh4S__VEp-aDnM5huB5MEfm_Iu1u2IzNgyrn0emiWDYA6rSQXDvzjE0O3HBbUlqoDeCmXYYInzZ6Cg
```

#### See also {#see-also}

{% if product == "yandex-cloud" %}
* [{#T}](../../operations/iam-token/create.md)
{% endif %}
* [{#T}](../../operations/iam-token/create-for-sa.md)
* [{#T}](../../operations/iam-token/create-for-federation.md)
* [{#T}](../../../compute/operations/vm-connect/auth-inside-vm.md)
{% if product == "yandex-cloud" %}
* [{#T}](../../../functions/operations/function-sa.md)
{% endif %}
* [{#T}](./index.md)
