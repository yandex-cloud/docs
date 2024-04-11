# IAM token

An IAM token is a unique sequence of characters issued to a user after authentication.

## Using the token {#use}

{% include [iam-token-usage](../../../_includes/iam-token-usage.md) %}

To work with {{ TF }}, [add an IAM token to environment variables](../../../tutorials/infrastructure-management/terraform-quickstart.md#get-credentials) or specify it in the [provider configuration file](../../../tutorials/infrastructure-management/terraform-quickstart.md#configure-provider):

```
provider "yandex" {
  token = "<IAM_token>"
}
```

In case you work in the management console or the command line interface (CLI), you do not need to do anything to obtain and use a token.

## Lifetime {#lifetime}

IAM tokens are valid for a maximum of {{ iam-token-lifetime }}. A token's lifetime is specified in a response from the service that returns the token, e.g., the [VM metadata service](../../../compute/operations/vm-connect/auth-inside-vm.md).

To avoid situations when your token has expired and you do not have a new token yet, request it beforehand.

If you generate a new {{ iam-short-name }} token, the previous one continues to be valid until its lifetime expires.

If a token is created using cookies (for example, under [federated authentication](../../../cli/operations/authentication/federated-user.md)), its lifetime is limited to that of the cookies. If the cookies are revoked (for example, when the user logs out), all the tokens generated for the cookies are canceled.

The {{ iam-short-name }} API may return the same token in response to different requests if it is still a long time before it expires.

## Services that support this authentication method {#supported-services}

This authentication method is supported by all services, except for those with AWS-compatible APIs. Such services require an IAM token only for managing [access keys](access-key.md) and [service accounts](../users/service-accounts.md).

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

* [{#T}](../../operations/iam-token/create.md)
* [{#T}](../../operations/iam-token/create-for-sa.md)
* [{#T}](../../operations/iam-token/create-for-federation.md)
* [{#T}](../../../compute/operations/vm-connect/auth-inside-vm.md)
* [{#T}](../../../functions/operations/function-sa.md)
* [{#T}](./index.md)
