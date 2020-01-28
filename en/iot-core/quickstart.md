# Getting started

To get started with {{ iot-name }}:

* [Create X.509 certificates](#create-ca).
* [Create a registry](#create-registry).
* [Create a device](#create-device).
* [Configure messaging between them](#exchange).

## Before you start {#before-you-begin}

1. Go to the [management console]({{ link-console-main }}). Then log in to Yandex.Cloud or sign up if don't already have an account.
2. [On the billing page]({{ link-console-billing }}), make sure that a [billing account](../billing/concepts/billing-account.md) is linked and that its status is `ACTIVE` or `TRIAL_ACTIVE`. If you don't have a billing account, [create one](../billing/quickstart/index.md#create_billing_account).
3. If you don't have a folder, [create one](../resource-manager/operations/folder/create.md).

## Create a certificate {#create-ca}

Devices and registries interact using X.509 certificates:

- If you have a certificate, just add it to the device in the registry.

- If don't have one, you can create a certificate, for example, with [OpenSSL](https://www.openssl.org):

    ```
    $ openssl req -x509 \
    -newkey rsa:4096 \
    -keyout key.pem \
    -out cert.pem \
    -nodes \
    -days 365 \
    -subj '/CN=localhost'
    ```

    Where:
    - `-x509`: X.509 certificate.
    - `newkey`: Encryption algorithm.
    - `-keyout`: File to write the private key to.
    - `-out`: File to save the certificate to.
    - `-nodes`: This flag is set when no public key encryption is required.
    - `-days`: Certificate validity period in days.
    - `-subj`: Request object.

## Create a registry {#create-registry}

{% list tabs %}

- CLI

    {% include [cli-install](../_includes/cli-install.md) %}

    {% include [default-catalogue](../_includes/default-catalogue.md) %}

    To create a [registry](concepts/index.md#registry):

    1. Run the command:

        ```
        $ yc iot registry create --name my-registry
        
        id: b91hafek85hpppnbpld2
        folder_id: aoek49ghmknnpj1ll45e
        created_at: "2019-05-27T13:40:06.923Z"
        name: my-registry
        ```

    2. Add a certificate to the registry:

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

{% endlist %}

## Create a device {#create-device}

{% list tabs %}

- CLI

    {% include [cli-install](../_includes/cli-install.md) %}

    {% include [default-catalogue](../_includes/default-catalogue.md) %}

    To create a [device](concepts/index.md#device):

    1. Run the command:

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

{% endlist %}

## Configure messaging between devices and registries {#exchange}

Find out how to:

- [Send a message](operations/publish.md).
- [Subscribe a device or registry to receive messages](operations/subscribe.md).

## What's next {#what-is-next}

- Read about [service concepts](concepts/index.md).
- Find out how to [work with registries and devices](operations/index.md).

