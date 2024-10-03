---
title: Getting started with {{ iot-full-name }} device registries
description: To get started with {{ iot-name }}, create an X.509 certificate, registry, and device. Then, set up message exchange between the registry and the device.
---

# Getting started with {{ iot-name }} device registries

To start using the {{ iot-name }} service, create the following:

1. [X.509 certificates](#create-ca)
1. [Registry](#create-registry)
1. [Device](#create-device)

Then, [set up message exchange](#exchange) between the device and the registry.

## Getting started {#before-you-begin}

{% include [before-you-begin](../_tutorials/_tutorials_includes/before-you-begin.md) %}

## Create a certificate {#create-ca}

X.509 certificates enable interaction between MQTT clients: the [registry](concepts/index.md#registry) and [device](concepts/index.md#device). Each of them needs its certificate.

* If you have certificates, add them to the MQTT clients. You can do this when creating clients.
* If you do not have certificates, create them using the [OpenSSL](https://www.openssl.org) program (the command below creates only one certificate):

   ```bash
   openssl req -x509 \
   -newkey rsa:4096 \
     -keyout private-key.pem \
     -out cert.pem \
     -nodes \
     -days 365 \
     -subj '/CN=localhost'
   ```

   Where:

   * `-x509`: Certificate type, X.509.
   * `-newkey`: Encryption algorithm.
   * `-keyout`: File with the private key of the certificate.
   * `-out`: File with the public key of the certificate.
   * `-nodes`: This flag is set when no public key encryption is required.
   * `-days`: Certificate validity period in days.
   * `-subj`: Request object.

   For each of the MQTT clients, specify different names for files with private and public keys.

## Create a registry {#create-registry}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select the folder to create your registry in.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_iot-core }}**.
   1. In the left-hand panel, select **{{ ui-key.yacloud.iot.label_registries }}**.
   1. Click **{{ ui-key.yacloud.iot.button_create-registry }}**.
   1. Under **{{ ui-key.yacloud.common.section-base }}**, add `my-registry` as the registry name.
   1. Add a certificate:

      * To add a file:

         1. Choose the `{{ ui-key.yacloud.component.file-content-dialog.value_upload }}` method.
         1. Click **Attach file**.
         1. Select the file with the public key of the certificate and click **Open**.
         1. Click **{{ ui-key.yacloud.component.file-content-dialog.button_submit }}**.

      * To add text:

         1. Choose the `{{ ui-key.yacloud.component.file-content-dialog.value_manual }}` method.
         1. Paste the public key of the certificate to the **{{ ui-key.yacloud.component.file-content-dialog.field_content }}** field.
         1. Click **{{ ui-key.yacloud.component.file-content-dialog.button_submit }}**.

   1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

   {% include [cli-install](../_includes/cli-install.md) %}

   {% include [default-catalogue](../_includes/default-catalogue.md) %}

   1. Create a registry:

      ```bash
      yc iot registry create --name my-registry
      ```

      Result:

      ```text
      id: b91hafek85**********
      folder_id: aoek49ghmk*********
      created_at: "2019-05-27T13:40:06.923Z"
      name: my-registry
      status: ACTIVE
      log_group_id: ckghotead**********
      ```

   1. Add a certificate to the registry:

      ```bash
      yc iot registry certificate add \
        --registry-name my-registry \
        --certificate-file registry-cert.pem
      ```

      Where:

      * `--registry-name`: Registry name.
      * `--certificate-file`: Path to the public key of the certificate.

      Result:

      ```text
      registry_id: b91hafek85**********
      fingerprint: 589ce16050****
      certificate_data: |
         -----BEGIN CERTIFICATE-----
         MIIE/jCCAuagAwIBAgIJAPRA...
         -----END CERTIFICATE-----
      created_at: "2019-05-27T13:41:45.295Z"
      ```

{% endlist %}

## Create a device {#create-device}

{% list tabs group=instructions %}

- Management console {#console}

   1. In the [management console]({{ link-console-main }}), select a folder to create a device in.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_iot-core }}**.
   1. Select `my-registry` from the list.
   1. On the left side of the window, select the **{{ ui-key.yacloud.iot.label_devices }}** section.
   1. Click **{{ ui-key.yacloud.iot.button_add-device }}**.
   1. Under **{{ ui-key.yacloud.common.section-base }}**, add `my-device` as the device name.
   1. Add a certificate:

      * To add a file:

         1. Choose the `{{ ui-key.yacloud.component.file-content-dialog.value_upload }}` method.
         1. Click **Attach file**.
         1. Select the file with the public key of the certificate and click **Open**.
         1. Click **{{ ui-key.yacloud.component.file-content-dialog.button_submit }}**.

      * To add text:

         1. Choose the `{{ ui-key.yacloud.component.file-content-dialog.value_manual }}` method.
         1. Paste the public key of the certificate to the **{{ ui-key.yacloud.component.file-content-dialog.field_content }}** field.
         1. Click **{{ ui-key.yacloud.component.file-content-dialog.button_submit }}**.

   1. Click **{{ ui-key.yacloud.common.create }}**.

- CLI {#cli}

   1. Create a device:

      ```bash
      yc iot device create \
        --registry-name my-registry \
        --name my-device
      ```

      Where:

      * `--registry-name`: Name of the registry that the device is part of.
      * `--name`: Device name.

      Result:

      ```text
      id: b912an77oq**********
      registry_id: b91hafek85**********
      created_at: "2019-05-27T13:44:35.164Z"
      name: my-device
      ```

   1. Add a certificate to the device:

      ```bash
      yc iot device certificate add \
        --device-name my-device \
        --certificate-file ./certs/device-cert.pem
      ```

      Where:

      * `--device-name`: Device name.
      * `--certificate-file`: Path to the public key of the certificate.

      Result:

      ```text
      device_id: b912an77oq**********
      fingerprint: 65e5b05006***
      certificate_data: |
         -----BEGIN CERTIFICATE-----
         MIIE/jCCAuagAwIBAgIJANZbq...
         -----END CERTIFICATE-----
      created_at: "2019-05-27T13:45:23.306Z"
      ```

{% endlist %}

## Set up message exchange between the device and the registry {#exchange}

1. [Subscribe a device or registry to receive messages](operations/subscribe.md).
1. [Send a message](operations/publish.md).

## What's next {#what-is-next}

* Read about [service concepts](concepts/index.md).
* Find out how to [work with registries and devices](operations/index.md).
