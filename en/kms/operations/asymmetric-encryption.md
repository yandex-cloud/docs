# Asymmetric data encryption

{% note info %}

{% include [preview-pp.md](../../_includes/preview-pp.md) %}

{% endnote %}

In this section, you will learn how to use {{ kms-short-name }} to encrypt and decrypt data using [asymmetric encryption](../concepts/asymmetric-encryption.md).

## Getting started {#before-you-begin}

In this tutorial, encryption is performed using the [OpenSSL](https://www.openssl.org/) utility. If you do not have OpenSSL yet, install it.

{% include [install-openssl](../../_includes/kms/install-openssl.md) %}

## Encrypt data {#encryption}

1. If you do not have an encryption key pair, [create](./asymmetric-encryption-key.md#create) one.

1. Get a public encryption key and save it:

   {% list tabs %}

   - Management console

      1. In the [management console]({{ link-console-main }}), select the [folder](../../resource-manager/concepts/resources-hierarchy.md#folder) with the appropriate key pair.
      1. In the list of services, select **{{ ui-key.yacloud.iam.folder.dashboard.label_kms }}**.
      1. In the left-hand panel, select ![image](../../_assets/kms/asymmetric-key.svg) **{{ ui-key.yacloud.kms.switch_asymmetric-keys }}**.
      1. Go to the **{{ ui-key.yacloud.kms.asymmetric-key.form.label_encryption }}** tab.
      1. In the line with the appropriate key pair, click ![image](../../_assets/horizontal-ellipsis.svg) and select **{{ ui-key.yacloud.kms.asymmetric-keys.action_public-key }}**.
      1. In the window that opens, click **{{ ui-key.yacloud.kms.asymmetric-keys.button_download }}** to download a public encryption key.

   - CLI

      {% include [cli-install](../../_includes/cli-install.md) %}

      {% include [default-catalogue](../../_includes/default-catalogue.md) %}

      1. View a description of the CLI command to get a public encryption key:

         ```bash
         yc kms asymmetric-encryption-crypto get-public-key --help
         ```

      1. [Get](../../resource-manager/operations/folder/get-id.md) the ID of the folder where the encryption key pair is saved.

      1. {% include [get-signature-key](../../_includes/kms/get-a-encryption-key.md) %}

      1. Get a public encryption key by specifying the previously obtained key pair ID:

         ```bash
         yc kms asymmetric-encryption-crypto get-public-key \
           --id <key_pair_ID>
         ```

         Result:

         ```bash
         key_id: abj9g2dil5sj********
         public_key: |
         -----BEGIN PUBLIC KEY-----
         MIIB...
         ...QAB
         -----END PUBLIC KEY-----
         ```

         Save the obtained key to a file, such as `public.key`. Make sure that lines in the file do not start with spaces.

   - API

      To get a public encryption key, use the [AsymmetricEncryptionCryptoService/GetPublicKey](../api-ref/grpc/asymmetric_encryption_crypto_service.md#GetPublicKey) gRPC API call.

   {% endlist %}

1. Encrypt the message file using the OpenSSL utility:

   {% include [asymmetric-encryption-message-size-note](../../_includes/kms/a-encryption-message-size-note.md) %}

   ```bash
   openssl pkeyutl \
     -in <path_to_message_file> \
     -encrypt \
     -pubin \
     -inkey <path_to_public_key_file> \
     -pkeyopt rsa_padding_mode:oaep \
     -pkeyopt rsa_oaep_md:sha256 \
     -pkeyopt rsa_mgf1_md:sha256 | base64 > <path_to_file_with_ciphertext>
   ````

   Where:
   * `-in`: Path to the file with the message to be encrypted.
   * `-inkey`: Path to the file with the public encryption key.
   * `<path_to_file_with_ciphertext>`: Path to the file the encrypted message will be saved to.

   As a result of executing the command, the encrypted message will be saved to the specified file in `base64` encoding.

## Decrypt data {#decryption}

{% list tabs %}

- CLI

   {% include [cli-install](../../_includes/cli-install.md) %}

   {% include [default-catalogue](../../_includes/default-catalogue.md) %}

   1. View a description of the CLI command to decrypt data with a private encryption key:

      ```bash
      yc kms asymmetric-encryption-crypto decrypt --help
      ```

   1. [Get](../../resource-manager/operations/folder/get-id.md) the ID of the folder where the encryption key pair is saved.

   1. {% include [get-signature-key](../../_includes/kms/get-a-encryption-key.md) %}

   1. Decrypt the ciphertext:

      ```bash
      yc kms asymmetric-encryption-crypto decrypt \
        --id <key_pair_ID> \
        --ciphertext-file <path_to_file_with_ciphertext> \
        --plaintext-file <path_to_file_with_decrypted_message> \
        --inform base64
      ```

      Where:

      * `--id`: Previously obtained ID of the encryption key pair.
      * `--ciphertext-file`: Path to the file with the `base64` encoded ciphertext.
      * `--plaintext-file`: Path to the file to save the decrypted message to.

      Result:

      ```bash
      key_id: abjt22qubivb********
      plaintext: 0KHQv...QuSE=
      ```

      As a result of executing the command, the encrypted message will be decrypted with the private encryption key in {{ kms-short-name }} and the decrypted text will be saved to the specified file.

- API

   To decrypt data, use the [AsymmetricEncryptionCryptoService/Decrypt](../api-ref/grpc/asymmetric_encryption_crypto_service.md#Decrypt) gRPC API call.

{% endlist %}