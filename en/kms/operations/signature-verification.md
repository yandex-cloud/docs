---
title: How to create a digital signature
description: Follow this guide to create a digital signature.
---

# Digital signature and its verification based on data hash

In {{ kms-name }}, you can create a [digital signature](../concepts/digital-signature.md) that can be used to verify data authenticity and integrity, as well as to protect the signed data from modification.

## Getting started {#before-you-begin}

This guide uses [OpenSSL](https://www.openssl.org/) for digital signature verification. If you do not have OpenSSL yet, install it.

{% include [install-openssl](../../_includes/kms/install-openssl.md) %}

## Create a digital signature {#create-signature}

Depending on the size of the message or file to sign, {{ kms-short-name }} enables creating a message signature [using a private key](#message-signing) or a [hash-based](#hash-signing) signature.

### Signing a message with a private key {#message-signing}

{% note info %}

A signature based on a private key is used for messages of up to 32 KB.

{% endnote %}

1. If you do not have a digital signature key pair, [create](./asymmetric-signature-key.md#create) one.

1. Get a signature public key and save it:

    {% list tabs group=instructions %}

    - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) containing the digital signature key pair.
      1. [Navigate]({{ link-console-main }}/link/kms) to **{{ ui-key.yacloud.iam.folder.dashboard.label_kms }}**.
      1. In the left-hand panel, select ![image](../../_assets/kms/asymmetric-key.svg) **{{ ui-key.yacloud.kms.switch_asymmetric-keys }}**.
      1. Navigate to the **{{ ui-key.yacloud.kms.asymmetric-key.form.label_signature }}** tab.
      1. In the key pair row, click ![image](../../_assets/console-icons/ellipsis.svg) and select ![shield-keyhole](../../_assets/console-icons/shield-keyhole.svg) **{{ ui-key.yacloud.kms.asymmetric-keys.action_public-key }}**.
      1. In the window that opens, click ![floppy-disk](../../_assets/console-icons/floppy-disk.svg) **{{ ui-key.yacloud.kms.asymmetric-keys.button_download }}** to download the digital signature public key.

    - CLI {#cli}

      {% include [cli-install](../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../_includes/default-catalogue.md) %}

      1. View the description of the CLI command for getting a signature public key:

          ```bash
          yc kms asymmetric-signature-crypto get-public-key --help
          ```

      1. [Get](../../resource-manager/operations/folder/get-id.md) the ID of the folder containing the digital signature key pair.

      1. {% include [get-signature-key](../../_includes/kms/get-signature-key.md) %}

      1. {% include [cli-get-public-key](../../_includes/kms/cli-get-public-key.md) %}

    {% endlist %}

1. Create a file with a `base64`-encoded message:

    1. Create a text file, e.g., `message.txt`:

        ```bash
        cat > message.txt
        My sample message.
        It will be used to verify ECDSA signature.
        ```

        The message size must not exceed 32 KB.

    1. Change the message encoding to `base64` by specifying the path to the created `base64`-encoded message file:

        ```bash
        base64 message.txt > <base64_message_file>
        ```

1. Create a message signature:

    {% list tabs group=instructions %}

    - CLI {#cli}

      1. View the description of the CLI command for getting a digital signature:

          ```bash
          yc kms asymmetric-signature-crypto sign --help
          ```

      1. Get a digital signature for the message:

          ```bash
          yc kms asymmetric-signature-crypto sign \
            --id <key_pair_ID> \
            --signature-output-file <signature_file_path> \
            --message-file <message_file_path> \
            --inform base64 \
            --outform base64
          ```

          Where:
          
          * `--id`: ID of the digital signature key pair.
          * `--signature-output-file`: Path to the file to save the digital signature to.
          * `--message-file`: Path to the previously created file with the `base64`-encoded message.
          * `--inform`: Message file format. The possible values are `raw` (default), `base64`, and `hex`.
          * `--outform`: Signature file format. The possible values are `raw` (default), `base64`, and `hex`.

          Result:

          ```text
          key_id: abjcg4mhmdfe********
          signature: MAa7C...imw==
          ```

      1. Change the digital signature format to [DER](https://en.wikipedia.org/wiki/X.690#DER_encoding), which is required for `OpenSSL`:

          ```bash
          echo -n "$(< <signature_file_path>)" | base64 -d > <signature_file>
          ```

          Where:
          
          * `<signature_file_path>`: Path to the signature file you got in the previous step.
          * `<signature_file>`: Path to the new signature file in `DER` format.

      The signature file in `DER` format can be used to [verify](#verify-digital-signature) the signature using `OpenSSL`.

    {% endlist %}

## Signing a file using its data hash {#hash-signing}

{% note info %}

A hash-based signature is used for messages or files over 32 KB.

{% endnote %}

1. If you do not have a digital signature key pair, [create](./asymmetric-signature-key.md#create) one.

1. Get a digital signature public key and save it:

    {% list tabs group=instructions %}

    - Management console {#console}

      1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) containing the digital signature key pair.
      1. [Navigate]({{ link-console-main }}/link/kms) to **{{ ui-key.yacloud.iam.folder.dashboard.label_kms }}**.
      1. In the left-hand panel, select ![image](../../_assets/kms/asymmetric-key.svg) **{{ ui-key.yacloud.kms.switch_asymmetric-keys }}**.
      1. Navigate to the **{{ ui-key.yacloud.kms.asymmetric-key.form.label_signature }}** tab.
      1. In the key pair row, click ![image](../../_assets/console-icons/ellipsis.svg) and select ![shield-keyhole](../../_assets/console-icons/shield-keyhole.svg) **{{ ui-key.yacloud.kms.asymmetric-keys.action_public-key }}**.
      1. In the window that opens, click ![floppy-disk](../../_assets/console-icons/floppy-disk.svg) **{{ ui-key.yacloud.kms.asymmetric-keys.button_download }}** to download the signature public key.

    - CLI {#cli}

      {% include [cli-install](../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../_includes/default-catalogue.md) %}
  
      1. View the description of the CLI command for getting a signature public key:

          ```bash
          yc kms asymmetric-signature-crypto get-public-key --help
          ```

      1. [Get](../../resource-manager/operations/folder/get-id.md) the ID of the folder containing the digital signature key pair.

      1. {% include [get-signature-key](../../_includes/kms/get-signature-key.md) %}
      
      1. {% include [cli-get-public-key](../../_includes/kms/cli-get-public-key.md) %}

    {% endlist %}

1. Get the file hash:

    {% list tabs group=programming_language %}

    - Bash {#bash}

      Run this command:

      ```bash
      echo -n \
        $(<hashing_algorithm> <source_file_path> | cut -d " " -f 1) > \
        <hash_file_path>
      ```

      Where:
      
      * `<hashing_algorithm>`: Hashing algorithm used when creating a digital signature key pair. The hashing algorithm is specified above in the `SIGNATURE ALGORITHM` field of the results you get with the list of key pairs. The possible values are as follows:
          
          * `sha256sum`: For SHA-256 algorithms.
          * `sha384sum`: For SHA-384 algorithms.
          * `sha512sum`: For SHA-512 algorithms.
      
      * `<path_to_source_file>`: Path to the file to hash.
      * `<path_to_hash_file>`: Path to the file to save the hash to.

    - PowerShell {#powershell}

      Run this command:

      ```powershell
      (Get-FileHash -Path <source_file_path> -Algorithm <hashing_algorithm>).Hash.ToLower() | `
        Out-File -FilePath <hash_file_path> `
        -encoding ASCII `
        -NoNewline
      ```

      Where:
      
      * `<hashing_algorithm>`: Hashing algorithm used when creating a signature key pair. The hashing algorithm is specified above in the `SIGNATURE ALGORITHM` field of the results you get with the list of key pairs. The possible values are as follows:
          
          * `SHA256`: For SHA-256 algorithms.
          * `SHA384`: For SHA-384 algorithms.
          * `SHA512`: For SHA-512 algorithms.
      
      * `<path_to_source_file>`: Path to the file to hash.
      * `<path_to_hash_file>`: Path to the file to save the hash to.

    This will create a text file containing the hash of the source file.

    {% endlist %}

1. Create a hash-based file signature:

    {% list tabs group=instructions %}

    - CLI {#cli}

      1. View the description of the CLI command for getting a hash-based digital signature:

          ```bash
          yc kms asymmetric-signature-crypto sign-hash --help
          ```

      1. [Get](../../resource-manager/operations/folder/get-id.md) the ID of the folder containing the digital signature key pair.

      1. {% include [get-signature-key](../../_includes/kms/get-signature-key.md) %}

      1. Get a hash-based digital signature:

          ```bash
          yc kms asymmetric-signature-crypto sign-hash \
            --id <key_pair_ID> \
            --signature-output-file <signature_file_path> \
            --message-hash-file <hash_file_path> \
            --inform hex
          ```

          Where:
          
          * `--id`: ID of the digital signature key pair.
          * `--signature-output-file`: Path to the file to save the digital signature to.
          * `--message-hash-file`: Path to the previously created hash file.
          * `--inform`: Hash file format. Our example uses the common `hex` format that is supported by all platforms. The possible values are `raw` (default), `base64`, and `hex`.

          Result:

          ```text
          signature: W7V8A...22g==
          ```

    {% endlist %}

## Verify the digital signature {#verify-digital-signature}

### ECDSA signature {#ecdsa-verification}

{% include [signature-verification-ecdsa](../../_includes/kms/signature-verification-ecdsa.md) %}

### RSA signature {#rca-verification}

{% include [signature-verification-rsa](../../_includes/kms/signature-verification-rsa.md) %}
