# Getting started

To start exchanging data between your devices:

- [Create certificates for a registry and device](#create-ca).
- [Create a registry and add a certificate to it](#create-registry).
- [Create a device in the registry and add a certificate to it](#create-device).
- [Connect to the MQTT broker](#connect-mqtt-broker).

## Before you start {#before-begin}

To get started, you will need:

1. A folder in Yandex.Cloud. If you don't have a folder yet, create one:

    {% include [create-folder](../_includes/create-folder.md) %}

1. A command line interface: [Yandex CLI](../cli/quickstart.md).

1. A certificate from the certificate authority (CA): {{ ca-address }}.

1. [Registry and device certificates](quickstart.md#create-ca).

## Creating a certificate {#create-ca}

For devices and registries to interact, you must have X.509 certificates:

- If you have a certificate, just add it to the device in the registry.

- If not, you can create a certificate, for example, with [OpenSSL](https://www.openssl.org):

    ```
    $ openssl req -x509 \ # X.509 certificate.
    -newkey rsa:4096 \ # Encryption algorithm.
    -keyout key.pem \ # File to write the private key to.
    -out cert.pem \ # File to save the certificate to.
    -nodes \ # This flag is set when no public key encryption is required.
    -days 365 \ # Certificate validity period in days.
    -subj '/CN=localhost' # Request object.
    ```

## Creating a registry {#create-registry}

1. Create a registry:

    ```
    $ yc iot registry create --name my-registry
    
    id: b91hafek85hpppnbpld2
    folder_id: aoek49ghmknnpj1ll45e
    created_at: "2019-05-27T13:40:06.923Z"
    name: my-registry
    ```

1. Add a certificate to the registry:

    ```
    $ yc iot registry certificate add \
    --registry-name my-registry \ # Registry name.
    --certificate-file ./certs/registry-cert.pem # Path to the public part of the certificate.
    
    registry_id: b91hafek85hpppnbpld2
    fingerprint: 589ce16050****
    certificate_data: |
      -----BEGIN CERTIFICATE-----
      MIIE/jCCAuagAwIBAgIJAPRA...
      -----END CERTIFICATE-----
    created_at: "2019-05-27T13:41:45.295Z"
    ```

## Creating a device {#create-device}

1. Create a device:

    ```
    $ yc iot device create \
    --registry-name my-registry \ # Registry name.
    --name my-device # Device name.
    
    id: b912an77oqaeijolmlgm
    registry_id: b91hafek85hpppnbpld2
    created_at: "2019-05-27T13:44:35.164Z"
    name: my-device
    ```

1. Add a certificate to the device:

    ```
    $ yc iot device certificate add \
    --device-name my-device \ # Device name.
    --certificate-file ./certs/device-cert.pem # Path to the public part of the certificate.
    
    device_id: b912an77oqaeijolmlgm
    fingerprint: 65e5b05006...
    certificate_data: |
      -----BEGIN CERTIFICATE-----
     MIIE/jCCAuagAwIBAgIJANZbq...
      -----END CERTIFICATE-----
    created_at: "2019-05-27T13:45:23.306Z"
    ```


## Configure message exchange between devices and registers {#exchange}

Learn how to:
- [Sending messages](operations/publish.md).
- [Subscribing a device or registry to receive messages](operations/subscribe.md).

## What's next {#what-is-next}

- Read about [service concepts](concepts/index.md).
- See how to [work with registries and devices](operations/index.md).
