# Getting started with {{ kms-name }}

{% note info %}

The service is only available on request: to request access, fill in the [form](https://cloud.yandex.ru/services/kms#request-access).

{% endnote %}

In this guide, you create your first [key](../concepts/index.md) and encrypt and decrypt text using the {{ kms-short-name }} REST API.

## Before you start {#before-you-begin}

To start working with {{ kms-name }}:

* Set up Yandex.Cloud:
  1. Log in to the [management console]({{link-console-main}}). If you aren't registered, go to the management console and follow the instructions.
  1. [On the billing page](https://console.cloud.yandex.ru/billing), make sure you linked a [payment account](../../billing/concepts/billing-account.md), and it has the `ACTIVE` or `TRIAL_ACTIVE` status. If you don't have a billing account, [create one](../../billing/quickstart/index.md#create_billing_account).
  1. Make sure that you have the `owner` or `editor` role for the cloud.
* Configure your local environment (you need the Bash shell):
  1. {% include [cli-install](../../_includes/cli-install.md) %}
  1. Download scripts with commands to access the service API: [kms-encrypt.sh, kms-decrypt.sh, and kms-client.sh](https://github.com/yandex-cloud/examples/tree/master/kms/quickstart).
  1. Install [jq](https://stedolan.github.io/jq/download/), a utility used in scripts to work with JSON responses from the service.

## Create a symmetric encryption key {#create-key}

You can create a key in the management console:

1. Go to the [management console]({{link-console-main}}) and select {{ kms-name }}.
1. In the **Keys** tab, click **Create** and set the key attributes:
   * Name, such as <q>myFirstKey</q>.
   * Encryption algorithm, such as AES-256.
   * Leave the rotation period as <q>No rotation</q>.
   * Click **Create**.
1. Click the line with the key name and make sure the **Versions** section contains the first key version.

## Encrypt text using the key {#encrypt}

Come up with a secret text, for example <q>The launch is scheduled for Marchember 42.</q>. The text size must not exceed 32 KB. To encrypt large volumes of data, use [envelope encryption](../concepts/encryption.md#envelope-encryption).

Encrypt the text:

1. Copy the ID of the created key from the management console.
1. Go to the folder containing the `kms-encrypt.sh`, `kms-decrypt.sh`, and `kms-client.sh` scripts.
1. Run the encryption command (`"foo=bar"` is the [AAD context](../concepts/encryption.md#aad), an additional check on decryption):

   ```bash
   $ echo "The launch is scheduled for Marchember 42." > plaintext.txt >
   $ ./kms-encrypt.sh <your key ID> "foo=bar" `cat plaintext.txt | base64` > ciphertext.txt
   ```
1. The result is the `ciphertext.txt` file containing the BASE64-encoded encrypted text.

## Decrypt the text {#decrypt}

To decrypt the text, you need access to the {{ kms-short-name }} key and know the AAD context (if specified at encryption).

1. Copy the ID of the key from the management console.
1. Go to the folder containing the `kms-encrypt.sh`, `kms-decrypt.sh`, and `kms-client.sh` scripts.
1. Run the decryption command (the decrypted text will be output to the terminal):

   ```bash
   $ ./kms-decrypt.sh <your key ID> "foo=bar" `cat ciphertext.txt` | base64 --decode
   The launch is scheduled for Marchember 42.
   ```

#### See also {#see-also}

- [Key rotation](../operations/key.md#rotate)
- [Change the default key version](../operations/version.md#make-primary)

