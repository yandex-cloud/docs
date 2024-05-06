# Signing requests


Many requests to {{ objstorage-name }} require authentication on the service side, so the user sending a request must sign it.

{{ objstorage-name }} supports [AWS Signature V4](https://docs.aws.amazon.com/AmazonS3/latest/API/sig-v4-authenticating-requests.html).

The signing process consists of the following stages:

1. [Generating a string to sign](#string-to-sign-gen).
1. [Generating a signing key](#signing-key-gen).
1. [Signing a string with a key](#signing).

Use [HMAC](https://ru.wikipedia.org/wiki/HMAC) with the [SHA256](https://ru.wikipedia.org/wiki/SHA-2) hash function to sign. Many programming languages support relevant methods. The examples assume that there is a `sign(KEY, STRING)` function that encodes the input string with the specified key.

## Generate a string to sign {#string-to-sign-gen}

The string to sign (`StringToSign`) depends on the {{ objstorage-name }} usage scenario:

* [Accessing an Amazon S3-compatible API](./index.md) without an SDK or special utilities.
* [Uploading objects using an HTML form](../concepts/presigned-post-forms.md).
* [Signing a URL with query parameters](../concepts/pre-signed-urls.md).


## Generating a signing key {#signing-key-gen}

{% include [generate-signing-key](../../_includes/storage/generate-signing-key.md) %}

## Sign a string with a key {#signing}

To get a string signature, use `HMAC` with the `SHA256` hash function and convert the result to hexadecimal format.

```text
signature = Hex(sign(SigningKey, StringToSign))
```

See the [code examples](../concepts/pre-signed-urls.md#code-examples) for signature generation in [{#T}](../concepts/pre-signed-urls.md).