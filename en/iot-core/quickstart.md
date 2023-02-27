---
title: "Getting started with {{ iot-full-name }}"
description: "In this tutorial, you will learn how to create X509 certificates and configure messaging between devices and registries using {{ iot-full-name }}."
---

# Getting started with {{ iot-name }}

To get started with {{ iot-name }}:

* [Create X.509 certificates](#create-ca).
* [Create a registry](#create-registry).
* [Create a device](#create-device).
* [Configure messaging between them](#exchange).

## Before you begin {#before-you-begin}

1. Go to the [management console]({{ link-console-main }}) and log in to {{ yandex-cloud }} or register if you don't have an account yet.
{% if product == "yandex-cloud" %}
1. [On the billing page]({{ link-console-billing }}), make sure you linked a [billing account](../billing/concepts/billing-account.md) and it has the `ACTIVE` or `TRIAL_ACTIVE` status. If you do not yet have a billing account, [create one](../billing/quickstart/index.md#create_billing_account).
{% endif %}
1. If you do not have any folder, [create one](../resource-manager/operations/folder/create.md).

## Create a certificate {#create-ca}

Devices and registries interact using X.509 certificates:

* If you have a certificate, just add it to the device in the registry.
* If you don't have one, you can create a certificate with [OpenSSL](https://www.openssl.org), for instance:

   ```
   openssl req -x509 \
   -newkey rsa:4096 \
     -keyout key.pem \
     -out cert.pem \
     -nodes \
     -days 365 \
     -subj '/CN=localhost'
   ```

   Where:

   * `-x509`: X.509 certificate.
   * `newkey`: Encryption algorithm.
   * `-keyout`: File to write the private key to.
   * `-out`: File to save the certificate to.
   * `-nodes`: This flag is set when no public key encryption is required.
   * `-days`: Certificate validity period in days.
   * `-subj`: Request object.

## Create a registry {#create-registry}

{% list tabs %}

- Management console

   To create a registry:

   1. In the [management console]({{ link-console-main }}), select the folder where you wish to create your registry.
   1. Select **{{ iot-short-name }}**.
   1. Click **Create registry**.
   1. Under **General information**, add:
      * A **name** for the registry. For example, `my-registry`.
      * (optional) A **description** with further information about the registry.
      * A **password** that you will be using for registry access.<br/>You can use a [password generator](https://passwordsgenerator.net/) to create one.<br/>Make sure to save the password: you will need it later.
      * (optional) To assign a label to the registry, fill in the **Key** and **Value** fields and click **Add label**.
   1. (optional) Add [certificates](operations/certificates/create-certificates.md):
      * To add a file:
         1. Choose the **File** method.
         1. Click **Select file**.
         1. Specify the certificate file on your computer and click **Open**.
         1. Click **Add**.
      * To add text:
         1. Choose the **Text** method.
         1. Insert the certificate body in the **Contents** field.
         1. Click **Add**.
   1. Click **Create**.

- CLI

   {% include [cli-install](../_includes/cli-install.md) %}

   {% include [default-catalogue](../_includes/default-catalogue.md) %}

   To create a [registry](concepts/index.md#registry):
   1. Run the following command:

      ```
      yc iot registry create --name my-registry
      ```

      Result:

      ```
      id: b91hafek85hpppnbpld2
      folder_id: aoek49ghmknnpj1ll45e
      created_at: "2019-05-27T13:40:06.923Z"
      name: my-registry
      ```

   1. Add a certificate to the registry:

      ```
      yc iot registry certificate add \
        --registry-name my-registry \ # Registry name.
        --certificate-file ./certs/registry-cert.pem # Path to the public part of the certificate.
      ```

      Result:

      ```
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

- Management console

   To create a device:

   1. In the [management console]({{ link-console-main }}), select a folder where you wish to create a device.
   1. Select **{{ iot-short-name }}**.
   1. Select the desired registry from the list.
   1. In the left part of the window, select **Devices**.
   1. Click **Add device**.
   1. Under **General information**, add:
      * **Name** of the device. For example, `my-device`.
      * (optional) A **description** with further information about the device.
      * A **password** that you will be using for device access.<br/>You can use a [password generator](https://passwordsgenerator.net/) to create one.<br/>Make sure to save the password: you will need it later.
   1. (optional) Add [aliases](concepts/topic/usage.md#aliases):
      1. Click **Add alias**.
      1. Complete the fields: enter an alias (such as, `events`) and topic type after `$devices/<deviceID>` (such as, `events`).<br/>You can use the `events` alias to replace `$devices/<deviceID>/events`.
   1. (optional) Add [certificates](operations/certificates/create-certificates.md):
      * To add a file:
         1. Choose the **File** method.
         1. Click **Select file**.
         1. Specify the certificate file on your computer and click **Open**.
         1. Click **Add**.
      * To add text:
         1. Choose the **Text** method.
         1. Insert the certificate body in the **Contents** field.
         1. Click **Add**.
   1. Click **Create**.

- CLI

   {% include [cli-install](../_includes/cli-install.md) %}

   {% include [default-catalogue](../_includes/default-catalogue.md) %}

   To create a [device](concepts/index.md#device):
   1. Run the following command:

      ```
      yc iot device create \
        --registry-name my-registry \ # Registry name.
        --name my-device # Device name.
      ```

      Result:

      ```
      id: b912an77oqaeijolmlgm
      registry_id: b91hafek85hpppnbpld2
      created_at: "2019-05-27T13:44:35.164Z"
      name: my-device
      ```

   1. Add a certificate to the device:

      ```
      yc iot device certificate add \
        --device-name my-device \ # Device name.
        --certificate-file ./certs/device-cert.pem # Path to the public part of the certificate.
      ```

      Result:

      ```
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
* [Send a message](operations/publish.md).
* [Subscribe a device or registry to receive messages](operations/subscribe.md).

## What's next {#what-is-next}

* Read about [service concepts](concepts/index.md).
* Find out how to [work with registries and devices](operations/index.md).
