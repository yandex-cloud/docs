# Getting started with {{ kms-name }}

In this guide, you create your first [key](../concepts/index.md) and encrypt and decrypt text using the {{ kms-short-name }}.

## Before you start {#before-you-begin}

To get started with {{ kms-name }}:

1. Log in to the [management console]({{ link-console-main }}). If you aren't registered, go to the management console and follow the instructions.
{% if product == "yandex-cloud" %}
1. [On the billing page]({{ link-console-billing }}), make sure you linked a [billing account](../../billing/concepts/billing-account.md) and it has the `ACTIVE` or `TRIAL_ACTIVE` status. If you don't have a billing account, [create one](../../billing/quickstart/index.md#create_billing_account).
{% endif %}
1. Make sure that you have the `owner` or `editor` role for the cloud.
1. If you don't have the {{ yandex-cloud }} (CLI) command line interface yet, [install and initialize it](../../cli/quickstart#install).

## Create a symmetric encryption key {#create-key}

{% list tabs %}

- Management console

   Create a symmetric encryption key:
   1. In the [management console]({{ link-console-main }}), select the folder where you want to create a key.
   1. Select {{ kms-name }}.
   1. Click **Create** and set the key parameters:
      * In the **Name** field, enter `my-first-key`.
      * In the **Encryption algorithm** field, specify `AES-256`.
      * In the **Rotation period, days** field, leave the value `No rotation`.
      * Click **Create**.
   1. Click the line with the key name and make sure the **Versions** section contains the first key version.

{% endlist %}

## Encrypt text using the key {#encrypt}

Come up with a secret text, for example <q>The launch is scheduled for Marchember 42.</q>. The text size must not exceed 32 KB. To encrypt large volumes of data, use [envelope encryption](../concepts/encryption.md#envelope-encryption).

{% list tabs %}

- CLI

   Encrypt the text:

   1. Save the secret text to the `plaintext.txt` file.
   1. Copy the ID of the previously created key from the management console.
      1. In the [management console]({{ link-console-main }}), go to the folder where the key was created.
      1. Select {{ kms-name }}.
      1. In the window that opens, copy the key from the **ID** field.
   1. Encrypt the text:

      ```
      yc kms symmetric-crypto encrypt \
       --id <key ID> \
       --plaintext-file plaintext.txt \
       --ciphertext-file ciphertext
      ```

   The result is a binary file named `ciphertext` containing ciphertext.

{% endlist %}

## Decrypt the text {#decrypt}

Decrypt the `ciphertext` binary file from the previous step.

{% list tabs %}

- CLI

   Decrypt the text:

   ```
   yc kms symmetric-crypto decrypt \
   --id <key ID> \
   --ciphertext-file ciphertext \
   --plaintext-file decrypted.txt
   ```

   As a result, the `ciphertext` file is decrypted and the following decrypted text is written to the `decrypted.txt` file: <q>The launch is scheduled for Marchember 42.</q>.

{% endlist %}

#### See also {#see-also}

* [Updating keys](../operations/key.md#update)
* [Rotating keys](../operations/key.md#rotate)
* [Changing the default key version](../operations/version.md#make-primary)
