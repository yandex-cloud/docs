---
title: "Getting started with {{ iot-name }} brokers"
description: "To start working with {{ iot-name }}, create an X.509 certificate and a broker. Then, set up message exchange."
---

# Getting started with {{ iot-name }} brokers

To get started with {{ iot-name }}:

1. [Create an X.509 certificate](#create-ca).
1. [Create a broker](#create-broker).
1. [Set up message exchange](#exchange).

{% include [note-pp](../_includes/iot-core/note-pp.md) %}

## Getting started {#before-you-begin}

{% include [before-you-begin](../_tutorials/_tutorials_includes/before-you-begin.md) %}

## Create a certificate for the {#create-ca} broker

If you have a certificate, add it to the broker after [creation](#create-broker). If you do not have a certificate, create it using the [OpenSSL](https://www.openssl.org) program:

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

## Create a broker {#create-broker}

{% list tabs %}

- Management console

   1. In the [management console]({{ link-console-main }}), select the folder where you want to create a broker.
   1. Select **{{ ui-key.yacloud.iam.folder.dashboard.label_iot-core }}**.
   1. In the left-hand panel, select **{{ ui-key.yacloud.iot.label_brokers }}**.
   1. Click **{{ ui-key.yacloud.iot.button_create-broker }}**.
   1. Under **General information**, specify the broker name: `my-broker`.
   1. Add certificates:

      * To add a file:

         1. Choose the **{{ ui-key.yacloud.component.file-content-dialog.value_upload }}** method.
         1. Click **Attach file**.
         1. Select the file with the public key of the certificate and click **Open**.
         1. Click **{{ ui-key.yacloud.component.file-content-dialog.button_submit }}**.

      * To add text:

         1. Choose the **{{ ui-key.yacloud.component.file-content-dialog.value_manual }}** method.
         1. Paste the public key of the certificate into the **{{ ui-key.yacloud.component.file-content-dialog.field_content }}** field.
         1. Click **{{ ui-key.yacloud.component.file-content-dialog.button_submit }}**.

   1. Click **Create**.

- CLI

   {% include [cli-install](../_includes/cli-install.md) %}

   {% include [default-catalogue](../_includes/default-catalogue.md) %}

   1. Create a broker:

      ```bash
      yc iot broker create --name my-broker
      ```

      Result:

      ```text
      id: b91ki3851h**********
      folder_id: aoek49ghmk*********
      created_at: "2022-05-28T11:29:42.420Z"
      name: my-broker
      ```

   1. Make sure the broker was created:

      ```bash
      yc iot broker list
      ```

      Result:

      ```text
      +----------------------+-------------+
      |          ID          |    NAME     |
      +----------------------+-------------+
      | b91ki3851h********** |  my-broker  |
      +----------------------+-------------+
      ```

   1. Add the certificate to the broker:

      ```bash
      yc iot broker certificate add \
         --broker-name my-broker \
         --certificate-file cert.pem
      ```

      Where:

      * `--broker-name`: Broker name.
      * `--certificate-file`: Path to the public key of the certificate.

      Result:

      ```text
      broker_id: b91ki3851h**********
      fingerprint: 1f21cf6d0183d****
      certificate_data: |
         -----BEGIN CERTIFICATE-----
         MIIEpDCCAow...
         -----END CERTIFICATE-----
      created_at: "2023-07-11T16:20:53.466370019Z"
      ```

{% endlist %}

## Set up message exchange {#exchange}

Find out how to:

* [Subscribe to receive messages in a broker](operations/subscribe.md#broker).
* [Sending a message in a broker](operations/publish.md#broker).

## What's next {#what-is-next}

* Read about [service concepts](concepts/index.md).
* Learn how to [work with brokers](operations/index.md#broker).
