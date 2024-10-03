---
title: CAPTCHA keys in {{ captcha-full-name }}
description: In this article, you will learn what CAPTCHA client and server keys are and what they are used for.
---

# CAPTCHA keys

When you create a CAPTCHA, a pair of keys is generated automatically: a client key and a server key. Once generated when creating a CAPTCHA, these keys never change.

The client key (`client_key`) is used for [adding the {{ captcha-name }} widget](./widget-methods.md) to a website. This is a public key that is specified on the page hosting the widget.

The server key (`server_key`) is used by the website backend to get the [verification results](./validation.md#validation-result) for the user request. The server key is private and should be stored in a secure location, e.g., using [{{ lockbox-full-name }}](../../lockbox/).

{{ captcha-name }} automatically generates a one time token, i.e., a request identifier used when receiving the [verification results](validation.md#validation-result) for the user request. The token is valid for five minutes.

{% note warning %}

Never send your {{ captcha-name }} server key to anyone, store it unencrypted, or allow it to become public. If it did become public, [create a new CAPTCHA](../operations/create-captcha.md) to replace the old one.

{% endnote %}

For more information on how to get the server and client keys, see [{#T}](../operations/get-keys.md).

## Key format {#key-format}

The client key is always prefixed with `ysc1_`, and the server key with `ysc2_`. Their next 20 characters are the same.

Here are some sample keys:

* `client_key` : `ysc1_yzF85********`
* `server_key` : `ysc2_yzF85********`
