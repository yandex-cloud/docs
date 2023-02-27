# Authentication

There are two authentication methods:
* [Using X.509 certificates](#certs).
* [Using a username and password](#log-pass).

You can use both X.509 certificates and passwords at the same time. Note that passwords have a higher priority than certificates. The table below describes different ways to use a certificate and password simultaneously during authentication.

| Certificate | Password | Authentication |
|----|----|----|
| Invalid | Invalid | Authentication fails. |
| Invalid | Correct | Authentication is successful. |
| Correct | Invalid | Authentication fails. |
| Correct | Correct | Authentication using a username and password is successful. |
| Correct, <br>but for a different device | Correct | Authentication is performed on behalf of the device, the ID of which is specified in the username. |


## Authentication using certificates {#certs}

When authenticating with X.509 certificates, private keys and certificates stored as .pem files are used. They are stored on a device or in a registry.
* For a private key, you specify the path to the .pem file when sending messages or subscribing to receive messages.
* You add the certificate to the device or registry and specify the path to the .pem file with the certificate when sending messages or subscribing to receive messages.

Each certificate must be unique. You can't add the same certificate to two different [devices](./index.md#device) or a device and a [registry](./index.md#registry). To [send](../operations/publish.md) and [receive](../operations/subscribe.md) messages in a [topic](topic/index.md), you need to use two different certificates.

{% include [mqtt-note](../../_includes/iot-core/mqtt-note.md) %}

## Authenticating by username and password {#log-pass}

When authenticating with your username and password:
* The username is the ID of the device or registry.
* The password is a combination of characters that you specify. You can also generate your password via the YC CLI.
   * Minimum password length is 14 characters.
   * The password must contain 3 out of 4 groups of characters: lowercase Latin letters, uppercase Latin letters, numbers, and special characters.

#### See also {#see-also}

* [{#T}](../concepts/index.md).
* [{#T}](../operations/certificates/create-certificates.md).
* [{#T}](../operations/certificates/device-certificates.md).
* [{#T}](../operations/certificates/registry-certificates.md).
* [{#T}](../operations/password/device-password.md).
* [{#T}](../operations/password/registry-password.md).