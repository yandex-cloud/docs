# Signing requests

Many requests to {{ objstorage-name }} require authentication on the service side, so the user sending a request must sign it.

{{ objstorage-name }} supports AWS Signature V4.

The signing process consists of the following stages:

1. [Generate a signing key](#signing-key-gen)
2. [Generate a string to sign](#string-to-sign-gen)
3. [Sign a string with a key](#signing)

Use [HMAC](https://ru.wikipedia.org/wiki/HMAC) with the [SHA256](https://ru.wikipedia.org/wiki/SHA-2) hash function to sign. Many programming languages support relevant methods. The examples assume that there is a `sign(KEY, STRING)` function that encodes the input string with the specified key.


## Generating a signing key {#signing-key-gen}

To generate a signing key, you need static access keys for {{ objstorage-name }}. To learn how to get them, see [Before you start](./index.md#before-you-begin).

Generate a signing key

1. Use the secret key to encode the date:

    ```
    DateKey = sign("AWS4" + "SecretKey", "yyyymmdd")
    ```

2. Encode the region using the `DateKey` obtained in the previous step:

    ```
    RegionKey = sign(DateKey, "{{ region-id }}")
    ```

3. Encode the service using the `RegionKey` obtained in the previous step:

    ```
    ServiceKey = sign(RegionKey, "s3")
    ```

4. Get a signing key:

    ```
    SigningKey = sign(ServiceKey, "aws4_request")
    ```


## Generate a string to sign {#string-to-sign-gen}

The string to sign (`StringToSign`) depends on the {{ objstorage-name }} usage scenario:

- [Accessing an Amazon S3-compatible API](./index.md) without an SDK or special utilities.
- [Uploading objects using an HTML form](../concepts/presigned-post-forms.md).
- [Signing a URL with query parameters](../concepts/pre-signed-urls.md).

## Sign a string with a key {#signing}

To get a string signature, use `HMAC` with the `SHA256` hash function and convert the result to hexadecimal format.

```
signature = Hex(sign(SigningKey, StringToSign))
```
